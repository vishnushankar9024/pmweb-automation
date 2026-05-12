using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace PMWebApi.Controllers
{
    public class CompanyController : BaseApiController
    {
        [AcceptVerbs("GET")]
        [Route("api/company/getname/")]
        public HttpResponseMessage GetName(int id)
        {
            if (id == 0)
            return Request.CreateResponse(HttpStatusCode.BadRequest);
            return Request.CreateResponse(HttpStatusCode.OK, facade.Company.GetName(id));
        }
    }
}