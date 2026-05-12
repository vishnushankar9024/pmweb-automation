<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="MultipleRivisionPopup.aspx.vb" Inherits="Website.MultipleRivisionPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function pageLoad() {
            CheckParentBox();
        }

        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgDrawings']");
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
            var rdgRights = $("div[id$='rdgDrawings']");
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


            var rdgRights = $("div[id$='rdgDrawings']");
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
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="dtpRevisionDate">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDrawings" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="dtpRevisionDate" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <table style="width: 320px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="NoWrap">
                                            <asp:Label runat="server" ID="lblRevision" meta:resourcekey="lblFrom" Text="Revision Date"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dtpRevisionDate" AutoPostBack="true" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="120px" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </td>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>



        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                                                <telerik:RadGrid ID="rdgDrawings" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                                                    AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250" FitPageHeightOffset="5"
                                                    AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                                    AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                                                        TableLayout="Fixed" ItemStyle-Wrap="false">
                                                        <Columns>
                                                            <telerik:GridTemplateColumn UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false"
                                                                HeaderStyle-Width="25px">
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" HeaderStyle-Width="110px"
                                                                ItemStyle-Wrap="false" SortExpression="ProjectName" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC"
                                                                ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false" DataField="ProjectName"
                                                                AutoPostBackOnFilter="true" DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#DataBinder.Eval(Container.DataItem, "ProjectName")%>
                                                                    &nbsp;</span>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Phase" HeaderStyle-Width="110px" SortExpression="PhaseName"
                                                                HeaderStyle-Wrap="false" GroupByExpression="PhaseName [GridColumn_PhaseName] Group By PhaseName"
                                                                UniqueName="PhaseName" DataField="PhaseName" AutoPostBackOnFilter="true" DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#DataBinder.Eval(Container.DataItem, "PhaseName")%>
                                                                    &nbsp;</span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Drawing #" SortExpression="DrawingNumber"
                                                                GroupByExpression="DrawingNumber [GridColumn_DrawingNumber] Group By DrawingNumber"
                                                                UniqueName="DrawingNumber" DataField="DrawingNumber" AutoPostBackOnFilter="true"
                                                                DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#Eval("DrawingNumber")%>
                                                                    &nbsp;</span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="DrawingDescription"
                                                                GroupByExpression="DrawingDescription [GridColumn_DrawingDescription] Group By DrawingDescription"
                                                                UniqueName="DrawingDescription" DataField="DrawingDescription" AutoPostBackOnFilter="true"
                                                                DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#Eval("DrawingDescription")%>
                                                                 &nbsp;</span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Drawing Set" SortExpression="DrawingSet"
                                                                GroupByExpression="DrawingSet [GridColumn_DrawingSet] Group By DrawingSet" UniqueName="DrawingSet"
                                                                DataField="DrawingSet" AutoPostBackOnFilter="true" DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#Eval("DrawingSet")%>
                                                                    &nbsp;</span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Line Description" SortExpression="DrawingDetailDescription"
                                                                GroupByExpression="DrawingDetailDescription [GridColumn_DrawingDetailDescription] Group By DrawingDetailDescription"
                                                                UniqueName="DrawingDetailDescription" DataField="DrawingDetailDescription" AutoPostBackOnFilter="true"
                                                                DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#Eval("DrawingDetailDescription")%>
                                                                        &nbsp;</span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="210px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Current Revision" SortExpression="CurrentRevision"
                                                                GroupByExpression="CurrentRevision [GridColumn_CurrentRevision] Group By CurrentRevision"
                                                                UniqueName="CurrentRevision" DataField="CurrentRevision" AutoPostBackOnFilter="true"
                                                                DataType="System.Int64">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" CssClass="NoWrap" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "CurrentRevision")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "CurrentRevision")), "&nbsp;", DataBinder.Eval(Container.DataItem, "CurrentRevision"))%>'
                                                                        ID="lblCsi"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <ItemStyle Wrap="False" HorizontalAlign="right"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Current Date" SortExpression="DrawingDate" DataField="DrawingDate"
                                                                GroupByExpression="DrawingDate [GridColumn_DrawingDate] Group By DrawingDate"
                                                                UniqueName="DrawingDate" AutoPostBackOnFilter="true" DataType="System.String">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#FormatDate(Eval("DrawingDate"))%>
                                                                 &nbsp;</span>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <%--  <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>--%>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="New Revision" SortExpression="NewRevision"
                                                                GroupByExpression="NewRevision [GridColumn_NewRevision] Group By NewRevision"
                                                                UniqueName="NewRevision" DataField="NewRevision" AutoPostBackOnFilter="true" DataType="System.Int64">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtRevision" MaxLength="9" CssClass="PositiveInteger" Width="100%" runat="server"
                                                                        Text='<%# Eval("NewRevision") %>'></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="New Date" AutoPostBackOnFilter="true" DataType="System.String"
                                                                SortExpression="NewDate" DataField="NewDate" GroupByExpression="NewDate [GridColumn_NewDate] Group By NewDate"
                                                                UniqueName="NewDate">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtNewDate" Width="100%" Text='<%#FormatDate(Eval("NewDate"))%>'
                                                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                                                        runat="server"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                                <%-- <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>--%>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <CommandItemTemplate>
                                                            <div style="padding: 2px">
                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateRevision" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateRevision"
                                                                    ValidationGroup="DocumentAttachments" OnClientClick="DisablePanelAjax()"
                                                                    Visible="True">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelPopup" CssClass="GridCmdCancelPopup"
                                                                    SecurityButtonType="AddEditMode" Visible="True" OnClientClick="DisablePanelAjax()">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblCancel" meta:resourcekey="lblCancel" runat="server"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                                                    CommandName="SaveState" Visible='<%# rdgDrawings.EditIndexes.Count = 0 And (Not rdgDrawings.MasterTableView.IsItemInserted) %>'>
                                                                    <asp:Label ID="Label3" runat="server"></asp:Label>
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                                                    CausesValidation="False" CommandName="LoadDefaultState" Visible='<%# rdgDrawings.EditIndexes.Count = 0 And (Not rdgDrawings.MasterTableView.IsItemInserted) %>'>
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
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
