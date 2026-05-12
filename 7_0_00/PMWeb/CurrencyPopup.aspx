<%@ Page Language="vb" meta:resourcekey="Page" Title="Currency" AutoEventWireup="false" CodeBehind="CurrencyPopup.aspx.vb" Inherits="Website.CurrencyPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

            function dtpDateChanged(sender, args) {
                var rdbLinkedToRateMatrix = document.getElementById("rdbLinkedToRateMatrix");
                if (rdbLinkedToRateMatrix.checked == true) {
                    var btn = document.getElementById("btnPreviewRates");
                    btn.click();
                }
                return false;
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
                <telerik:AjaxSetting AjaxControlID="btnPreviewRates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgRates" LoadingPanelID="ldpPM1" />
                        <telerik:AjaxUpdatedControl ControlID="btnPreviewRates" />
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
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save" Height="50px"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save"
                                CommandName="SaveExit" Value="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                PostBack="false">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <asp:RadioButton ID="rdbDefaultRates" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                        meta:resourcekey="rdbDefaultRates" Text="Default Rates11" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                     <br /><br />

                    <asp:RadioButton ID="rdbLinkedToRateMatrix" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                        meta:resourcekey="rdbLinkedToRateMatrix" Text="Linked to Rate Matrix11" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                    <br /><br />

                    <asp:RadioButton ID="rdbSavedInRecord" runat="server" GroupName="Options" AutoPostBack="true" CausesValidation="true" CssClass="RadioCss"
                        meta:resourcekey="rdbSavedInRecord" Text="Save Rates in this Record11" ValidationGroup="Save" OnClick="DisableCurrentToolbar();" />
                     <br /><br />
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRateDate" runat="server" Text="Date11" meta:resourcekey="lblRateDate"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important">
                                <telerik:RadDatePicker ID="dtpDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Skin="Default" EnableTyping="True" AutoPostBack="False">
                                    <DateInput ID="DateInput1" Skin="Default" runat="server"></DateInput>
                                    <ClientEvents OnDateSelected="dtpDateChanged" />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ID="rfvDate" CssClass="Validator" ErrorMessage="Required."
                                    ValidationGroup="Save" ControlToValidate="dtpDate" Display="Dynamic" meta:resourcekey="rfvDate">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth" style="width: 240px !important">

                                <asp:LinkButton ID="btnUpdateFromRateMatrix" runat="server" Visible="true" Width="100%" Style="box-sizing: border-box !important; height: 35px; line-height: 35px; text-align: center; padding: 0"
                                    CssClass="lnkButton btnUpdateFromRateMatrix" ValidationGroup="Save">
                                             <label class="Icon" runat="server"></label>
                                             <asp:Label runat="server" Text="Update from Rate Matrix11"  meta:resourcekey="btnUpdateFromRateMatrix"></asp:Label>
                                </asp:LinkButton>

                            </td>
                        </tr>

                    </table>
                    <telerik:RadGrid ID="rdgRates" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" ShowFooter="false" FitPageHeightOffset="24"
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
                </div>
            </div>
        </div>
        <asp:Button runat="server" ID="btnPreviewRates" CssClass="Hide" />
    </form>
</body>
</html>
