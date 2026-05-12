<%@ Page Language="vb" meta:resourcekey="Page" Title="Currency Defaults" AutoEventWireup="false" CodeBehind="DefaultCurrencyPopUp.aspx.vb" Inherits="Website.DefaultCurrencyPopUp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .FontWhite a {
            color: #FFF !important;
        }

        .FontWhite:hover a {
            color: #000 !important;
        }

        .RadCalendar_Metro .rcRow td.rcSelected {
            background: #fff !important;
            border: #25a0da 1px solid;
        }

        .RadCalendar_Metro .rcRow .rcSelected a {
            color: #000 !important;
        }
         @media screen and (max-width: 843px) {
            .PMHeader > div.row {
                margin-top:74px;
            }
        }
          @media screen and (min-width:320px) and (max-width:843px)  {
            .PMHeader .row .col-4  {
               width:396px !important;
            }
            .PMHeader{ width:396px !important;}
        }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            var CheckedOption = '';

            function pageLoad() {
                if ($("input[id=rdbDefaultRates]")[0].checked == true)
                    CheckedOption = 'Default';
                if ($("input[id=rdbLinkedToRateMatrix]")[0].checked == true)
                    CheckedOption = 'LinkedToRateMatrix';
                if ($("input[id=rdbSavedInRecord]")[0].checked == true)
                    CheckedOption = 'SavedInRecord';
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

            function click_handler(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'Cancel': CloseRadWnd();

                }


            }

            function DisableCurrentToolbar() {
                if ($("input[id=rdbDefaultRates]")[0].checked == true && CheckedOption == 'Default')
                    return true;
                if ($("input[id=rdbLinkedToRateMatrix]")[0].checked == true && CheckedOption == 'LinkedToRateMatrix')
                    return true;
                if ($("input[id=rdbSavedInRecord]")[0].checked == true && CheckedOption == 'SavedInRecord')
                    return true;

                var maintoolbar = $find("<%=mainToolBar.ClientID%>");
                maintoolbar.set_enabled(false);
                return true;
            }

        </script>
    </telerik:RadCodeBlock>
</head>
<body>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
        </script>
    </telerik:RadScriptBlock>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgRates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgRates" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM1" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td valign="middle" align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientButtonClicked="click_handler" CssClass="popup-toolbar">
                        <Items>
                             <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save" Value="Save"> </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                PostBack="false">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMHeader" style="margin-left:24px;margin-right:24px;">
            <div class="row">
                <div class="col-4">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbDefaultRates" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                                    meta:resourcekey="rdbDefaultRates" Text="Default Rates" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbLinkedToRateMatrix" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                                    meta:resourcekey="rdbLinkedToRateMatrix" Text="Linked to Rate Matrix" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbSavedInRecord" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                                    meta:resourcekey="rdbSavedInRecord" Text="Save Rates in this Record" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row" style="margin-top: 0 !important; padding-top: 0 !important">
                <div class="col-4">
                    <table class="colTable" width="400px">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRateDate" runat="server" Text="Rate Date" meta:resourcekey="lblRateDate"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important">
                                <telerik:RadComboBox ID="ddlDefaultRate" runat="server"
                                    OnSelectedIndexChanged="ddlDefaultRate_OnSelectedIndexChanged" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="Fixed Date" Value="FixedDate" meta:resourcekey="ItemValue_Fixed_Date" />
                                        <telerik:RadComboBoxItem Text="Today" Value="Today" meta:resourcekey="ItemValue_Today" />
                                        <telerik:RadComboBoxItem Text="Yesterday" Value="Yesterday" Selected="True" meta:resourcekey="ItemValue_Yesterday" />
                                        <telerik:RadComboBoxItem Text="Last Week" Value="LastWeek" meta:resourcekey="ItemValue_Last_Week" />
                                        <telerik:RadComboBoxItem Text="Last Month" Value="LastMonth" meta:resourcekey="ItemValue_Last_Month" />
                                        <telerik:RadComboBoxItem Text="Last Quarter" Value="LastQuarter" meta:resourcekey="ItemValue_Last_Quarter" />
                                        <telerik:RadComboBoxItem Text="Last Year" Value="LastYear" meta:resourcekey="ItemValue_Last_Year" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="labelWidth"></td>
                            <td colspan="2" class="controlWidth" style="width: 240px !important">
                                <telerik:RadComboBox ID="ddlWeekDays" Visible="false" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="Monday" Value="Monday" Selected="True" meta:resourcekey="ItemValue_Monday" />
                                        <telerik:RadComboBoxItem Text="Tuesday" Value="Tuesday" meta:resourcekey="ItemValue_Tuesday" />
                                        <telerik:RadComboBoxItem Text="Wednesday" Value="Wednesday" meta:resourcekey="ItemValue_Wednesday" />
                                        <telerik:RadComboBoxItem Text="Thursday" Value="Thursday" meta:resourcekey="ItemValue_Thursday" />
                                        <telerik:RadComboBoxItem Text="Friday" Value="Friday" meta:resourcekey="ItemValue_Friday" />
                                        <telerik:RadComboBoxItem Text="Saturday" Value="Saturday" meta:resourcekey="ItemValue_Saturday" />
                                        <telerik:RadComboBoxItem Text="Sunday" Value="Sunday" meta:resourcekey="ItemValue_Sunday" />
                                    </Items>

                                </telerik:RadComboBox>
                                <telerik:RadDatePicker ID="dtpFixedDate" runat="server" MinDate="1900-01-01" MaxDate="2100-01-01"
                                    Width="120px" Skin="Default" EnableTyping="True" Visible="false">
                                    <DateInput ID="DateInput1" Skin="Default" runat="server"></DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ID="rfvDate" CssClass="Validator" ErrorMessage="Required."
                                    ValidationGroup="Save" ControlToValidate="dtpFixedDate" Display="Dynamic"
                                    meta:resourcekey="rfvDate">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                         <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth" style="width: 240px !important">
                                <asp:LinkButton ID="btnUpdateFromRateMatrix" runat="server" Visible="true" Width="100%" Style="box-sizing: border-box !important; height: 35px; line-height: 35px; text-align: center; padding: 0;"
                                    CssClass="lnkButton btnUpdateFromRateMatrix" ValidationGroup="Save">
                                    <label class="Icon" runat="server"></label>
                                             <asp:Label runat="server" Text="Update from Rate Matrix11"  meta:resourcekey="btnUpdateFromRateMatrix"></asp:Label>
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 10px;">
                                <telerik:RadGrid ID="rdgRates" runat="server" setwidth="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
                                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250" ShowFooter="false"
                                    AllowPaging="false" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" TableLayout="Fixed" EditMode="InPlace">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency">
                                                <ItemTemplate>
                                                    <%# Eval("Currency")%>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%# Eval("Currency")%>&nbsp;
                                                </EditItemTemplate>
                                                <HeaderStyle Width="190px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Conversion" UniqueName="Conversion">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtConversion" runat="server" MaxLength="15" CssClass="PositiveDouble" precision="5" Text='<%# FormatNumber(Eval("Conversion"), 5)%>' Width="100%"></asp:TextBox>
                                                    <div>
                                                        <asp:Label ID="lblRateError" runat="server" Visible="false" Text="Value must be greater than 0." CssClass="Validator" meta:resourcekey="lblRateError"></asp:Label>
                                                        <%--<asp:CustomValidator runat="server" ID="csvConversion" ErrorMessage='<%# Me.GetLocalResourceObject("csvConversion.ErrorMessage")%>'
                                                                ControlToValidate="txtConversion" CssClass="Validator" ClientValidationFunction="CheckPositiveValue" Display="Dynamic" ValidationGroup="Save">
                                                            </asp:CustomValidator>--%>
                                                    </div>
                                                </ItemTemplate>
                                                <HeaderStyle Width="190px" />
                                            </telerik:GridTemplateColumn>

                                        </Columns>

                                        <CommandItemTemplate>
                                        </CommandItemTemplate>

                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="false" AllowRowsDragDrop="false">
                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
