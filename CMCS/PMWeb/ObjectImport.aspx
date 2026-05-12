<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ObjectImport.aspx.vb"
    Inherits="Website.ObjectImport" Culture="auto" meta:resourcekey="Page" UICulture="auto" Title="IMPORT RECORDS" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="CSS/MainCss.css" rel="stylesheet" />
    <title></title>
    <telerik:RadCodeBlock runat="server" ID="script1">

        <%--<link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>

        <script type="text/javascript">
            function pageLoad() {
                CheckParentBox();
            }

            function DisplayMessage(innerText) {
                alert(innerText);
                // radalert(innerText, null, null, 'Warning Message');
            }
            function AllCheckClicked(iObj) {
                $("#rdgPreview").find("input[type='checkbox']").each(function () {
                    if (!this.disabled)
                        this.checked = iObj.checked;
                });
            }
            function SelectParent(chk) {
                var chkPArent = $("#rdgPreview").find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                $("#rdgPreview").find("input[type='checkbox']").each(function () {
                    if (i != 0) {
                        if (chk.checked) {
                            if (!this.checked) isChecked = false;
                        }
                    }
                    i++;
                });

                if (!chk.checked) {
                    chkPArent.checked = false;

                } else {
                    chkPArent.checked = isChecked;
                }

                return false;
            }

            function CheckParentBox() {


                var ParentIsNotChecked = true;
                var i = 0;

                $("#rdgPreview").find("input[type='checkbox']").each(function () {
                    if (i != 0) {
                        if (!this.checked) {
                            ParentIsNotChecked = false;
                        }
                    }
                    i++;
                });

                if (!ParentIsNotChecked) {
                    $("#rdgPreview_ctl00_ctl02_ctl02_chkAll").removeAttr("checked");

                } else {
                    $("#rdgPreview_ctl00_ctl02_ctl02_chkAll").attr("checked", "checked");
                }
            }
            function OpenProgressImport() {
                var objecttype = "<%= qstObjectType %>"
                OpenSmallestPopup("ImportResultsPopup.aspx?objecttype=" + objecttype, 454, 500);
               
            }
            function SwitchSelectUpload() {
                var btnSelectUpload = document.getElementById('btnSelectUpload');               
                if (btnSelectUpload.className === 'SelectFile') {
                    ImportFileClick();
                    btnSelectUpload.className = 'UploadFile';
                    document.getElementById("lblUploadFile").style.display = "block";
                    document.getElementById("lblSelectUpload").style.display = "none";
                    
                }
                else if (btnSelectUpload.className === 'UploadFile') {

                    
                    UploadClick();
                   
                }
               
                return false;
               
            }



            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function CloseWindow() {
                var oWindow = GetRadWindow();
                oWindow.Close();
            }
            function DisplayImportFileName() {
                var value = document.getElementById('<%=btnImportFile.ClientID%>').value.toString();
                var index = value.lastIndexOf('\\');
                value = value.substring(index + 1);
                document.getElementById('<%=txtImportFile.ClientID%>').value = value;
            }
            function DisplayPage(iPageIndex) {
                if (document.getElementById('<%=txtImportFile.ClientID%>').value == '')
                    return false;
                document.getElementById('divPage1').style.display = 'none';
                document.getElementById('divPage2').style.display = 'none';

                document.getElementById('divPage' + iPageIndex).style.display = 'block';
            }
            function ImportFileClick() {
                var file = document.querySelector('#btnImportFile');
                file.click();
                return false;
            }
            function UploadClick() {
                var uploadFile = document.getElementById("imgUploadFiles");
                uploadFile.click();

            }

            function mainToolBarClicked(sender, args) {
                var commandName = args.get_item().get_commandName();
                if (commandName === "Back") {
                    DisplayPage(1);
                    return false;
                }

            }
            window.onload = function () {
                document.querySelector('.FileToUpload').addEventListener("change", FilePathName);
            }
            function FilePathName() {
                var FilePath = document.querySelector('.FilePath');
                var file = document.querySelector('.FileToUpload');
                if (file.value.lastIndexOf('\\') > 0)
                    FilePath.value = file.value.substring(file.value.lastIndexOf('\\') + 1);
                else
                    FilePath.value = file.value;
            }

        </script>



    </telerik:RadCodeBlock>
    <style>
        .rfdSkinnedButton {
            text-decoration: none;
        }

        .lnkButtonBar {
            width: 50px !important;
        }

            .lnkButtonBar:hover {
                background-color: #ededed;
            }

        /*.ToolbarNext .rtbIcon {
            background-position: -1776px 0px;
        }*/


        .ToolbarBack .rtbIcon {
            background-position: -1752px 0px;
        }

        #rdgImport_GridData {
            height: calc(80vh - 150px) !important;
        }

        /*.SelectUploadFile  {
   background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
    background-position: -1264px 0px !important;
    height: 24px !important;
    width: 24px !important;
    background-repeat: no-repeat;
    border:0 !important;
 }*/
    </style>
</head>
<body style="background: url('../images/login/whitedot.gif')">
    <form bgcolor="white" id="form1" runat="server">
               <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <telerik:RadWindowManager ID="PMWindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
       
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
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />



        <div id="divPage1">
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="cancel" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton CssClass="lnkButtonBar" meta:resourcekey="btnImport" CommandName="Import" Value="btnImport" ValidationGroup="Save" Text="IMPORT" runat="server"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <div class="PMMainPage PMPopupMainPage documentSinglePage">
                <div class="row Cols2">
                    <div class="col-6">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important">
                                    <asp:Label ID="lblFileType" runat="server" meta:resourcekey="lblFileType"></asp:Label>&nbsp;
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="cboFileType" runat="server" AllowCustomText="True" MarkFirstMatch="True" Width="100%" Style="width: 400px"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
   
                            <tr>
                                <td class="labelWidth" style="width: 160px !important">
                                    <asp:Label ID="lblFilePath" runat="server" meta:resourcekey="lblFilePath" CssClass="FilePath" ></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <%--<table class="TableNoSpacingNoBorder" style="width: 100%">
                                        <tr>
                                            <td style="width: 208px; padding-right: 8px">--%>
                                    <input type="text" id="txtImportFile" readonly="readonly" runat="server" />

                                    <%--<td>
                                                <asp:LinkButton ID="imgNext" runat="server" CausesValidation="False" ToolTip="<%$ Resources: Label_NextPage %>" AlternateText="<%$ Resources: Label_NextPage %>" CssClass="RightFlashButton">
                                                <span class="Icon"></span> 
                                                </asp:LinkButton>
                                            </td>--%>
                                    <%--      </tr>
                                    </table>--%>
                                </td>
                            </tr>
                   
                        </table>
                    </div>
                    <div class="col-6">
                        <table class="colTable floatRightImport" style="width: 400px">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lbluploaded" runat="server" meta:resourcekey="lbluploaded" Text="uploaded"></asp:Label>&nbsp;

                                </td>
                                <td class="controlWidth">
                                    <input type="text" id="Uploadeddate" readonly="readonly" runat="server" cssclass="Uploaded" />

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
                            <asp:Label runat="server" ID="lblSelectUpload" meta:resourcekey="lblSelectUpload" Text="Click to Select a File"></asp:Label>

                            <asp:Label runat="server" ID="lblUploadFile" meta:resourcekey="lblUploadFile" Style="display: none;" Text="Click to Upload a File"></asp:Label>
                            <input type="file" id="btnImportFile" onchange="DisplayImportFileName()" style="display:none"  class="FileToUpload Hide"
                                runat="server" />
                               <asp:Button ID="btnSelectFile" runat="server" OnClientClick="ImportFileClick(); return false;" Text="Select a file" Style="text-decoration: none;display:none" />
                                <asp:Button ID="imgUploadFiles" runat="server" Text="Upload File" CausesValidation="False" ToolTip="<%$ Resources: Label_UploadFile %>" AlternateText="<%$ Resources:PMWeb, UploadFile %>" style="display:none"></asp:Button>



                            <asp:Panel ID="pnlLoadFile" runat="server" Style="width: 100%;">
                                <telerik:RadAjaxPanel runat="server" ID="rapImport" LoadingPanelID="ldpPM" HorizontalAlign="NotSet">
                                    <telerik:RadGrid ID="rdgImport" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                            <Columns>
                                                <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PMWeb Field"
                                                    UniqueName="PMWebField">
                                                    <ItemTemplate>
                                                        <%# IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldFriendlyName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", "")) %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50%" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Import File Field"
                                                    UniqueName="FieldName">
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="ddlExcelFields" runat="server" DataSource="<%# LoadExcelFields() %>"
                                                            DataTextField="FileField" DataValueField="ValueField" SelectedIndex='<%# GetSelectedExcelFieldName(Container.DataItem("ExcelFileField")) %>'
                                                            Width="100%">
                                                        </telerik:RadComboBox>
                                                        <asp:CompareValidator runat="server" ControlToValidate="ddlExcelFields" CssClass="Validator"
                                                            Display="Dynamic" Enabled='<%# Container.DataItem("Required") %>' ErrorMessage="This field is required"
                                                            ForeColor="" ValidationGroup="ObjectImport" meta:resourcekey="CompareValidator"
                                                            Operator="NotEqual" ValueToCompare="PMWEBCOMPAREVALUE"></asp:CompareValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50%" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                                    UpdateImageUrl="Update.gif">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <CommandItemTemplate>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                        <HeaderContextMenu EnableViewState="false">
                                        </HeaderContextMenu>
                                        <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                                    </telerik:RadGrid>
                                </telerik:RadAjaxPanel>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                </div>


                <div id="divPage2" style="display: none; padding-top: 0;">
                    <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr valign="top">
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="RadToolBarSplitButtonImport" ValidationGroup="Save"></telerik:RadToolBarButton>

                                    </Items>
                                </telerik:RadToolBar>
                                <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnClientButtonClicked="mainToolBarClicked">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBack" CommandName="Back"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                    <div class="PMMainPage PMPopupMainPage">
                        <div class="row documentSinglePage">
                            <div class="col-12">

                                <asp:Panel ID="pnlPreviewPage" runat="server">
                                    <telerik:RadAjaxPanel runat="server" ID="rapPreview" LoadingPanelID="ldpPM" HorizontalAlign="NotSet">
                                        <asp:HiddenField ID="hdfCheckedId" runat="server"></asp:HiddenField>
                                        <telerik:RadGrid ID="rdgPreview" AutoGenerateColumns="true" runat="server"
                                            Font-Size="8px" AllowPaging="True" PageSize="250"
                                            GridLines="None" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <ClientSettings AllowDragToGroup="True" EnableRowHoverStyle="True">
                                                <Selecting AllowRowSelect="True" />
                                                <Resizing AllowColumnResize="True" />
                                            </ClientSettings>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderStyle-Width="50px">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                                        UpdateImageUrl="Update.gif">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <%--<CommandItemTemplate>
                                            <div style="padding: 2px">
                                                &nbsp;&nbsp;
                                                                <asp:LinkButton ID="btnImport" runat="server" CausesValidation="False" CommandName="RadToolBarSplitButtonImport" CssClass="GridCmdRadToolBarSplitButtonImport">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblImport" runat="server"></asp:Label>
                                                                </asp:LinkButton>
                                                &nbsp;&nbsp;
                                                                 <asp:LinkButton ID="PreviousButton" runat="server" CausesValidation="False" OnClientClick="DisplayPage(1)" CssClass="PreviousButton">
                                                                     <span class="Icon"></span>
                                                                     <asp:Label ID="Label1" runat="server" meta:resourcekey="lblPrevious"></asp:Label>
                                                                 </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>--%>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt" Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False" />
                                            <HeaderContextMenu EnableViewState="false">
                                            </HeaderContextMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadAjaxPanel>
                                </asp:Panel>

                            </div>
                        </div>
                    </div>
                </div>
                
               <asp:HiddenField ID="hdnImportState" Value="" runat="server" />
        <asp:Button ID ="btnhdnImport"  runat="server" CssClass="Hide" />

                <telerik:RadWindowManager ID="radWindowMgr" Skin="Default" ShowContentDuringLoad="False"
                    VisibleStatusbar="False" ReloadOnShow="True" runat="server" Behavior="Default" IconUrl="Images/Global/favicon.ico"
                    InitialBehavior="None" Left="" Style="display: none;" Top="">
                </telerik:RadWindowManager>
                <telerik:RadAjaxLoadingPanel ID="ldpImport" runat="server" Skin="Default" />
    </form>
</body>
</html>
