using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using PMWebApi.Models;

namespace PMWebApi.Controllers
{
    public class UserController : BaseApiController
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
        [Route("api/user/Authenticate/")]
        public HttpResponseMessage Authenticate([FromBody] Authentication authentication)
        {
            if (string.IsNullOrEmpty(authentication.Username.Trim()) || string.IsNullOrEmpty(authentication.Password.Trim()))
                return Request.CreateResponse(HttpStatusCode.BadRequest);

            return Request.CreateResponse(HttpStatusCode.OK, facade.UserInfo.Authenticate(authentication.Username, authentication.Password));
        }

        [AcceptVerbs("GET")]
        [Route("api/user/authcheck/")]
        public HttpResponseMessage authcheck(string username, string password)
        {
            if (string.IsNullOrEmpty(username.Trim()) || string.IsNullOrEmpty(password.Trim()))
                return Request.CreateResponse(HttpStatusCode.BadRequest);

            return Request.CreateResponse(HttpStatusCode.OK, facade.UserInfo.Authenticate(username, password));
        }

        [AcceptVerbs("GET")]
        [Route("api/user/getcompany/")]
        public HttpResponseMessage GetCompany(int id)
        {
            if (id == 0)
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            return Request.CreateResponse(HttpStatusCode.OK, facade.Company.GetByUserId(id));
        }
    }
}