using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using PMWebApi.Models;
using System.IO;

namespace PMWebApi.Controllers
{
    public class FileManagerController : BaseApiController
    {
        [AcceptVerbs("GET", "POST")]
        [Route("api/file/GetAllowedFileTypes/")]
        public HttpResponseMessage GetAllowedFileTypes()
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetAllowedFileTypes());
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetProjectFolders/")]
        public HttpResponseMessage GetProjectFolders([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetProjectFolders(request.ProjectId, request.UserId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetProjectsFolder/")]
        public HttpResponseMessage GetProjectsFolder([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetProjectsFolder(request.UserId));
        }

        [AcceptVerbs("GET")]
        [Route("api/Folder/GetProjectFoldersGet/")]
        public HttpResponseMessage GetProjectFoldersGet(int projectId, int userId)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetProjectFolders(projectId, userId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetSharedFolders/")]
        public HttpResponseMessage GetSharedFolders([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetSharedFolders(request.UserId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetSubFolder/")]
        public HttpResponseMessage GetSubFolder([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetSubFolders(request.Id, request.UserId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetFolderByName/")]
        public HttpResponseMessage GetFolderByName([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetFolderByName(request.FolderName, request.ParentId, request.ProjectId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/CreateFolder/")]
        public HttpResponseMessage CreateFolder([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.CreateFolder(request.FolderName, request.ParentId, request.ProjectId, request.UserId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetFoldersByDocId/")]
        public HttpResponseMessage GetFoldersByDocId([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetFoldersByDocId(request.Id, request.DocumentTypeId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetRootId/")]
        public HttpResponseMessage GetRootId([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetRootNode(request.ProjectId));
        }

        [AcceptVerbs("POST")]
        [Route("api/Folder/GetFiles/")]
        public HttpResponseMessage GetFiles([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetFolderFiles(new int[] { request.FolderId }, request.FormId, request.DocumentTypeId, request.UserId));
        }

        [AcceptVerbs("POST")]
        [Route("api/File/CreateFile/")]
        public async Task<HttpResponseMessage> CreateFile()
        {
            var request = this.Request;


            var provider = new MultipartFormDataStreamProvider(System.Web.HttpContext.Current.Server.MapPath("~/App_Data/uploads"));

            RequestContainer req = new RequestContainer();

            var task = await request.Content.ReadAsMultipartAsync(provider);

            var formData = provider.FormData;

            req.FileName = formData["FileName"].ToString();
            req.Extenstion = formData["Extenstion"].ToString();
            req.ContentType = formData["ContentType"].ToString();
            req.Size = Convert.ToDouble(formData["Size"].ToString());
            req.FolderId = formData["FolderId"].ToInt();
            req.ProjectId = formData["ProjectId"].ToInt();
            req.UserId = formData["userId"].ToInt();


            if (provider.FileData.Count > 0)
            {

                string file = provider.FileData.First().LocalFileName;
                FileInfo finfo = new FileInfo(provider.FileData.First().LocalFileName);

                req.BinaryFile = ConvertFileToBinary(file);
                File.Delete(finfo.FullName);

                // this is the file name on the server where the file was saved 
                return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.CreateFile(req.FileName, req.Extenstion, req.ContentType, req.Size, req.FolderId, req.ProjectId, req.UserId, req.BinaryFile));
            }

            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }

        [AcceptVerbs("POST")]
        [Route("api/File/GetFile/")]
        public HttpResponseMessage GetFile([FromBody] RequestContainer req)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.FileRep.GetFile(req.FileGuid));
        }

        private byte[] ConvertFileToBinary(string filePath)
        {
            byte[] file;
            using (var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            {
                using (var reader = new BinaryReader(stream))
                {
                    file = reader.ReadBytes((int)stream.Length);
                }
            }
            return file;
        }
    }
}
