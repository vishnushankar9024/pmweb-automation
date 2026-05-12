<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormTypeValues.ascx.vb"
    Inherits="Website.CustomFormTypeValues" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<style type="text/css">
    /*.riSingle .riTextBox {
    width: 160px !important;
}*/
</style>

<table cellpadding="0" cellspacing="0" id="tblValues" runat="server" width="100%"
    style="border-width: 0px">
    <tr id="trEditMode" runat="server">
        <td id="tdDataTypes" runat="server" style="border-width: 0px;" class="NoWrap">
            <telerik:RadComboBox ID="ddlDataTypes" runat="server" Width="100px" AutoPostBack="True" Skin="Default"
                LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                CausesValidation="False">
                <Items>
                    <telerik:RadComboBoxItem Text="Text" Value="String" meta:resourcekey="RadComboBoxItem1" />
                    <telerik:RadComboBoxItem Text="Integer" Value="Integer" meta:resourcekey="RadComboBoxItem2" />
                    <telerik:RadComboBoxItem Text="Double" Value="Double" meta:resourcekey="RadComboBoxItem3" />
                    <telerik:RadComboBoxItem Text="Currency" Value="Currency" meta:resourcekey="RadComboBoxItem4" />
                    <telerik:RadComboBoxItem Text="Date" Value="Date" meta:resourcekey="RadComboBoxItem5" />
                    <telerik:RadComboBoxItem Text="Cost Code" Value="CostCode" meta:resourcekey="RadComboBoxItem12" />
                    <telerik:RadComboBoxItem Text="List" Value="List" meta:resourcekey="RadComboBoxItem6" />
                    <telerik:RadComboBoxItem Text="Boolean" Value="Boolean" meta:resourcekey="RadComboBoxItem7" />
                </Items>
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
        </td>
        <td id="tdOptions" runat="server" style="border-width: 0px" class="NoWrap">
            <telerik:RadComboBox ID="ddlTextMode" runat="server" Width="90px" Skin="Default"
                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px; padding-left: 5px;" AutoPostBack="True"
                CausesValidation="False">
                <Items>
                    <telerik:RadComboBoxItem Text="Single Line" Value="SingleLine" meta:resourcekey="RadComboBoxItem8" />
                    <telerik:RadComboBoxItem Text="Multi Line" Value="MultiLine" meta:resourcekey="RadComboBoxItem9" />
                </Items>
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
            <asp:CheckBox ID="chkDefaultValue" runat="server" CssClass="mobile-switch" />
            <telerik:RadComboBox ID="ddlCostCodes" Visible="false" runat="server" Height="304px"
                Skin="Default" CloseDropDownOnBlur="true" Width="150px" DropDownWidth="200px"
                 NoWrap="true" EnableLoadOnDemand="True"  ShowMoreResultsBox="true"
                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" ShowToggleImage="true">
            </telerik:RadComboBox>
            <telerik:RadComboBox ID="ddlProjects" Visible="false" runat="server" Height="304px"
                Skin="Default" CloseDropDownOnBlur="true" Width="150px" DropDownWidth="200px"
                NoWrap="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" ShowToggleImage="true">
            </telerik:RadComboBox>
            <telerik:RadLabel runat="server" ID="lblDefaultValue" Width="100%"></telerik:RadLabel>
            <telerik:RadTextBox runat="server" ID="txtDefaultValue"></telerik:RadTextBox>
            <telerik:RadNumericTextBox Width="50px" ID="rnbHeight" runat="server" Skin="Default" Value="50"
                Culture="English (United States)" meta:resourcekey="rnbHeight">
            </telerik:RadNumericTextBox>
            <telerik:RadTextBox Width="250px" ID="txtLists" runat="server" Skin="Default" meta:resourcekey="txtLists">
            </telerik:RadTextBox>
            <telerik:RadComboBox ID="ddlLists" Visible="false" runat="server" Height="304px"
                Skin="Default" CloseDropDownOnBlur="true" Width="150px" DropDownWidth="200px" OnClientSelectedIndexChanged="CustomFormType_ResetCombos"
                 NoWrap="true" EnableLoadOnDemand="True"  ShowMoreResultsBox="true"
                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" ShowToggleImage="true">
            </telerik:RadComboBox>
            <telerik:RadComboBox ID="ddlCompanies" runat="server" EmptyMessage="Select Company..."
                Skin="Default"  AutoPostBack="True" NoWrap="True" AllowCustomText="True"
               Width="150px" DropDownWidth="200px" CausesValidation="False" Height="340px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
            </telerik:RadComboBox>
            <telerik:RadComboBox ID="ddlDateMode" runat="server" Width="100px" Skin="Default"
                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" AutoPostBack="True"
                CausesValidation="False">
                <Items>
                    <telerik:RadComboBoxItem Text="Fixed Date" Value="FixDate" meta:resourcekey="FixedDate" />
                    <telerik:RadComboBoxItem Text="Today" Value="Today" meta:resourcekey="RadComboBoxItem11" />
                </Items>
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
          
            <telerik:RadDatePicker ID="calDefaultDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                SelectedDate='<%# Date.Today %>' Width="110px" Skin="Default">
                <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default">
                </DateInput>
                <Calendar Skin="Default">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl="" CssClass=""></DatePopupButton>
            </telerik:RadDatePicker>
            <telerik:RadNumericTextBox ShowSpinButtons="True" Width="100px" ID="rnbDaysOffset"
                runat="server" Skin="Default" Culture="English (United States)" meta:resourcekey="rnbDaysOffset">
            </telerik:RadNumericTextBox>
            <telerik:RadComboBox ID="ddlDefaultValues" Visible="false" runat="server" Height="304px" OnClientItemsRequesting="CustomFormType_GetValueToReturn"
                Skin="Default" CloseDropDownOnBlur="true" Width="150px" DropDownWidth="200px"
                NoWrap="true" EnableLoadOnDemand="True"  ShowMoreResultsBox="true"
                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" ShowToggleImage="true" />
        </td>

    </tr>
    <tr id="trDisplayMode" runat="server">
        <td style="border-width: 0px" class="NoWrap">
            <asp:TextBox ID="txtValues" runat="server" Width="300px"></asp:TextBox>
            <asp:CheckBox ID="chkValue" runat="server" CssClass="mobile-switch"/>
            <telerik:RadDatePicker ID="calValue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                Width="110px" Skin="Default">
                <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default">
                </DateInput>
                <Calendar Skin="Default">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl="" CssClass=""></DatePopupButton>
            </telerik:RadDatePicker>
            <telerik:RadComboBox ID="ddlValues"   runat="server" Width="200px" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                Style="font-size: 11px" NoWrap="True" DropDownWidth="200px">
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
        </td>
    </tr>
</table>
