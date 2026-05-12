<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorkflowStepActionAttachmentsPopup.aspx.vb" Inherits="Website.WorkflowStepActionAttachmentsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="Close" ImageUrl="Images/ToolBar/Cancel.png" meta:resourcekey="RadToolBarButton_Close" Text="Close11"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-8" style="padding-left:0px !important; max-width:unset !important">
                    <table class="colTable" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width:100%">
                                <telerik:RadGrid ID="rdgStepActionAttachments" runat="server" Skin="Default" ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left"
                                    SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
                                     AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="true" ShowStatusBar="true">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="AttachmentId" ClientDataKeyNames="AttachmentId">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="80px" ItemStyle-Width="80px" ItemStyle-Wrap="false" UniqueName="AttachPreview">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgAttachPreview" runat="server" />&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="File Name" HeaderStyle-Width="200px" ItemStyle-Width="200px" DataField="FileNameWithExtension" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="FileNameWithExtension"
                                                SortExpression="FileNameWithExtension" GroupByExpression="FileNameWithExtension [GridColumn_FileNameWithExtension] Group By FileNameWithExtension ASC">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;" ToolTip="<%$ Resources:PMWeb, Download %>">
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="FileSize" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                AutoPostBackOnFilter="true" HeaderText="Size" HeaderStyle-Width="110px" ItemStyle-Width="110px" UniqueName="FileSize" SortExpression="FileSize"
                                                GroupByExpression="FileSize [GridColumn_FileSize] Group By FileSize ASC">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFileSize" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="FileExtension" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                AutoPostBackOnFilter="true" HeaderText="Ext." HeaderStyle-Width="50px" ItemStyle-Width="50px" UniqueName="FileExtension" SortExpression="FileExtension"
                                                GroupByExpression="FileExtension [GridColumn_FileExtension] Group By FileExtension ASC">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExtension" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Attached By" DataField="AttachedBy" ItemStyle-Wrap="false" UniqueName="AttachedBy"
                                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="120px" ItemStyle-Width="120px"
                                                SortExpression="AttachedBy" GroupByExpression="AttachedBy [GridColumn_AttachedBy] Group By AttachedBy ASC" AllowSorting="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCreatedByUserName" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Attached Date" DataField="AttachedDate" ItemStyle-Wrap="false" UniqueName="AttachedDate"
                                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="100px" ItemStyle-Width="100px"
                                                SortExpression="AttachedDate" GroupByExpression="AttachedDate [GridColumn_AttachedDate] Group By AttachedDate ASC" AllowSorting="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAttachedDate" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Attached Time" DataField="AttachedTime" ItemStyle-Wrap="false" UniqueName="AttachedTime"
                                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="100px" ItemStyle-Width="100px"
                                                SortExpression="AttachedDate" GroupByExpression="AttachedTime [GridColumn_AttachedTime] Group By AttachedTime ASC" AllowSorting="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAttachedTime" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                                        <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
