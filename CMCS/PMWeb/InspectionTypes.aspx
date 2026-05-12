<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="InspectionTypes.aspx.vb" Inherits="Website.InspectionTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <%@ Register Src="CustomFormTypeValues.ascx" TagName="CustomFormTypeValues" TagPrefix="uc1" %>

    <style>
        .ToolbarMobileMenu {
            margin-left: 11px !important;
        }


        /*.ChkALL{
            padding-left:50px;
        }*/
    </style>
    <telerik:radcodeblock id="CodeBlock" runat="server">
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

            function AllDisplayColumnsClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgInspectionTypesDetails']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && this.id.indexOf("chkDisplay") > 0) {
                            if (!this.checked)
                                j = j + 1;
                            if (this.checked)
                                k = k + 1;
                            this.checked = iObj.checked;
                        }
                       
                    }
                    i++;
                 
                });
                UpdateDisplayedColumns(iObj);
                
            }

            function UpdateDisplayedColumns(iObj) {
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/UpdateDisplayedColumns",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ IsChecked: iObj.checked }),
                    dataType: "json",
                    async: true
                });
                var btnrefresh = document.getElementById("ctl00_CPH1_rdgInspectionTypesDetails_ctl00_ctl02_ctl00_btnRefresh");
                btnrefresh.click();
            }

            function  SelectInspectionTypesParent(sender){
                var rdgRights = $("div[id$='rdgInspectionTypesDetails']");
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                var inspectionDetailId=parseInt(sender.parentElement.getAttribute('InspectionDetailId'));
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (sender.checked) {
                            if (!this.disabled && !this.checked && this.id.indexOf("chkDisplay") > 0) isChecked = false;
                        }
                    }
                    i++;
                });


                if (!sender.checked) {
                    chkPArent.checked = false;



                } else {
                    chkPArent.checked = isChecked;

                }
                UpdateDisplayedColumn(sender, inspectionDetailId);

                return false;
           
            };
            function UpdateDisplayedColumn(sender, inspectionDetailId) {
              $.ajax({
                  type: "POST",
                  url: "AjaxService.aspx/UpdateDisplayedColumn",
                  contentType: "application/json; charset=utf-8",
                  data: JSON.stringify({ IsChecked: sender.checked, inspectionDetailId: inspectionDetailId }),
                  dataType: "json",
                  async: true
              });
              var btnrefresh = document.getElementById("ctl00_CPH1_rdgInspectionTypesDetails_ctl00_ctl02_ctl00_btnRefresh");
              btnrefresh.click();
              
            }
            function InspectionTypes_OnRowSelected(sender, eventArgs) {
                var IsSystem = $("#" + eventArgs.get_id())[0].getAttribute("IsSystem")
                var btndelete = document.getElementById('ctl00_CPH1_rdgInspectionTypesDetails_ctl00_ctl02_ctl00_btnDelete');

                if (IsSystem) {
                    btndelete.classList.add("Hide");

                }
                else {
                    btndelete.classList.remove("Hide");
                }
            }

        </script>
    </telerik:radcodeblock>

    <telerik:radajaxmanagerproxy id="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgInspectionTypesDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgInspectionTypesDetails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>


        </AjaxSettings>
    </telerik:radajaxmanagerproxy>


    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar SmallToolbar" valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="true"
                                onclientbuttonclicked="click_handler">
                                <Items>
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

                                            <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord" SecurityButtonType="Copy"  ValidationGroup="Save">
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
                            </telerik:radtoolbar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="PMMainPage marginBottomOnMobile">
        <div class="row ">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblId" runat="server" meta:Resourcekey="lblId" Text="ID*"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" MaxLength="255" ID="txtId" Text=""></asp:TextBox>
                            <asp:Label ID="lblIdUnique" meta:Resourcekey="lblIdUnique"
                                runat="server" Text="ID must be unique."
                                Visible="False" Class="Validator"></asp:Label>
                            <asp:RequiredFieldValidator ID="rfvId" runat="server" meta:Resourcekey="rfvId"
                                ValidationGroup="Save" ControlToValidate="txtId" CssClass="Validator" Display="Dynamic"
                              ForeColor=""></asp:RequiredFieldValidator>

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
                    <telerik:radgrid id="rdgInspectionTypesDetails" allowmultirowselection="true" runat="server" useeditforminmobile="true" cssclass="ResponsiveMargin"
                        headerstyle-font-size="8" width="99.5%" PageSize="250" allowpaging="True" allowmultirowedit="True"
                        autogeneratecolumns="false" allowsorting="true" showstatusbar="true">

                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" Width="10%" />

                        <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">


                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="DISPLAY" UniqueName="Display" meta:Resourcekey="GridColumn_Display"  ItemStyle-HorizontalAlign="Left"
                                   HeaderStyle-Width="120px" SortExpression="Display">
                                       <HeaderTemplate>
                                    <asp:CheckBox ID="chkAll" onClick="AllDisplayColumnsClicked(this)" runat="server" cssclass="ChkALL"/>
                                </HeaderTemplate>
                                    <ItemTemplate>
                                              <asp:CheckBox ID="chkDisplay" runat="server"  Checked='<%# CBool(IIf(Eval("IsVisible") Is System.DBNull.Value, 0, Eval("IsVisible")))%>' />
                                    </ItemTemplate>
                               
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                  <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Order" meta:Resourcekey="GridColumn_FieldNumber" UniqueName="FieldNumber" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="120px">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("FieldNumber").ToString()%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("FieldNumber").ToString()%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="FIELD NAME" UniqueName="FIELDNAME" meta:Resourcekey="GridColumn_FieldName"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="FieldName">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("FieldName").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFieldName" MaxLength="4000" Text='<%# Eval("FieldName") %>' Width="100%" runat="server"></asp:TextBox>
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

                                <telerik:GridTemplateColumn HeaderText="DEFAULT" UniqueName="DEFAULT" meta:Resourcekey="GridColumn_Default"
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="Default">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDefaultValue" runat="server" Text='<%#Container.DataItem("Default") %>'></asp:Label>

                                        <img runat="server" visible="false" id="imgCheck" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:CustomFormTypeValues style="position: relative; top: -8px;" ID="CustomFormTypeValuesDefaultValue" runat="server" />
                                    </EditItemTemplate>

                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                                               <telerik:GridTemplateColumn HeaderText="WIDTH IN TABLE (PX)" UniqueName="WIDTH" meta:Resourcekey="GridColumn_WIDTH" 
                                    HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="25%" SortExpression="Default">
                                    <ItemTemplate>
                                        <asp:Label ID="lblwidth" runat="server" Text='<%#Container.DataItem("FieldWidth") %>'></asp:Label>

                                    </ItemTemplate>
                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtFieldWidth"  runat="server" Width="99%" Text='<%# Eval("FieldWidth")%>' CssClass="Integer" ></asp:TextBox>
                                    </EditItemTemplate>
 
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
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true">
                            <ClientEvents OnRowDblClick="RowDblClick" OnRowSelected="InspectionTypes_OnRowSelected"></ClientEvents>
                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="SaveDetail" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:radgrid>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
