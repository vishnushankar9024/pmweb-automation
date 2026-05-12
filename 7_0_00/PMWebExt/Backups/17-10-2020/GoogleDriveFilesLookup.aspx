<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GoogleDriveFilesLookup.aspx.vb" Inherits="Website.GoogleDriveFilesLookup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        Body
        {
            background-color: White !important;
        }
    </style>
</head>
<body>
     <form id="form1" runat="server">
     <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript" src= "JS/GoogleDrive/GoogleDrive.js"></script>
        <script type ="text/javascript">
        var Hostname = '<%= PM.Aconexinfo.Hostname %>';
        </script> 
    </telerik:RadCodeBlock>
    <telerik:RadAjaxLoadingPanel ID="ldpFileUpload" runat="server" BackgroundPosition="Center" Skin="Default" />
    <telerik:RadAjaxManager ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="trvProjects" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadSplitter1" LoadingPanelID="ldpFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="lblError"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgFiles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFiles" LoadingPanelID="ldpFileUpload" />
                    <telerik:AjaxUpdatedControl ControlID="trvProjects" />
                    <telerik:AjaxUpdatedControl ControlID="lblError"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div style="background-color: White">
        <asp:Label ID="lblConnectionError" runat="server" CssClass="Validator"></asp:Label>
        <div id="BodyPanel" runat="server">
            <table class="MaxWidth" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td class="Padding7 Top">
                        <div style="float:left"><img src="Images/Global/Aconex.png" alt="" /></div>
                        <div style="float:right">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                            &nbsp;<asp:TextBox ID="txtSearch" CssClass="SearchButton" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Hide" />
                        </asp:Panel></div>
                    </td>
                </tr>
            </table>
            <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%"
                Height="580px">
                <telerik:RadPane ID="treeFoldersAndFilesPane" runat="server" Width="200" Height="100%"
                    MinWidth="100">
                    <table width="100%" class="NormalWhiteBack" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="Padding7">
                                <telerik:RadTreeView ID="trvFolders" OnClientDoubleClick="OnClientDoubleClick_FillFiles"
                                    runat="server" Skin="Default" MultipleSelect="false">
                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                </telerik:RadTreeView>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Splitter" runat="server" />
                <telerik:RadPane ID="RadContentPane" runat="server">
                    <table cellpadding="0" cellspacing="0" width="99%">
                        <tr>
                            <td class="Top">
                                <telerik:RadGrid ID="rdgFiles" runat="server" AllowMultiRowSelection="False"
                                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                                    Skin="Default" Width="99%" PageSize="20" AllowPaging="True" ShowGroupPanel="true" AllowSorting="True" AllowFilteringByColumn="true"  FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true">
                                    <HeaderStyle Font-Size="8pt" />
                                    <ClientSettings Selecting-AllowRowSelect="true" ClientEvents-OnRowDblClick="LookupFile_RowDblClick_SelectFile">
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView CommandItemDisplay="Top" TableLayout="Fixed">
                                        <CommandItemTemplate>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                                                Visible="<%# rdgFiles.EditIndexes.Count = 0 And (Not rdgFiles.MasterTableView.IsItemInserted) %>">
                                                  <span class="Icon"></span><asp:Label
                                                    ID="lblRefresh" runat="server"></asp:Label></asp:LinkButton>&#160;&#160;
                                        </CommandItemTemplate>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="" Display="False" ItemStyle-Wrap="false"
                                                UniqueName="Id">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocId" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="File #" HeaderStyle-Width="115px" Display="True" 
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="Number" AutoPostBackOnFilter="true" 
                                                GroupByExpression="Number [GridColumn_Number] Group By Number ASC" DataType="System.String" DataField="Number" 
                                                UniqueName="Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocNumber" runat="server" Text='<%#Eval("Number") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Title" HeaderStyle-Width="200px" Display="True"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="Title" AutoPostBackOnFilter="true" 
                                                GroupByExpression="Title [GridColumn_Title] Group By Title ASC" DataType="System.String" DataField="Title" 
                                                UniqueName="Title">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="File Name" HeaderStyle-Width="150px" Display="True" 
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="FileName" AutoPostBackOnFilter="true" 
                                                GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC" DataType="System.String" DataField="FileName"
                                                UniqueName="FileName">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileName" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="File Size" Display="True" HeaderStyle-Width="115px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="FileSize" AutoPostBackOnFilter="true" 
                                                GroupByExpression="FileSize [GridColumn_FileSize] Group By FileSize ASC" DataType="System.String" DataField="FileSize"
                                                UniqueName="FileSize">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileSize" runat="server" Text='<%#Eval("FileSize") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Version Number" Display="True" HeaderStyle-Width="115px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="VersionNumber" AutoPostBackOnFilter="true" 
                                                GroupByExpression="VersionNumber [GridColumn_VersionNumber] Group By VersionNumber ASC" DataType="System.String" DataField="VersionNumber"
                                                UniqueName="VersionNumber">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVersionNumber" runat="server" Text='<%#Eval("VersionNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Revision" Display="True" HeaderStyle-Width="115px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="Revision" AutoPostBackOnFilter="true" 
                                                GroupByExpression="Revision [GridColumn_Revision] Group By Revision ASC" DataType="System.String" DataField="Revision"
                                                UniqueName="Revision">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRevision" runat="server" Text='<%#Eval("Revision") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="ProjectId" Display="False" ItemStyle-Wrap="false"
                                                UniqueName="ProjectId">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectId" runat="server" Text='<%#Eval("ProjectId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="RevisionDate" Display="True" HeaderStyle-Width="100px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="RevisionDate" AutoPostBackOnFilter="true" 
                                                GroupByExpression="RevisionDate [GridColumn_RevisionDate] Group By RevisionDate ASC" DataType="System.DateTime" FilterListOptions="VaryByDataType" DataField="RevisionDate"
                                                UniqueName="RevisionDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRevisionDate" runat="server" Text='<%#Eval("RevisionDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Created Date" Display="True" HeaderStyle-Width="100px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="DateCreated" AutoPostBackOnFilter="true" 
                                                GroupByExpression="DateCreated [GridColumn_DateCreated] Group By DateCreated ASC" DataType="System.DateTime" FilterListOptions="VaryByDataType" DataField="DateCreated"
                                                UniqueName="DateCreated">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDateCreated" runat="server" Text='<%#Eval("DateCreated") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Modified Date" Display="True" HeaderStyle-Width="100px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="DateModified" AutoPostBackOnFilter="true" 
                                                GroupByExpression="DateModified [GridColumn_DateModified] Group By DateModified ASC" DataType="System.DateTime" FilterListOptions="VaryByDataType" DataField="DateModified"
                                                UniqueName="DateModified">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDateModified" runat="server" Text='<%#Eval("DateModified") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Comments" Display="True" HeaderStyle-Width="120px"
                                                ItemStyle-Wrap="false" Groupable="true" SortExpression="Comments" AutoPostBackOnFilter="true" 
                                                GroupByExpression="Comments [GridColumn_Comments] Group By Comments ASC" DataType="System.String" DataField="Comments"
                                                UniqueName="Comments">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <NoRecordsTemplate>
                                            <table style="height: 200px; width: 100%">
                                                <tr>
                                                    <td class="Top Center">
                                                        <asp:Label runat="server" ID="lblNoFilesToDisplay" Text="No Files to display."
                                                            meta:resourcekey="lblNoFilesToDisplay"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings AllowDragToGroup="true"/>
                                    </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblError" runat="server" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </telerik:RadPane>
            </telerik:RadSplitter>
        </div>
    </div>
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" meta:resourcekey="PMWindowManagerResource1"
        Style="display: none;" Top="">
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" meta:resourcekey="ldpPMResource1" />
    </form>
</body>
</html>
