<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ApplicationDesigner.aspx.vb" Inherits="Website.ApplicationDesigner" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .PMHeader .row .col-8 {
            padding-left: 0px !important;
        }

        .PMHeader .row {
            padding-left: 24px;
            padding-right: 24px;
            padding-top: 24px;
        }

        .col-4 {
            padding-left: 24px;
            width:500px !important;
        }

        @media screen and (min-width:844px) and (max-width:1323px) {
            .PMHeader .row {
                padding-left: 16px;
                padding-right: 16px;
                padding-top: 16px;
            }

            .col-4 {
                padding-left: 16px;
            }
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            .col-4 {
                padding-left: 0px;
            }
        }
    </style>
    <script type="text/javascript">
        function OpenHelpTextPopup(Id) {
            OpenPOPUp('HelpTextPopup.aspx?Id=' + Id, 790, 505, true);
            return false;
        }

        function OpenCustomTableDesigner(Id) {
            OpenPOPUp('CustomTableDesigner.aspx?Id=' + Id, 790, 700, true, 'rdgCustomTables');
            return false;
        }
    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgSectionOptions">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSectionOptions" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomFields" />
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomLinks" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgCustomLinks">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomLinks" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgSectionOptions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgCustomFields">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomFields" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgSectionOptions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgCustomTables">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomTables" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgSectionOptions" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <div class="PMMainPage" style="width:1396px">
        <div class="row row-8-4">
            <div class="col-8">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblSectionOptions" runat="server" meta:resourcekey="lblSectionOptions" Text="Sections"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgSectionOptions" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                        AutoGenerateColumns="False" ShowStatusBar="True"
                        Font-Size="8px" PageSize="20" AllowPaging="True" ShowGroupPanel="False"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="true" GridLines="None" Width="100%" UseEditFormInMobile="true">

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed"
                            Width="100%" UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="False">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Display" UniqueName="Display" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkSectionUserUnits_OnChekedChanged" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" runat="server" Checked='<%# CBool(IIf(Eval("Display") Is System.DBNull.Value, 0, Eval("Display")))%>' />
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="System Section Name" UniqueName="DefaultSectionName" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("DefaultSectionName").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("DefaultSectionName").ToString%>&nbsp;
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="182px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Custom Section Name" UniqueName="CustomSectionName" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("CustomSectionName").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCustomSectionName" runat="server" Width="100%" Text='<%#Eval("CustomSectionName")%>' MaxLength="200"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="182px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" SortExpression="Type" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("Type").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("Type").ToString%>&nbsp;
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="114px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Help Text" UniqueName="HelpText" Groupable="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgHelpText" Style="cursor: pointer" meta:resourcekey="imgHelpText" ToolTip="Help Text" runat="server"><span class="Icon"></span> </asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        &nbsp;
                                    </EditItemTemplate>
                                    <HeaderStyle Width="60px" />
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>

                            </Columns>

                            <CommandItemTemplate>
                                <div>
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                        SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                        Visible='<%# rdgSectionOptions.EditIndexes.Count = 0 And (Not rdgSectionOptions.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                        CommandName="UpdateEdited" Visible='<%# rdgSectionOptions.EditIndexes.Count > 0 %>'
                                        meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        SecurityButtonType="AddEditMode"
                                        Visible='<%# rdgSectionOptions.EditIndexes.Count > 0 Or rdgSectionOptions.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgSectionOptions.EditIndexes.Count = 0 And (Not rdgSectionOptions.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="false" AllowRowsDragDrop="true">
                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
            </div>
            <div class="col-4">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblCustomFields" runat="server" meta:resourcekey="lblCustomFields" Text="Custom Fields"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgCustomFields" runat="server" SetWidth="true" AppendMenus="true"
                        AutoGenerateColumns="False" ShowStatusBar="True"
                        Font-Size="8px" PageSize="5" AllowPaging="True" ShowGroupPanel="False"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="False" GridLines="None" UseEditFormInMobile="true">

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed"
                            UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="False">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Display" UniqueName="Display" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkFieldUserUnits_OnChekedChanged" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" runat="server" Checked='<%# CBool(IIf(Eval("Display") Is System.DBNull.Value, 0, Eval("Display")))%>' />
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Spec Group" UniqueName="SpecGroup" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("SpecGroup").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("SpecGroup").ToString%>&nbsp;
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="438px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                            </Columns>

                            <CommandItemTemplate>
                                <div>
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        SecurityButtonType="ItemMode_Edit"
                                        Visible='<%# rdgCustomFields.EditIndexes.Count = 0 And (Not rdgCustomFields.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save"
                                        Visible='<%# rdgCustomFields.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        SecurityButtonType="AddEditMode"
                                        Visible='<%# rdgCustomFields.EditIndexes.Count > 0 Or rdgCustomFields.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgCustomFields.EditIndexes.Count = 0 And (Not rdgCustomFields.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>

                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="False">
                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                AllowColumnResize="false" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
                <fieldset>
                    <legend>
                        <asp:Label ID="lblCustomTables" runat="server" meta:resourcekey="lblCustomTables" Text="Custom Tables"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgCustomTables" runat="server" SetWidth="true" AppendMenus="true"
                        AutoGenerateColumns="False" ShowStatusBar="True"
                        Font-Size="8px" PageSize="5" AllowPaging="True" ShowGroupPanel="False"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="False" GridLines="None">

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed"
                            UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="False">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Display" UniqueName="Display" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkTableUserUnits_OnChekedChanged" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="ID" UniqueName="ID" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("Code").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="95px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Table Name" UniqueName="TableName" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("Name").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="283px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="Edit" Groupable="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgEdit" Style="cursor: pointer" meta:resourcekey="imgEdit" ToolTip="Edit" runat="server"><span class="Icon"></span> </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="60px" />
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>

                            </Columns>

                            <CommandItemTemplate>
                                <div>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                        CommandName="InitNewRow" Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomTables.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomLinks.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomTables.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>

                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="false" AllowRowsDragDrop="true">
                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
                <fieldset>
                    <legend>
                        <asp:Label ID="lblLinks" runat="server" meta:resourcekey="lblLinks" Text="Links"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgCustomLinks" runat="server" SetWidth="true" AppendMenus="true"
                        AutoGenerateColumns="False" ShowStatusBar="True"
                        Font-Size="8px" PageSize="5" AllowPaging="True" ShowGroupPanel="False"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        AllowSorting="False" GridLines="None" UseEditFormInMobile="true">

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" InsertItemDisplay="Top"
                            UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                            EditMode="InPlace" EnableHeaderContextMenu="False">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Display" UniqueName="Display" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkLinkUserUnits_OnChekedChanged" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbDisplay" runat="server" Checked='<%# CBool(IIf(Eval("Display") Is System.DBNull.Value, 0, Eval("Display")))%>' />
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Wrap="false" Width="60px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Hyperlink Description" UniqueName="HyperLinkDescription" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("HyperLinkDescription").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtHyperLinkDescription" runat="server" Width="100%" Text='<%#Eval("HyperLinkDescription")%>' MaxLength="500"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="219px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Hyperlink" UniqueName="HyperLink" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#Eval("HyperLink").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtHyperLink" runat="server" Width="100%" Text='<%#Eval("HyperLink")%>' MaxLength="200"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" Width="219px" HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>

                            </Columns>

                            <CommandItemTemplate>
                                <div>
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                        CommandName="EditRows" Visible='<%# rdgCustomLinks.EditIndexes.Count = 0 And (Not rdgCustomLinks.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                        SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                        CommandName="UpdateEdited" Visible='<%# rdgCustomLinks.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                        SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                        CommandName="PerformInsert" Visible='<%# rdgCustomLinks.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                        SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                        CommandName="CancelAll" Visible='<%# rdgCustomLinks.EditIndexes.Count > 0 Or rdgCustomLinks.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                        CommandName="InitNewRow" Visible='<%# rdgCustomLinks.EditIndexes.Count = 0 And (Not rdgCustomLinks.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                        Visible='<%# rdgCustomLinks.EditIndexes.Count = 0 And (Not rdgCustomLinks.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1" CssClass="GridCmdDeleteRows"
                                        SecurityButtonType="ItemMode_Delete">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgCustomLinks.EditIndexes.Count = 0 And (Not rdgCustomLinks.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>

                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="False">
                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
