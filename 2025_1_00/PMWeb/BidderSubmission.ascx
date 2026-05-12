<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BidderSubmission.ascx.vb" Inherits="Website.BidderSubmission" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAK">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAK" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="txtRemainingAcknowledgements" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



<div class="PMMainPage">
    <div class="row row-8-4">
        <div class="col-4">
            <fieldset>
                <legend>
                    <asp:Label runat="server" ID="lblBidInfo" Text="Bidder Information" meta:resourcekey="lblBidInfo" />
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblCompany" meta:resourcekey="lblCompany" Text="Company" />
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCompany" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblContact" meta:resourcekey="lblContact" Text="Contact*" />
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtContact" runat="server"></asp:TextBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblBidExpires" meta:resourcekey="lblBidExpires" Text="Bid Expires*" />
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="rdpBidExpires" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                Width="100%" Skin="Default" Culture="English (United States)" EnableTyping="true">
                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                    runat="server">
                                </DateInput>
                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>

                            </telerik:RadDatePicker>

                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblCOFee" meta:resourcekey="lblCOFee" Text="Change Order Fee" />
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCOFee" CssClass="Percent" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblAvailableToStart" meta:resourcekey="lblAvailableToStart" Text="Available To Start" />
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="rdpAvailableToStart" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                Width="100%" Skin="Default" Culture="English (United States)" EnableTyping="true">
                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                    runat="server">
                                </DateInput>
                                <Calendar ID="Calendar1" Skin="Default" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>

                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblPhone" Text="Phone*" meta:resourcekey="lblPhone"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtPhone"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblExt" Text="Ext." meta:resourcekey="lblExt"></asp:Label></td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtExt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblEmail" Text="Email" meta:resourcekey="lblEmail"></asp:Label></td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtEmail"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Top labelWidth">
                            <asp:Label runat="server" ID="lblComments" meta:resourcekey="lblComments" Text="Comments" />
                        </td>
                        <td class="controlWidth">
                            <telerik:RadTextBox ID="txtComments" runat="server" BackColor="White"
                                CausesValidation="True" Height="82px" LabelCssClass="" Skin="Default"
                                TextMode="MultiLine" Width="100%" MaxLength="1000">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-8">
            <div runat="server" id="tdAcknowledgments" width="100%">
                <fieldset>
                    <legend>
                        <asp:Label runat="server" ID="lblAcknowledment" Text="Acknowledgments" meta:resourcekey="lblAcknowledment" />
                    </legend>
                    <telerik:RadGrid ID="rdgAK" runat="server"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250" SetWidth="true"
                        AllowPaging="True" ShowGroupPanel="false" AllowMultiRowEdit="true" AllowMultiRowSelection="true"
                        AllowSorting="True" GridLines="None" AllowFilteringByColumn="false">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top"
                            UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                            EnableHeaderContextMenu="true" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" UniqueName="Acknowledge" HeaderText="Acknowledge" Groupable="False" HeaderStyle-Width="98px">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAcknowledge" meta:resourcekey="lblAcknowledge" Text="Acknowledge1" runat="server"></asp:Label>
                                        <asp:CheckBox runat="server" ID="chkSelectAll" TextAlign="Left" AutoPostBack="true" OnCheckedChanged="chkSelectAll_OnCheckedChanged" />
                                    </HeaderTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="DisplayType" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false" SortExpression="DisplayType" Groupable="false">
                                    <ItemTemplate>

                                        <span><%#Eval("DisplayType")%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="175px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false" SortExpression="Description" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("Description")%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="175px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Date Acknowledged" UniqueName="AcknowledgeDate" Groupable="false"
                                   ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false" SortExpression="AcknowledgeDate">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Eval("AcknowledgeDate"))%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="175px"></HeaderStyle>
                                    <%--       <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>--%>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Acknowledged By" UniqueName="AcknowledgeBy" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false" SortExpression="AcknowledgeBy" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("AcknowledgeBy")%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="175px"></HeaderStyle>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                </telerik:GridTemplateColumn>

                            </Columns>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
            </div>
        </div>
    </div>
</div>
