using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DocumentLib;

namespace PMWebApi.Controllers
{
    public class BaseApiController : ApiController
    {
        internal Facade facade = new Facade();
    }
}
