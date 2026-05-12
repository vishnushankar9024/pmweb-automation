using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMWebApi
{
    public class Startup
    {
        public static void RegisterDbConfig()
        {
            Db.Connection = System.Configuration.ConfigurationManager.ConnectionStrings["PMWeb"].ToString();
            Db.DBType = DBType.SqlServer;
            Db.SpPrefix = System.Configuration.ConfigurationManager.AppSettings["DbPrefix"].ToString();
        }

        public static void ProjectConfig()
        {
            Project.Path = System.IO.Path.GetDirectoryName(
                                        System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase
                                    );
        }
    }
}