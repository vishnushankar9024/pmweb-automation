<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderDetails.ascx.vb"
    Inherits="Website.WorkOrderDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxLoadingPanel ID="ldpWorkOrderDetail" runat="server" EnableSkinTransparency="true"
    BackgroundPosition="Center" Skin="Default" />


<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%" EnableAJAX="false">
                                        <table style="width: 100%;" cellspacing="0" border="0">
                                            <tr>
                                                <td class="labelWidth">
                                                    <div style="float: left;">
                                                        <asp:Label runat="server" meta:resourcekey="lblContactName" ID="lblContactName" Text="Contact Name"></asp:Label>
                                                    </div>
                                                    <div style="float: right;">
                                                        <asp:LinkButton runat="server" ID="btnContact" CssClass="SearchButton" OnClientClick="return OpenContactPOPUp('ContactBrowser.aspx',500, 550,true);">
                                                            <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtContactName" MaxLength="255" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" meta:resourcekey="lblContactPhone" ID="lblContactPhone"
                                                        Text="Contact Phone"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtPhone" Style="width: 97%" MaxLength="50" runat="server">
                                                                </asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblExt" meta:resourcekey="lblExt" Text="Ext."></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtExt" Style="width: 97%" MaxLength="50" runat="server" TabIndex="3"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" meta:resourcekey="lblCell" ID="lblCell" Text="Cell"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox Style="width: 99%" ID="txtCell" MaxLength="50" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" meta:resourcekey="lblPhoneNight" ID="lblPhoneNight" Text="Phone (Night)"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtPhoneNight" Style="width: 97%" MaxLength="50" runat="server">
                                                                </asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblExtNight" meta:resourcekey="lblExt" Text=""></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtExtNight" Style="width: 97%" MaxLength="50" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" meta:resourcekey="lblEmail" ID="lblEmail" Text="Email"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtEmail" MaxLength="255" runat="server" Width="99%"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                                        CssClass="Validator" ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ValidationGroup="Save" Display="Dynamic" meta:resourcekey="revEmail">
                                                    </asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblPriority" meta:resourcekey="lblPriority" runat="server" Text="Priority"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlPriority" runat="server" Width="100%" Skin="Default"
                                                        Style="font-size: 11px" NoWrap="true" TabIndex="5" Height="150px" AllowCustomText="True">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblReported" meta:resourcekey="lblReported" runat="server" Text="Reported"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <span runat="server" id="rmd_calReportedDate" style="display: block">
                                                        <telerik:RadDatePicker ID="calReportedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            SelectedDate='<%#Date.Today %>' Width="100%" Skin="Default" TabIndex="6">
                                                            <DateInput ID="DateInput1" ReadOnly="true" LabelCssClass="radLabelCss_Office2007"
                                                                Skin="Default" runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar1" Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label meta:resourcekey="lblEstimatedStart" ID="lblEstimatedStart" runat="server"
                                                        Text="Estimated Start"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <span runat="server" id="rmd_calEstimatedStartDate" style="display: block">
                                                                    <telerik:RadDatePicker ID="calEstimatedStartDate" runat="server" MinDate="1901-01-01"
                                                                        MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>' Width="100%" Skin="Default"
                                                                        TabIndex="7">
                                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                            runat="server" Height="20px">
                                                                        </DateInput>
                                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                        </Calendar>
                                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                                                                    </telerik:RadDatePicker>
                                                                </span>
                                                            </td>
                                                            <td style="width: 35px">
                                                                <asp:Label ID="lblEstimatedFinish" meta:resourcekey="lblFinish" runat="server" Text="Estimated Finish"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <span runat="server" id="rmd_calEstimatedFinishDate" style="display: block">
                                                                    <telerik:RadDatePicker ID="calEstimatedFinishDate" runat="server" MinDate="1901-01-01"
                                                                        MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>' Width="100%" Skin="Default"
                                                                        TabIndex="8">
                                                                        <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                            runat="server">
                                                                        </DateInput>
                                                                        <Calendar ID="Calendar3" Skin="Default" runat="server">
                                                                        </Calendar>
                                                                    </telerik:RadDatePicker>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label meta:resourcekey="lblApproximateDuration" ID="lblApproximateDuration"
                                                        runat="server" Text="Approximate Duration"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadMaskedTextBox ID="txtApproximateDuration" Width="99%" CssClass="PositiveInteger"
                                                        runat="server" DisplayMask="##### Hours" Mask="##### Hours" TabIndex="9" NumericRangeAlign="Left">
                                                    </telerik:RadMaskedTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <%-- Default Budget Code--%>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox Visible="false" ID="ddlDefaultBudgetCode" runat="server" Width="100%"
                                                        Skin="Default" Style="font-size: 11px" NoWrap="true" TabIndex="10">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadAjaxPanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset runat="server" id="fldsetTags">
                                        <legend>
                                            <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                                        </legend>
                                        <table style="width: 100%" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick=" return OpenGooglepWorkOrderAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address"></asp:LinkButton>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="99%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <div style="float: left;">
                                                        <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                                    </div>
                                                    <div style="float: right">
                                                        <asp:LinkButton runat="server" ID="imgPMbarcode" CssClass="SearchButton" OnClientClick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','WORKORDER','<%= PM.Asset.WorkOrderInfo.Id %>')">
                                                            <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                                <td class="controlWidth">
                                                    <div class="NoWrap">
                                                        <asp:TextBox ID="txtBarcode" runat="Server" Width="99%" Style="vertical-align: middle;" MaxLength="255"></asp:TextBox>
                                                        <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                                        <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                                    </div>

                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="col-8">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <fieldset runat="server" id="fldLinkedAssets">
                                        <legend>
                                            <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAssets" runat="server" Text="Linked Assets"></asp:Label>
                                        </legend>
                                        <telerik:RadGrid NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                            ID="rdgAssets" runat="server"
                                            HeaderStyle-Font-Size="8" Width="100%"
                                            AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11"
                                            AllowMultiRowSelection="true" AllowPaging="true" PageSize="10">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                            <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="150px" SortExpression="Suite">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-Width="150px" SortExpression="Property">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Building" HeaderStyle-Width="150px" SortExpression="Building">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="150px" UniqueName="Floor" SortExpression="Floor">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Space" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="150px" UniqueName="Space" SortExpression="Space">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Equipment" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-Width="150px" SortExpression="Equipment">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">
                                                        &nbsp;&nbsp;
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkAsset" CssClass="GridCmdlinkAsset"
                                            OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=1&IsInstalled=0&IsServiced=0',1035, 710,true,'rdgAssets');">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                            runat="server" SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblDeleteAssets" Text="Delete Assets"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                            <ClientSettings Resizing-AllowColumnResize="true"></ClientSettings>
                                        </telerik:RadGrid>
                                    </fieldset>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>



