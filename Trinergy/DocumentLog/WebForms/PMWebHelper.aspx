<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Web.Services" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb Helper</title>
    <script runat="server" language="C#">
        void Page_Load(Object sender, EventArgs e)
        {
            if (Request.QueryString["UserId"] != null)
            {
                Library.PM pm = new Library.PM();
                if (Session["PM"] == null)
                {
                    Session["PM"] = pm;
                }
                else
                {
                    pm = Session["PM"] as Library.PM;
                }
                //pm.CnnStr = "Data Source=HSHCL5VVSQ1\\SQL1;Initial Catalog=PMWeb;Integrated Security=False;User ID=PMWebUser;Password=tasdWERF@#23bb;Connection Timeout=300";

                pm.CnnStr = ConfigurationManager.AppSettings["PMWeb"].ToString();
                try
                {
                    pm.UserController.GetUserInfo(Convert.ToInt32(Request.QueryString["UserId"].ToString()));
                    //HttpContext.Current.Session["Username"] = pm.UserInfo.Username;
                    //Response.Write(HttpContext.Current.Session.SessionID);
                    //pm.Security.LicenseController.InitNewLicense();
                    //pm.Security.LicenseController.AddOnlineUser(HttpContext.Current.Session.SessionID, pm.UserInfo, "", 1, Convert.ToInt32(Request.QueryString["UserId"].ToString()));
                    //pm.Security.LicenseController.currUsername = pm.UserInfo.Username;
                    //Response.Write("<br />" + pm.Security.LicenseController.currSessionId);
                    //Response.Write("<br />" + pm.Security.LicenseController.currUsername);
                    //var b = pm.Security.LicenseController.IsAuthenticateUser(HttpContext.Current.Session.SessionID);
                    //Response.Write("<br />" + b);
                    //Response.Write("<br />" + pm.Security.LicenseController.OnlineUserCanContinue(HttpContext.Current.Session.SessionID));
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
                if (Request.QueryString["DocumentType"] != null && Request.QueryString["DocumentType"].ToString() != "")
                {
                    pm.DocumentAttachmentInfo.DocumentType = Request.QueryString["DocumentType"].ToString();
                }
                if (Request.QueryString["DocumentId"] != null && Request.QueryString["DocumentId"].ToString() != "")
                {
                    pm.DocumentAttachmentInfo.DocumentId = Convert.ToInt32(Request.QueryString["DocumentId"].ToString());
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static string GetUser()
        {

            if (HttpContext.Current.Session["PM"] != null)
            {
                Library.PM pm = HttpContext.Current.Session["PM"] as Library.PM;
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new
                {
                    Id = pm.UserInfo.UserId.ToString(),
                    Email = pm.UserInfo.Email
                    //Company = pm.UserInfo.Company,
                    //Group = pm.UserInfo.GroupName,
                    //Username = pm.UserInfo.Username
                });
            }
            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Id = 0, Email = "" });
        }
        [WebMethod(EnableSession = true)]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static string SetSession(int customformId, string wfaction)
        {
            HttpContext.Current.Session["customformId"] = customformId;
            HttpContext.Current.Session["wfaction"] = wfaction;
            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(1);
        }
        [WebMethod(EnableSession = true)]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static void SetUserSession(int userId)
        {
            Library.PM pm = new Library.PM();
            if (HttpContext.Current.Session["PM"] == null)
            {
                HttpContext.Current.Session["PM"] = pm;
            }
            else
            {
                pm = HttpContext.Current.Session["PM"] as Library.PM;
            }
            pm.UserController.GetUserInfo(userId);
            HttpContext.Current.Session["Username"] = pm.UserInfo.Username;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
