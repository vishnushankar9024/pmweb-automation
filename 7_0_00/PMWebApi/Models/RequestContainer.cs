using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMWebApi.Models
{
    public class RequestContainer
    {
        public string Username { get; set; }
        public int Id { get; set; }
        public int ProjectId { get; set; }
        public int UserId { get; set; }
        public string FolderName { get; set; }
        public int ParentId { get; set; }

        public string FileName { get; set; }
        public string Extenstion { get; set; }
        public string ContentType { get; set; }
        public string DocumentType { get; set; }
        public double Size { get; set; }
        public int FolderId { get; set; }
        public byte[] BinaryFile { get; set; }

        public int DocumentTypeId { get; set; }
        public int FormId { get; set; }
        public int FileId { get; set; }
        public string FileGuid { get; set; }

    }

}