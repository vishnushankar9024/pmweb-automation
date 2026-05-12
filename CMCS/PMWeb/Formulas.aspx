<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Formulas.aspx.vb" Inherits="Website.Formulas" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<%@ Register Src="FormulaDetails.ascx" TagName="FormulaDetails" TagPrefix="uc1" %>--%>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value().indexOf("Generate_") == 0) {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(value) {
                var left = (screen.width - 910) / 2;
                var top = (screen.height - 380) / 2;
                var HasPMWebReports = '<%=PM.QueryBuilderPermissionController.HasReports("FORMULA")%>';
                var Id = '<%= PM.Estimate.FormulaInfo.Id %>';
                 <%--var HasReports = '<%= PM.FormulaInfo.HasReports%>';--%>
                 <%--var RecordDescription = '<%=JSEscape(PM.FormulaInfo.RecordDescription)%>';--%>
                switch (value) {
                     case 'Print':
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=FORMULA&Id=" +
                            '<%= PM.Estimate.FormulaInfo.Id %>',
                            'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    default:
                        break;
                }
            }

            function LOD_DropDownTextChange(sender, args) {
                if (sender.get_value() == '') {
                    args.set_cancel(true);
                }
            }
        
        </script>

    </telerik:RadCodeBlock>
 
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpFormulas">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFormulas" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFormulas" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<%--    <style>
        .documentMultiPages{
            margin-top:115px !important;
        }
        @media screen and (min-width: 320px) and (max-width: 843px) {
             .documentMultiPages {
                 margin-top: 180px !important;
             }
        }
    </style>--%>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default"
                                AutoPostBack="True">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                                        EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#Formulas">
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
   
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
                    runat="server" MultiPageID="mlpFormulas" Skin="Default" OnTabClick="tbsDocument_TabClick"
                    Width="100%" EnableViewState="true" CausesValidation="False">
                    <Tabs>
                        <telerik:RadTab Text="Header" Value="Header" Selected="True" />
                        <telerik:RadTab Text="Notes" Value="Notes" />
                        <telerik:RadTab Text="Attachments" Value="Attachments" />
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="mlpFormulas" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
                    RenderSelectedPageOnly="True">
                    <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                        <div class="PMMainPage JustifyContent">
                            <div class="row">
                                <div class="col-4 col-4-left">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblIdText" meta:resourcekey="lblIdText" Text="Formula ID*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox runat="server" ReadOnly="true" ID="txtId" meta:resourcekey="lblId" Style="text-align: right;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox runat="server" MaxLength="200" ID="txtDescription"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                                    CssClass="Validator" Display="Dynamic" meta:resourcekey="rfv_Description"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="LblType" runat="server" meta:resourcekey="LblType"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Skin="Default" AllowCustomText="true"
                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-4 col-4-right">
                                    <uc11:AssetRotator ID="PMrot" runat="server" />
                                </div>
                            </div>
                            <div class="PMHeader">
                                <div class="row">
                                    <div class="col-12">
                                        <telerik:RadGrid ID="rdgFormulaDetails" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True" UseEditFormInMobile="true" Width="200px" AllowSorting="true"
                                            AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                EditMode="InPlace" EnableHeaderContextMenu="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" GroupByExpression="DetailOrder [GridColumn_Line] Group By DetailOrder ASC" Reorderable="true"
                                                        Groupable="false" DataField="DetailOrder" AllowFiltering="false" SortExpression="DetailOrder" AllowSorting="true">
                                                        <ItemTemplate>
                                                            <%#Container.DataItem("DetailOrder").ToString%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <%#Eval("DetailOrder").ToString%>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                                                        UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                                                        GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnAttachments"> 
                                                                        <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" Groupable="false" DataField="Variable">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("Variable") = String.Empty, "&nbsp;", Container.DataItem("Variable"))%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtVariable" MaxLength="50" runat="server" Text='<%# Eval("Variable") %>' Width="99%"></asp:TextBox>
                                                            <div style="display: block">
                                                                <asp:RequiredFieldValidator ID="rfvVariable" runat="server" ControlToValidate="txtVariable"
                                                                    CssClass="Validator" ErrorMessage="Enter the Variable" Display="Dynamic" ForeColor=""
                                                                    meta:resourcekey="rfvVariable"></asp:RequiredFieldValidator>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description" Groupable="false">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text='<%# Eval("Description") %>' Width="99%"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" Groupable="false" DataField="UOM">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlUOM" runat="server" AllowCustomText="true" Width="99%" Filter="Contains" MarkFirstMatch="true">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Calculation / Quantity" UniqueName="CalculationQuantity" DataField="Calculation"
                                                        Groupable="false">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Calculation") = String.Empty, "&nbsp;", RestoreCalculationFromUS(Container.DataItem("Calculation")))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtCalculation" MaxLength="500" runat="server" Text='<%# RestoreCalculationFromUS(IIf(Eval("Calculation") Is System.DBNull.Value, "", Eval("Calculation"))) %>'
                                                                Width="100%"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" Groupable="false" DataField="Notes">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>' Width="99%"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="175px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="DetailOrder"></telerik:GridSortExpression>
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                                        CancelImageUrl="Cancel.gif">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">

                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                            CommandName="EditRows" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 And (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                                            CommandName="UpdateEdited" Visible='<%# rdgFormulaDetails.EditIndexes.Count > 0 %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                                            CommandName="PerformInsert" Visible='<%# rdgFormulaDetails.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                            CommandName="CancelAll" Visible='<%# rdgFormulaDetails.EditIndexes.Count > 0 Or rdgFormulaDetails.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                                            CommandName="InitNewRow" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 And (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblAddLine" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                                            OnClientClick="return ConfirmDelete()" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 And (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'
                                                            runat="server" CommandName="DeleteRows">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                            CommandName="RebindGrid" Visible='<%# rdgFormulaDetails.EditIndexes.Count = 0 And (Not rdgFormulaDetails.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                            CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                            EnableShadows="true" CausesValidation="false"
                                                            Visible="true">
                                                        </telerik:RadMenu>
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                            <ClientSettings>
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                        <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                        <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
     
    <telerik:RadAjaxLoadingPanel ID="ldpFormulas" runat="server" Skin="Default" />
</asp:Content>
