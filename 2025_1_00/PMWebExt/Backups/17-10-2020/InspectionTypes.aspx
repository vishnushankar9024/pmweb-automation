<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="InspectionTypes.aspx.vb" Inherits="Website.InspectionTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <%@ Register Src="CustomFormTypeValues.ascx" TagName="CustomFormTypeValues" TagPrefix="uc1" %>

    <style>
        .ToolbarMobileMenu {
            margin-left: 11px !important;
        }
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
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                switch (Value) {

                    case 'New':
                        window.location = "InspectionTypes.aspx";
                        break;

                }
            }


            function CustomFormType_GetValueToReturn(combobox, eventArgs) {
                var context = eventArgs.get_context();

                var ListIdAttr = combobox.get_attributes().getAttribute("listid");
                if (ListIdAttr && ListIdAttr > 0) {
                    context["ListId"] = ListIdAttr;
                } else {
                    var ddlLists = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('CustomFormTypeValuesDefaultValue'), combobox.get_id().lenght - 1) + 'ddlTypes');
                    if (ddlLists != null) {
                        var selectedValue = ddlLists.get_value();
                        context["ListId"] = selectedValue;
                        context["ListId"] = context["ListId"].substring(0, context["ListId"].lastIndexOf(' '));
                    } else {
                        context["ListId"] = 0;
                    }
                }
            }

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgInspectionTypesDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgInspectionTypesDetails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>


        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar SmallToolbar" valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd Hide">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="InspectionTypes.aspx">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                            <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                            <telerik:RadComboBox ID="ddlInspectionTypes" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" Skin="Default"
                                CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false"
                                NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True">
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                                OnClientButtonClicked="click_handler">
                                <Items>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                        Value="Save">
                                    </telerik:RadToolBarButton>


                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" PostBack="false" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" Width="150px">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif" Style="margin: 20px !important">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Active" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="InActive" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('INSPECTION_TYPES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>


                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                                        Value="Activate" CommandName="Activation" ToolTip="Activate">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" CausesValidation="false"
                                        Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm">
                                    </telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="PMMainPage marginBottomOnMobile">
        <div class="row documentSinglePage">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblId" runat="server" meta:Resourcekey="lblId" Text="ID*"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" MaxLength="255" ID="txtId"  Text=""></asp:TextBox>
                            <asp:Label ID="lblIdUnique" meta:Resourcekey="lblIdUnique"
                                runat="server" Text="ID must be unique."
                                Visible="False" Class="Validator"></asp:Label>
                            <asp:RequiredFieldValidator ID="rfvId" runat="server" meta:Resourcekey="rfvId"
                                ValidationGroup="Save" ControlToValidate="txtId" CssClass="Validator" Display="Dynamic"
                                ErrorMessage="Enter The ID." ForeColor=""></asp:RequiredFieldValidator>

                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblDescription" runat="server" meta:Resourcekey="lblDescription" Text="Description"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" MaxLength="255" ID="txtDescription" Text=""></asp:TextBox>

                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgInspectionTypesDetails" AllowMultiRowSelection="true" runat="server" UseEditFormInMobile="true" CssClass="ResponsiveMargin"
                        HeaderStyle-Font-Size="8" Width="99.5%" PageSize="10" AllowPaging="True" AllowMultiRowEdit="True"
                        AutoGenerateColumns="false" AllowSorting="true" ShowStatusBar="true">

                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" Width="10%" />

                        <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">


                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="DISPLAY" UniqueName="Display" meta:Resourcekey="GridColumn_Display"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="Display">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsVisible")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkDisplay" runat="server" Checked='<%# CBool(IIf(Eval("IsVisible") Is System.DBNull.Value, 0, Eval("IsVisible")))%>' />
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="FIELD NAME" UniqueName="FIELDNAME" meta:Resourcekey="GridColumn_FieldName"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="FieldName">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("FieldName").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFieldName" MaxLength="4000" Text='<%# Eval("FieldName") %>' Width="100%" runat="server"></asp:TextBox>
                                        <asp:Label ID="lblFieldName" MaxLength="4000" Text='<%# Eval("FieldName") %>' Width="100%" Visible="false" runat="server"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvFieldName" ControlToValidate="txtFieldName" Display="Dynamic" ValidationGroup="SaveDetail"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="DATA TYPE" UniqueName="DataTypeId" meta:Resourcekey="GridColumn_DataType"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="DataTypeId">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Type") = "System", "-- System --", Container.DataItem("Type"))%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlTypes" AllowCustomText="false" runat="server" Skin="Default"
                                            CloseDropDownOnBlur="true" Width="100%" NoWrap="true" DropDownCssClass="ddlTreeviewTemplate">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="" />
                                            </Items>
                                            <ItemTemplate>
                                                <telerik:RadTreeView ID="rdvTypes" Skin="Default" runat="server" Height="250px" Width="100%"
                                                    OnNodeDataBound="rdvTypes_NodeDataBound" OnNodeExpand="rdvTypes_NodeExpand"
                                                    MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvOccupantNodeClicking" OnNodeClick="DataTypeSelectedIndexChanged">
                                                </telerik:RadTreeView>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:Label runat="server" ID="lblType" Visible="false"></asp:Label>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="DEFAULT" UniqueName="DEFAULT" meta:Resourcekey="GridColumn_FieldName"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="Default">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDefaultValue" runat="server" Text='<%#Container.DataItem("Default") %>'></asp:Label>

                                        <img runat="server" visible="false" id="imgCheck" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:CustomFormTypeValues style="position: relative; top: -8px;" ID="CustomFormTypeValuesDefaultValue" runat="server" />
                                    </EditItemTemplate>

                                    <%--     <HeaderStyle Wrap="False" Width="180px"></HeaderStyle>--%>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">

                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" CssClass="GridCmdEditRows"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count = 0 And (Not rdgInspectionTypesDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server"
                                            Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        SecurityButtonType="AddEditMode_Edit" ValidationGroup="SaveDetail"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="SaveDetail"
                                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                        Visible='<%# rdgInspectionTypesDetails.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnSaveResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count > 0 Or rdgInspectionTypesDetails.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count = 0 And (Not rdgInspectionTypesDetails.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnAddResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line"></asp:Label>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" SecurityButtonType="ItemMode_Delete"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count = 0 And (Not rdgInspectionTypesDetails.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"
                                            Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                        Visible='<%# rdgInspectionTypesDetails.EditIndexes.Count = 0 And (Not rdgInspectionTypesDetails.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false">
                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="SaveDetail" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
