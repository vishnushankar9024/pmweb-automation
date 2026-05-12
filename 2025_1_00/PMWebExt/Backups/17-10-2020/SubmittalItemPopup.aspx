<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="SubmittalItemPopup.aspx.vb" Inherits="Website.SubmittalItemPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function pageLoad() {
            CheckParentBox();
        }

        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgSubmittals']");
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled)
                        if (this.id.indexOf("chkSelect") > 0)
                            this.checked = iObj.checked;
                }
                i++;
            });
        }
        function SelectParent(chk) {
            var rdgRights = $("div[id$='rdgSubmittals']");
            var chkPArent = rdgRights.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i != 0) {
                    if (chk.checked) {
                        if (!this.checked) {

                            if (this.id.indexOf("chkSelect") > 0)
                                isChecked = false;
                        }
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


            var rdgRights = $("div[id$='rdgSubmittals']");
            var ParentIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkSelect") > 0)
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
        function DisablePanelAjax() {
            var updatePanel1 = $find($("[id$=pnl]")[0].id);
            updatePanel1.set_enableAJAX(false);
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
                    <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                        <telerik:RadGrid ID="rdgSubmittals" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                            AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15" AppendMenus="true"
                            AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                            AllowSorting="True" GridLines="None" AllowFilteringByColumn="true">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                                TableLayout="Fixed" ItemStyle-Wrap="false">
                                <Columns>
                                    <telerik:GridTemplateColumn UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="50px">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-Width="110px" SortExpression="Code"
                                        HeaderStyle-Wrap="false" GroupByExpression="Code [GridColumn_Code] Group By Code" UniqueName="Code"
                                        DataField="Code" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#DataBinder.Eval(Container.DataItem, "Code")%> &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName"
                                        GroupByExpression="PhaseName [GridColumn_PhaseName] Group By PhaseName"
                                        UniqueName="PhaseName" DataField="PhaseName" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%# Eval("PhaseName")%>
                                                 &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                                        GroupByExpression="Description [GridColumn_Description] Group By Description"
                                        UniqueName="Description" DataField="Description" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%#Eval("Description")%>
                                                 &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Category" SortExpression="Category"
                                        GroupByExpression="Category [GridColumn_Category] Group By Category"
                                        UniqueName="Category" DataField="Category" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%#Eval("Category")%>
                                                &nbsp;</span>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company"
                                        GroupByExpression="Company [GridColumn_Company] Group By Company" UniqueName="Company"
                                        DataField="Company" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%#Eval("Company")%>
                                            &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Submittal Status" SortExpression="SubmittalStatus"
                                        GroupByExpression="SubmittalStatus [GridColumn_SubmittalStatus] Group By SubmittalStatus" UniqueName="SubmittalStatus"
                                        DataField="SubmittalStatus" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%#Eval("SubmittalStatus")%>
                                             &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="CSI Code" SortExpression="CSICode" GroupByExpression="CSICode [GridColumn_CSICode] Group By CSICode"
                                        UniqueName="CSICode" DataField="CSICode" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <asp:Label runat="server" CssClass="NoWrap" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "CSICode")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "CSICode")), "&nbsp;", DataBinder.Eval(Container.DataItem, "CSICode"))%>' ID="lblCsi"></asp:Label>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                        <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Mfr." SortExpression="Manufacturer" DataField="Manufacturer"
                                        GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer"
                                        UniqueName="Manufacturer" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span>
                                                <%#Eval("Manufacturer")%>
                                                 &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Mfr. #" SortExpression="ManufacturerNumber"
                                        GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber"
                                        UniqueName="ManufacturerNumber" DataField="ManufacturerNumber" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("ManufacturerNumber") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Revision #" SortExpression="Revision"
                                        GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                                        UniqueName="Revision" DataField="Revision" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#Eval("Revision")%></span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Supplier" AutoPostBackOnFilter="true" DataType="System.String"
                                        SortExpression="Supplier" DataField="Supplier" GroupByExpression="Supplier [GridColumn_Supplier] Group By Supplier"
                                        UniqueName="Supplier">
                                        <ItemTemplate>
                                            <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Supplier")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Supplier")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Supplier"))%></span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Task" SortExpression="Task" GroupByExpression="Task [GridColumn_Task] Group By Task"
                                        UniqueName="Task" DataField="Task" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Task")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Task")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Task"))%></span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Lead Time" DataField="LeadTime" AutoPostBackOnFilter="true" DataType="System.Int64"
                                        SortExpression="LeadTime" GroupByExpression="LeadTime [GridColumn_LeadTime] Group By LeadTime"
                                        UniqueName="LeadTime">
                                        <ItemTemplate>
                                            <span><%#Eval("LeadTime")%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Due Date" SortExpression="DueDate"
                                        GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate"
                                        UniqueName="DueDate" DataField="DueDate" AutoPostBackOnFilter="true" DataType="System.DateTime">
                                        <ItemTemplate>
                                            <span><%#FormatDate(Container.DataItem("DueDate"))%> &nbsp;</span>
                                        </ItemTemplate>

                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes"
                                        GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                                        UniqueName="Notes" DataField="Notes" AutoPostBackOnFilter="true" DataType="System.String">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateSubItemPopup" CssClass="GridCmdUpdateSubItemPopup" SecurityButtonType="AddEditMode_Edit"
                                            ValidationGroup="DocumentAttachments" OnClientClick="DisablePanelAjax()"
                                            Visible="True">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelSubItemPopup" CssClass="GridCmdCancelSubItemPopup"
                                            SecurityButtonType="AddEditMode" Visible="True" OnClientClick="DisablePanelAjax()">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" meta:resourcekey="lblCancel" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                            CommandName="SaveState" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 AND (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                            <asp:Label ID="Label3" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                            CausesValidation="False" CommandName="LoadDefaultState" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 AND (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                            &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
                                ColumnsReorderMethod="Reorder" AllowDragToGroup="true" AllowRowsDragDrop="false">
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </telerik:RadAjaxPanel>
   </div>
        </div>
    </div>
    </form>
</body>
</html>
