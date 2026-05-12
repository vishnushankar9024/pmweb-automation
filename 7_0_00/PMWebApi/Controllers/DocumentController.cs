using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using PMWebApi.Models;

namespace PMWebApi.Controllers
{
    public class DocumentController : BaseApiController
    {
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }

        [AcceptVerbs("POST")]
        [Route("api/document/GetForms/")]
        public HttpResponseMessage GetForms(HttpRequestMessage request)
        {
            var username = request.Content.ReadAsStringAsync().Result;
            return Request.CreateResponse(HttpStatusCode.OK, facade.Document.GetForms(username));
        }

        [AcceptVerbs("POST")]
        [Route("api/document/GetProjects/")]
        public HttpResponseMessage GetProjects([FromBody] RequestContainer request)
        {
            if (request.Id == 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, facade.Project.GetProjects(request.Username));
            }
            return Request.CreateResponse(HttpStatusCode.OK, facade.Project.GetProjects(request.Username, request.Id));
        }

        [AcceptVerbs("POST")]
        [Route("api/document/GetDocuments/")]
        public HttpResponseMessage GetDocuments([FromBody] RequestContainer request)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.Document.GetDocuments(request.Id, request.ProjectId));
        }

        [AcceptVerbs("POST")]
        [Route("api/document/GetDocumentTypeId/")]
        public HttpResponseMessage GetDocumentTypeId([FromBody] RequestContainer req)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.Document.GetDocumentTypeId(req.DocumentType));
        }

        [AcceptVerbs("POST")]
        [Route("api/document/AttachFile/")]
        public HttpResponseMessage AttachFile([FromBody] RequestContainer req)
        {
            return Request.CreateResponse(HttpStatusCode.OK, facade.Document.AttachFile(req.DocumentTypeId, req.FormId, req.FileId, req.UserId));
        }
    }
}