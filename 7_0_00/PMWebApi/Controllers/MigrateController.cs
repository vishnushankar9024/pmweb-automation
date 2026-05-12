using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMWebApi.Controllers
{
    public class MigrateController : Controller
    {
        // GET: Migrate
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            SqlLib.Migrate migrate = new SqlLib.Migrate();
            return View(migrate.GetFiles("Procedures"));
        }

        public JsonResult Do(string fName, string sType)
        {
            SqlLib.Migrate migrate = new SqlLib.Migrate();
            return Json(migrate.ExecuteProc(fName, sType), JsonRequestBehavior.AllowGet);
        }
    }
}