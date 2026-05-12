<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PortfolioPlanning_Import.aspx.vb" Inherits="Website.PortfolioPlanning_Import" Title="IMPORT RECORDS - Portfolio Planning Worksheet" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">

        function SwitchSelectUpload() {
            var selectUploadbtn = document.getElementById('btnSelectUpload');
            if (selectUploadbtn.className === 'SelectFile') {
                ImportFileClick();
                selectUploadbtn.className = 'UploadFile';
                document.getElementById("lblUploadFile").style.display = "inline";
                document.getElementById("lblSelectUpload").style.display = "none";

            }
            else if (selectUploadbtn.className === 'UploadFile') {

                UploadClick(); 

            }

            return false;

        }

        function OpenProgressImport() {
            OpenSmallestPopup("ImportResultsPopup.aspx?objecttype=PORTFOLIOPLANS", 454, 500);
        }

        function ImportFileClick() {
            var file = document.querySelector('.FileToUpload');
            file.click();
            return false;
        }

        function UploadClick() {
            var uploadFile = document.getElementById("btnUpload");
            uploadFile.click();

        }
        window.onload = function () {
            document.querySelector('#FileToUpload').addEventListener("change", FilePathName);
        }
        function FilePathName() {
            var txtPath = document.querySelector('#txtPath');
            var file = document.querySelector('#FileToUpload');
            if (file.value.lastIndexOf('\\') > 0)
                txtPath.value = file.value.substring(file.value.lastIndexOf('\\') + 1);
            else
                txtPath.value = file.value;
        }
        function DisplayMessage(innerText) {
            alert(innerText);
        }
    </script>
    <style type="text/css">   
 .lnkButtonBar {
            width: auto !important;
        }     
        .lnkButtonBar:hover {
    background-color: #ededed;
}
        .upload-btn-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width:100%;
            padding-right: 10px;
        }

        .upload-btn-wrapper input[type=file] {
            font-size: 0px;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }

        a{
            text-decoration: none;
        }
        #RDG1_GridData {
            height: calc(80vh - 80px) !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadWindowManager ID="PMWindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False" >
            <AjaxSettings>    
                <telerik:AjaxSetting AjaxControlID="btnhdnImport">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnhdnImport" />
                          <telerik:AjaxUpdatedControl ControlID="hdnImportState" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM2" runat="server" Skin="Default" />


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="cancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CssClass="lnkButtonBar" meta:resourcekey="Import" CommandName="Import" Value="btnImport" Text="IMPORT" Style="display: none"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <asp:Panel ID="pnlMain" runat="server">

            <asp:Panel ID="pnl1" runat="server">
                <div class="PMMainPage PMPopupMainPage documentSinglePage">
                    <div class="row Cols2">
                        <div class="col-6">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFileName" runat="server" meta:resourcekey="lblDataFile"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPath" ReadOnly="True" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth"></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-6">
                            <table class="colTable floatRightImport" >
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblUploaded" runat="server" meta:resourcekey="lblUploaded"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <input type="text" runat="server" id="UploadedDate" readonly="ReadOnly" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div runat="server" id="divUpload" style="text-align: center">
                                <asp:LinkButton runat="server" ID="btnSelectUpload" CssClass="SelectFile" OnClientClick="SwitchSelectUpload(); return false;">
                                <div class="Icon"></div>
                                </asp:LinkButton>
                                <br />
                                <asp:Label runat="server" ID="lblSelectUpload" meta:resourcekey="lblSelectUpload" CssClass="IconLabelsSelect"></asp:Label>
                                <asp:Label runat="server" ID="lblUploadFile" meta:resourcekey="lblUploadFile" Style="display: none;"  CssClass="IconLabelsUpload"></asp:Label>
                                 <asp:FileUpload ID="FileToUpload" runat="server" CssClass="Hide FileToUpload" />
                                <asp:LinkButton ID="btnUpload" runat="server" CausesValidation="False" Text="Upload" Style="display: none;" CssClass="UploadFile"
                                    meta:resourcekey="btnUpload">
                                    <div class="Icon"></div>
                                </asp:LinkButton>
                            </div>

                            <telerik:RadGrid ID="RDG1" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None" Style="display: none;">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="none" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>

                                        <telerik:GridTemplateColumn DataField="TableName" HeaderText="PMWeb Table" Visible="false"
                                            UniqueName="PMWebTableName">
                                            <ItemTemplate>
                                                <%#Container.DataItem("TableName")%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="250px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PMWeb Field" UniqueName="PMWebFieldName">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", ""))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="250px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Import File Field" UniqueName="FieldName">
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="100%" ValidationGroup="Save" AllowCustomText="true">
                                                </telerik:RadComboBox>
                                                 </ItemTemplate>
                                            <HeaderStyle Width="250px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:HiddenField ID="hdnImportState" Value="" runat="server" />
        <asp:Button ID ="btnhdnImport"  runat="server" CssClass="Hide" />


            <%--<asp:Panel ID="pnl2" runat="server">
                <div class="PMMainPage PMPopupMainPage documentSinglePage">
                    <div class="row ">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG3" runat="server" AllowPaging="true" PageSize="20" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="none" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </asp:Panel>--%>

            <%--<asp:Panel ID="pnl3" runat="server">
                <div class="PMMainPage PMPopupMainPage documentSinglePage">
                    <div class="row">
                        <div class="col-4">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblImportResults" Text="Import Results" runat="server" meta:resourcekey="lblImportResults"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label ID="lblPlans" Text="Plans1" runat="server" meta:resourcekey="lblPlans"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedPlans" Text="" runat="server"></asp:Label>&nbsp;
                                                        <asp:Label ID="lblOf1" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                        <asp:Label ID="lblTotalNumPlans" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label ID="lblPlanlines" Text="Planlines1" runat="server" meta:resourcekey="lblPlanlines"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedPlanlines" Text="" runat="server"></asp:Label>&nbsp;
                                                            <asp:Label ID="lblOf2" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                            <asp:Label ID="lblTotalNumPlanlines" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG4" runat="server" AllowPaging="true" PageSize="10" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="none" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnFinish" runat="server" CausesValidation="False" Text="Finish"
                                            meta:resourcekey="btnFinish" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </asp:Panel>--%>
        </asp:Panel>
    </form>
</body>
</html>
