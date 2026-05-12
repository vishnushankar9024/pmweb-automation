<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PBS_Import.aspx.vb" Inherits="Website.PBS_Import" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Import</title>
     <script type="text/javascript">
         function OpenProgressImport() {
                OpenSmallestPopup("ImportResultsPopup.aspx?objecttype=PBS", 454, 500);
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
        function UploadClick() {
            var uploadFile = document.getElementById("btnUpload");
            uploadFile.click();

        }
        function ImportFileClick() {
            var file = document.querySelector('.FileToUpload');
            file.click();
            return false;
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
        .upload-btn-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
            padding-right: 10px;
        }

                        .lnkButtonBar {
            width: auto !important;
        }

            .lnkButtonBar:hover {
                background-color: #ededed;
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

        a {
            text-decoration: none;
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
                    <telerik:RadToolBar ID="mainToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="cancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CssClass="lnkButtonBar" meta:resourcekey="Import" CommandName="Import" Value="btnImport"  Text="IMPORT" Style="display: none"></telerik:RadToolBarButton>
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
                                        <asp:Label ID="lblFileName" Text="File Name111" runat="server" meta:resourcekey="lblFileName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPath" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSepators" runat="server" meta:resourcekey="lblSepators" Text="Code Sepator1111"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSeparators" Width="100%" runat="server" Text="."></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSeparator" runat="server" ControlToValidate="txtSeparators"
                                            meta:resourcekey="rfvSeparator" CssClass="Validator" ErrorMessage="Separatorsssss" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
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
                            <div style="text-align: center">
                                <asp:LinkButton runat="server" ID="btnSelectUpload" CssClass="SelectFile" OnClientClick="SwitchSelectUpload(); return false;">
                                <div class="Icon"></div>
                                </asp:LinkButton>
                                <br />
                                <asp:Label runat="server" ID="lblSelectUpload" meta:resourcekey="lblSelectUpload" CssClass="IconLabelsSelect"></asp:Label><br />
                                <asp:Label runat="server" ID="lblUploadFile" meta:resourcekey="lblUploadFile" Style="display: none;" CssClass="IconLabelsUpload"></asp:Label>
                                <asp:Button ID="btnFileToUpload" runat="server" CausesValidation="False" Text="Select A File"
                                    meta:resourcekey="btnFileToUpload" style="display:none" />
                                <asp:FileUpload ID="FileToUpload" runat="server" CssClass="FileToUpload Hide"></asp:FileUpload>
                                 <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload"
                                            meta:resourcekey="btnUpload" style="display:none" />
                            </div>
                            </div>
                            <telerik:RadGrid ID="RDG1" Width="100%" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
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
                                            <HeaderStyle Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PMWeb Field" UniqueName="PMWebFieldName">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", ""))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Import File Field" UniqueName="FieldName">
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="100%" ValidationGroup="Save" AllowCustomText="true">
                                                </telerik:RadComboBox>
                                              <%--  <asp:RangeValidator ID="cmvExcelField" meta:resourcekey="cmvExcelField" runat="server"
                                                    CssClass="Validator" ControlToValidate="ddlExcelFields" MinimumValue="1" MaximumValue="1000000"
                                                    Type="Integer" Enabled='<%#Container.DataItem("Required")%>' ErrorMessage="Required Field" Display="Dynamic">
                                                </asp:RangeValidator>--%>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlExcelFields" meta:resourcekey="cmvExcelField"
                                                    CssClass="Validator" InitialValue="" ErrorMessage="44" ValidationGroup="Save" Enabled='<%#Container.DataItem("Required")%>'
                                                    Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
               <%--                         <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="SaveMapping" ValidationGroup="Save" CssClass="GridCmdSaveMapping">
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
            <asp:HiddenField ID="hdnImportState" Value="" runat="server" />
            <asp:Button ID ="btnhdnImport"  runat="server" CssClass="Hide" />



            <%--<asp:Panel ID="pnl2" runat="server">
                <div class="PMMainPage PMPopupMainPage">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG3" runat="server" AllowPaging="true" PageSize="20" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None" FitPageHeightOffset="24">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="TopAndBottom" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="ImportRows" CssClass="GridCmdImportRows">
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

                <div class="PMMainPage PMPopupMainPage">
                    <div class="row">
                        <div class="col-4">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblImportResults" Text="Import Results" runat="server" meta:resourcekey="lblImportResults"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPBS" Text="PBS" runat="server" meta:resourcekey="lblPBS"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedPBS" Text="" runat="server"></asp:Label>&nbsp;
                                            <asp:Label ID="lblOf1" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                            <asp:Label ID="lblTotalNumPBS" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG4" runat="server" AllowPaging="true" PageSize="10" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None" FitPageHeightOffset="24">
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
                            <asp:Button ID="btnFinish" runat="server" CausesValidation="False" Text="Finish"
                                meta:resourcekey="btnFinish" />
                        </div>
                    </div>
                </div>

            </asp:Panel>--%>
        </asp:Panel>

    </form>
</body>
</html>
