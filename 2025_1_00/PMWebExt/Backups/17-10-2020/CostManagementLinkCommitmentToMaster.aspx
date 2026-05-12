<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CostManagementLinkCommitmentToMaster.aspx.vb" Inherits="Website.CostManagementLinkCommitmentToMaster" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgCommitments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCommitments" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">

                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
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
                <div class="col-12">
                    <telerik:RadGrid ID="rdgCommitments" runat="server" setwidth="true" allow-scroll="true" FitPageHeightOffset="1"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10"
                        AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="True" GridLines="None">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                            TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                    HeaderStyle-Width="60px" UniqueName="Select" Groupable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" CssClass="mobile-switch" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type"
                                    UniqueName="Type">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Project" SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project"
                                    UniqueName="Project">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="170px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ID" UniqueName="CommitmentCode" SortExpression="CommitmentCode"
                                    HeaderStyle-Wrap="false" Groupable="true" Reorderable="false" GroupByExpression="ID [GridColumn_CommitmentCode] Group By ID">
                                    <ItemTemplate>
                                        <%#IIf(Eval("CommitmentCode") = "", "&nbsp;", Eval("CommitmentCode"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company"
                                    UniqueName="Company">
                                    <ItemTemplate>
                                        <%#IIf(Eval("Company") = "", "&nbsp;", Eval("Company"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description"
                                    UniqueName="Description">
                                    <ItemTemplate>
                                        <%#IIf(Eval("Description") = "", "&nbsp;", Eval("Description"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status"
                                    GroupByExpression="Status [GridColumn_Status] Group By Status" UniqueName="Status">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                                    UniqueName="Revision">
                                    <ItemTemplate>
                                        <%#Eval("Revision")%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" SortExpression="Date" GroupByExpression="Date [GridColumn_Date] Group By Date"
                                    UniqueName="Date" DataField="Date">
                                    <ItemTemplate>
                                        <span><%#If(Eval("Date") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("Date")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
        
    </form>
</body>
</html>
