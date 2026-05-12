<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ObjectImport.aspx.vb"
    Inherits="Website.ObjectImport" Culture="auto" meta:resourcekey="Page" UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Import</title>
    <telerik:RadCodeBlock runat="server" ID="script1">
        <link href="CSS/MainCss.css" rel="stylesheet" type="text/css" />
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
            function mainToolBarClicked(sender, args) {
                var commandName = args.get_item().get_commandName();
                if (commandName === "Back") {
                    DisplayPage(1);
                    return false;
                }

            }
        </script>



    </telerik:RadCodeBlock>
    <style>
        .rfdSkinnedButton {
            text-decoration: none;
        }

        .ToolbarNext .rtbIcon {
            background-position: -1776px 0px;
        }

        .ToolbarBack .rtbIcon {
            background-position: -1752px 0px;
        }
    </style>
</head>
<body style="background: url('../images/login/whitedot.gif')">
    <form bgcolor="white" id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager2" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />



        <div id="divPage1">
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarNext" CommandName="Next" ValidationGroup="Save"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <div class="PMMainPage PMPopupMainPage documentSinglePage">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFileType" runat="server" meta:resourcekey="lblFileType"></asp:Label>&nbsp;
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="cboFileType" runat="server" AllowCustomText="True" MarkFirstMatch="True" Width="100%" Style="max-width: 240px !important"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="controlWidth">
                                    <asp:Button ID="btnSelectFile" runat="server" OnClientClick="ImportFileClick(); return false;" Text="Select a file" Style="text-decoration: none" />
                                    <input type="file" id="btnImportFile" onchange="DisplayImportFileName()" style="display: none;"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFilePath" runat="server" meta:resourcekey="lblFilePath" Style="background-color: RGB(237,237,237)"></asp:Label>
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
                            <tr>
                                <td></td>
                                <td class="controlWidth">

                                    <asp:Button ID="imgUploadFiles" runat="server" Text="Upload File" CausesValidation="False" ToolTip="<%$ Resources: Label_UploadFile %>" AlternateText="<%$ Resources:PMWeb, UploadFile %>"></asp:Button>
                                </td>
                            </tr>
                            <tr>
                                <td></td>

                            </tr>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <asp:Panel ID="pnlLoadFile" runat="server" Style="width: 100%;">
                            <telerik:RadAjaxPanel runat="server" ID="rapImport" LoadingPanelID="ldpPM" HorizontalAlign="NotSet">
                                <telerik:RadGrid ID="rdgImport" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"  FitPageHeightOffset="24"
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
                                    Font-Size="8px" AllowPaging="True" PageSize="15"
                                    GridLines="None"  SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24">
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

        <telerik:RadWindowManager ID="radWindowMgr" Skin="Default" ShowContentDuringLoad="False"
            VisibleStatusbar="False" ReloadOnShow="True" runat="server" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxLoadingPanel ID="ldpImport" runat="server" Skin="Default" />
    </form>
</body>
</html>
