<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="DrawingsPopup.aspx.vb" Inherits="Website.DrawingsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgDrawingLists">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDrawingLists" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" Height="32px" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
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
                                <asp:Label ID="lblProject" runat="server" Text="<%$ Resources:ProjectManagement, Label_Project %>"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" ReadOnly="true" MaxLength="100" Width="99%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPhase" runat="server" Text="<%$ Resources:ProjectManagement, Label_Phase %>"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPhase" runat="server" ReadOnly="true" MaxLength="100" Width="99%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgDrawingLists" runat="server" Width="100%" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" FitPageHeightOffset="24"
                        AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext"
                        EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                            TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" HeaderStyle-HorizontalAlign="Left" AllowFiltering="false"
                                    HeaderStyle-Width="60px" UniqueName="Select" Groupable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="List #" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false" Groupable="true" DataField="ListNumber" AutoPostBackOnFilter="true" DataType="System.String"
                                    Reorderable="false" GroupByExpression="ListNumber [GridColumn_ListNumber] Group By ListNumber">
                                    <ItemTemplate>
                                        <%#IIf(Eval("ListNumber") = "", "&nbsp;", Eval("ListNumber"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Line #"
                                    DataField="LineNumber" AutoPostBackOnFilter="true" DataType="System.Int64"
                                    UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Eval("LineNumber")%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Sheet" DataField="Sheet" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="Sheet" GroupByExpression="Sheet [GridColumn_Sheet] Group By Sheet"
                                    UniqueName="Sheet">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Sheet") = String.Empty, "&nbsp;", Container.DataItem("Sheet"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="Revision"
                                    DataField="Revision" AutoPostBackOnFilter="true" DataType="System.Int64"
                                    GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                                    UniqueName="Revision">
                                    <ItemTemplate>
                                        <%#Eval("Revision")%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="50px"
                                    DataField="ItemId" AutoPostBackOnFilter="true" DataType="System.Int64"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="ItemId"
                                    HeaderStyle-Wrap="false" UniqueName="Item" GroupByExpression="ItemId [GridColumn_Item] Group By ItemId">
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemItemTemplate" runat="server" Text='<%#IIf(Eval("ItemId") = "0", "&nbsp;", Eval("ItemId").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Date"
                                    DataField="DrawingDate" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="DrawingDate" GroupByExpression="DrawingDate [GridColumn_DrawingDate] Group By DrawingDate"
                                    UniqueName="DrawingDate">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("DrawingDate")) %> &nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                                    DataField="Description" AutoPostBackOnFilter="true" DataType="System.String"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description">
                                    <ItemTemplate>
                                        <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="170px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CSI Division" SortExpression="CSIDivision"
                                    DataField="CSIDivision" AutoPostBackOnFilter="true" DataType="System.String"
                                    GroupByExpression="CSIDivision [GridColumn_CSIDivisionId] Group By CSIDivision" UniqueName="CSIDivisionId">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("CSIDivision") = String.Empty, "&nbsp;", Container.DataItem("CSIDivision"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CSI Code"
                                    DataField="CSICode" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="CSICode" GroupByExpression="CSICode [GridColumn_CSICodeId] Group By CSICode"
                                    UniqueName="CSICodeId">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("CSICode") = String.Empty, "&nbsp;", Container.DataItem("CSICode"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Category"
                                    DataField="Category" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="Category" GroupByExpression="Category [GridColumn_CategoryId] Group By Category"
                                    UniqueName="CategoryId">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Task"
                                    DataField="TaskName" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="TaskName" GroupByExpression="TaskName [GridColumn_TaskName] Group By TaskName"
                                    UniqueName="TaskName">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("TaskName") = String.Empty, "&nbsp;", Container.DataItem("TaskName"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ProjectLocation"
                                    DataField="ProjectLocation" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="ProjectLocation" GroupByExpression="ProjectLocation [GridColumn_ProjectLocation] Group By ProjectLocation"
                                    UniqueName="ProjectLocation">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("ProjectLocation") = String.Empty, "&nbsp;", Container.DataItem("ProjectLocation"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" AutoPostBackOnFilter="true" DataType="System.String"
                                    SortExpression="Status" DataField="Status" GroupByExpression="Status [GridColumn_StatusId] Group By Status"
                                    UniqueName="StatusId">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="%"
                                    AutoPostBackOnFilter="true" DataType="System.String" DataField="Percentage"
                                    SortExpression="Percentage" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage"
                                    UniqueName="Percentage">
                                    <ItemTemplate>
                                        <%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Percentage")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Percentage")), "&nbsp;", FormatNumber(DataBinder.Eval(Container.DataItem, "Percentage")))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes"
                                    AutoPostBackOnFilter="true" DataType="System.String" DataField="Notes"
                                    SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                                    UniqueName="Notes">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Notes") is DBNull.Value,"&nbsp;", Container.DataItem("Notes") & "&nbsp;")%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
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
                    <%--        <tr align="right">
                            <td align="right">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSave" runat="server" Text="<%$ Resources:PMWeb, SaveToRecord %>" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>--%>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
