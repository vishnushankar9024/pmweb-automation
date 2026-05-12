<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="~/DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="~/NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="~/CustomFormDetails.ascx" TagName="CustomFormDetails" TagPrefix="uc1" %>
<%@ Register Src="~/DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc7" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb Helper</title>
    <script runat="server" language="C#">
        Library.PM PM = new Library.PM();
        void Page_Load(Object sender, EventArgs e)
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
            pm.CnnStr = "Data Source=pmwebprd1\\pmwebprd1;Initial Catalog=PMWeb;Integrated Security=False;User ID=PMWebUser;Password=PMWeb;Connection Timeout=300";
            pm.UserController.GetUserInfo(5);

            this.PM = pm;
            //this.mainToolBar.set_OnClientButtonClicked("click_handler");
            if (!this.IsPostBack && !this.Page.IsCallback)
            {
                this.PM.Workflow.CustomFormController.dts.tblDefinitionColumns.Clear();
                this.PM.Workflow.CustomFormController.dts.tblColumsData.Clear();
                this.PM.CustomTableController.lstCustomtables = new Dictionary<int, object>();
                int Id = 0;
                int TypeId = 0;
                if (this.Request.QueryString["TypeId"] != null & int.TryParse(this.Request.QueryString["TypeId"].ToString(), out TypeId))
                {
                    this.PM.Workflow.CustomFormInfo.CustomFormTypeId = Convert.ToInt32(this.Request.QueryString["TypeId"]);
                    //this.SourceObjectType = "GENERALCUSTOMFORM_" + this.PM.Workflow.CustomFormInfo.CustomFormTypeId.ToString();
                    this.PM.Utilities.SelectPageMenu("CustomForms.aspx?TypeId=" + this.PM.Workflow.CustomFormInfo.CustomFormTypeId.ToString());
                    this.PM.Workflow.CustomFormController.InitNewCustomForm(this.PM.Workflow.CustomFormInfo.CustomFormTypeId);
                    this.Session["SourceUrl"] = (object) ("~/CustomForms.aspx?TypeId=" + this.PM.Workflow.CustomFormInfo.CustomFormTypeId.ToString());
                    this.Session["SourceObjectType"] = (object) ("GENERALCUSTOMFORM_" + this.PM.Workflow.CustomFormInfo.CustomFormTypeId.ToString());
                    if (this.PM.SearchDocumentInfo.AddNewDocument)
                    {
                        this.PM.SearchDocumentInfo.AddNewDocument = false;
                        this.LoadCustomForm();
                        //this.ddlCustomForms.set_SelectedIndex(-1);
                        //this.ddlCustomForms.set_Text("");
                        if (!this.PM.Workflow.CustomFormInfo.UseTemplate)
                            return;
                        //this.pnlDetailPane1.Visible = false;
                        return;
                    }
                    Id = !(this.Request.QueryString["Id"] != null & int.TryParse(this.Request.QueryString["Id"].ToString(), out Id)) ? Convert.ToInt32(this.PM.Utilities.GetLastSelectedObjectTypeByName(this.PM.Workflow.CustomFormInfo.ObjectType)) : Convert.ToInt32(this.Request.QueryString["Id"]);
                }
                else
                    this.PM.Workflow.CustomFormInfo.CustomFormTypeId = 0;
                //this.LoadCustomFormsList();
                if (Id > 0)
                    this.PM.Workflow.CustomFormController.GetCustomForm(Id, this.PM.Workflow.CustomFormInfo.CustomFormTypeId);
                //this.BindControls();
                //this.LoadCustomForm();
            }
            //this.lblRecordNumberAlreadyExist.Visible = false;

            //this.CustomFormDetails1.LoadControls();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:CustomFormDetails ID="CustomFormDetails1" runat="server" />
        </div>
    </form>
</body>
</html>
