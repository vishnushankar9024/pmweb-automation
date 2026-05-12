<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Currency.aspx.vb" Inherits="Website.Currency" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .RadioCss.MarginFix input[type="radio"] {
            margin-top: -10px !important;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/PMRotator/PMRotator.js" type="text/javascript"></script>
        <script type="text/javascript">

            function OpenUpdateRatesPopup(IsNew) {
                OpenCurrencyPOPUpToRedirect('CurrenciesAddAndEditRatesPopup.aspx?IsNew=' + IsNew, 480, 550, false, 'rdgRates');
                return false;
            }

            function OpenPastRates() {
                OpenPOPUpToRedirect('CurrencyPastRates.aspx', 450, 340, false);
                return false;
            }

            function OnRowSelecting(sender, eventArgs) {

                var rdgRates = $find($("[id$=rdgRates]")[0].id);
                var IsDefault = $("#" + eventArgs.get_id())[0].getAttribute("IsDefault")

                if (IsDefault == 1) {
                    var hfSelectedItems = $("[id$=hfSelectedItems]")[0];
                    hfSelectedItems.value = 'Clear';
                    eventArgs.set_cancel(true);
                }
            }

            //function CheckPositiveValue(sender, args) {
            //    var txtvalue = args.Value;
            //    if (txtvalue <= 0) {
            //        args.IsValid = false;
            //        return;
            //    }
            //    args.IsValid = true;
            //    return;
            //}

            function SetDefaults(sender, args) {
                var txtSymbol = document.getElementById(sender.get_id().replace('_ddlCodes', '_txtSymbol'));
                var txtDescription = document.getElementById(sender.get_id().replace('_ddlCodes', '_txtCurrency'));
                var ComboItem = sender.get_selectedItem();
                if (ComboItem != null) {
                    var DefaultSymbol = ComboItem.get_attributes().getAttribute("defaultsymbol");
                    var DefaultDescription = ComboItem.get_attributes().getAttribute("defaultdescription");
                    txtSymbol.value = DefaultSymbol;
                    txtDescription.value = DefaultDescription;
                }
            }
        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgCurrencyList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCurrencyList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hfSelectedItems" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgRates">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgRates" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hfSelectedItems" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="hfSelectedItems" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="hfSelectedItems" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mainToolBarCRate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
                                runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" CssClass="documentTabWithoutToolbar EmailSetupTabs"
                                CausesValidation="False">
                                <Tabs>
                                    <telerik:RadTab Value="General" Text="General" Selected="True"></telerik:RadTab>
                                    <telerik:RadTab Text="Conversion Rates" Value="ConversionRates"></telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>

                            <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPagesWithoutToolbar">
                                <telerik:RadPageView ID="pvGeneral" runat="server" Selected="True">
                                    <div class="PMHeader" style="padding-top: 38px">
                                        <div class="row">
                                            <div class="col-12">
                                                <fieldset>
                                                    <telerik:RadGrid ID="rdgCurrencyList" Width="100%" runat="server" AutoGenerateColumns="False" FitPageHeightOffset="1"
                                                        AllowPaging="True" PageSize="20" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true" ShowStatusBar="true"
                                                        AllowMultiRowSelection="true" ShowGroupPanel="false" AllowSorting="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" UseEditFormInMobile="true">
                                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                                            InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
                                                            <Columns>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="90px" ItemStyle-Wrap="false" HeaderText="ID*" UniqueName="CurrencyCode" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%#Eval("Code").ToString%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <telerik:RadComboBox ID="ddlCodes" Width="100%" Skin="Default" runat="server" Filter="Contains" AllowCustomText="True" MarkFirstMatch="true" OnClientSelectedIndexChanged="SetDefaults" Height="350px"></telerik:RadComboBox>
                                                                        <div>
                                                                            <asp:RequiredFieldValidator runat="server" ID="rfvCode" CssClass="Validator"
                                                                                ValidationGroup="Save" ControlToValidate="ddlCodes" Display="Dynamic"
                                                                                meta:resourcekey="rfvCode">
                                                                            </asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="100px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Currency*" UniqueName="CurrencyName" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%#Eval("Name").ToString%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCurrency" runat="server" MaxLength="100" Text='<%#Eval("Name") %>' Width="100%"></asp:TextBox>
                                                                        <div>
                                                                            <asp:RequiredFieldValidator runat="server" ID="rfvCurrency" CssClass="Validator"
                                                                                ValidationGroup="Save" ControlToValidate="txtCurrency" Display="Dynamic"
                                                                                meta:resourcekey="rfvCurrency">
                                                                            </asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="200px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="90px" ItemStyle-Wrap="false" HeaderText="Symbol*" UniqueName="CurrencySymbol" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%#Eval("Symbol").ToString%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtSymbol" runat="server" MaxLength="50" Text='<%#Eval("Symbol") %>' Width="100%"></asp:TextBox>
                                                                        <div>
                                                                            <asp:RequiredFieldValidator runat="server" ID="rfvSymbol" CssClass="Validator"
                                                                                ValidationGroup="Save" ControlToValidate="txtSymbol" Display="Dynamic"
                                                                                meta:resourcekey="rfvSymbol">
                                                                            </asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="100px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Symbol Position*" UniqueName="CurrencySymbolPosition" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server" ID="lblSymbolPosition"></asp:Label>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <telerik:RadComboBox ID="ddlSymbolPosition" runat="server" Width="100%">
                                                                            <Items>
                                                                                <telerik:RadComboBoxItem Text="Left" Value="Left" Selected="True" meta:resourcekey="SymbolPosition_LEFT"></telerik:RadComboBoxItem>
                                                                                <telerik:RadComboBoxItem  Text="Right" Value="Right" Selected="False" meta:resourcekey="SymbolPosition_RIGHT"></telerik:RadComboBoxItem>
                                                                            </Items>
                                                                        </telerik:RadComboBox>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="100px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="140px" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" HeaderText="Default Rate*" UniqueName="CurrencyDefaultRate" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%# FormatNumber(Eval("DefaultRate"), 5)%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtDefaultRate" runat="server" CssClass="PositiveDouble" Precision="5" MaxLength="50"
                                                                            Text='<%# FormatNumber(Eval("DefaultRate"), 5)%>' Width="100%"></asp:TextBox>
                                                                        <%--<div><asp:CustomValidator runat="server" ID="csvCurrencyDefaultRate" ErrorMessage='<%# Me.GetLocalResourceObject("csvCurrencyDefaultRate.ErrorMessage")%>'
                                                                ControlToValidate="txtDefaultRate" CssClass="Validator" ClientValidationFunction="CheckPositiveValue" Display="Dynamic" ValidationGroup="Save">
                                                            </asp:CustomValidator></div>--%>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="150px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="140px" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" HeaderText="Current Rate" UniqueName="CurrentRate" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%# FormatNumber(Eval("CurrentRate"), 5)%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCurrentRate" runat="server" CssClass="PositiveDouble" ReadOnly="True" Precision="5" MaxLength="50"
                                                                            Text='<%# FormatNumber(Eval("CurrentRate"), 5)%>' Width="100%"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="150px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Default*" UniqueName="IsDefaultCurrency" ItemStyle-HorizontalAlign="Center" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsDefault")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:CheckBox ID="chbIsDefault" Checked='<%# CBool(IIf(Eval("IsDefault") Is System.DBNull.Value, 0, Eval("IsDefault")))%>' runat="server" />
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="60px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="100%" ItemStyle-Wrap="false" HeaderText="PMWeb Word Decimal Name*" UniqueName="CurrencySubDivision" Groupable="false">
                                                                    <ItemTemplate>
                                                                        <%# Eval("SubDivision").ToString%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtSubDivision" runat="server" MaxLength="50" Text='<%#Eval("SubDivision") %>' Width="100%"></asp:TextBox>
                                                                        <div>
                                                                            <asp:RequiredFieldValidator runat="server" ID="rfvCurrencySubDivision" CssClass="Validator"
                                                                                ValidationGroup="Save" ControlToValidate="txtSubDivision" Display="Dynamic"
                                                                                meta:resourcekey="rfvtxtCurrencySubDivision">
                                                                            </asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="160px" />
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-Width="100%" ItemStyle-Wrap="false" HeaderText="PMWeb Word Decimal Places*" Groupable="false"
                                                                    ItemStyle-HorizontalAlign="Right" UniqueName="CurrencySubDivisionPrecision">
                                                                    <ItemTemplate>
                                                                        <%# Eval("SubDivisionPrecision").ToString%>&nbsp;
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtSubDivisionPrecision" runat="server" MaxLength="4" Text='<%#Eval("SubDivisionPrecision") %>' CssClass="PositiveInteger" Width="100%"></asp:TextBox>
                                                                        <div>
                                                                            <asp:RequiredFieldValidator runat="server" ID="rfvSubDivisionPrecision" CssClass="Validator"
                                                                                ValidationGroup="Save" ControlToValidate="txtSubDivisionPrecision" Display="Dynamic"
                                                                                meta:resourcekey="rfvSubDivisionPrecision">
                                                                            </asp:RequiredFieldValidator>
                                                                        </div>
                                                                        <div>
                                                                            <asp:RangeValidator Type="Double" MaximumValue="4" MinimumValue="1" ID="rnvCurrencySubDivisionPrecision" runat="server" ControlToValidate="txtSubDivisionPrecision" ValidationGroup="Save"
                                                                                CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rnvCurrencySubDivisionPrecision" ErrorMessage="*"></asp:RangeValidator>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                    <HeaderStyle Width="165px" />
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                            <CommandItemTemplate>
                                                                <div>
                                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                        Visible='<%# rdgCurrencyList.EditIndexes.Count = 0 And (Not rdgCurrencyList.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                                        Visible='<%# rdgCurrencyList.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                                        Visible='<%# rdgCurrencyList.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                                        &nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                                        Visible='<%# rdgCurrencyList.EditIndexes.Count > 0 Or (rdgCurrencyList.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnCancelResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" ValidationGroup="Save"
                                                                        Visible='<%# rdgCurrencyList.EditIndexes.Count = 0 And (Not rdgCurrencyList.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                                        Visible='<%# rdgRates.EditIndexes.Count = 0 And (Not rdgCurrencyList.MasterTableView.IsItemInserted)%>'
                                                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                                        meta:resourcekey="btnRefreshResource1" Visible='<%# rdgCurrencyList.EditIndexes.Count = 0 And (Not rdgCurrencyList.MasterTableView.IsItemInserted)%>'>
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </CommandItemTemplate>
                                                        </MasterTableView>
                                                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="false">
                                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="false" />
                                                            <Selecting AllowRowSelect="true" />
                                                            <ClientEvents OnRowDblClick="RowDblClick" />
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPageView>

                                <telerik:RadPageView ID="PvConversionRates" runat="server">



                                    <table class="ToolBar documentSubToolbar" cellpadding="0" cellspacing="0" width="100%" style="top: 68px">
                                        <tr valign="top">
                                            <td valign="top">
                                                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td class="ToolbarTd">
                                                            <telerik:RadToolBar ID="mainToolBarCRate" runat="server" Skin="Default" AutoPostBack="true" Width="90px" CssClass="popup-toolbar">
                                                                <Items>
                                                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" SecurityButtonType="Edit" ValidationGroup="SaveInfo" CommandName="Save"></telerik:RadToolBarButton>
                                                                </Items>
                                                            </telerik:RadToolBar>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td id="tdAdvancedMultiCurrency" runat="server">
                                                            <div style="width: 100%; height: 30px; background-color: #ffd0b9; padding-left: 10px">
                                                                <asp:Label ID="lblAdvancedMultiCurrencies" meta:Resourcekey="lblAdvancedMultiCurrencies"
                                                                    runat="server" Visible="true" Style="line-height: 30px;" Text="Advanced Multi-Currency is currently NOT enabled.11"></asp:Label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="PMMainPage">
                                        <div class="row documentMultiPages row-8-4">
                                            <div class="col-4">
                                                <table class="colTable" border="0">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:HyperLink runat="server" CssClass="Link" ID="hpldefaultCurrency" meta:Resourcekey="hpldefaultCurrency" Text="Default Currency11"></asp:HyperLink>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtDefaultCurrency" runat="server" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Button runat="server" ID="btnPastRates" meta:Resourcekey="btnPastRates" Text="PastRates1" OnClientClick="return OpenPastRates();" /></td>

                                                        <td class="controlWidth"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <fieldset style="width: 100%">
                                                                <legend class="legend">
                                                                    <asp:Label ID="lblRateServiceSettings" runat="server" meta:resourcekey="lblRateServiceSettings" Text="Rate Service Settings"></asp:Label>

                                                                </legend>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblRateServiceURL" runat="server" Text="Rate Service URL" meta:Resourcekey="lblRateServiceURL"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtRateServiceURL" runat="server" Enabled="false"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="rfvRateServiceURL" CssClass="Validator"
                                                                ValidationGroup="SaveInfo" ControlToValidate="txtRateServiceURL" Display="Dynamic"
                                                                meta:resourcekey="rfvRateServiceURL">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblUserName" runat="server" Text="User Name" meta:Resourcekey="lblUserName"></asp:Label>
                                                        </td>

                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblPassword" runat="server" Text="Password" meta:Resourcekey="lblPassword"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Style="width: 100%; height: 24px; box-sizing: border-box;"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDONotDownload" runat="server" Text="Do Not Download" meta:resourcekey="rdbDoNotDownload" Style="text-transform: uppercase;"></asp:Label>

                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:RadioButton ID="rdbDoNotDownload" runat="server" Text="" CssClass="RadioCss MarginFix" GroupName="RateDownloadSettings" OnCheckedChanged="RateDownloadSettings_CheckedChanged" AutoPostBack="True" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDaily" runat="server" Text="Daily" meta:resourcekey="rdbDaily" Style="text-transform: uppercase;"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:RadioButton ID="rdbDaily" runat="server" Text="" CssClass="RadioCss MarginFix" GroupName="RateDownloadSettings" OnCheckedChanged="RateDownloadSettings_CheckedChanged" AutoPostBack="True" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblWeekly" runat="server" Text="Weekly" meta:resourcekey="rdbWeekly" Style="text-transform: uppercase;"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:RadioButton ID="rdbWeekly" runat="server" Text="" CssClass="RadioCss MarginFix" GroupName="RateDownloadSettings" OnCheckedChanged="RateDownloadSettings_CheckedChanged" AutoPostBack="True" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblMonthly" runat="server" Text="Monthly" meta:resourcekey="rdbMonthly" Style="text-transform: uppercase;"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:RadioButton ID="rdbMonthly" runat="server" Text="" CssClass="RadioCss MarginFix" GroupName="RateDownloadSettings" OnCheckedChanged="RateDownloadSettings_CheckedChanged" AutoPostBack="True" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblStartDate" runat="server" Text="Start Date*" meta:Resourcekey="lblStartDate"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <span runat="server" id="rmd_dtpStartDate" style="display: block">
                                                                <telerik:RadDatePicker ID="dtpStartDate" runat="server" Culture="English (United States)"
                                                                    EnableTyping="True" MaxDate="9999-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                                                    Skin="Default" Width="150px">
                                                                    <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                                                    <Calendar ID="Calendar2" runat="server" Skin="Default"></Calendar>
                                                                </telerik:RadDatePicker>
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" CssClass="Validator"
                                                                    ValidationGroup="SaveInfo" ControlToValidate="dtpStartDate" Display="Dynamic"
                                                                    meta:resourcekey="rfvValueDateRequired"> </asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblTime" runat="server" Text="Time*" meta:Resourcekey="lblTime"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadTimePicker ID="dtpTime" runat="server" Culture="English (United States)"
                                                                EnableTyping="True" MaxDate="9999-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                                                Skin="Default" Width="150px">
                                                                <DateInput ID="DateInput3" runat="server" LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                                                <Calendar ID="Calendar3" runat="server" Skin="Default"></Calendar>
                                                            </telerik:RadTimePicker>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="Validator"
                                                                ValidationGroup="SaveInfo" ControlToValidate="dtpTime" Display="Dynamic"
                                                                meta:resourcekey="rfvValueDateRequired"> </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblEndDate" runat="server" Text="End Date*" meta:Resourcekey="lblEndDate"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <span runat="server" id="rmd_dtpEndDate" style="display: block">
                                                                <telerik:RadDatePicker ID="dtpEndDate" runat="server" Culture="English (United States)"
                                                                    EnableTyping="True" MaxDate="9999-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                                                    Skin="Default" Width="150px">
                                                                    <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                                                                    <Calendar ID="Calendar1" runat="server" Skin="Default"></Calendar>
                                                                </telerik:RadDatePicker>
                                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueDate" CssClass="Validator"
                                                                    ValidationGroup="SaveInfo" ControlToValidate="dtpEndDate" Display="Dynamic"
                                                                    meta:resourcekey="rfvValueDateRequired">
                                                                </asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                    </tr>

                                                    <tr runat="server" id="trWeekly">
                                                        <td style="width: 100px;">
                                                            <asp:Label ID="lblWeekDays" runat="server" Text="Day of the Week11" meta:resourcekey="lblWeekDays"></asp:Label>
                                                        </td>
                                                        <td style="text-align: start; width: 200px;">
                                                            <telerik:RadComboBox ID="ddlWeekDays" Width="125px" Skin="Default" runat="server">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trMonthlyOnDay">
                                                        <td style="width: 100px;">
                                                            <asp:RadioButton ID="rdoMonthlyOnDay" Checked="true" CssClass="RadioCss" AutoPostBack="true" runat="server" Text="Day11" meta:resourcekey="rdoMonthlyOnDay" GroupName="Monthly" />
                                                        </td>
                                                        <td style="text-align: start; width: 200px;">
                                                            <telerik:RadNumericTextBox ID="txtDaysOfMonth" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" MaxValue="31" Width="60px" runat="server">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n"
                                                                    PositivePattern="n" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trMonthlyOnThe">
                                                        <td style="width: 100px;">
                                                            <asp:RadioButton ID="rdoMonthlyOnThe" AutoPostBack="true" CssClass="RadioCss" meta:resourcekey="rdoMonthlyOnThe" runat="server" Text="The11" GroupName="Monthly" />
                                                        </td>
                                                        <td>
                                                            <table class="colTable">
                                                                <tr>
                                                                    <td style="width: 50%; padding-right: 4px;">
                                                                        <telerik:RadComboBox ID="ddlWeekDayPart" Width="100%" Skin="Default"
                                                                            runat="server">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td style="width: 50%; padding-left: 4px;">
                                                                        <telerik:RadComboBox ID="ddlMonthWeekDays" Width="100%" Skin="Default" runat="server">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>

                                                    </tr>
                                                </table>
                                                <table class="colTable">
                                                    <tr>
                                                        <td class="labelColor">
                                                            <asp:Label ID="Label3" runat="server" Text="Allow Service to Update Existing Records" meta:resourcekey="chkUpdateExistingDateRecords"></asp:Label>

                                                        </td>
                                                        <td style="text-align: right; width: 20px">
                                                            <asp:CheckBox runat="server" ID="chkUpdateExistingDateRecords" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-8">
                                                <table class="colTable">
                                                    <tr>
                                                        <td>
                                                            <fieldset>
                                                                <telerik:RadGrid ID="rdgRates" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" Width="100%"
                                                                    AutoGenerateColumns="True" setwidth="true" AllowSorting="true" ShowGroupPanel="false" AllowMultiRowEdit="false" ShowStatusBar="false" AllowPaging="True" PageSize="20">
                                                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                                        ClientDataKeyNames="FromDate" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                                                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="False">
                                                                        <Columns>
                                                                            <%--<telerik:GridTemplateColumn HeaderText="To Be Processed" UniqueName="Processed">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Processed")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="60px" />
                                                    </telerik:GridTemplateColumn>--%>
                                                                            <telerik:GridTemplateColumn HeaderStyle-Width="120px" UniqueName="FromDate" ItemStyle-Wrap="false" HeaderText="Date"
                                                                                Groupable="False" Reorderable="False"
                                                                                SortExpression="FromDate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFromDate" Text='<%# IIf(FormatDate(Eval("FromDate")) = String.Empty, GetLocalResourceObject("lblDefaultRates"), FormatDate(Eval("FromDate")))%>' runat="server"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Width="125px" />
                                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            </telerik:GridTemplateColumn>
                                                                        </Columns>
                                                                        <CommandItemTemplate>
                                                                            <div style="padding: 2px">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                                                Visible='<%# rdgRates.EditIndexes.Count = 0 And (Not rdgRates.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                                                                                <span class="Icon"></span>
                                                                                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>

                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" ValidationGroup="Save"
                                                                                                Visible='<%# rdgRates.EditIndexes.Count = 0 And (Not rdgRates.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                                                                                <span class="Icon"></span>
                                                                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                                                                Visible='<%# rdgRates.EditIndexes.Count = 0 And (Not rdgRates.MasterTableView.IsItemInserted) %>'
                                                                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                                                                                <span class="Icon"></span>
                                                                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                                                                meta:resourcekey="btnRefreshResource1" Visible='<%# rdgRates.EditIndexes.Count = 0 And (Not rdgRates.MasterTableView.IsItemInserted) %>'>
                                                                                                <span class="Icon"></span>
                                                                                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnSaveState" runat="server" CausesValidation="False"
                                                                                                CommandName="SaveState" Visible="False">
                                                                                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="btnLoadDefaultState" runat="server"
                                                                                                CausesValidation="False" CommandName="LoadDefaultState" Visible="False">
                                                                                                &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </CommandItemTemplate>
                                                                    </MasterTableView>

                                                                    <ClientSettings AllowDragToGroup="false" AllowColumnHide="false" AllowColumnsReorder="true">
                                                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                                            AllowColumnResize="True" />
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                                                                        <ClientEvents OnRowSelecting="OnRowSelecting" />
                                                                    </ClientSettings>
                                                                </telerik:RadGrid>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <asp:HiddenField runat="server" ID="hfSelectedItems" Value="" />
</asp:Content>
