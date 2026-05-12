<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EstimateProcurementDetails.ascx.vb" Inherits="Website.EstimateProcurementDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgProcurementDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgProcurementDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgProcurementDetails" runat="server" CssClass="WithoutTopBorder" UseEditFormInMobile="true"
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true"
                PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" AllowMultiRowEdit="True"
                AllowMultiRowSelection="true" AllowSorting="false" ItemStyle-Height="20px">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by">
                </GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="True" ShowGroupFooter="true">
                    <Columns>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid" HeaderText="Include In Bid" Groupable="false" HeaderStyle-Width="120px">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" AutoPostBack="true" OnCheckedChanged="chkUserUnits_OnChekedChanged" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" UniqueName="LineNumber"
                            Reorderable="false" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber").ToString) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
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
                            <HeaderStyle Width="120px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectFullName" ItemStyle-Wrap="false" HeaderText="Project"
                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectName] Group By ProjectFullName ASC" DataField="ProjectFullName">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProjectFullName")) = String.Empty, "&nbsp;", Eval("ProjectFullName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                    OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                                    NoWrap="true" Skin="Default" Width="100%" DropDownWidth="250px" ShowMoreResultsBox="True" OnClientSelectedIndexChanged="ResetCombos"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Project Required."
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                            </EditItemTemplate>

                            <HeaderStyle Width="85px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" SortExpression="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC"
                            UniqueName="ItemCode" DataField="ItemCode">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" CssClass="Right" runat="server" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" Enabled='<%# Not rdgProcurementDetails.MasterTableView.IsItemInserted %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" DataField="Description"
                            UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Scope Of Work" SortExpression="ScopeOfWork" UniqueName="ScopeOfWork"
                            GroupByExpression="ScopeOfWork [GridColumn_ScopeOfWork] Group By ScopeOfWork ASC" DataField="ScopeOfWork">
                            <ItemTemplate>
                                <div>&nbsp;<%#Eval("ScopeOfWork").ToString%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScopeOfWork" runat="server" Text='<%#Eval("ScopeOfWork")%>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgScopeOfWork" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgScopeOfWork','txtScopeOfWork'))">
                        <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC" DataField="Currency">
                            <ItemTemplate>

                                <span><%#Eval("Currency")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" Height="300px" DropDownWidth="250px" runat="server" Skin="Default" Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="130px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" ItemStyle-Wrap="false"
                            GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" DataField="UOM">
                            <ItemTemplate>

                                <span><%#Eval("UOM").ToString%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                                <asp:Label runat="server" ID="lblUOM" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True" AllowCustomText="False" OnClientSelectedIndexChanged="ResetCombos" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ItemsLoadRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                            UniqueName="CostType" DataField="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName" DataField="PhaseName"
                            GroupByExpression="PhaseName [GridColumn_Phase] Group By PhaseName ASC"
                            UniqueName="Phase">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPhase" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True" AllowCustomText="False" OnClientSelectedIndexChanged="ResetCombos" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ItemsLoadRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px" OnClientSelectedIndexChanged="ResetCombos" OnClientItemsRequesting="GetValueToReturn">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Bid Section" SortExpression="BidSection" UniqueName="BidSection" ItemStyle-Wrap="false"
                            GroupByExpression="BidSection [GridColumn_BidSection] Group By BidSection ASC" DataField="BidSection">
                            <ItemTemplate>
                                <span><%# Eval("BidSection").ToString%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlBidSection" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Bid Section..." DropDownWidth="200px"
                                    Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" ItemStyle-Wrap="false"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField="Quantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" MaxLength="15" runat="server" Text='<%#FormatNumber(ParseDouble(Eval("Quantity")))%>'
                                    Width="100%" CssClass="Double" Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Est. Unit Cost" SortExpression="EstimatedUnitCost" ItemStyle-Wrap="false"
                            UniqueName="EstimatedUnitCost" GroupByExpression="EstimatedUnitCost [GridColumn_EstimatedUnitCost] Group By EstimatedUnitCost" DataField="EstimatedUnitCost">
                            <ItemTemplate>
                                <span>
                                    <asp:LinkButton runat="server" ID="lnkEstimatedUnitCost" Text='<%#FormatCurrency(Eval("EstimatedUnitCost"), CurrencyId:=Eval("CurrencyId"))%>' Visible="false"></asp:LinkButton>
                                    <asp:Label runat="server" ID="lblEstimatedUnitCost" Text='<%#FormatCurrency(Eval("EstimatedUnitCost"), CurrencyId:=Eval("CurrencyId"))%>' Visible="false"></asp:Label></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEstimatedUnitCost" MaxLength="15" runat="server" Text='<%#FormatCurrency(Eval("EstimatedUnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="130px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Estimated Total" SortExpression="EstimatedTotal" ItemStyle-Wrap="false"
                            UniqueName="EstimatedTotal" DataField="EstimatedTotal" GroupByExpression="EstimatedTotal [GridColumn_EstimatedTotal] Group By EstimatedTotal">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("EstimatedTotal"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEstimatedTotal" MaxLength="90" runat="server" Text='<%#FormatCurrency(Eval("EstimatedTotal"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotalEstTotal" Text=""></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="130px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Estimated Total Converted" Visible="false" SortExpression="EstimatedTotalConverted" ItemStyle-Wrap="false"
                            UniqueName="EstimatedTotalConverted" DataField="EstimatedTotalConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="EstimatedTotalConverted [GridColumn_EstimatedTotalConverted] Group By EstimatedTotalConverted">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("EstimatedTotalConverted"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <div>&nbsp;<%#Eval("Notes").ToString%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
            <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Est. Line #" DataField="EstimateLineNumber"
                            UniqueName="EstimtatedLineNumber" Groupable="false">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("EstimateLineNumber")) = "0", "&nbsp;", Eval("EstimateLineNumber").ToString)%></span>
                                <%--<span>&nbsp;
                        <%#Eval("EstimtateLineNumber").ToString %></span>--%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(CStr(Eval("EstimateLineNumber").ToString) = "0", "&nbsp;", Eval("EstimateLineNumber").ToString)%></span>
               
                            </EditItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" SortExpression="ManufacturerName"
                            GroupByExpression="ManufacturerName [GridColumn_Manufacturer] Group By ManufacturerName ASC" ItemStyle-Wrap="false" DataField="ManufacturerName">
                            <ItemTemplate>

                                <span><%# IIf(Eval("ManufacturerName").ToString = "", "&nbsp;", Eval("ManufacturerName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Mfr. Number" SortExpression="MfrNumber" UniqueName="MfrNumber" DataField="MfrNumber"
                            GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber" ItemStyle-Wrap="false">
                            <ItemTemplate>

                                <span><%# IIf(Eval("MfrNumber").ToString = "", "&nbsp;", Eval("MfrNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" Width="100%" MaxLength="255" 
                                    runat="server" Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle CssClass="left" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
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

                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="EstimatedUnitCost" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle HorizontalAlign="Left" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 AND (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddItems" CssClass="GridCmdAddItems"
                                Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Procurement', 910, 580, true,'rdgProcurementDetails');">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddEstimateItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddEstimateItems" CssClass="FormulaButton"
                                Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('EstimateProcurementsPopup.aspx?SourceId=Procurement', 880, 550, true,'rdgProcurementDetails');">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Add estimate items" meta:resourcekey="lblAddEstimateItems"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                CommandName="PerformInsert" Visible='<%# rdgProcurementDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return DeleteSelectedLines('rdgProcurementDetails');" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                CommandName="RebindGrid" Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgProcurementDetails.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgProcurementDetails.EditIndexes.Count > 0 Or rdgProcurementDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSaveState" runat="server" CssClass="Hide" SecurityButtonType="ItemMode" CausesValidation="False"
                                CommandName="SaveState" Visible='false'>
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" CssClass="Hide" SecurityButtonType="ItemMode"
                                CausesValidation="False" CommandName="LoadDefaultState" Visible='false'>
                                &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                            </asp:LinkButton>

                        <telerik:RadCombobox ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDisplay_OnSelectedIndexChanged">
                            <Items>
                             <telerik:RadComboBoxItem meta:Resourcekey="ListItemAll" Value="0" Text="-- All --" Selected="True"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemActiveBiddersOnly" Value="1" Text="Active Bidders Only"></telerik:RadComboBoxItem>
                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemInactiveBiddersOnly" Value="2" Text="Inactive Bidders Only"></telerik:RadComboBoxItem>
                            </Items>
                   
                        </telerik:RadCombobox>

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgProcurementDetails.EditIndexes.Count = 0 And (Not rdgProcurementDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="true" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False"
                        AllowColumnResize="True" />
                    <%-- <Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
                <ValidationSettings ValidationGroup="ProcurementDetails" EnableValidation="true"
                    CommandsToValidate="SaveChanges" />
            </telerik:RadGrid>
        </div>
    </div>
</div>

