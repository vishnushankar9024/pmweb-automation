<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FolderManagerAdvancedSearchResult.ascx.vb" Inherits="Website.FolderManagerAdvancedSearchResult" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnCardClickSearch">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="DetailPane1" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnCardClickSearch" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<telerik:RadGrid ID="rdgAdvancedSearch" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="false" CssClass="rdgDocumentManager" Visible="true"
    GridLines="None" HeaderStyle-Font-Size="8" SetWidth="true" FitPageHeightOffset="24" AppendMenus="true" allow-scroll="true"
    ShowStatusBar="false" PageSize="10" AllowPaging="false" ClientSettings-Scrolling-AllowScroll="true" MasterTableView-AllowPaging="true" MasterTableView-PageSize="20"
    AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="false" ClientSettings-Scrolling-UseStaticHeaders="true"
    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="false">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
    <HeaderStyle Font-Size="8pt" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
        CommandItemDisplay="None" DataKeyNames="Id,IsFolder" ClientDataKeyNames="Id,IsLastVersion,Extension,DocStatusId,CheckedIn,CheckedById,EditFiles,DeleteFiles,ManageFolder,FolderId,WorkflowStatusId,IsInBluebeamSession,IsEligible,IsFolder" EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" HeaderText="Action" UniqueName="Action" SortExpression="Action">
                <ItemTemplate>
                    <asp:LinkButton ID="imgAction" CssClass="Folder" runat="server">
                                            <span class="Icon"></span>
                    </asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                <ItemStyle HorizontalAlign="Center" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Root" UniqueName="Root" SortExpression="Root" Groupable="true"
                DataField="Root" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:LinkButton ID="hplRoot" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Root")%></u></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Entity" UniqueName="Entity" SortExpression="Entity" Groupable="true"
                DataField="Entity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:LinkButton ID="hplEntity" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Entity")%></u></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Folder" UniqueName="Folder" SortExpression="Folder" Groupable="true"
                DataField="Folder" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:LinkButton ID="hplFolder" btnId='<%#Eval("Id") %>' runat="server" Style="white-space: nowrap; cursor: pointer;" Visible="true"><u><%#Eval("Folder")%></u></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn>
                <ItemTemplate>
                    <asp:LinkButton ID="imgRedlining" runat="server">
                        <span id="spanImg" class="smallIcon" runat="server"></span>
                    </asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle Width="40px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name" SortExpression="Name" Groupable="true"
                DataField="Name" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# IIf(Eval("IsFolder"), Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", ""), Eval("FileName")) %></span>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description" Groupable="true"
                DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Document#" UniqueName="Document#" SortExpression="Document#" Groupable="true"
                DataField="Document#" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:HyperLink ID="lblDocumentNbr" runat="server" Text='<%# Eval("DOCUMENT#") %>'></asp:HyperLink>
                    <asp:LinkButton ID="lnkBtnOpenFolder" runat="server" Visible="false" Text="Open Folder" Style="text-transform: uppercase"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Ext." UniqueName="Extension" SortExpression="Extension" Groupable="true"
                DataField="Extension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label ID="lblExtension" runat="server" Text='<%# Eval("Extension") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Modified" UniqueName="Modified" SortExpression="Modified" Groupable="true"
                DataField="Modified" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label ID="lblModified" runat="server" Text='<%# Eval("ModifiedDate").ToString() %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" SortExpression="Size" Groupable="true"
                DataField="Size" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label ID="lblSize" runat="server" Text='<%# Eval("FileSize") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Version" UniqueName="Version" SortExpression="Version" Groupable="true"
                DataField="Version" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label ID="lblVersion" runat="server" Text='<%# Eval("Version") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle />
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings Selecting-AllowRowSelect="true" ClientEvents-OnRowClick="OnRowClick"
        AllowRowsDragDrop="true">
        <Selecting AllowRowSelect="True" />
        <ClientEvents />
    </ClientSettings>
</telerik:RadGrid>

<div class="cardView" id="CardViewContainer" runat="server" visible="false">
    <div>
        <div class="foldersContainer" id="foldersContainer" runat="server">
            <h2 meta:resourcekey="lblFolders">Folders</h2>
            <telerik:RadListView runat="server" ID="rptFoldersCardView" ClientDataKeyNames="Id , FileName">
                <ClientSettings>
                    <ClientEvents />
                </ClientSettings>
                <ItemTemplate>
                    <div class="rlvI">
                        <div class="rlvDrag">
                            <div style="margin: 0px 16px 16px 0; float: left">
                                <div id="folderCard" runat="server" title='<%#Eval("FileName")%>'>
                                    <div class="mainContent">
                                        <div class="check">
                                            <span class="icon"></span>
                                        </div>
                                        <span class="FolderIcon" runat="server">
                                            <span class="smallIcon" runat="server"></span>
                                        </span>
                                        <span class="folderName"><%#Eval("FileName") + IIf(Eval("NbrOfFiles") > 0, " (" + Eval("NbrOfFiles").ToString() + ")", "")  %> </span>
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
            <telerik:RadListView runat="server" ID="rptFilesCardView" ClientDataKeyNames="Id , FileName">
                <ClientSettings>
                    <ClientEvents />
                </ClientSettings>
                <ItemTemplate>
                    <div class="rlvI">
                        <div class="rlvDrag">
                            <div id="card" runat="server" title='<%#Eval("FileName")%>'>
                                <div class="mainContent">
                                    <div class="check">
                                        <span class="icon"></span>
                                    </div>
                                    <div class="content">
                                        <asp:Image ID="imgDisplay" runat="server" />
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
<div>
    <asp:Button ID="btnCardClickSearch" runat="server" CssClass="Hide btnSearchCardView" />
</div>
