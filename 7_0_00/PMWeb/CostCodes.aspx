<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostCodes.aspx.vb" Inherits="Website.CostCodes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostCodeDetails.ascx" TagName="CostCodeDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Costs/BudgetSetup.js" type="text/javascript"></script>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpBudgetSetup">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBudgetSetup" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBudgetSetup" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table style="width: 100%;" cellspacing="0" cellpadding="0" border="0" runat="server">
        <tr class="ToolBar">
            <td style="width: 240px" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlProjects" runat="server" Skin="Default" AutoPostBack="true"
                    AllowCustomText="false"
                    ShowDropDownOnTextboxClick="true" Height="400px" OnClientTextChange="LOD_DropDownTextChange"
                    Width="100%" NoWrap="true"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">                                        
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#CostCodes"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" OnClientTabSelecting="onTabSelecting"
        runat="server" MultiPageID="mlpBudgetSetup" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="true" CssClass="documentTabs"
        CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpBudgetSetup" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">

                <div class="PMMainPage">
                    <div class="row row-8-4">
                        <div class="col-8">
                            <telerik:RadGrid ID="rdgGroups" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true"
                                Width="100%" AutoGenerateColumns="False" ShowStatusBar="true" ShowFooter="false"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" PageSize="25" AllowPaging="True">
                                <PagerStyle Mode="NextPrevAndNumeric" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id,IsUsed" CommandItemDisplay="Top" EditMode="InPlace" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Level #" UniqueName="LevelNumber" Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("GroupNumber").ToString%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblGroupNumber" runat="server"
                                                    Text='<%#Eval("GroupNumber").ToString%>'></asp:Label>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Description*" UniqueName="Description" SortExpression="Description">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDescription" MaxLength="100" runat="server" Text='<%#Bind("Description")%>' Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" CssClass="Validator"
                                                   Display="Dynamic" ForeColor="" meta:resourceKey="rfvDescription"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="350px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="# of Characters" UniqueName="NumberofCharacters" SortExpression="NumberofCharacters">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("NumberofCharacters") = "0", "&nbsp;", Container.DataItem("NumberofCharacters"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <span><%#IIf(Eval("NumberofCharacters") Is DBNull.Value OrElse Container.DataItem("NumberofCharacters") = "0", "&nbsp;", Eval("NumberofCharacters"))%></span>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="144px"></HeaderStyle>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Values" UniqueName="Values">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="btnAddGroupDetails" CssClass="SearchButton" Enabled="false">
    					                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                &nbsp;
                                            </EditItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="IsUsed" UniqueName="IsUsed" Display="false"></telerik:GridBoundColumn>


                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="GroupNumber"></telerik:GridSortExpression>
                                    </SortExpressions>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                                    SecurityButtonType="ItemMode_Edit"
                                                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgGroups.EditIndexes.Count = 0 And (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label runat="server" ID="lblEditSelected" Text="Edit Selected Lines" />
                                                </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                                SecurityButtonType="AddEditMode_Edit"
                                                CommandName="PerformUpdate" CssClass="GridCmdPerformUpdate" Visible='<%# rdgGroups.EditIndexes.Count > 0 %>'>
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblUpdateEdited" Text="Save" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                                SecurityButtonType="AddEditMode_Add"
                                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgGroups.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblSave" Text="Save" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                                SecurityButtonType="AddEditMode"
                                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgGroups.EditIndexes.Count > 0 Or rdgGroups.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblCancel" Text="Cancel" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                                SecurityButtonType="ItemMode_Add"
                                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgGroups.EditIndexes.Count = 0 And (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblAddLine" Text="Add Line" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                                Visible='<%# rdgGroups.EditIndexes.Count = 0 And (Not rdgGroups.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblDelete" Text="Delete Seleced Lines" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                                SecurityButtonType="ItemMode"
                                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgGroups.EditIndexes.Count = 0 And (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblRefresh" Text="Refresh" />&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCopyFromProject" runat="server" CausesValidation="false"
                                                SecurityButtonType="ItemMode_Add" CommandName="CopyFromProject">
                                                <asp:Label runat="server" ID="lblCopyFromProject" Text="Copy From Project" meta:resourcekey="lblCopyFromProject" />&nbsp;&nbsp;
                                                  <%--  Copy From Project&nbsp;&nbsp;--%>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>

                                </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="True" />
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                        <div class="col-4"></div>
                    </div>
                </div>

            </telerik:RadAjaxPanel>
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:CostCodeDetails ID="CostCodeDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


    <telerik:RadCodeBlock ID="CodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function pageLoad() {
                var rdgGroups = $find("<%= rdgGroups.ClientID %>");
            }

             function click_handler(sender, args) {

                 switch (args.get_item().get_commandName()) {

                    case 'ViewReports':
                        var ProjectValue = '<%=PM.CostManagement.BudgetSetupInfo.ProjectId%>';
                        if (parseInt(ProjectValue)){
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BUDGET_SETUP&Id=" +
                            '<%= PM.CostManagement.BudgetSetupInfo.ProjectId%>'
                            + "&EntityId=" + '<%=PM.CostManagement.BudgetSetupInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                     case 'BIReporting':

                         window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                         args.set_cancel(true);
                         break;
                         
                     case 'Print':
                         var ProjectValue = '<%=PM.CostManagement.BudgetSetupInfo.ProjectId%>';
                         if (parseInt(ProjectValue)) {
                             OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BUDGET_SETUP&Id=" +
                             '<%= PM.CostManagement.BudgetSetupInfo.ProjectId%>'
                             + "&EntityId=" + '<%=PM.CostManagement.BudgetSetupInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                         } else {
                             window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                             args.set_cancel(true);
                         }
                         break;


                    default:
                        break;
                }
            }
            //]]>
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
