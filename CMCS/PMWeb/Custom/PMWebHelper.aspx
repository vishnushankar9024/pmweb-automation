<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Web.Services" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb Helper</title>
    <script runat="server" language="C#">
        void Page_Load(Object sender, EventArgs e)
        {
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
                    Email = pm.UserInfo.Email,
                    //Company = pm.UserInfo.Company,
                    Group = pm.UserInfo.GroupName,
                    Username = pm.UserInfo.Username
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
