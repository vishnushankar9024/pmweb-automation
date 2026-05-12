<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Specifications.aspx.vb" Inherits="Website.Specifications" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
     
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function rdvOccupantNodeClicking(sender, args) {
                var comboBox = $find(sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlTypes') + 9));
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                if (strValue.indexOf("D") > 0) return;
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);
                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }
            function OpenViewNoteSpecPopup(txtNoteId, GroupId, RecordTypeId) {
                var left = (screen.width - 620) / 2;
                var top = (screen.height - 320) / 2;
                var btnRefreshId = $("a[id$=btnRefresh]")[0].id;
                var win = OpenPOPUp('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&SpecGroupId=' + GroupId + '&btnRefreshId=' + btnRefreshId + '&RecordTypeId=' + RecordTypeId, '',
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=620,height=400,top=' + top + ',left=' + left);
                return false;

            }

            function RowSelecting(sender, args) {
                if (args.getDataKeyValue("Id") <= 0)
                    args.set_cancel(true)
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RamSpecification" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgSpecificationGroups">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSpecificationGroups" />
                    <telerik:AjaxUpdatedControl ControlID="rdgSpecificationTemplate" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlDetails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdgSpecificationTemplate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSpecificationTemplate" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>



    <div class="PMMainPage">
        <div class="row">
            <div class="col-4">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" Text="Record Type"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlRecordTypes" Width="100%" Height="400px" runat="server" AllowCustomText="True"
                                CausesValidation="false" Skin="Default" meta:resourcekey="ddlRecordTypes" AutoPostBack="True" NoWrap="True" Filter="StartsWith">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
            <div class="row row-8-4" style="padding-top:0; padding-right: 0px !important;">
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblDefineTabs" runat="server" meta:resourcekey="lblDefineTabs" Text="Define Tabs"></asp:Label></legend>
                        <telerik:RadGrid ID="rdgSpecificationGroups" AllowMultiRowSelection="true" runat="server" UseEditFormInMobile="true"
                            HeaderStyle-Font-Size="8" Width="100%" AllowMultiRowEdit="True" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                            AutoGenerateColumns="False" AllowSorting="false" ShowStatusBar="true"
                            PageSize="10" AllowPaging="True">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" Width="10%" />
                            <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace" TableLayout="Fixed">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Sort Order" UniqueName="SortOrder" HeaderStyle-Wrap="false" SortExpression="SortOrder"
                                        AllowFiltering="false" GroupByExpression="SortOrder [GridColumn_SortOrder] Group By SortOrder ASC">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblSortOrder" Text='<%#Container.DataItem("SortOrder").ToString%>'></asp:Label></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("SortOrder").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Name" UniqueName="SpecGroup" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-Width="148px" SortExpression="Name" GroupByExpression="Name [GridColumn_SpecGroup] Group By Name ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' Width="100%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTabName" runat="server" ControlToValidate="txtName"
                                                CssClass="Validator" ErrorMessage="yyy" Display="Dynamic"
                                                ForeColor="" ValidationGroup="specGroup" meta:resourcekey="rfvTabName"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Visible"
                                        UniqueName="Visible" HeaderStyle-Width="100px" ItemStyle-Wrap="false"
                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Visible")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chbVisible" Checked='<%# CBool(IIf(Eval("Visible") Is System.DBNull.Value, 0, Eval("Visible")))%>'
                                                runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false"
                                        HeaderStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="imgNotes" Style="cursor: pointer" runat="server" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="txtNotes" CssClass="Hide" > </asp:Label>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:HiddenField runat="server" ID="hdnField" />
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />

                                    </telerik:GridTemplateColumn>

                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                            CommandName="EditRows" CssClass="GridCmdEditRows" SecurityButtonType="ItemMode_Edit"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count = 0 And (Not rdgSpecificationGroups.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnEditSelectedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server"
                                                Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>


                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"
                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count = 0 And (Not rdgSpecificationGroups.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server" Text="Add line"
                                                meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                            SecurityButtonType="AddEditMode_Edit" ValidationGroup="specGroup"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="specGroup"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                            Visible='<%# rdgSpecificationGroups.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnSaveResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count > 0 Or rdgSpecificationGroups.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" SecurityButtonType="ItemMode_Delete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count = 0 And (Not rdgSpecificationGroups.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"
                                                Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                            Visible='<%# rdgSpecificationGroups.EditIndexes.Count = 0 And (Not rdgSpecificationGroups.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                                                meta:resourcekey="lblRefreshResource1"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ClientSettings EnableRowHoverStyle="true" AllowRowsDragDrop="True"
                                Resizing-AllowColumnResize="True">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                            <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true" />
                        </telerik:RadGrid>
                    </fieldset>
                </div>
                <div class="col-8">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblDefineFields" runat="server" meta:resourcekey="lblDefineFields" Text="DefineCustomFields"></asp:Label></legend>
                        <telerik:RadGrid ID="rdgSpecificationTemplate" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                            HeaderStyle-Font-Size="8" Width="100%" PageSize="10" AllowPaging="True" AllowMultiRowEdit="True" UseEditFormInMobile="true" FitPageHeightOffset="24"
                            AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" Width="10%" />
                            <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Line Number" UniqueName="FieldsSortOrder" HeaderStyle-Wrap="false" SortExpression="FieldsSortOrder"
                                        AllowFiltering="false" GroupByExpression="SortOrder [GridColumn_FieldsSortOrder] Group By FieldsSortOrder ASC">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("FieldsSortOrder").ToString%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("FieldsSortOrder").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="True" Width="61px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Tab" UniqueName="Tab" meta:Resourcekey="GridColumn_Tab"
                                        HeaderStyle-HorizontalAlign="Center" SortExpression="Tab">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Tab") = String.Empty, "&nbsp;", Container.DataItem("Tab"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlGroups" AllowCustomText="false" runat="server" Skin="Default"
                                                CloseDropDownOnBlur="true" Width="100%" NoWrap="true"
                                                ShowToggleImage="true">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Spec*" meta:Resourcekey="GridColumn_Spec"
                                        UniqueName="Spec" HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSpec" MaxLength="4000" Text='<%# Eval("Name") %>' runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rvSpecTemplate" Display="Dynamic"  meta:resourcekey="rvSpecTemplate" CssClass="Validator"
                                                runat="server" ControlToValidate="txtSpec" ValidationGroup="specTemplate" ErrorMessage="Enter the Spec"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" meta:Resourcekey="GridColumn_UOM"
                                        HeaderStyle-HorizontalAlign="Center" SortExpression="UOM">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("UOM").ToString = String.Empty, "&nbsp;", Container.DataItem("UOM").ToString)%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlUOM" Width="100%" Filter="Contains" MarkFirstMatch="true" Height="220px" DropDownWidth="120px" AllowCustomText="True" runat="server" Skin="Default">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="75px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" meta:Resourcekey="GridColumn_Type"
                                        HeaderStyle-HorizontalAlign="Center" SortExpression="Type">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlTypes" AllowCustomText="false" runat="server" Skin="Default"
                                                CloseDropDownOnBlur="true" Width="100%" NoWrap="true"
                                                ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="" />
                                                </Items>
                                                <ItemTemplate>
                                                    <telerik:RadTreeView ID="rdvTypes" Skin="Default" runat="server" Height="250px" Width="100%"
                                                        OnNodeDataBound="rdvTypes_NodeDataBound" OnNodeExpand="rdvTypes_NodeExpand"
                                                        MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvOccupantNodeClicking">
                                                    </telerik:RadTreeView>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <%--<telerik:GridTemplateColumn HeaderText="DefaultValue" meta:Resourcekey="GridColumn_DefaultValue"
                                                            UniqueName="DefaultValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px"
                                                            SortExpression="DefaultValue">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("DefaultValue").ToString = String.Empty, "&nbsp;", Container.DataItem("DefaultValue"))%>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtDefaultValue" MaxLength="4000" Text='<%# Eval("DefaultValue") %>' Width="100%" runat="server"></asp:TextBox>
                                                            </EditItemTemplate>
                                                             <HeaderStyle Wrap="False" Width="180px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </telerik:GridTemplateColumn>--%>
                                    <telerik:GridTemplateColumn HeaderText="Required" UniqueName="Required" meta:Resourcekey="GridColumn_Required"
                                        HeaderStyle-HorizontalAlign="Center" SortExpression="Type">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Required")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chkRequired" runat="server" Checked='<%# CBool(IIf(Eval("Required") Is System.DBNull.Value, 0, Eval("Required")))%>' />
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                                <CommandItemTemplate>
                                    <div style="padding: 2px">

                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                            CommandName="EditRows" CssClass="GridCmdEditRows"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count = 0 And (Not rdgSpecificationTemplate.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server"
                                                Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                            SecurityButtonType="AddEditMode_Edit" ValidationGroup="specTemplate"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="specTemplate"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                            Visible='<%# rdgSpecificationTemplate.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnSaveResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count > 0 Or rdgSpecificationTemplate.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count = 0 And (Not rdgSpecificationTemplate.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server" Text="Add line"></asp:Label>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" SecurityButtonType="ItemMode_Delete"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count = 0 And (Not rdgSpecificationTemplate.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"
                                                Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                            Visible='<%# rdgSpecificationTemplate.EditIndexes.Count = 0 And (Not rdgSpecificationTemplate.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="True">
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
            </div>
        </div>


    <telerik:RadAjaxLoadingPanel ID="ldpSpecification" runat="server" Skin="Default" />
</asp:Content>
