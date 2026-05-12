<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CurrenciesAddAndEditRatesPopup.aspx.vb" Inherits="Website.CurrenciesAddAndEditRatesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        //function CheckPositiveValue(sender, args) {
        //    var txtvalue = args.Value;
        //    if (txtvalue <= 0) {
        //        args.IsValid = false;
        //        return;
        //    }
        //    args.IsValid = true; 
        //    return;
        //}
        function clickOnToolbar(sender, args) {
            var comandName = args.get_item().get_commandName();
            if (comandName == "Save") {
                var btnCheckIsNew = $("[id$=btnCheckIsNew]");
                btnCheckIsNew.click();
            }
            if (comandName == "SaveExit") {
                var btnCheckIsNew = $("[id$=btnCheckIsNew]");
                btnCheckIsNew.click();
            }
        }
        function OpenCurrencyDuplicateDatePopup() {
            OpenPOPUp("CurrencyDuplicateDate.aspx", 350, 150, false);
            return false;
        }
        function SaveCurrencyRate() {
            var btnSave = $("[id$=btnSave]");
            btnSave.click();

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="clickOnToolbar" runat="server" AutoPostBack="true" Width="230px" CssClass="popup-toolbar">
                                    <Items>
                                          <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save" PostBack="false"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit" PostBack="false"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-4">
                        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                            <table class="colTable Margins" style="width:400px">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReferenceCurrency" runat="server" Text="Reference Currency" meta:Resourcekey="lblReferenceCurrency"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="width:240px !important">
                                        <asp:TextBox ID="txtReferenceCurrency" runat="server" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="Date" meta:Resourcekey="lblDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpDate" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="9999-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                            >
                                            <DateInput ID="DateInput1" runat="server"></DateInput>
                                            <Calendar ID="Calendar1" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvDate" CssClass="Validator"
                                            ValidationGroup="Save" ControlToValidate="dtpDate" Display="Dynamic"
                                            meta:resourcekey="rfvRate">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                </table>
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadGrid ID="rdgRates" runat="server" style="overflow: auto;;height: 495px;"
                                            HeaderStyle-Font-Size="8"  AutoGenerateColumns="False" AllowMultiRowEdit="True"
                                            AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="False">
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace" TableLayout="Fixed">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" HeaderStyle-Width="190px">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCode" runat="server" Text='<%#Eval("Code")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Rate" UniqueName="Rate" HeaderStyle-Width="190px">
                                                        <ItemTemplate>
                                                            <asp:TextBox Width="100%" ID="txtRate" CssClass="PositiveDouble" Precision="5" runat="server" Text='<%#FormatNumber(Eval("Rate"), 5)%>'></asp:TextBox></td>
                                                    <asp:Label ID="lblRateError" runat="server" Visible="false" Text="Value must be greater than 0." CssClass="Validator" meta:resourcekey="lblRateError"></asp:Label>
                                                            <asp:RequiredFieldValidator runat="server" ID="rfvRate" CssClass="Validator"
                                                                ValidationGroup="Save" ControlToValidate="txtRate" Display="Dynamic"
                                                                meta:resourcekey="rfvRate">
                                                            </asp:RequiredFieldValidator>
                                                            <%--<asp:CustomValidator runat="server" ID="csvRate" ErrorMessage='<%# Me.GetLocalResourceObject("csvRate.ErrorMessage")%>'
                                                        ControlToValidate="txtRate" CssClass="Validator" ClientValidationFunction="CheckPositiveValue" Display="Dynamic" ValidationGroup="Save">
                                                    </asp:CustomValidator>--%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                            <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                                <asp:Button ID="btnCheckIsNew" runat="server" CssClass="Hide"
                                    Text="" />
                         </table>
                        </telerik:RadAjaxPanel>
                </div>
            </div>
        </div>

        <asp:Button ID="btnSave" runat="server" CssClass="Hide" ValidationGroup="Save"
            Text="" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" 
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
