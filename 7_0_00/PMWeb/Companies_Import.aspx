<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Companies_Import.aspx.vb" Inherits="Website.Companies_Import" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMPORT RECORDS - Companies</title>
    <script type="text/javascript">
        function OpenProgressImport() {
            OpenSmallestPopup("ImportResultsPopup.aspx?objecttype=COMPANY", 454, 500);
        }
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
        function ImportFileClick() {
            var file = document.querySelector('.FileToUpload');
            file.click();
            return false;
        }

        function UploadClick() {
            var uploadFile = document.getElementById("btnUpload");
            uploadFile.click();

        }
        function DisplayMessage(innerText) {
            alert(innerText);

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
    </script>
    <style type="text/css">
        .rfdSkinnedButton {
            text-decoration: none;
        }

        .lnkButtonBar {
            width: auto !important;
        }

            .lnkButtonBar:hover {
                background-color: #ededed;
            }

            #RDG1_GridData{
                height: calc(80vh - 130px) !important;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadWindowManager ID="PMWindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False">
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
                    <telerik:RadToolBar ID="mainToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="cancel" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CssClass="lnkButtonBar" meta:resourcekey="Import" CommandName="Import" Value="btnImport" ValidationGroup="Save" Text="IMPORT" Style="display: none"></telerik:RadToolBarButton>
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
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblFileName" Text="File Name" runat="server" meta:resourcekey="lblFileName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPath" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-6">
                            <table class="colTable floatRightImport" style="width: 400px">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important;">
                                        <asp:Label ID="lbluploaded" runat="server" meta:resourcekey="lbluploaded" Text="Uploaded"></asp:Label>&nbsp;

                                    </td>
                                    <td class="controlWidth">
                                        <input type="text" id="Uploadeddate" readonly="readonly" runat="server" />
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
                                <asp:Label runat="server" ID="lblUploadFile" meta:resourcekey="lblUploadFile" Style="display: none;" CssClass="IconLabelsUpload"></asp:Label>
                                <asp:FileUpload ID="FileToUpload" CssClass="FileToUpload Hide" runat="server" Width="100%"></asp:FileUpload>
                                <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload" CssClass="btnImportFile Hide"
                                    meta:resourcekey="btnUpload"></asp:Button>
                            </div>
                        </div>


                        <telerik:RadGrid ID="RDG1" Width="100%" runat="server" setwidth="true" Style="display: none;"
                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                <Columns>

                                    <telerik:GridTemplateColumn DataField="TableName" HeaderText="PMWeb Table" visible="false"
                                        UniqueName="PMWebTableName">
                                        <ItemTemplate>
                                            <%#Container.DataItem("TableName")%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="300px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PMWeb Field" UniqueName="PMWebFieldName">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", ""))%>
                                        </ItemTemplate>
                                        <HeaderStyle Width="300px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Import File Field" UniqueName="FieldName">
                                        <ItemTemplate>
                                            <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="100%" AllowCustomText="true">
                                            </telerik:RadComboBox>


                                            <asp:RequiredFieldValidator ID="cmvExcelField" meta:Resourcekey="rfvExcelField" runat="server" Style="float: unset !important"
                                                ControlToValidate="ddlExcelFields" CssClass="Validator" InitialValue=""
                                                Display="Dynamic" ForeColor="" Enabled='<%#Container.DataItem("Required")%>'>
                                            </asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                        <HeaderStyle Width="300px" />

                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <CommandItemTemplate>
                                    <%--            <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="SaveMapping" CssClass="GridCmdSaveMapping">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Save" meta:resourcekey="lblUpdateRecords"></asp:Label>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelImport" CssClass="GridCmdCancelImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancel"></asp:Label>
                                            </asp:LinkButton>
                                        </div>--%>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        </telerik:RadGrid>

                    </div>
                </div>
            </asp:Panel>

            <%--<asp:Panel ID="pnl2" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 Margins">

                            <telerik:RadGrid ID="RDG3" runat="server" AllowPaging="true" PageSize="20" setwidth="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="ImportRows" CssClass="GridCmdImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblImportRecords" runat="server" Text="Import" meta:resourcekey="lblImportRecords"></asp:Label>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelImport" CssClass="GridCmdCancelImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancel"></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>

                        </div>
                    </div>
                </div>
            </asp:Panel>--%>

            <%--<asp:Panel ID="pnl3" runat="server">

                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblImportResults" Text="Import Results" runat="server" meta:resourcekey="lblImportResults"></asp:Label>
                                </legend>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCompanies" Text="Companies" runat="server" meta:resourcekey="lblCompanies"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedCompanies" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf1" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumCompanies" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddresses" Text="Addresses" runat="server" meta:resourcekey="lblAddresses"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedAddresses" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf2" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumAddresses" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContacts" Text="Contacts" runat="server" meta:resourcekey="lblContacts"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedContacts" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf3" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumContacts" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>

                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG4" runat="server" AllowPaging="true" PageSize="10" setwidth="true"
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
         <asp:HiddenField ID="hdnImportState" Value="" runat="server" />
        <asp:Button ID ="btnhdnImport"  runat="server" CssClass="Hide" />
    </form>
</body>
</html>
