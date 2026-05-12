<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementOnlineChangeRequestDetails.ascx.vb" Inherits="Website.CostManagementOnlineChangeRequestDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgOnlineChangeRequestDetails" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext"  appendmenus="true"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8"
                PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" CssClass="WithoutTopBorder" HasPasteFromExcel="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="<%$Resources:PMWeb, Grid_GroupPanel %>"></GroupPanel>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    NoDetailRecordsText="" DataKeyNames="Id" 
                    CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" Name="Budget"
                    UseAllDataFields="true" EditMode="InPlace" EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="true" GroupLoadMode="Client">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" Reorderable="true" UniqueName="LineNumber" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdnRevisedBy" runat="server" />
                            </EditItemTemplate>

                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" />
                              <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Item " DataField="ItemCode" SortExpression="ItemCode" UniqueName="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" runat="server" Text='<%#Eval("ItemCode")%>' Width="100%" ReadOnly="true"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" DataField="Description" SortExpression="Description" UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" MaxLength="500" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="220px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <span><%#Eval("Currency")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                    Skin="Default" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" DataField="UOM" SortExpression="UOM" UniqueName="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox runat="server" ID="ddlUOMs" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <div id='<%# "Detail_" & IIf(Eval("CommitmentDetailId") > 0, "C_" & Eval("CommitmentDetailId").ToString(), "CO_" & Eval("CommitmentCODetailId").ToString())%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                    <span style="float: right">
                                        <%# IIf(CDbl(ParseDouble(Container.DataItem("Quantity"), 1)) = CInt(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1), 5).TrimEnd("0"))%>

                                    </span>&nbsp;
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" MaxLength="15" runat="server" Precision="5"
                                    Text='<%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost" DataField="UnitCost">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" runat="server" Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' Width="100%" MaxLength="15" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Ext. Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right" SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC" DataField="ExtCost">
                            <ItemTemplate>
                                <div id='<%# "DetailVR_" & IIf(Eval("CommitmentDetailId") > 0, "C_" & Eval("CommitmentDetailId").ToString(), "CO_" & Eval("CommitmentCODetailId").ToString())%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                    <span style="float: right">
                                        <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblExtCost" /></span>&nbsp;
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Commitment Line" SortExpression="CommitmentDetail"
                            UniqueName="CommitmentLine" DataField="CommitmentDetail" GroupByExpression="CommitmentDetail [GridColumn_CommitmentDetail] Group By CommitmentDetail ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("CommitmentDetail") = String.Empty, "&nbsp;", Container.DataItem("CommitmentDetail"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCommitmentLine" Width="100%" runat="server" Skin="Default"
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlCommitmentLine_OnSelectedIndexChanged" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Code" DataField="CostCode" SortExpression="CostCode" UniqueName="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCodeWithDescription")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCodeWithDescription") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    ValidationGroup="Save" Style="font-size: 11px" Height="250px" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                        Display="Dynamic" Enabled="false" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" DataField="CostType" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC" UniqueName="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Days" UniqueName="Days" ItemStyle-HorizontalAlign="Right" DataField="Days" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Days [GridColumn_Days] Group By Days ASC" SortExpression="Days">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Days"), IIf(ParseDouble(Eval("Days")) Mod 1 = 0, 0, 2))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDays" runat="server" Width="100%" CssClass="Days" MaxLength="15" Text='<%#FormatNumber(ParseDouble(Eval("Days")), IIf(ParseDouble(Eval("Days")) Mod 1 = 0, 0, 2)) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase" DataField="Phase" HeaderStyle-Width="150px" SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" Height="200px" CloseDropDownOnBlur="true" 
                                    Width="100%" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" DataField="WBS" UniqueName="WBS" GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        Style="font-size: 11px" Height="250px" OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                <span class="Icon"></span>
                                    </asp:LinkButton>

                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Period" DataField="Period" SortExpression="Period" UniqueName="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
                                    Skin="Default" Width="150px" Height="300px" AllowCustomText="true" NoWrap="true" CausesValidation="false"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Assigned To" SortExpression="AssignedTo" UniqueName="AssignedTo" GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" DataField="AssignedTo" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AssignedToId") = "-1" Or Container.DataItem("AssignedTo") = "0", "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="85%" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" 
                                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
                                <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manufacturer" SortExpression="Mfr" UniqueName="Manufacturer" GroupByExpression="Mfr [GridColumn_Manufacturer] Group By Mfr ASC" DataField="Mfr" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("MfrId") = "-1" Or Container.DataItem("MfrId") = "0", "&nbsp;", Container.DataItem("Mfr"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="85%" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" 
                                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                                        OnClientDropDownClosed="dllcompClientClosed1" OnItemsRequested="ddl_ItemsRequested"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton"
                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlManufacturer'),'Companies')">
                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="130px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Mfr. #" SortExpression="MfrNumber" UniqueName="MfrNumber" GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber" DataField="MfrNumber">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("MfrNumber") = String.Empty, "&nbsp;", Container.DataItem("MfrNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" Width="100%" MaxLength="255" runat="server" Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="CE ID" SortExpression="ChangeEvent" UniqueName="CEID" DataField="ChangeEvent" GroupByExpression="ChangeEvent [GridColumn_ChangeEvent] Group By ChangeEvent">
                            <ItemTemplate>
                                <span><a runat="server" id="hypCENumber" href='<%#Eval("ChangeEventPostBackURL")%>'><%# Eval("ChangeEvent")%> </a>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(Eval("ChangeEvent").ToString = String.Empty, "&nbsp;", Eval("ChangeEvent"))%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="CCO ID" SortExpression="CommitmentCO" UniqueName="CCOID" DataField="CommitmentCO" GroupByExpression="CommitmentCO [GridColumn_CommitmentCO] Group By CommitmentCO">
                            <ItemTemplate>
                                <span><a runat="server" id="hypCONumber" href='<%#Eval("CommitmentCOPostBackURL")%>'><%# Eval("CommitmentCO")%> </a>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(Eval("CommitmentCO").ToString = String.Empty, "&nbsp;", Eval("CommitmentCO"))%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" UniqueName="Field1" Groupable="false" DataField="Field1" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" AllowFiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field7" DataField="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />

                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="false" UniqueName="UnitCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitCostConverted" DataField="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible="false" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCostConverted" DataField="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <ItemStyle Wrap="false" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            
     
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditSelectedLines" CssClass="GridCmdEditSelectedLines" Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelected" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                             <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False"
                                SecurityButtonType="ItemMode_Add" CommandName="AddItems" CssClass="GridCmdAddItems"
                                Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=OnlineChangeRequest', 910, 580, true, 'rdgOnlineChangeRequestDetails');">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="OCRDSave"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="OCRDSave"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateEdited" runat="server" Text="s"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count > 0 Or rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
          
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <span style="width: 100%; text-align: right">
                            <asp:CheckBox ID="chbUseUnits" runat="server" AutoPostBack="true" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" OnCheckedChanged="chbUseUnits_OnChekedChanged" meta:resourcekey="chbUseUnits" SecurityButtonType="ItemMode_Edit" />

                            </span>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Export To Exel" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgOnlineChangeRequestDetails.EditIndexes.Count = 0 And (Not rdgOnlineChangeRequestDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
                <ValidationSettings ValidationGroup="OCRDSave" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />

            </telerik:RadGrid>
            <input type="button" id="btnClipborad" class="Hide" runat="server" />
            <input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>
