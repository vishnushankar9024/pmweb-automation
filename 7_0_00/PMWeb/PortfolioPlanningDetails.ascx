<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PortfolioPlanningDetails.ascx.vb" Inherits="Website.PortfolioPlanningDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<style>
    table#ctl00_CPH1_PortfolioPlanningDetails1_rdgFundinghistory_ctl00{
        background-color: #ededed;
    }
    span.rtbText{
        margin-bottom: 1px;
    }
</style>

            <textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPortfolioPlanningDetails" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" CssClass="WithoutTopBorder" SetWidth="true" AppendMenus="true" UseEditFormInMobile="true"
                Font-Size="8px" PageSize="10" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" HasPasteFromExcel="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="False">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" SortExpression="LineNumber"
                            GroupByExpression="LineNumber [GridColumn_Line] Group By LineNumber ASC" Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="40px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Fund" HeaderStyle-Width="45px" ItemStyle-Wrap="false" SortExpression="Fund" Groupable="false" UniqueName="Fund">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Fund")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkFund" Checked='<%# CBool(IIf(Eval("Fund") Is System.DBNull.Value, 0, Eval("Fund")))%>' runat="server" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                                                        <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Initiative" HeaderStyle-Width="150px" HeaderStyle-Wrap="false"
                            UniqueName="Initiative" SortExpression="Initiative" GroupByExpression="Initiative [GridColumn_Initiative] Group By Initiative">
                            <ItemTemplate>
                                <span><%#Container.DataItem("Initiative")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtInitiative" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("Initiative")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="170px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Initiative ID" SortExpression="InitiativeID" UniqueName="InitiativeID" GroupByExpression="InitiativeID [GridColumn_InitiativeID] Group By InitiativeID">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliInitiativeID" runat="server" CssClass="NoWrap"
                                    Text='<%#IIf(Container.DataItem("InitiativeID") = String.Empty, "&nbsp;", Container.DataItem("InitiativeID"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("InitiativeUrl"))%>'></asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtInitiativeID" runat="server" Text='<%# Eval("InitiativeID") %>' Width="100%" Enabled="false" MaxLength="50"> </asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Budget Year" SortExpression="BudgetYear" UniqueName="BudgetYear" GroupByExpression="BudgetYear [GridColumn_BudgetYear] Group By BudgetYear">
                            <ItemTemplate>
                                <span><%#Container.DataItem("BudgetYear") %></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadNumericTextBox ID="rntBudgetYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                    Label="" runat="server" Width="70px" MaxValue="2100" MinValue="1899">
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvBudgetYear" runat="server" ControlToValidate="rntBudgetYear" CssClass="Validator" InitialValue=""
                                        ErrorMessage="Enter a funding year." Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Funding Source" UniqueName="FundingSource"
                            SortExpression="FundingSource" GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FundingSource") = String.Empty, "&nbsp;", Container.DataItem("FundingSource"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlFundingSource" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true" Height="300px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" NoWrap="True" OnItemsRequested="ddl_ItemsRequested"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project Manager" UniqueName="ProjectManager"
                            SortExpression="ProjectManager" GroupByExpression="ProjectManager [GridColumn_ProjectManager] Group By ProjectManager">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectManager") = String.Empty, "&nbsp;", Container.DataItem("ProjectManager"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectManager" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("ProjectManager")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" DropDownWidth="250px" Height="300px" runat="server" Skin="Default" Style="font-size: 11px" >
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="InitiativeType" GroupByExpression="InitiativeType [GridColumn_InitiativeType] Group By InitiativeType" SortExpression="InitiativeType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("InitiativeType") = String.Empty, "&nbsp;", Container.DataItem("InitiativeType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total" ItemStyle-HorizontalAlign="Right" GroupByExpression="Total [GridColumn_Total] Group By Total"
                            SortExpression="Total">
                            <ItemTemplate>
                                <span><%# FormatCurrency(Container.DataItem("Total"),CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotal" runat="server" Width="100%" CssClass="Currency" MaxLength="15" Text='<%#FormatCurrency(Eval("Total"),CurrencyId:=IIF(Eval("CurrencyId") is system.DBNULL.value,0, Eval("CurrencyId") )) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Start" SortExpression="Start" DataField="Start" UniqueName="Start" GroupByExpression="Start [GridColumn_Start] Group By Start">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("Start"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStart" Text='<%#FormatDate(Eval("Start"))%>' onclick="showDatePopup(this, event);"
                                    onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);" runat="server" Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Finish" SortExpression="Finish" DataField="Finish" UniqueName="Finish" GroupByExpression="Finish [GridColumn_Finish] Group By Finish">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("Finish"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFinish" Text='<%#FormatDate(Eval("Finish"))%>' onclick="showDatePopup(this, event);"
                                    onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);" runat="server" Width="100%">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" GroupByExpression="Priority [GridColumn_Priority] Group By Priority" UniqueName="Priority">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Priority") = String.Empty, "&nbsp;", Container.DataItem("Priority"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPriority" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Score" UniqueName="Score" ItemStyle-HorizontalAlign="Right" GroupByExpression="Score [GridColumn_Score] Group By Score" SortExpression="Score">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Score") = "0", "&nbsp;", FormatNumber(Container.DataItem("Score")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScore" runat="server" Width="100%" CssClass="Double" MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Score") is system.DBNULL.value, "0", Eval("Score"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="66px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Rating" UniqueName="Rating" ItemStyle-HorizontalAlign="Right" GroupByExpression="Rating [GridColumn_Rating] Group By Rating" SortExpression="Rating">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Rating"),1)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRating" runat="server" Width="100%" CssClass="Double" Precision="1" MaxLength="15" MaxNumber="5" MinNumber="0"
                                    Text='<%#FormatNumber(IIF(Eval("Rating") is system.DBNULL.value, "0", Eval("Rating")),1) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="66px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Sponsor" UniqueName="Sponsor" SortExpression="Sponsor" GroupByExpression="Sponsor [GridColumn_Sponsor] Group By Sponsor">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Sponsor") = String.Empty, "&nbsp;", Container.DataItem("Sponsor"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSponsor" MaxLength="255" Width="100%" runat="server" Text='<%#Eval("Sponsor")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UserDef1" GroupByExpression="UserDef1 [GridColumn_UserDef1] Group By UserDef1" SortExpression="UserDef1" UniqueName="UserDef1">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UserDef1") = String.Empty, "&nbsp;", Container.DataItem("UserDef1"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUserDef1" runat="server" Text='<%# Eval("UserDef1") %>' Width="100%" MaxLength="255"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UserDef2" SortExpression="UserDef2" UniqueName="UserDef2" GroupByExpression="UserDef2 [GridColumn_UserDef2] Group By UserDef2">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UserDef2") = String.Empty, "&nbsp;", Container.DataItem("UserDef2"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUserDef2" runat="server" Text='<%# Eval("UserDef2") %>' Width="100%" MaxLength="255"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Converted" Visible="false" UniqueName="TotalConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalConverted" DataField="TotalConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <table style="display: inline; padding: 0px; border: 0px transparent none; height: 15px" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="max-width: 150px;">
                                    <%-- <div style="padding: 2px">--%>
                                    <%--</div>--%>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited NoWrap"
                                                    meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Save"
                                                    securitybuttontype="AddEditMode_Edit" Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count > 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                                <td>

                                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                        meta:resourcekey="btnSaveResource1" ValidationGroup="Save"
                                        securitybuttontype="AddEditMode_Add" Visible='<%# rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll NoWrap"
                                        meta:resourcekey="btnCancelResource1"
                                        securitybuttontype="AddEditMode" Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count > 0 Or rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                        securitybuttontype="ItemMode_Edit" meta:resourcekey="btnEditSelectedResource1"
                                        Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>

                                </td>

                                <td>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        meta:resourcekey="btnAddResource1" securitybuttontype="ItemMode_Add"
                                        Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>

                                </td>
                                <td>

                                    <telerik:RadToolBar ID="rtbInitiative" runat="server" AutoPostBack="true"
                                        OnClientButtonClicked="OpenAddInitiativeTemplatePopup">
                                        <Items>
                                            <telerik:RadToolBarSplitButton meta:resourcekey="ContextMenu_AddInititiative" CssClass="GridCmdInitNewRow"
                                                EnableDefaultButton="false" CommandName="AddInitiative" PostBack="false" EnableImageSprite="True">
                                                <Buttons>
                                                    <telerik:RadToolBarButton PostBack="false" Width="150px" meta:resourcekey="ContextMenu_AddNewInitiative" CssClass="ToolbarButtonNewInitiative"
                                                        CommandName="NewInitiative" EnableImageSprite="True">
                                                    </telerik:RadToolBarButton>
                                                    <telerik:RadToolBarButton PostBack="false" Width="150px" CssClass="ToolbarButtonNewInitiativeFromTemplate" meta:resourcekey="ContextMenu_CopyInitiative"
                                                        CommandName="NewInitiativeFromTemplate" EnableImageSprite="True">
                                                    </telerik:RadToolBarButton>
                                                </Buttons>
                                            </telerik:RadToolBarSplitButton>
                                        </Items>
                                    </telerik:RadToolBar>


                                </td>
                                <td>

                                    <asp:LinkButton ID="btnLinkInitiative" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdLinkInitiative"
                                        Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted) %>'
                                        OnClientClick="return OpenPOPUp('PlanWorksheetInitiativesPopup.aspx', 800, 500, true);; ">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblLinkInitiative" runat="server" Text="Link Initiatives" meta:resourcekey="lblLinkInitiative"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        securitybuttontype="ItemMode_Delete" runat="server"
                                        CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1" Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        meta:resourcekey="btnRefreshResource1"
                                        securitybuttontype="ItemMode" Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnExportExcel" runat="server"
                                        SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                        Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted)%>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                        &nbsp;&nbsp
                                    </asp:LinkButton>
                                </td>
                                <td>

                                    <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                        SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                        OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                        SecurityButtonType="ItemMode"
                                        Visible='<%# rdgPortfolioPlanningDetails.EditIndexes.Count = 0 And (Not rdgPortfolioPlanningDetails.MasterTableView.IsItemInserted)%>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label11" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td align="right" id="tdfilter" runat="server" style="display: inline-block;">
                                    <table style="display: inline; padding: 0px; border: 0px transparent none; height: 15px;" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="padding-bottom: 1px; padding-right: 2px;"><b>
                                                <asp:Label ID="lblFrom" meta:resourcekey="lblFrom" runat="server" Text="From"></asp:Label></b></td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="rntFromYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                                    Label="" runat="server" Width="70px" ButtonsPosition="Right" MaxValue="2100" MinValue="1899">
                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                            <td style="padding-bottom:1px; padding-right: 2px;"><b>
                                                <asp:Label ID="lblTo" meta:resourcekey="lblTo" Style="margin-left: 10px;" runat="server" Text="To"></asp:Label></b></td>
                                            <td>
                                                <telerik:RadNumericTextBox ID="rntToYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                                    Label="" runat="server" Width="70px" MaxValue="2100" MinValue="1899">
                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                            <td style="padding-top:1px;">
                                                <asp:LinkButton ID="Linkbutton1" runat="server" CausesValidation="false" CommandName="FilterGrid" CssClass="GridCmdFilterGrid" securitybuttontype="ItemMode">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label1" runat="server" Text="Filter" meta:resourcekey="lblFilter"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:CheckBox runat="server" CssClass="chkAlignMiddle" ID="ckbCurrencyAmount" meta:resourcekey="ckbCurrencyAmount" Text="Only Lines with Currency Amount" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <Selecting AllowRowSelect="true " />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <fieldset>
                <legend>
                    <asp:Label ID="lblFundinghistory" runat="server" Text="Funding History" meta:resourcekey="lblFundinghistory"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgFundinghistory" runat="server" CssClass="WithoutTopBorder"
                    AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" AppendMenus="true"
                    Font-Size="8px" ShowFooter="False" AllowPaging="false" ShowGroupPanel="False"
                    AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="False" GridLines="None">
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                        EditMode="InPlace" EnableHeaderContextMenu="false">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="No Year" UniqueName="NoYear">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("NoYear") Is System.DBNull.Value, "&nbsp;", FormatCurrency(Container.DataItem("NoYear"),CurrencyId:=PM.PortfolioPlanning.PlanningWorksheetInfo.CurrencyId ))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="190px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />

                            </telerik:GridTemplateColumn>

                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <table width="1000px" style="display: inline; padding: 0px; border: 0px transparent none; height: 15px;"
                                    cellpadding="0" cellspacing="0">
                                    <tr>


                                        <td>
                                            <table style="display: inline; padding: 0px; border: 0px transparent none; height: 15px;"
                                                cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <b>
                                                            <asp:Label ID="lblFrom" meta:resourcekey="lblFrom" runat="server" Text="From"></asp:Label></b>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox ID="rntFromYear" ShowSpinButtons="true"
                                                            IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                                            Label="" runat="server" Width="70px"
                                                            MaxValue="2100" MinValue="1899">
                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                        </telerik:RadNumericTextBox>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <b>
                                                            <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label></b>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox ID="rntToYear" ShowSpinButtons="true"
                                                            IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                                            Label="" runat="server" Width="70px"
                                                            MaxValue="2100" MinValue="1899">
                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                        </telerik:RadNumericTextBox>
                                                        &nbsp;&nbsp;
                                                    </td>

                                                    <td>

                                                        <asp:LinkButton ID="btnFilter" runat="server" CausesValidation="False" CommandName="FilterGrid" CssClass="GridCmdFilterGrid"
                                                            securitybuttontype="ItemMode">
                                                            &nbsp;&nbsp;
                                               <span class="Icon"></span>
                                                            <asp:Label ID="lblFilter" runat="server" Text="Filter" meta:resourcekey="lblFilter">
                                                            </asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                    </ClientSettings>
                </telerik:RadGrid>

            </fieldset>
             <input type="button" id="btnClipborad" class="Hide" runat="server" />
            <input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>



