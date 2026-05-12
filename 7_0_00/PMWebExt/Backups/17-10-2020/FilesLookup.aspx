<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="FilesLookup.aspx.vb"
    Inherits="Website.FilesLookup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <style type="text/css">
                .BackColorDark {
                    background-color: #666 !important;
                }

                .TreeWithDarkBackground .rtUL.rtLines {
                    height: calc(100vh - 71px) !important;
                }

                .TreeWithDarkBackground {
                    height: 100%;
                }

                #RAD_SPLITTER_PANE_CONTENT_RadContentPane, .SplitterPanePopup {
                    height: calc(100vh - 50px) !important;
                }

                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .RadTreeView {
                        max-height: 100% !important;
                        overflow: auto;
                        height: calc(100vh - 50px);
                    }

                    #RAD_SPLITTER_PANE_CONTENT_RadContentPane {
                        height: calc(100vh - 50px) !important;
                        width: calc(100vw - 3px) !important;
                    }

                    #RadSplitter1.documentSplitter {
                        padding-top: 4px !important;
                    }

                    .SplitterPanePopup {
                        position: absolute;
                        z-index: 3000;
                        width: 60vw;
                    }
                }

                .documentSplitter {
                    padding-top: 50px;
                }

                .DMSearchButton .Icon {
                    background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
                    width: 24px;
                    height: 24px;
                    background-repeat: no-repeat;
                    background-position: -216px 0px !important;
                    display: inline-block;
                    vertical-align: middle;
                }

                @media screen and (min-width:844px) {
                    .Splitter {
                        height: calc(100vh - 50px) !important;
                    }

                    td#treeFoldersAndFilesPane {
                        display: inline-block !important;
                    }
                }
            </style>
            <script type="text/javascript" src="JS/FileManager/FileManager.js"></script>
            <script type="text/javascript" language="javascript">


                var ALLOWED_IMAGE_EXTENSION = '<%=Me.PM.Parameters.ALLOWED_IMAGE_EXTENSION%>'
                function pageLoad() {
                    $("input[id$='txtSearch']").unbind().keydown(function (event) { searchFiles(event); });
                    $("input[id$='btnSearch']").attr("disabled", "");
                    $("input[id$='btnGetProjects']").attr("disabled", "");
                    CheckParentBox();
                }

                function searchFiles(event) {
                    if (event.keyCode == 13) {
                        __doPostBack('btnSearch', '');
                        return false;
                    }

                }

                function maintoolbarClick(sender, args) {
                    var value = args.get_item().get_commandName();

                    switch (value) {

                        case 'ToggleSplitter':
                            var pane = $find('treeFoldersAndFilesPane');
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                            break;
                    }
                }
                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter') {
                        var pane = $find('treeFoldersAndFilesPane');
                        pane.set_visible(false);
                        return false;
                    }
                }
                function OnClientResized(sender) {
                    setTimeout(FloatDivs, 100);
                    var splitter = sender.get_parent();
                    var pane1 = splitter._panes[0];
                    var pane2 = splitter._panes[1];
                    var pane1Td = pane1._element;
                    pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 8);

                }

                function CheckParentBox() {
                    var rdgRights = $("div[id$='rdgEstimateItems']");
                    var ParentIsNotChecked = true;
                    var i = 0;
                    rdgRights.find("input[type='checkbox']").each(function () {
                        if (i > 0) {
                            if (!this.checked) {
                                if (this.id.indexOf("chkIsIncluded") > 0)
                                    ParentIsNotChecked = false;
                            }
                        }
                        i++;
                    });

                    if (!ParentIsNotChecked) {
                        rdgRights.find("input[type='checkbox']")[0].checked = false;

                    } else {
                        if (i > 0) {
                            rdgRights.find("input[type='checkbox']")[0].checked = true;
                        }

                    }
                }
                function SelectParent(chk) {
                    var rdgRights = $("div[id$='rdgFiles']");
                    if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                    var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                    var i = 0;
                    var isChecked = true;
                    rdgRights.find("input[type='checkbox']").each(function () {
                        if (i > 0) {
                            if (chk.checked) {
                                if (!this.checked) isChecked = false;
                            }
                        }
                        i++;
                    });
                    var hdnCount = $("[id$=hdnCount]");
                    var Value = parseFloat(hdnCount.val());

                    if (!chk.checked) {
                        chkPArent.checked = false;
                        if (Value > 0)
                            Value = Value - 1;


                    } else {
                        chkPArent.checked = isChecked;
                        Value = Value + 1;
                    }
                    hdnCount.val(Value);
                    return false;
                }

                function SelectAll(chk) {
                    var i = 0;
                    var rdg = $("div[id$='rdgFiles']");
                    var j = 0;
                    var k = 0;
                    rdg.find("input[type='checkbox']").each(function () {
                        if (i > 0) {
                            if (!this.disabled && this.id.indexOf("chkIsIncluded") > 0) {
                                if (!this.checked)
                                    j = j + 1;
                                if (this.checked)
                                    k = k + 1;
                                this.checked = chk.checked;
                            }

                        }
                        i++;
                    });

                    var hdnCount = $("[id$=hdnCount]");
                    var Value = parseFloat(hdnCount.val());
                    if (chk.checked) {
                        Value = Value + j;
                        var btnCheckAll = $("[id$=btnCheckAll]");
                        btnCheckAll.click();
                    }
                    else {
                        if ((Value - k) >= 0)
                            Value = Value - k;
                        var btnUncheckAll = $("[id$=btnUncheckAll]");
                        btnUncheckAll.click();
                    }
                    hdnCount.val(Value);
                }

            </script>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxLoadingPanel ID="ldpFileUpload" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="AjaxManagerProxy1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="trvFolders">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadSplitter1" />
                        <telerik:AjaxUpdatedControl ControlID="trvFolders" />
                        <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnGetProjects">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadSplitter1" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgFiles">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="imgPreview" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgFiles">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="trvFolders" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnCheckAll">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnUncheckAll">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div style="background-color: White">
            <table class="MaxWidth" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td class="ToolbarTd">
                        <asp:HiddenField ID="hdnEntitiesValues" runat="server" />
                        <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" AllowCustomText="True"
                            OnClientDropDownClosing="OnClientDropDownClosing_ddlEntities" Filter="Contains"
                            Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Width="200px"
                            DropDownWidth="400px" meta:resourcekey="ddlEntitiesResource1">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <table width="100%" cellpadding="1" cellspacing="0" border="0">
                                        <tr>
                                            <td class="Top">
                                                <asp:CheckBox runat="server" ID="chkEntity" />
                                            </td>
                                            <td style="width: 99%" class="NoWrap">
                                                <asp:Label runat="server" ID="lblEntity" AssociatedControlID="chkEntity">
                                                        <%#Eval("value")%>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ItemTemplate>
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                        <asp:Button ID="btnGetProjects" CssClass="Hide" runat="server" Text="Go" />
                    </td>
                    <td class="SearchToolBar" style="width: 100%">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 240px;" align="center">

                                        <asp:TextBox ID="txtSearch" CssClass="SearchButton" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="btnSearch1" Style="margin-left: 10px" runat="server" CssClass="DMSearchButton">
                                                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </td>
                                    <td style="padding-left: 40px;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblSearchContent" runat="server" Text="Search file contents" meta:ResourceKey="chkSearchContent"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <label class="switch">
                                                        <input id="chkSearchContent" runat="server" type="checkbox" />
                                                        <span class="slider round"></span>
                                                    </label>

                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Hide" />
                                    </td>
                                    <%--                            <td>
                                        <asp:CheckBox runat="server" ID="" Text="Search file contents" meta:ResourceKey="chkSearchContent" />

                                    </td>--%>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>

                </tr>
            </table>
            <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter Splitter">
                <telerik:RadPane ID="treeFoldersAndFilesPane" runat="server" Width="420px" CssClass="SplitterPanePopup " OnClientExpanded="OnClientResized"
                    MinWidth="100">
                    <table border="0" cellpadding="0" cellspacing="0" class="ToolBar" style="width: calc(70vw) !important;">
                        <tr>
                            <td class="ToolbarTd ShowOnMobile">
                                <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick" Height="50px" Style="line-height: 45px;">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" class="NormalWhiteBack" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td style="padding-top: 0px; vertical-align: top; height: 100%;">
                                <telerik:RadTreeView ID="trvFolders" CssClass="trvFoldersPaddingTop" DropDownCssClass="ddlTreeviewTemplate"
                                    runat="server" EnableDragAndDrop="False" OnClientContextMenuShowing="onClientContextMenuShowing"
                                    Skin="Default" MultipleSelect="false" OnContextMenuItemClick="trvFolders_ContextMenuItemClick"
                                    OnClientContextMenuItemClicking="onClientContextMenuItemClicking">
                                    <ContextMenus>
                                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu"
                                            Width="100%">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Value="Open" Text="Open" CssClass="MenuOpen">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadTreeViewContextMenu>
                                    </ContextMenus>
                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                </telerik:RadTreeView>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" EnableEmbeddedBaseStylesheet="False" CssClass="TreeToolbarSplitbar" Index="1" Skin="" />
                <telerik:RadPane ID="RadContentPane" runat="server" OnClientResized="OnClientResized" CssClass="fullWidthPane" Index="2" Skin="">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
                        <tr>
                            <td class="ToolbarTd ShowOnMobile">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick" Style="line-height: 45px;">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>

                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgFiles" runat="server" AllowMultiRowSelection="True" AutoGenerateColumns="True"
                                    GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="false" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                    Width="100%" AllowFilteringByColumn="true" AllowPaging="true" AllowSorting="true" SetWidth="true" AppendMenus="true"
                                    PageSize="10">
                                    <HeaderStyle Font-Size="8pt" />
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <ClientSettings Selecting-AllowRowSelect="true" ClientEvents-OnRowDblClick="LookupFile_RowDblClick_SelectFile">
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView CommandItemDisplay="Top" TableLayout="Fixed">
                                        <CommandItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnOpenContainingFolder" runat="server" CausesValidation="false" CssClass="GridCmdOpenContainingFolder"
                                                            Visible="false" CommandName="OpenContainingFolder">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblOpenContainingFolder" Text="Open Containing Folder" runat="server" />
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnUpLoadFile" runat="server" OnClientClick="javascript:UploadFileFromLookup();return false;" CssClass="GridCmdUploadFile"
                                                            CommandName="UploadFile" CausesValidation="false">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" Text="Check In" ID="Label2"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnSave" runat="server" CommandName="AttachSelected" CausesValidation="false" CssClass="GridCmdAttachSelected">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblSave" runat="server" Text="Save1" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnSaveAndExit" runat="server" CommandName="AttachSelectedAndExit" CssClass="GridCmdAttachSelectedAndExit"
                                                            CausesValidation="false" OnClientClick="CloseFileslookupPopup();">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label4" runat="server" Text="Save1" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                            Visible="<%# rdgFiles.EditIndexes.Count = 0 And (Not rdgFiles.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnPreview" runat="server" CausesValidation="false" CommandName="Preview" CssClass="GridCmdPreview">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblPreview" Text="Preview" runat="server" />
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnShowLastVersion" runat="server" CausesValidation="false" CommandName="ShowLastVersion"
                                                            Visible="false">
                                                            <asp:Label runat="server" Text="Show Last Versions Only" ID="Label1"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnShowAllVersions" runat="server" CausesValidation="false" CommandName="ShowAllVersions"
                                                            Visible="true">
                                                            <asp:Label runat="server" Text="Show All Versions" ID="Label3"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </CommandItemTemplate>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                                Groupable="false" Reorderable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkIsIncluded" runat="server"
                                                        onclick="SelectParent(this);" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:Label ID="lblSelect" runat="server" Text=""></asp:Label>
                                                    <asp:CheckBox ID="chkAll" runat="server" TextAlign="Left"
                                                        onclick="SelectAll(this);" />
                                                </HeaderTemplate>
                                                <HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridClientSelectColumn HeaderText="" Visible="false" UniqueName="CheckboxSelectColumn" />
                                            <telerik:GridTemplateColumn HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                UniqueName="CanSelect" AllowFiltering="false" CurrentFilterFunction="EqualTo"
                                                DataField="CanSelect" AutoPostBackOnFilter="false" SortExpression="CanSelect"
                                                Groupable="false" DataType="System.Boolean"
                                                FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCanSelect" runat="server" Text=''></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                UniqueName="FileId" AllowFiltering="false" CurrentFilterFunction="EqualTo" DataField="FileId"
                                                AutoPostBackOnFilter="true" SortExpression="FileId" Groupable="false"
                                                DataType="System.Int32" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileId" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select"
                                                            Reorderable="false">
                                                        </telerik:GridClientSelectColumn>--%>
                                            <telerik:GridTemplateColumn HeaderText="" UniqueName="IsInBluebeamSession" HeaderStyle-Width="50px" Groupable="False" Reorderable="false"
                                                ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:Image runat="server" Style="margin: 0px !important;" CssClass="BluebeamIcon" ID="Image1" Visible='<%# Eval("IsInBluebeamSession")%>' ImageUrl="~/Images/FileManager/bluebeamLogoSmall.png" />
                                                    <span class="Icon"></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="" ItemStyle-Wrap="false" UniqueName="CheckedIn_Out"
                                                AllowFiltering="false" CurrentFilterFunction="EqualTo" DataField="CheckedIn_Out"
                                                AutoPostBackOnFilter="true" SortExpression="CheckedIn_Out" Groupable="false"
                                                DataType="System.Boolean" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="imgCheck" Style="cursor: pointer; padding-left: 10px" runat="server"><span class="Icon"></span> </asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                                <HeaderStyle Width="50px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="File Name" UniqueName="FileName" AllowFiltering="true"
                                                CurrentFilterFunction="Contains" DataField="FileName" AutoPostBackOnFilter="true"
                                                SortExpression="FileName" Groupable="false"
                                                DataType="System.String" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <span>
                                                        <asp:Label ID="lblObjectId" runat="server" CssClass="Hide" Text='<%#Eval("ObjectId")%>'></asp:Label>
                                                        <asp:Label ID="lblFullFileName" runat="server" CssClass="Hide" Text='<%#Eval("FilePath")%>'></asp:Label>
                                                        <asp:Label ID="lblFileName" runat="server" Visible="true" Text='<%#Eval("FileName")%>'></asp:Label></span>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Path" UniqueName="FolderPath" ItemStyle-Wrap="false"
                                                AllowFiltering="false" CurrentFilterFunction="Contains" DataField="Path"
                                                AutoPostBackOnFilter="true" SortExpression="Path" Groupable="false"
                                                DataType="System.String" FilterListOptions="VaryByDataType" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPath" runat="server" Text='<%#Eval("Path")%>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Version" UniqueName="Version" ItemStyle-Wrap="false"
                                                Groupable="false"
                                                SortExpression="Version" AllowFiltering="false" CurrentFilterFunction="Contains"
                                                DataField="Version" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <asp:Label CssClass="Hide" ID="lblIsLastVersion" runat="server" Text='<%#Eval("IsLastVersion")%>'></asp:Label>
                                                    <asp:Label CssClass="Hide" ID="lblOriginalVersionFileId" runat="server" Text='<%#Eval("OriginalVersionFileId")%>'></asp:Label>
                                                    <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("Version")%>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="50px"></HeaderStyle>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" ItemStyle-Wrap="false"
                                                AllowFiltering="false" CurrentFilterFunction="EqualTo" DataField="FileSize" AutoPostBackOnFilter="true"
                                                SortExpression="FileSize" Groupable="false"
                                                DataType="System.Int32" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileSize" runat="server" Text='<%#FormatByte(CInt(Eval("FileSize")))%>'></asp:Label>
                                                    <asp:HiddenField ID="hdnFileSize" runat="server" Value='<%#ParseInt(Eval("FileSize"))%>' />
                                                </ItemTemplate>
                                                <HeaderStyle Width="80px"></HeaderStyle>
                                                <ItemStyle Wrap="False" HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-Wrap="false"
                                                Groupable="false" SortExpression="Type"
                                                AllowFiltering="true" CurrentFilterFunction="Contains" DataField="Type" AutoPostBackOnFilter="true"
                                                DataType="System.String" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" ItemStyle-Wrap="false"
                                                Groupable="false" SortExpression="Category"
                                                AllowFiltering="true" CurrentFilterFunction="Contains" DataField="Category" AutoPostBackOnFilter="true"
                                                DataType="System.String" FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Workflow Status" UniqueName="WorkflowStatus"
                                                ItemStyle-Wrap="false" Groupable="false"
                                                SortExpression="WorkflowStatus" AllowFiltering="true" CurrentFilterFunction="Contains"
                                                DataField="WorkflowStatus" AutoPostBackOnFilter="true" DataType="System.String"
                                                FilterListOptions="VaryByDataType">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("WorkflowStatus") = String.Empty, "&nbsp;", Container.DataItem("WorkflowStatus"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="140px"></HeaderStyle>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Last Modified" UniqueName="LastModified"
                                                ItemStyle-Wrap="false" Visible="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblModifiedDate" runat="server" Text='<%#Eval("ModifiedDate")%>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Last Checked In/Out" UniqueName="LastCheckedInOut"
                                                ItemStyle-Wrap="false" Visible="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCheckedByUserName" runat="server" Text='<%#Eval("CheckedByUserName")%>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridDateTimeColumn UniqueName="$Date1$" Display="False" AllowFiltering="True" DataType="System.DateTime">
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridCheckBoxColumn UniqueName="$Boolean1$" Display="False" AllowFiltering="True" DataType="System.boolean">
                                            </telerik:GridCheckBoxColumn>
                                        </Columns>
                                        <NoRecordsTemplate>
                                            <table style="height: 200px; width: 100%">
                                                <tr>
                                                    <td class="Top Center">
                                                        <asp:Label runat="server" ID="lblNoFileToDisplay" Text="No Files to display." meta:resourcekey="lblNoFileToDisplay"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </div>
                        </div>
                        <div class="row">
                            <asp:Panel ID="pnlPreview" runat="server" Style="padding-left: 5px; margin-top: 7px;">
                                <fieldset style="width: 250px;" class="Padding7">
                                    <legend>
                                        <asp:Label runat="server" ID="lblPreview" meta:resourcekey="legend_Preview"></asp:Label></legend>
                                    <asp:Image ID="imgPreview" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="200px" />
                                </fieldset>
                            </asp:Panel>
                        </div>
                    </div>
                </telerik:RadPane>
            </telerik:RadSplitter>
        </div>
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" meta:resourcekey="PMWindowManagerResource1"
            Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" meta:resourcekey="ldpPMResource1" />
        <asp:Button ID="btnSaveExit" runat="server" CssClass="Hide" />
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
        <asp:Button ID="btnUncheckAll" runat="server" CssClass="Hide" />
        <asp:Button ID="btnCheckAll" runat="server" CssClass="Hide" />
    </form>
</body>
</html>
