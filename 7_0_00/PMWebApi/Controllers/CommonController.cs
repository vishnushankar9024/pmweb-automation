using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Microsoft.SqlServer.Dts.Runtime;
using PMWebApi.Models;

namespace PMWebApi.Controllers
{
    public class CommonController : BaseApiController
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
       
        [AcceptVerbs("GET", "POST")]
        [Route("api/Phase/GetPhaseList/")]
        public HttpResponseMessage GetPhaseListforUserCompany(string Type= "", string category = "", String user = "")
        {
            if (category.Trim() != "" && category.Trim().Length > 0 && user.Trim() != "" && user.Trim().Length > 0 && Type.Trim() != "" && Type.Trim().Length > 0)
            {
               
                return Request.CreateResponse(HttpStatusCode.OK, facade.Common.getPhaseListforUserCompany(category,user,Type));
            }
            return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.PMWebList>());
        }

        [AcceptVerbs("GET", "POST")]
        [Route("api/Commitment/GetCommitmentList/")]
        public HttpResponseMessage GetCommitmentListCOR(string recId = "", String CustomFormTypeId = "")
        {
            if (recId.Trim() != "" && recId.Trim().Length > 0 )
            {

                return Request.CreateResponse(HttpStatusCode.OK, facade.Common.getCommitmentListCOR(recId, CustomFormTypeId));
            }
            return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.PMWebList>());
        }
        [AcceptVerbs("GET", "POST")]
        [Route("api/Commitment/SaveCOR/")]
        public HttpResponseMessage SaveCOR(string Types = "", String recId = "", String CustomFormTypeId ="")
        {
            if (recId.Trim() != "" && recId.Trim().Length > 0 && Types.Trim() != "" && Types.Trim().Length > 0)
            {

                return Request.CreateResponse(HttpStatusCode.OK, facade.Common.SaveCOR(recId, Types, CustomFormTypeId));
            }
            return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.SaveResult>());
            
        }
        [AcceptVerbs("GET", "POST")]
        [Route("api/Commitment/GroupPermitted/")]
        public HttpResponseMessage GetGroup()
        {           

            return Request.CreateResponse(HttpStatusCode.OK, facade.Common.GetGroup());

            return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.PMWebList>());

        }
        [AcceptVerbs("GET", "POST")]
        [Route("api/Commitment/UserPermitted/")]
        public HttpResponseMessage GetUserforRecap()
        {

            return Request.CreateResponse(HttpStatusCode.OK, facade.Common.GetUserforRecap());

            return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.PMWebList>());

        }
        [HttpPost]
        [Route("api/RunSSIS")]
        public IHttpActionResult ExecuteSSISPackage([FromBody] PMWebLib.Models.SSISRequest model)
        {
            try
            {
                // Call the repository method to execute the stored procedure
                
                List<PMWebLib.Models.SSISResults> results = facade.Common.ExecuteSSISPackage(model);                
                return Ok(new { status = "success", results });
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
        //This is for Procurement URL
        [AcceptVerbs("GET", "POST")]
        [Route("api/Procurement/Url/")]
        public HttpResponseMessage GetUrl(string Typeid = "", string Recordid = "", String user = "")
        {
            //if (category.Trim() != "" && category.Trim().Length > 0 && user.Trim() != "" && user.Trim().Length > 0 && Type.Trim() != "" && Type.Trim().Length > 0)
            //{

            // return Request.CreateResponse(HttpStatusCode.OK, facade.Common.GetUrl(Typeid,Recordid,user));
            //}
            // return Request.CreateResponse(HttpStatusCode.OK, new List<PMWebLib.Models.PMWebList>());
            List<PMWebLib.Models.ProcURL> results = facade.Common.GetUrl(Typeid, Recordid, user); // Assuming it returns a string
            return Request.CreateResponse(HttpStatusCode.OK, results);
        }

    }
}