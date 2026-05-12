<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FolderManager.aspx.vb"
    MasterPageFile="~/PmMaster.Master" Inherits="Website.FolderManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="FileManagerPermissions.ascx" TagName="FileManagerPermissions" TagPrefix="uc1" %>
<%@ Register Src="FilesAttributes.ascx" TagName="FilesAttributes" TagPrefix="uc2" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc3" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc6" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc9" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentManagerDetailsPane.ascx" TagName="DetailPane" TagPrefix="uc12" %>
<%@ Register Src="~/FolderManagerBookMarks.ascx" TagPrefix="uc13" TagName="FolderManagerBookMarks" %>
<%@ Register Src="~/FolderManagerAdvancedSearchResult.ascx" TagPrefix="uc1" TagName="FolderManagerAdvancedSearchResult" %>


<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" EnableStyleSheetCombine="true"></telerik:RadStyleSheetManager>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript" src="JS/FileManager/FileManager.js?version=<%= PM.Security.LicenseInfo.PMWebVersion %>"></script>
        <script src="JS/Scoring.js" type="text/javascript"></script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">

        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnUpload">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnUpload" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSorting">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSorting" />
                    <telerik:AjaxUpdatedControl ControlID="CardViewContainer" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefreshRootGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlRoot" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshRootGrid" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAddNewFolderAndRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnAddNewFolderAndRefresh" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefreshCurrentWorkingFolder">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshCurrentWorkingFolder" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>


        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAddNewFolder">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mainContent" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnAddNewFolder" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRemoveFolderEditMode">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mainContent" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRemoveFolderEditMode" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>


        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RootContextMenu">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RootContextMenu" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgRoot" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="floatButton" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="SearchBar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" />
                    <telerik:AjaxUpdatedControl ControlID="rdgRoot" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgRoot">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgRoot" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="RootContextMenu" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="floatButton" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                    <telerik:AjaxUpdatedControl ControlID="filePermissionSeperator" />
                    <telerik:AjaxUpdatedControl ControlID="btnFilePermission" />
                    <telerik:AjaxUpdatedControl ControlID="SearchBar" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnCardClick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DetailPane1" LoadingPanelID="ldpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="btnCardClick" LoadingPanelID="ldpDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnListViewRowClick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DetailPane1" LoadingPanelID="ldpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="btnListViewRowClick" LoadingPanelID="ldpDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>


        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefreshDetailsPane">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DetailPane1" LoadingPanelID="ldpDetails" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshDetailsPane" LoadingPanelID="ldpDetails" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>



        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefreshWithoutDetailsPane">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mainContent" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshWithoutDetailsPane" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rptFilesCardView" EventName="ItemDrop">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CardViewContainer" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>


        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rptFoldersCardView" EventName="ItemDrop">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CardViewContainer" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgFiles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                    <telerik:AjaxUpdatedControl ControlID="btnFilePermission" />
                    <telerik:AjaxUpdatedControl ControlID="filepermissionseperator" />
                    <telerik:AjaxUpdatedControl ControlID="SearchBar" />
                    <%--<telerik:AjaxUpdatedControl ControlID="DetailPane1"/>--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnCardDoubleClick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlFolder" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rptFolderId" />
                    <telerik:AjaxUpdatedControl ControlID="lblBookMarksSearch" />
                    <telerik:AjaxUpdatedControl ControlID="btnFilePermission" />
                    <telerik:AjaxUpdatedControl ControlID="filePermissionSeperator" />
                    <telerik:AjaxUpdatedControl ControlID="SearchBar" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmFileActions">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmFileActions" />
                    <telerik:AjaxUpdatedControl ControlID="DetailPane1" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hdnCurrentWorkingFolder" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="Folder_DocumentManager">
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="SmallToolbar">
            <tr class="ToolBar">
                <td class="ToolbarTd" id="btnFilesFolders" runat="server" visible="false">
                    <asp:LinkButton runat="server" ID="lnkBtnFilesFolders">
                                <div class="btnToolbarFoldersFiles">
                                                   &nbsp; 
                                                </div>
                    </asp:LinkButton>
                </td>
                <td class="ToolbarTd">
                    <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=59">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                    </asp:HyperLink>
                </td>
                <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                    <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                    </asp:LinkButton>
                </td>
                <td class="ToolbarTd HideOnMobileToolbar showOnIpad" id="btnBookMarks" runat="server">
                    <asp:LinkButton runat="server" ID="lnkBtnBookMark" CssClass="bookMark" meta:ResourceKey="btnBookMarks">
                        <span class="Icon" id="span3" runat="server"></span>
                    </asp:LinkButton>
                </td>
                <asp:Panel ID="searchBarSeperator" runat="server">
                    <td class="ToolbarTd seperator b"></td>
                </asp:Panel>
                <td class="HideOnMobileToolbar showOnIpad">
                    <div runat="server" id="SearchBar" visible="true" class="searchBar">
                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="searchLoop">
                       <span class="Icon"></span>
                        </asp:LinkButton>
                        <asp:TextBox ID="txtManagerSearch" CssClass="txtSearch" runat="server"></asp:TextBox>
                        <asp:LinkButton ID="btnClearSelection" runat="server" CssClass="clearSelection">
                       <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                </td>


                <td id="btnAdvancedSearchTd" runat="server" class="ToolbarTd HideOnMobileToolbar ADVANCEDSEARCH showOnIpad">
                    <asp:LinkButton runat="server" ID="btnAdvancedSearch" OnClientClick="openAdvancedSearchPopUp();return false;"
                        CssClass="advancedSearch" meta:ResourceKey="btnAdvancedSearch">
                        <span class="Icon" id="span2" runat="server"></span>
                    </asp:LinkButton>
                </td>

                <td runat="server"  class="ToolbarTd">
                    <asp:Label id="filePermissionSeperator" class="verticalSeperator" runat="server"></asp:Label>
                </td>

                <td class="ToolbarTd HideOnMobileToolbar showOnIpad">
                    <asp:LinkButton runat="server" ID="btnFilePermission" CssClass="filePermission" meta:ResourceKey="btnFilePermission">
                    <span class="Icon" runat="server"></span>
                    </asp:LinkButton>
                </td>

                <td class="ToolbarTd HideOnMobileToolbar showOnIpad">
                    <asp:Button ID="btnCloseSearch" runat="server" Text="Close Search" Style="width: 120px !important" Visible="false" />
                </td>
                <td style="width: 100%"></td>
            </tr>
        </table>
        <asp:Button ID="btnDownload" runat="server" CssClass="Hide" />


        <asp:Panel ID="pnlFolder" runat="server" Visible="true">
            <div class="menu" id="menuToolbar" runat="server">
                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="mainToolBar_clicked" runat="server" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Read" CssClass="Add" Value="Add" ImageUrl="Images/ToolBar/Save.png" PostBack="false"
                            CommandName="Add" AccessKey="s" ToolTip="Save (Alt+s)" Text="Add" meta:ResourceKey="mainToolBar_Add">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton Value="AddSeperator" IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" CssClass="Enabled" Value="ShowLatestVersions"
                            CommandName="ShowLatestVersions" AccessKey="s" Text="Latest Versions" meta:ResourceKey="mainToolBar_ShowLatestVersions">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="Details" CssClass="Enabled" PostBack="false"
                            CommandName="Details" AccessKey="s" Text="Details" meta:ResourceKey="mainToolBar_Details">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="CardView"
                            CommandName="CardView" AccessKey="s" ToolTip="Save (Alt+s)" Text="Card View" meta:ResourceKey="mainToolBar_CardView">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="ListView"
                            CommandName="ListView" AccessKey="s" ToolTip="Save (Alt+s)" Text="List View" meta:ResourceKey="mainToolBar_ListView">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Save.png" Value="Sort" PostBack="false"
                            CommandName="Sort" AccessKey="s" ToolTip="Save (Alt+s)" Text="Sort" meta:ResourceKey="mainToolBar_Sort">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarDropDown CssClass="ToolbarLayout"  Text="Layout" PostBack="false" EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="True" Text="Save Layout" CommandName="SaveLayout" Value="SaveLayout" CssClass="ToolbarUser"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="True" Text="Load Default Layout" CommandName="LoadDefaultState" Value="LoadDefaultState" CssClass="ToolbarDelegate"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarDropDown>--%>
                    </Items>
                </telerik:RadToolBar>
                <telerik:RadMenu ID="rdmFolderManagerLayouts" Style="float: none; display: inline-block; margin-left: -10px; vertical-align: middle;" securitybuttontype="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                    CollapseAnimation-Type="None" OnItemClick="rdmFolderManagerLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack rdmLayouts HideOnMobileToolbar "
                    EnableShadows="true" CausesValidation="false"
                    Visible="true">
                </telerik:RadMenu>
            </div>
            <div class="PMMainPage" style="height: calc(100vh - 140px); background: white;">
                <div class="row row-8-4-fit8" style="position: relative;">
                    <div class="col-8" id="filesGridPane" runat="server" style="height: calc(100vh - 140px);">
                        <div class="Js-DropZone" id="dropZone" runat="server">
                            <asp:Panel runat="server" ID="mainContent">
                                <telerik:RadGrid ID="rdgFiles" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="false" CssClass="rdgDocumentManager rgHeaderRightBorder" ClientSettings-Resizing-AllowColumnResize="true"
                                    GridLines="None" HeaderStyle-Font-Size="8" OnRowDrop="rdgFiles_RowDrop"
                                    ShowStatusBar="false" ClientSettings-Scrolling-AllowScroll="true"
                                    AllowSorting="true" ShowFooter="false" AllowFilteringByColumn="false" ClientSettings-Scrolling-UseStaticHeaders="true"
                                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="false" Height="100%" fitpageheightoffset="5">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                    <HeaderStyle Font-Size="8pt" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true" Width="1px" 
                                        CommandItemDisplay="None" AllowMultiColumnSorting="false"
                                         EditMode="InPlace" DataKeyNames="Id,IsSelected,IsEligible" ClientDataKeyNames="Id,IsLastVersion,Extension,DocStatusId,UploadFiles,CheckedIn,CheckedById,EditFiles,DeleteFiles,ManageFolder,FolderId,WorkflowStatusId,IsInBluebeamSession,IsEligible,IsFolder" EnableHeaderContextMenu="true">
                                        <CommandItemTemplate>
                                            <div>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    Visible="<%# rdgFiles.EditIndexes.Count = 0 And (Not rdgFiles.MasterTableView.IsItemInserted) %>">
                                                    <span class="Icon"></span>
                                                    <asp:Label
                                                        runat="server" ID="lblRefresh"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                        <Columns>
                                            <telerik:GridClientSelectColumn HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" Resizable="true" HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" Resizable="true" HeaderText="Action" UniqueName="Action" AllowSorting="false" Groupable="false">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server" OnClick="imgAction_Click">
                                                    <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server" OnClick="imgAction_Click">
                                                    <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </EditItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Root" HeaderStyle-Width="70px" Resizable="true" ItemStyle-HorizontalAlign="Left" UniqueName="Root" SortExpression="Root" Groupable="true"
                                                DataField="Root" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="hplRoot" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Root")%></u></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Entity" HeaderStyle-Width="190px" Resizable="true" UniqueName="Entity" SortExpression="Entity" Groupable="true"
                                                DataField="Entity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="hplEntity" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Entity")%></u></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle />
                                                <HeaderStyle Width="200px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Folder" HeaderStyle-Width="190px" Resizable="true" UniqueName="Folder" SortExpression="Folder" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="Folder" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="hplFolder" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Folder")%></u></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle />
                                                <HeaderStyle Width="120px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="30px" Resizable="true" AllowSorting="false" Groupable="False" UniqueName="Icon"
                                                AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="imgRedlining" runat="server">
                                                        <span id="spanImg" class="smallIcon" runat="server"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="imgRedlining" runat="server">
                                                        <span id="spanImg" class="smallIcon" runat="server"></span>
                                                    </asp:LinkButton>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="File Name" HeaderStyle-Width="180px" Resizable="true" UniqueName="FileName" SortExpression="FileName" Groupable="false" ItemStyle-HorizontalAlign="Left"
                                                DataField="FileName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%# IIf(Eval("IsFolder"), Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", ""), Eval("FileName")) %></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="newFolderCreatedInListView" ID="txtFolderName" onfocus="this.select();"  onblur="removeFolderEditMode();" onkeypress="addNewFolder(event , this)"></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="220px" Resizable="true" UniqueName="Description" SortExpression="Description" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="Description"  GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Description") Is DBNull.Value OrElse Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="220px" Resizable="true" UniqueName="Type" SortExpression="Type" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="Type"  GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Type") Is DBNull.Value OrElse Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Category" HeaderStyle-Width="220px" Resizable="true" UniqueName="Category" SortExpression="Category" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="Category"  GroupByExpression="Category [Category] Group By Category ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Category") Is DBNull.Value OrElse Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="220px" Resizable="true" UniqueName="WorkflowStatus" SortExpression="WorkflowStatus" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="WorkflowStatus"  GroupByExpression="WorkflowStatus [WorkflowStatus] Group By WorkflowStatus ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("WorkflowStatus") Is DBNull.Value OrElse Container.DataItem("WorkflowStatus") = String.Empty, "&nbsp;", Container.DataItem("WorkflowStatus"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Added By" HeaderStyle-Width="220px" Resizable="true" UniqueName="CreatedByUserName" SortExpression="CreatedByUserName" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="CreatedByUserName"  GroupByExpression="CreatedByUserName [CreatedByUserName] Group By CreatedByUserName ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("CreatedByUserName") Is DBNull.Value OrElse Container.DataItem("CreatedByUserName") = String.Empty, "&nbsp;", Container.DataItem("CreatedByUserName"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Last Checked In/Out By" HeaderStyle-Width="220px" Resizable="true" UniqueName="CheckedByUserName" SortExpression="CheckedByUserName" Groupable="true" ItemStyle-HorizontalAlign="Left"
                                                DataField="CheckedByUserName"  GroupByExpression="CheckedByUserName [CheckedByUserName] Group By CheckedByUserName ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("CheckedByUserName") Is DBNull.Value OrElse Container.DataItem("CheckedByUserName") = String.Empty, "&nbsp;", Container.DataItem("CheckedByUserName"))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Document #" HeaderStyle-Width="100px" Resizable="true" UniqueName="Id" SortExpression="DocumentNbr" Groupable="False" ItemStyle-HorizontalAlign="Left"
                                                DataField="Id" CurrentFilterFunction="EqualTo" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lblDocumentNumber" Font-Underline="true" Text='<%#Container.DataItem("Id").ToString() %>' runat="server" NavigateUrl='<%# "PMWebRecord.aspx?Id=" + Container.DataItem("Id").ToString() %>'></asp:HyperLink>
                                                    <asp:LinkButton ID="lnkBtnOpenFolder" runat="server" Visible="false" Text="Open Folder" Style="text-transform: uppercase"></asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle />
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderText="Size"  HeaderStyle-Width="75px" Resizable="true" UniqueName="Size" ItemStyle-Wrap="false" Groupable="false" ItemStyle-HorizontalAlign="Left"
                                                SortExpression="FileSize" DataField="FileSize" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileSize" runat="server" Text='<%#IIf(Container.DataItem("ContentType") = "Folder", "&nbsp;", FormatByte(ParseInt(Eval("FileSize"))))%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Ext." HeaderStyle-Width="75px" Resizable="true" UniqueName="Extension" ItemStyle-Wrap="false" GroupByExpression="Extension [GridColumn_Extension] Group By Extension ASC" ItemStyle-HorizontalAlign="Left"
                                                SortExpression="Extension" DataField="Extension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtFileDescription" runat="server" Text='<%#Eval("Extension")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Version" HeaderStyle-Width="75px" Resizable="true" UniqueName="Version" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Version [GridColumn_Version] Group By Version ASC" ItemStyle-HorizontalAlign="Left"
                                                SortExpression="Version" DataField="Version" DataType="System.String" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:Label CssClass="Hide" ID="lblIsLastVersion" runat="server" Text='<%#Eval("IsLastVersion")%>'></asp:Label>
                                                    <asp:Label CssClass="Hide" ID="lblOriginalVersionFileId" runat="server" Text='<%#Eval("OriginalVersionFileId")%>'></asp:Label>
                                                    <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("Version")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Last Updated" HeaderStyle-Width="75px" Resizable="true" SortExpression="LastModified" UniqueName="LastUpdated" GroupByExpression="ModifiedDate1 [GridColumn_LastUpdated] Group By ModifiedDate1 ASC"
                                                ItemStyle-Wrap="false" DataField="LastUpdated" CurrentFilterFunction="GreaterThanOrEqualTo" ItemStyle-HorizontalAlign="Left" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblModifiedDate" runat="server" Text='<%#FormatDate(Eval("ModifiedDate1"))%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span></span>
                                                </EditItemTemplate>
                                                <ItemStyle CssClass="text-left"></ItemStyle>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <NoRecordsTemplate>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="Top Center">
                                                        <asp:Label ID="lblNoFileToDisplay" runat="server" meta:ResourceKey="lblNoFileToDisplay"
                                                            Text="No Files to display."></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings Scrolling-SaveScrollPosition="true" Selecting-AllowRowSelect="true" AllowRowsDragDrop="true"
                                        ClientEvents-OnRowDropping="rdgFiles_OnRowClientDropping"  ClientEvents-OnRowMouseOver="rdgFiles_OnRowMouseOver"
                                        ClientEvents-OnRowClick="rdgFiles_OnRowClick" ClientEvents-OnRowSelecting="rdgFiles_OnRowSelecting" ClientEvents-OnRowDeselecting="rdgFiles_OnRowDeselecting" ClientEvents-OnRowDeselected="rdgFiles_OnRowDeselected" ClientEvents-OnRowContextMenu="rdgFiles_OnRowContextMenu">
                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                                    </ClientSettings>

                                </telerik:RadGrid>
                                <div class="cardView" id="CardViewContainer" runat="server">
                                    <div>
                                        <asp:HiddenField runat="server" ID="hdnCardViewSelectedForDrop" />
                                        <div class="foldersContainer" id="foldersContainer" runat="server">
                                            <h2 meta:resourcekey="lblFolders">Folders</h2>
                                            <div class="preFoldersContainer" id="preFoldersContainer" runat="server"></div>
                                            <telerik:RadListView runat="server" ID="rptFoldersCardView" ClientDataKeyNames="Id , FileName, IsFolder" OnItemDrop="rptFoldersCardView_ItemDrop" ItemPlaceholderID="FoldersCardViewContainer">
                                                <ClientSettings AllowItemsDragDrop="true">
                                                    <ClientEvents OnItemDropping="rptFoldersCardView_OnItemDropping" OnItemDragging="rptFoldersCardView_OnItemDragging" />
                                                </ClientSettings>
                                                <LayoutTemplate>
                                                    <div>
                                                        <asp:PlaceHolder ID="FoldersCardViewContainer" runat="server"></asp:PlaceHolder>
                                                    </div>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <div class="rlvI">
                                                        <div class="rlvDrag" id="rlvDrag" runat="server">
                                                            <div style="margin: 0px 16px 16px 0; float: left">
                                                                <div id="folderCard" runat="server" title='<%#Eval("FileName")%>'>
                                                                    <div class="mainContent">
                                                                        <div class="check">
                                                                            <span class="icon"></span>
                                                                        </div>
                                                                        <span class="FolderIcon" runat="server">
                                                                            <span class="smallIcon" runat="server"></span>
                                                                        </span>
                                                                        <span class='folderName <%#IIF(Eval("Id") = -1 , "editable" , "")%>'>
                                                                            <span id="folderLabel" runat="server"><%#Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", "")  %> </span>
                                                                            <label id="folderTextbox" class="newFolder" runat="server">
                                                                                <input value="Folder" onblur="removeFolderEditMode();" onfocus="this.select();" onkeypress="addNewFolder(event , this)" type="text" />
                                                                            </label>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadListView>
                                        </div>
                                        <div class="filesContainer" id="filesContainer" runat="server">
                                            <h2 meta:resourcekey="lblFiles">Files</h2>
                                            <telerik:RadListView runat="server" ID="rptFilesCardView"
                                                ClientDataKeyNames="Id,FileName,DocStatusId,CheckedIn,CheckedById,DeleteFiles,ManageFolder,FolderId,WorkflowStatusId,IsInBluebeamSession,IsEligible,IsFolder"
                                                OnItemDrop="rptFilesCardView_ItemDrop" ItemPlaceholderID="FilesCardViewContainer">
                                                <ClientSettings AllowItemsDragDrop="true">
                                                    <ClientEvents OnItemDragging="rptFilesCardView_OnItemDragging" OnItemDropping="rptFilesCardView_OnItemDropping" />
                                                </ClientSettings>
                                                <LayoutTemplate>
                                                    <div>
                                                        <asp:PlaceHolder ID="FilesCardViewContainer" runat="server"></asp:PlaceHolder>
                                                    </div>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <div class="rlvI">
                                                        <div class="rlvDrag" onmousedown="Telerik.Web.UI.RadListView.HandleDrag(event , '<%#Container.OwnerListView.ClientID %>' , <%#Container.DisplayIndex %>)">
                                                            <div id="card" runat="server" title='<%#Eval("FileName")%>'>
                                                                <div class="mainContent">
                                                                    <div class="check">
                                                                        <span class="icon"></span>
                                                                    </div>
                                                                    <div class="content">
                                                                        <%--<img alt="" src="Images/Charts/Marble.gif" />--%>
                                                                        <asp:Image ID="imgDisplay" runat="server" />
                                                                        <%--<span id="spnIcon" runat="server" visible="false"></span>--%>
                                                                    </div>
                                                                    <div class="linkRecord">
                                                                        <a href='<%#"PmwebRecord.aspx?Id=" + Eval("Id").ToString() %>'>
                                                                            <span id="cardIcon" runat="server">
                                                                                <span class="smallIcon"></span>
                                                                            </span>
                                                                            <%# Eval("Id").ToString() + " - " + Eval("FileName")%> 

                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadListView>
                                        </div>
                                    </div>
                                </div>
                                <div id="emptyFolder" runat="server" style="display: table; text-align: center; height: 100%; width: 100%" visible="false">
                                    <div style="display: table-cell; vertical-align: middle; height: calc( 100vh - 140px);">
                                        <asp:Image ID="imgEmptyFolder" Style="height: 200px; width: 200px; display: inline-block" runat="server" ImageUrl="CSS/Images/FolderManagerIcons/EmptyFolderIcon.png"></asp:Image>
                                        <br />
                                        <asp:Label ID="lblEmptyFolder" runat="server" Text="Drop Files here or click the Add Button" meta:ResourceKey="lblEmptyFolder" Style="font-size: 14px; color: #666;"></asp:Label>
                                    </div>
                                </div>
                            </asp:Panel>

                        </div>
                        <asp:Label ID="lblResult" runat="server" Style="display: none;" CssClass="Validator"></asp:Label>
                        <div id="floatButtonFiles" class="floatButton" onclick="openFileActionContextMenu(event)">
                            <span class="circle"></span>
                            <span class="circle"></span>
                            <span class="circle"></span>
                        </div>
                    </div>
                    <div class="col-4" id="DetailsPane" runat="server" style="overflow: auto; border-left: 1px solid gray; background: white;">

                        <asp:Button runat="server" ID="btnListViewRowClick" OnClick="btnListViewRow_Click" CssClass="Hide" />
                        <uc12:detailpane id="DetailPane1" runat="server" />
                    </div>
                </div>
            </div>
            <input type="hidden" runat="server" id="hdnCardViewSelected" />
            <asp:HiddenField ID="hdnIsCardView" runat="server" />
            <asp:HiddenField ID="hfManageFolder" runat="server" />
            <asp:HiddenField ID="hfCanAddFiles" runat="server" />
            <asp:HiddenField runat="server" ID="hdnMouseOverId" />
            <input type="hidden" runat="server" id="hdnCurrentWorkingFolder" />
            <asp:Button ID="btnRefreshWithoutDetailsPane" runat="server" CssClass="Hide" />
            <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" CssClass="Hide" />
            <asp:Button ID="btnRefreshDetailsPane" runat="server" CssClass="Hide" />

            <telerik:RadContextMenu OnClientItemClicking="folderContextMenu_OnClientItemClicking"
                runat="server" ID="folderContextMenu" CssClass="rootMenu" ClickToOpen="true" ExpandAnimation-Duration="500">
                <Items>
                    <telerik:RadMenuItem Value="NewFolder" Text="Folder" meta:ResourceKey="folderContextMenu_Folder"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="IsSeperator" IsSeparator="true"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="FromComputer" Text="From Your Computer" PostBack="false" meta:ResourceKey="folderContextMenu_FromYourComputer"></telerik:RadMenuItem>
                    <%--<telerik:RadMenuItem Value="FromBox" Text="FromBox"></telerik:RadMenuItem>
            <telerik:RadMenuItem Value="FromGoogleDrive" Text="From Google Drive"></telerik:RadMenuItem>--%>
                </Items>
            </telerik:RadContextMenu>
        </asp:Panel>
        <asp:Button ID="btnUpload" runat="server" class="Hide" />
        <asp:HiddenField ID="hdnFilesToAdd" runat="server" />
        <asp:HiddenField ID="hdnFoldersToAdd" runat="server" />

        <asp:Panel ID="pnlRoot" CssClass="rootPanel" runat="server" Visible="false">
            <telerik:RadGrid runat="server" ID="rdgRoot" AllowMultiRowSelection="true" setwidth="true" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" fitpageheightoffset="24"
                ShowFooter="false" ShowGroupPanel="false" CssClass="rdgDocumentManager" GridLines="None" HeaderStyle-Font-Size="8" AllowPaging="true" PageSize="250"
                ClientSettings-Scrolling-AllowScroll="true" Width="100%" AllowFilteringByColumn="false" ClientSettings-Scrolling-UseStaticHeaders="true"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="false">
                <HeaderStyle Font-Size="8pt" HorizontalAlign="Left" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None"
                    InsertItemDisplay="Top" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="30px" Groupable="False" Reorderable="false"
                            ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton CssClass="FolderIcon" runat="server">
                                <span class="smallIcon" runat="server"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings Selecting-AllowRowSelect="true" ClientEvents-OnRowDblClick="OnNotesRowClick" ClientEvents-OnRowSelected="rdgRoot_OnRowSelected" ClientEvents-OnRowContextMenu="rdgRoot_OnRowContextMenu"
                    ClientEvents-OnRowDeselected="rdgRoot_OnRowDeselected" ClientEvents-OnRowCreated="rdgRoot_OnRowCreated">
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
            </telerik:RadGrid>

            <div id="floatButton" runat="server" class="floatButton rootFloatButton" onclick="openContextMenu(event)">
                <span class="circle"></span>
                <span class="circle"></span>
                <span class="circle"></span>
            </div>


            <telerik:RadContextMenu OnClientShowing="RootContextMenu_OnClientShowing" OnClientItemClicking="RootContextMenu_OnClientItemClicking"
                runat="server" ID="RootContextMenu" CssClass="rootMenu" ClickToOpen="true" ExpandAnimation-Duration="500">
                <Items>
                    <telerik:RadMenuItem Value="Open" Text="Open" meta:ResourceKey="RootContextMenu_Open"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="Edit" Text="Edit" meta:ResourceKey="RootContextMenu_Edit"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="Bookmark" Text="Bookmark" meta:ResourceKey="RootContextMenu_Bookmark"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="UnBookmark" Text="Remove Bookmark" meta:ResourceKey="RootContextMenu_UnBookmark"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="CopyFolderUrl" Text="Copy URL" meta:ResourceKey="RootContextMenu_CopyUrl"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="Subscribe" Text="Subscribe" meta:ResourceKey="RootContextMenu_Subscribe"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="Unsubscribe" Text="Unsubscribe" meta:ResourceKey="RootContextMenu_Unsubscribe"></telerik:RadMenuItem>
                </Items>
            </telerik:RadContextMenu>



        </asp:Panel>
        <asp:Button ID="btnGoToFolder" runat="server" OnClick="btnGoToFolder_Click" CssClass="Hide" />
        <asp:Button runat="server" ID="btnCardClick" OnClick="btnCardClick_Click" CssClass="Hide" />
        <asp:Button runat="server" ID="btnCardDoubleClick" OnClick="btnCardDoubleClick_Click" CssClass="Hide" />
        <telerik:RadAsyncUpload runat="server" ID="rauAttachments" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
            OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded"
            MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true"
            OnFileUploaded="rauAttachment_FileUploaded" Width="100%" CssClass="ProjectCenterUpload Hide">
            <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
        </telerik:RadAsyncUpload>

        <telerik:RadContextMenu ID="cmFileActions" OnClientItemClicking="FileActionsItemClicking" OnClientShowing="FileActionsItemShowing" Skin="Default" runat="server" CssClass="rootMenu">
            <Items>
                <telerik:RadMenuItem Text="Go to Folder" Value="GoToFolder" meta:ResourceKey="FileContextMenu_GoToFolder" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="View" Value="View" meta:ResourceKey="FileContextMenu_View" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Open" Value="Open" meta:ResourceKey="FileContextMenu_Open" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Edit" Value="Edit" meta:ResourceKey="FileContextMenu_Edit" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="PMWeb Record" Value="PMWebRecord" meta:ResourceKey="FileContextMenu_PMWebRecord" EnableImageSprite="false" CssClass="MenuUpload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Download11" Value="Download" meta:ResourceKey="FileContextMenu_Download" EnableImageSprite="false" CssClass="MenuDownload"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Check In11" Value="CheckIn" meta:ResourceKey="FileContextMenu_CheckIn" EnableImageSprite="false" CssClass="MenuCheckedIn"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Check Out11" Value="CheckOut" meta:ResourceKey="FileContextMenu_CheckOut" EnableImageSprite="false" CssClass="MenuCheckedOut"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Cancel Check Out11" Value="CancelCheckout" meta:ResourceKey="FileContextMenu_CancelCheckOut" EnableImageSprite="false" CssClass="MenuCancel"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Bookmark" Value="Bookmark" meta:ResourceKey="FileContextMenu_Bookmark" EnableImageSprite="false" CssClass="MenuCheckedOut"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Un Bookmark" Value="UnBookmark" meta:ResourceKey="FileContextMenu_UnBookmark" EnableImageSprite="false" CssClass="MenuCheckedOut"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_CopyUrl" Text="Copy URL" Value="CopyUrl" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>

                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_AddPMWebViewer" Text="Add PMWeb Viewer" Value="AddPMWebViewer" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_GoToPMWebViewer" Text="Go to PMWeb Viewer" Value="GoToPMWebViewer" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_3DViewer" Text="3D Viewer" Value="3DViewer" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_SendToStudio" Text="Send to Studio" Value="SendToStudio" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_GoToBluebeamMarkups" Text="Go to Bluebeam Markups" Value="GoToBluebeamMarkups" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>


                <telerik:RadMenuItem Value="Subscribe" Text="Subscribe11" meta:ResourceKey="FolderContextMenu_Subscribe" EnableImageSprite="false" CssClass="MenuSubscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Unsubscribe" Text="Unsubscribe11" meta:ResourceKey="FolderContextMenu_Unsubscribe" EnableImageSprite="false" CssClass="MenuUnsubscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="AddSeperator" IsSeparator="true" Enabled="false" />
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Add" PostBack="false" Text="Add" Value="Add" EnableImageSprite="true" CssClass="MenuCopy">
                    <Items>
                        <telerik:RadMenuItem Value="NewFolder" Text="Folder" CssClass="AddRadMenu"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Value="FromComputer" Text="From Your Computer" PostBack="false" CssClass="AddRadMenu"></telerik:RadMenuItem>
                        <%--<telerik:RadMenuItem Value="FromBox" Text="FromBox"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Value="FromGoogleDrive" Text="From Google Drive"></telerik:RadMenuItem>--%>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Copy" Text="Copy/Move To" Value="Copy" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" Enabled="false" Value="LastSeparator" />

                <telerik:RadMenuItem meta:ResourceKey="FileContextMenu_Delete" Text="Delete11" Value="Delete" EnableImageSprite="false" CssClass="MenuDelete"></telerik:RadMenuItem>
            </Items>
        </telerik:RadContextMenu>

        <telerik:RadContextMenu ID="cmFolderActions" Skin="Default" runat="server" CssClass="trvContextMenu">
            <Items>
                <telerik:RadMenuItem Text="Add Folder11" meta:ResourceKey="FolderContextMenu_AddFolder" EnableImageSprite="false" CssClass="MenuAdd"></telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" />
                <telerik:RadMenuItem Text="Edit Folder11" meta:ResourceKey="FolderContextMenu_EditFolder" EnableImageSprite="false" CssClass="MenuEdit"></telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" />
                <telerik:RadMenuItem Text="Subscribe11" meta:ResourceKey="FolderContextMenu_Subscribe" EnableImageSprite="false" CssClass="MenuSubscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Unsubscribe11" meta:ResourceKey="FolderContextMenu_Unsubscribe" EnableImageSprite="false" CssClass="MenuUnsubscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuUpload"
                    Text="Upload File11" Value="UploadFiles" meta:ResourceKey="FolderContextMenu_UploadFiles">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuPaste" meta:ResourceKey="FolderContextMenu_Paste"
                    Text="Paste Files11" Value="Paste">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                <telerik:RadMenuItem EnableImageSprite="false" CssClass="MenuDelete" PostBack="false" meta:ResourceKey="FolderContextMenu_Delete"
                    Text="Delete Folders & Subfolders11" Value="Delete">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
            </Items>
        </telerik:RadContextMenu>
        <telerik:RadContextMenu
            runat="server" ID="cmSorting" CssClass="rootMenu js-sort" ClickToOpen="true" ExpandAnimation-Duration="500">
            <Items>
                <telerik:RadMenuItem Value="SortingBy">
                    <ItemTemplate>
                        <input type="radio" runat="server" id="chkDocumentNumber" clientidmode="Static" name="SortingBy" sortingby="Id" />
                        <label for="chkDocumentNumber" meta:resourcekey="SortingContextMenu_DocumentNumber">Document #</label>
                        <br />
                        <input type="radio" runat="server" id="chkExtension" name="SortingBy" clientidmode="Static" sortingby="Extension" />
                        <label for="chkExtension" meta:resourcekey="SortingContextMenu_Extension">Extension</label>
                        <br />
                        <input type="radio" runat="server" id="chkUpdated" name="SortingBy" clientidmode="Static" sortingby="LastModified" />
                        <label for="chkUpdated" meta:resourcekey="SortingContextMenu_Updated">Updated</label>
                        <br />
                        <input type="radio" runat="server" id="chkName" name="SortingBy" clientidmode="Static" sortingby="FileName" />
                        <label for="chkName" meta:resourcekey="SortingContextMenu_Name">Name</label>
                    </ItemTemplate>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem IsSeparator="true" Enabled="false" />
                <telerik:RadMenuItem Value="SortingDirection">
                    <ItemTemplate>
                        <input type="radio" runat="server" id="chkAscending" name="SortingDirection" clientidmode="Static" sortingby="ASC" />
                        <label for="chkAscending" meta:resourcekey="SortingContextMenu_Ascending">Ascending</label>
                        <br />
                        <input type="radio" runat="server" id="chkDescending" name="SortingDirection" clientidmode="Static" sortingby="DESC" />
                        <label for="chkDescending" meta:resourcekey="SortingContextMenu_Descending">Descending</label>
                    </ItemTemplate>
                </telerik:RadMenuItem>
                <%-- <telerik:RadMenuItem Value="Open" Text="Open"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Bookmark" Text="Bookmark"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="CopyFolderUrl" Text="Copy Url"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Subscribe" Text="Subscribe"></telerik:RadMenuItem>
                <telerik:RadMenuItem Value="Unsubscribe" Text="Unsubscribe"></telerik:RadMenuItem>--%>
            </Items>
        </telerik:RadContextMenu>
        <%--<asp:LinkButton ID="btnRefreshComments" runat="server" CssClass="Hide"></asp:LinkButton>--%>
        <asp:Button ID="btnRefreshFolderGrid" runat="server" CssClass="Hide" />
        <asp:Button ID="btnSorting" runat="server" CssClass="Hide" />
        <asp:Button ID="btnUploadFile" runat="server" class="Hide" />
        <asp:Button ID="btnAddNewFolder" runat="server" class="Hide" />
        <asp:Button ID="btnAddNewFolderAndRefresh" runat="server" class="Hide" />
        <asp:Button ID="btnAddNewFolderFromContext" runat="server" class="Hide" />
        <asp:FileUpload ID="inputFiles" CssClass="Hide" EnableViewState="true" runat="server" name="FileUpload" webkitdirectory AllowMultiple="true" />
        <asp:FileUpload ID="inputFileCurrentWorkingFolder" CssClass="Hide" onchange="uploadFileCurrentWorkingFolder(event)" EnableViewState="true" runat="server" AllowMultiple="true"/>
        <asp:FileUpload ID="inputFile" CssClass="Hide" onchange="uploadFile(event)" EnableViewState="true" runat="server" AllowMultiple="true"/>
        <asp:HiddenField ID="hdnEntitiesValues" runat="server" />
        <asp:HiddenField ID="hdnDropOnFolderId" runat="server" />
        <asp:HiddenField ID="hdnAllowVersioning" Value="false" runat="server" />
        <asp:HiddenField ID="hdnCopiedFolderId" runat="server" />
        <asp:HiddenField ID="hdnCopiedFileIds" runat="server" />
        <asp:HiddenField ID="hdnDownloadId" runat="server" />
        <asp:HiddenField ID="hdnFolderId" runat="server" />
        <asp:HiddenField ID="hdnIsFolder" runat="server" />
        <asp:LinkButton ID="btnRebindGrid" runat="server" CssClass="Hide" />
        <asp:LinkButton ID="btnRefreshRootGrid" runat="server" CssClass="Hide" />
        <asp:LinkButton ID="btnShowSearch" runat="server" CssClass="Hide" />
        <asp:Button ID="btnRefreshCurrentWorkingFolder" runat="server" CssClass="Hide" />
        <asp:Button ID="btnRefreshFilesAndFolder" runat="server" CssClass="Hide" />
        <asp:Button ID="btnRemoveFolderEditMode" runat="server" CssClass="Hide" />
        <asp:Button ID="Test" runat="server" CssClass="Hide" />
    </div>
</asp:Content>
