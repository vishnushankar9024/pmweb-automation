<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="CopyMoveToDialog.aspx.vb" Inherits="Website.CopyMoveToDialog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="AjaxManagerProxy1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlFolderRoot">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                        <telerik:AjaxUpdatedControl ControlID="btnCopy1" />
                        <telerik:AjaxUpdatedControl ControlID="btnMove1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlRoot">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                        <telerik:AjaxUpdatedControl ControlID="divButtons" />
                        <telerik:AjaxUpdatedControl ControlID="trFolderRoot" />
                        <telerik:AjaxUpdatedControl ControlID="ddlRoot" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdBtnFolders">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                        <telerik:AjaxUpdatedControl ControlID="divButtons" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="lnkBtnPrevious">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                        <telerik:AjaxUpdatedControl ControlID="btnMove1" />
                        <telerik:AjaxUpdatedControl ControlID="btnCopy1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnFolder">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="lnkBtnFolder">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divFolders" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="divButtons">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="divButtons" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCopyMoveToDialog" runat="server" Skin="Default" />
        <style>
            input[type="button"], input[type="submit"] {
                width: 70px !important;
                margin-left: 5px;
            }

            input[type="checkbox"] + label, input[type="radio"] + label {
                color: #666666 !important;
                margin: 5px;
                bottom: 3px;
                position: relative;
            }

            .FolderBtn .Icon {
                display: inline-block;
                width: 16px;
                height: 16px;
                background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
                background-position: -190px 0;
                background-repeat: no-repeat;
            }
            .closepopup div {
    background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png');
    background-repeat: no-repeat;
    display: inline-block;
    position:absolute;
    right: 24px;
    transform: rotate(90deg);
    width: 16px;
    height: 16px;
    background-size: cover;      
    background-position: -208px 0px; 
    top: 19px;
}
            .Prev .Icon {
                display: inline-block;
                width: 16px;
                height: 16px;
                background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
                background-position: -177px 0;
                background-repeat: no-repeat;
            }

            .RadAjaxPanel {
                display: inline-block !important;
            }

            #lblFolderRoot {
                width: 100% !important;
            }

            input[disabled=disabled] {
                background-color: rgb(237, 237, 237) !important;
            }


            #btnCopy1Panel{
                margin-left:10px;
            }
            .labelWidth{
                width:160px !important;
            }
            .controlWidth{
                width:240px !important;
            }
            .PMMainPage{
                padding-left:24px !important;
                padding-right:24px !important;
            }
        </style>

        <telerik:RadCodeBlock runat="server" ID="radCodeBlock">
            <script type="text/javascript">

                var arrSelectedFolderIds = [];
                var currentWorkingFolderId = '<%=PM.FileManager.FolderInfo.CurrentWorkingFolderId%>';
                var currentWorkingFolderManageFolder = '<%=PM.FileManager.FolderInfo.ManageFolder%>';
                var objectTypeId = '<%=PM.FileManager.CopyMoveDialogInfo.ObjectTypeId%>';
                var checkedLabel = '';

                function RefreshPmwebRecords() {
                    if (window.parent.location.href.toLowerCase().indexOf('pmwebrecord')>0)
                    {
                        
                        window.parent.refreshPage = true
                    }
                }
                function Cancel() {
                    window.close();
                }

                function CheckIfCanDelete(sender) {
                    var hfIsFolder = document.querySelector("#hfIsFolder").value;
                    if (arrSelectedFolderIds.length === 0 && hfIsFolder === "1") {
                        var hfFolderIds = document.querySelector("#hfFolderIds");
                        arrSelectedFolderIds = hfFolderIds.value.split(",")
                    }
                    var clickedFolderId = sender.getAttribute("btnId");
                    var canDelete = sender.attributes.CanDelete.value;
                    var manageFolder = sender.getAttribute("manageFolders");
                    var editFiles = sender.getAttribute("EditFiles");
                    var uploadFiles = sender.getAttribute("UploadFiles");
                    var btnMove = document.querySelector("#btnMove1");
                    var btnCopy = document.querySelector("#btnCopy1");
                    var manageFolderCurrentWorkingFolder = currentWorkingFolderManageFolder.toString().toLowerCase() === "true";
                    btnCopy.disabled = false;
                    if (sender.attributes.btnid.value == currentWorkingFolderId) {
                        btnMove.disabled = true;
                        btnCopy.disabled = true;
                    } else {
                        btnMove.disabled = false;
                        btnCopy.disabled = false;
                    }
                    var IsFolder = document.querySelector("#hfIsFolder").value;
                    var hasFiles = document.querySelector("#hfHasFiles").value;
                    if (arrSelectedFolderIds.indexOf(clickedFolderId) > -1) {
                        btnMove.disabled = true;
                    }

                    if ((hasFiles == "1" && (uploadFiles == "false")) || (IsFolder == "1" && manageFolder == "false")) {
                        btnCopy.disabled = true;
                        btnMove.disabled = true;
                    }

                    if (hasFiles == "1" && !manageFolderCurrentWorkingFolder)
                    {
                        btnCopy.disabled = true;
                    }
                    return false;
                }


                function OpenFileAdd(FolderId, ClearFileTable, AllowVersioning, IsCopyAction, IsMoveAction) {
                    var browserWidth = $telerik.$(window.parent).width();
                    var browserHeight = $telerik.$(window.parent).height();
                    var wnd = window.parent.radopen('FolderManagerAddFiles.aspx?FolderID=' + FolderId + '&ClearTable=' + ClearFileTable + '&AllowVersioning=' + AllowVersioning + '&IsCopyAction=' + IsCopyAction + '&IsMoveAction=' + IsMoveAction, 800, 440, true, 'rdgFiles');
                    var divWindow = wnd._popupElement;
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = ""
                    divWindow.classList.add("rwReminder");
                    divWindow.classList.add("rwFolderManager");
                    if (window.parent.location.href.toLowerCase().indexOf('pmwebrecord') > 0)
                    {
                        wnd.add_close(window.parent.RefreshPage);
                    }
                    if (browserWidth <= MobileScreenWidth) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(8, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    return false;
                }

                $(document).ready(function () {

                    $('.folderContainer').on('change', 'input[type="radio"]', function () {
                        $('input[type="radio"]').each(function () {
                            $(this).prop("checked", "");
                        });
                        $(this).prop("checked", "checked");
                        var btnMove = document.querySelector("#btnMove1");
                        var btnCopy = document.querySelector("#btnCopy1");
                        if (checkedLabel == $(this).attr("id")) {
                            //$(this).prop("checked", "");
                            checkedLabel = '';
                            //btnMove.disabled = true;
                            //btnCopy.disabled = true;
                            return;
                        } else
                            checkedLabel = $(this).attr("id");
                        if (checkedLabel != '') {
                            if ($(this).parent().attr("btnId") == currentWorkingFolderId) {
                                btnMove.disabled = true;
                            } else {
                                btnMove.disabled = false;
                            }
                        } else {
                            var manageFolderCurrentWorkingFolder = currentWorkingFolderManageFolder.toString().toLowerCase() === "true";
                            if (document.querySelector("#trFolderRoot").style.display != "none") {
                                var folder = $find("ddlFolderRoot");
                                var hasFiles = document.querySelector("#hfHasFiles").value;
                                var hfIsFolder = document.querySelector("#hfIsFolder").value;
                                if (hasFiles == "1" && (folder.get_attributes()._data.UploadFiles == "False") || folder.get_value() == currentWorkingFolderId || (hfIsFolder === "1" && folder.get_attributes()._data.ManageFolders == "False")) {
                                    btnMove.disabled = true;
                                } else {
                                    btnMove.disabled = false;
                                }
                                if (hasFiles == "1" && (folder.get_attributes()._data.UploadFiles == "False") || (hfIsFolder === "1" && folder.get_attributes()._data.ManageFolders == "False") || folder.get_value() == currentWorkingFolderId) {
                                    btnCopy.disabled = true;
                                }
                                else {
                                    btnCopy.disabled = false
                                }
                            } else {
                                var root = $find("ddlRoot");
                                btnMove.disabled = false;
                                btnCopy.disabled = false;
                                var hfIsFolder = document.querySelector("#hfIsFolder").value;
                                var hasFiles = document.querySelector("#hfHasFiles").value;
                                if(root.get_attributes()._data.folderId == currentWorkingFolderId)
                                {
                                    btnMove.disabled = true;
                                }
                                if (hasFiles == "1" && (root.get_attributes()._data.UploadFiles == "False") || (hfIsFolder === "1" && root.get_attributes()._data.ManageFolders == "False")) {
                                    btnMove.disabled = true;
                                    btnCopy.disabled = true;
                                }
                            }
                            if (hasFiles == "1" && !manageFolderCurrentWorkingFolder) {
                                btnCopy.disabled = true;
                            }
                        }
                    })

                });

                function selectFirst() {
                    if ($('#tblRepeater input[type="radio"]').length > 0) {
                        $('#tblRepeater input[type="radio"]').first().prop("checked", "checked");
                    }
                }

                function CloseWindow() {
                    var wnd = GetRadWindow(window);
                    wnd.Close();
                }
                function CloseParent() {
                    if (window.parent.location.toString().toLowerCase().indexOf("foldermanager.aspx") > -1)
                        window.parent.document.querySelector("#ctl00_CPH1_btnRefreshCurrentWorkingFolder").click();
                    else {
                        for (var i = 0; i < window.parent.length; i++) {
                            if (typeof window.parent[i].rebindFileGrid === 'function')
                                window.parent[i].rebindFileGrid();
                        }
                    }

                }

                function Copy() {
                    var btncopy = document.querySelector("#btnCopy");
                    var btnCancel = document.querySelector("#btnCancel");
                    btncopy.click();
                    btnCancel.click();
                }

                function Move() {
                    var btnMove = document.querySelector("#btnMove");
                    var btnCancel = document.querySelector("#btnCancel");
                    btnMove.click();
                }
            </script>
        </telerik:RadCodeBlock>

        <div>
             <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text="" ></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
            <table class="TableNoSpacingNoBorder"  style="width: 100%; margin-top: 44px">
                <tr>
                    <td style="border-bottom: 1px solid gray">
                        <div>
                            <div class="row" style="padding: 8px 0;" id="divButtons" runat="server">
                                <div class="col-12">
                                    <asp:Button Text="Copy" runat="server" ID="btnCopy1" Style="display: inline-block !important;margin-left:14px;" OnClientClick="return Copy();" meta:ResourceKey="btnCopy" />
                                    <asp:Button Text="Move" runat="server" ID="btnMove1" Style="display: inline-block !important" OnClientClick="return Move();" meta:ResourceKey="btnMove" />
                                    <asp:Button Text="Cancel" OnClientClick="Cancel()" Style="display: inline-block !important" runat="server" ID="btnCancel" meta:ResourceKey="btnCancel" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="PMMainPage">
                            <div class="row">
                                <div class="col-4 col-4-left">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblRoot" runat="server" Text="Root" meta:ResourceKey="lblRoot"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlRoot" Style="width: 240px !important" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlRoot_SelectedIndexChanged">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <div id="trFolderRoot" style="width: 100%" runat="server">
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblFolderRoot" runat="server"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlFolderRoot"
                                                        runat="server"
                                                        Skin="Default"
                                                        CloseDropDownOnBlur="true" Style="width: 240px !important" AutoPostBack="true"
                                                        NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnSelectedIndexChanged="ddlFolderRoot_SelectedIndexChanged" EnableVirtualScrolling="True"
                                                        OnItemsRequested="ddl_ItemsRequested">
                                                    </telerik:RadComboBox>
                                                    </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="folderContainer row">
                                <div id="divFolders" class="col-4 col-4-left" runat="server">
                                    <div>
                                        <table id="tblCurrFolder">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="lnkBtnPrevious" runat="server">
                                                        <div class="Prev" style="float: left; display: inline-block">
                                                            <span class="Icon"></span>
                                                        </div>
                                                    </asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:RadioButton ID="lblCurrFolder" runat="server"  GroupName="Folder" Font-Size="16px" Checked="true"></asp:RadioButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="row" style="padding-top: 24px;padding-left:24px;">
                                        <div>
                                            <table class="colTable" id="tblRepeater">
                                                <asp:Repeater ID="rdBtnFolders" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td style="width:92%;">
                                                                <%--<asp:RadioButton ClientIDMode="Static" GroupName="test" Text='<%# Eval("Name") %>' ID="rdBtnFolder" runat="server" />--%>
                                                                <div id="divRadio">
                                                                    <asp:RadioButton ID="btnFolder" runat="server" Text='<%# Eval("Name") %>' btnId='<%# Eval("RealId") %>' />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton style="float:right" Visible='<%# CBool(Eval("HasChild")) %>' ID="lnkBtnFolder" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName='<%# Eval("RealId") %>'>
                                                                    <div class="FolderBtn" style="display:inline-block;position:relative;top:-3px">
                                                                        <span class="Icon">
                                                                        </span>
                                                                    </div>                                                    
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hfIsFolder" runat="server" />
            <asp:HiddenField ID="hfHasFiles" runat="server" />
            <asp:HiddenField ID="hfHasAttributes" Value="0" runat="server" />
            <asp:HiddenField ID="hfFolderIds" runat="server" Value="" />
            <asp:Button ID="btnCopy" runat="server" CssClass="Hide" />
            <asp:Button ID="btnMove" runat="server" CssClass="Hide" />
        </div>
    </form>
</body>
</html>
