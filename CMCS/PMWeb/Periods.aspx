<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Periods.aspx.vb" Inherits="Website.Periods" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgPeriods">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgPeriods" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEntities" />
                     <telerik:AjaxUpdatedControl ControlID="divMessage" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlEntities">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgPeriods" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEntities" />
                     <telerik:AjaxUpdatedControl ControlID="divMessage" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style>
        .MainPagedocumentSinglePage{
            margin-top:0px
        }
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .MainPagedocumentSinglePage{
                margin-top:60px
            }

            .GridMargin {
                margin-top: 50px;
            }
            .divContentHolder {
               margin-top: 0px !important;
            }
        }
    </style>


    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />

<%--    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 160px" class="ToolbarTd"><b>
                            <asp:Label ID="lblPeriods" meta:Resourcekey="lblPeriods" runat="server" Text="Periods for" Style="font-weight: normal;"></asp:Label></b></td>
                        <td style="width: 240px;">
                            <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                EmptyMessage="Select Entity..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                                CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                <Items>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--%>
    <div class="PMHeader" >
        <div class="row MainPagedocumentSinglePage">
                
            <div class="col-12">
                <telerik:RadGrid ID="rdgPeriods" runat="server" HeaderStyle-Font-Size="8" AppendMenus="true" allow-scroll="true"
                    AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" UseEditFormInMobile="true"
                    AllowMultiRowEdit="True" AllowMultiRowSelection="true" ClientSettings-Scrolling-AllowScroll="true" setwidth="true">
                    <PagerStyle Mode="NextPrevAndNumeric" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="#" UniqueName="LineNumber">
                                <ItemTemplate>
                                    <%#Container.DataItem("LineNumber")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <HeaderStyle Width="30px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("Period") = String.Empty, "&nbsp;", Container.DataItem("Period"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPeriod" MaxLength="100" runat="server" Text='<%#Eval("Period")%>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Budget Year" UniqueName="BudgetYear">
                                <ItemTemplate>
                                    <%#IIf(Eval("BudgetYear") Is DBNull.Value, "&nbsp;", Eval("BudgetYear"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadNumericTextBox ID="rntBudgetYear" ShowSpinButtons="true"
                                        IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                        Label="" runat="server" Width="100%" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>"
                                        MaxValue="2100" MinValue="1899">
                                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                    </telerik:RadNumericTextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="70px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="From Date" UniqueName="FromDate">
                                <ItemTemplate>
                                    <%#FormatDate(Container.DataItem("FromDate"))%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="calFromDate" runat="server" MinDate="1901-01-01"
                                        MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                        Width="100%" Skin="Default" Culture="English (United States)"
                                        EnableTyping="True">
                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <HeaderStyle Width="125px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="To Date" UniqueName="ToDate">
                                <ItemTemplate>
                                    <%#FormatDate(Container.DataItem("ToDate"))%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="calToDate" runat="server" MinDate="1901-01-01"
                                        MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                        Width="100%" Skin="Default" Culture="English (United States)"
                                        EnableTyping="True">
                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                        <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <HeaderStyle Width="125px" />
                            </telerik:GridTemplateColumn>

                        </Columns>
                        <SortExpressions>
                        </SortExpressions>
                        <CommandItemTemplate>
                            <div style="padding: 2px">

                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit"
                                    CommandName="EditRows" Visible='<%# rdgPeriods.EditIndexes.Count = 0 And (Not rdgPeriods.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit"
                                    CommandName="UpdateEdited" Visible='<%# rdgPeriods.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add"
                                    CommandName="PerformInsert" Visible='<%# rdgPeriods.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" Visible='<%# rdgPeriods.EditIndexes.Count > 0 Or rdgPeriods.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add"
                                    CommandName="InitNewRow" Visible='<%# rdgPeriods.EditIndexes.Count = 0 And (Not rdgPeriods.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    SecurityButtonType="ItemMode_Delete"
                                    Visible='<%# rdgPeriods.EditIndexes.Count = 0 And (Not rdgPeriods.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    Visible='<%# rdgPeriods.EditIndexes.Count = 0 And (Not rdgPeriods.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnGenerate" runat="server" CausesValidation="false" CssClass="GridCmdGenerateNext"
                                    SecurityButtonType="ItemMode_Add"
                                    CommandName="GenerateNext" Visible='<%# rdgPeriods.EditIndexes.Count = 0 And (Not rdgPeriods.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Generate Next" runat="server" ID="lblGenerateNext"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="true">
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                </telerik:RadGrid>
                <div class="col-12" id="divMessage" runat="server" style="padding-left: 4px;">
                    <div class="col-12">
                        <br />
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMessage" runat="server" CssClass="Validator" style="top:-10px;position:relative"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="hplCopyFromProject" Text="Copy From Project" CssClass="lnkCreateNext" meta:Resourcekey="hplCopyFromProject" Width="200px"
                                            OnClientClick="return OpenSmallPOPUp('PeriodProjectsLookup.aspx', 370, 563, true);" style="margin-bottom:24px;"/>
                                    </td>
                                </tr>
                            </table>
                    </div>
            </div>

            </div>

        </div>
    </div>

</asp:Content>
