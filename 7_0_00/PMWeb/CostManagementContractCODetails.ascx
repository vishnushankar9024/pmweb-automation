<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementContractCODetails.ascx.vb" Inherits="Website.CostManagementContractCODetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>
<telerik:RadAjaxLoadingPanel ID="ldpContractsCODetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPrimeContractCODetails" runat="server"   FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"  HasPasteFromExcel="true"
                PageSize="10" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" 
                AllowMultiRowEdit="true" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
  <%--  <HeaderContextMenu OnClientItemOpening="OnClientItemOpening"></HeaderContextMenu>--%>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true" ShowGroupFooter ="true"  GroupLoadMode ="Client">
                     <Columns>
                         <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" UniqueName="LineNumber" AllowFiltering="false"
                             Reorderable="true">
                             <ItemTemplate>
                                 <span>
                                     <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <span>
                                     <%#IIf(CStr(Eval("LineNumber").ToString) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                             </EditItemTemplate>
                             <HeaderStyle Width="50px"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                             UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                             GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                             <ItemTemplate>
                                 <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                 </asp:LinkButton>
                             </ItemTemplate>
                             <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                             <HeaderStyle Width="75px" />
                             <ItemStyle HorizontalAlign="Center"></ItemStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Item" SortExpression="ItemCode" UniqueName="ItemCode" DataField="ItemCode" DataType="System.Int64"
                             GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode" ItemStyle-HorizontalAlign="Right">
                             <ItemTemplate>
                                 <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode").ToString)%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtItemCode" MaxLength ="50" runat="server" Enabled="false" Text='<%#IIf(Eval("ItemCode") Is DBNull.Value, "", Eval("ItemCode").ToString)%>'
                                     Width="100%"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="60px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" DataField="Description"
                             UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description">
                             <ItemTemplate>
                                 <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtDescription" MaxLength ="500"  runat="server" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="200px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox Width="100%" ID="ddlCurrencies" Height="300px" runat="server" Skin="Default" Style="font-size: 11px">
                                 </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" DataField="UOM"
                             GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                             <ItemTemplate>
                                 <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                 </telerik:RadComboBox>
                                 <asp:Label runat="server" ID="lblUOM" Width="100%"></asp:Label>
                             </EditItemTemplate>
                             <HeaderStyle Width="100px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity"
                             GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField ="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                             <ItemTemplate>
                                  <div id='<%# "Detail_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"><%# FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;</div>
                             </ItemTemplate>
                             <EditItemTemplate>
                                    <asp:TextBox ID="txtQuantity" MaxLength ="15" runat="server" Text='<%#FormatNumber(ParseDouble(Eval("Quantity"), 1))%>'
                                     Width="100%" CssClass="Double"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="100px"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Unit Price" SortExpression="UnitPrice" UniqueName="UnitPrice" GroupByExpression="UnitPrice [GridColumn_UnitPrice] Group By UnitPrice" DataField ="UnitPrice">
                             <ItemTemplate>
                                 <%#FormatCurrency(Container.DataItem("UnitPrice"), CurrencyId:=Eval("CurrencyId"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtUnitPrice" MaxLength ="15" runat="server" Text='<%# FormatCurrency(Eval("UnitPrice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                     Width="100%" CssClass="Currency"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="100px"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                       

                         <telerik:GridTemplateColumn HeaderText="Owner Budget" SortExpression="OwnerBudget" UniqueName="OwnerBudget" GroupByExpression="OwnerBudget [GridColumn_OwnerBudget] Group By OwnerBudget" DataField ="OwnerBudget" >
                             <ItemTemplate>
                                 <%#FormatCurrency(Container.DataItem("OwnerBudget"), CurrencyId:=Eval("CurrencyId"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtOwnerBudget" MaxLength ="15" runat="server" Text='<%# FormatCurrency(Eval("OwnerBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                     Width="100%" CssClass="Currency"></asp:TextBox>
                             </EditItemTemplate>

                             <HeaderStyle Width="100px"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                       

                           <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField ="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment1"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:Label Text='<%# FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" CssClass ="Currency" />
                        </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                                      
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField ="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment2"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label Text='<%# FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" CssClass ="Currency" /></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                     

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField ="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Tax"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                    <asp:Label Text='<%# FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" CssClass ="Currency" /> </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                      
                        
                         <telerik:GridTemplateColumn Visible ="false" HeaderText="Markup %" ItemStyle-HorizontalAlign="Right" DataField="MarkupPct" 
                             SortExpression="MarkupPct" UniqueName="MarkupPct" GroupByExpression="MarkupPct [GridColumn_MarkupPct] Group By MarkupPct">
                             <ItemTemplate>
                                 <span>
                                     <%#FormatPercent(IIf(Container.DataItem("MarkupPct") Is DBNull.Value, 0, Container.DataItem("MarkupPct")))%></span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtMarkupPct" MaxLength ="15" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server"
                                     Text='<%# FormatPercent(Eval("MarkupPct")) %>' Width="100%"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="80px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn Visible ="false" HeaderText="Markup" ItemStyle-HorizontalAlign="Right" DataField="Markup"
                             SortExpression="Markup" UniqueName="Markup" GroupByExpression="Markup [GridColumn_Markup] Group By Markup">
                             <ItemTemplate>
                                 <span>
                                     <%#FormatCurrency(IIf(Container.DataItem("Markup") Is DBNull.Value, 0, Container.DataItem("Markup")), CurrencyId:=Eval("CurrencyId"))%></span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtMarkup" Width="100%" MaxLength="15" CssClass="Double" runat="server"
                                     Text='<%#FormatNumber(IIf(Eval("Markup") Is DBNull.Value, 0, Eval("Markup")))%>'></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="80px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Total Price" UniqueName="TotalPrice" ItemStyle-HorizontalAlign="Right"
                             SortExpression="TotalPrice" GroupByExpression="TotalPrice [GridColumn_TotalPrice] Group By TotalPrice" DataField ="TotalPrice">
                             <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("TotalPrice"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblprice" />
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:Label Text='<%# FormatCurrency(Eval("TotalPrice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' Width="100%" runat="server" CssClass = "Currency"
                                     ID="lblTotalPrice" />
                             </EditItemTemplate>
                             <HeaderStyle Width="80px"></HeaderStyle>
                         </telerik:GridTemplateColumn>

                     

                          <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                 UniqueName="CostType" DataField="CostType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn HeaderText="Contract Line" SortExpression="ContractLine" DataField="ContractLine"
                            UniqueName="ContractLine" GroupByExpression="ContractLine [GridColumn_ContractLine] Group By ContractLine ASC">
                            <ItemTemplate>
                               <span> <%# IIf(Container.DataItem("ContractLine") = String.Empty, "&nbsp;", Container.DataItem("ContractLine"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlContractLine" Width="100%" DropDownWidth="300px" runat="server"  Skin="Default"
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnSelectedIndexChanged="ddlContractLine_OnSelectedIndexChanged" AutoPostBack ="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                                    <asp:Label runat="server" ID="lblContractLine" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" DataField="CostCode"
                             UniqueName="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                             <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"
                                       Skin="Default" CloseDropDownOnBlur="true"
                                     NoWrap="False" AllowCustomText="False"  
                                     EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                     OnItemsRequested="ddl_ItemsRequested">
                                 </telerik:RadComboBox>
                                 <asp:Label runat="server" ID="lblCostCode" Width="100%"></asp:Label>
                             </EditItemTemplate>
                             <HeaderStyle Width="150"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Cost Period" SortExpression="Period" UniqueName="Period" DataField="Period"
                             GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                             <ItemTemplate>
                                 <%#IIf(Container.DataItem("PeriodId") = "-1", "&nbsp;", IIf(Container.DataItem("PeriodId") = "0", PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                  <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px">

                     </telerik:RadComboBox>
                                 <asp:Label runat="server" ID="lblCostPeriod" Width="100%"></asp:Label>
                             </EditItemTemplate>
                             <HeaderStyle Width="100px"></HeaderStyle>
                             <%--<ItemStyle BackColor="#fffee3" />--%>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                             GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                             <ItemTemplate>
                                 <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                                
                            <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                 OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" >
                            <span class="Icon"></span>
                            </asp:LinkButton>
                                  
                             </EditItemTemplate>
                             <HeaderStyle Width="200px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="CE #" SortExpression="CENumber" UniqueName="CENumber" DataField="CENumber"
                             GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber ASC">
                             <ItemTemplate>
                                 <span><a  runat="server" visible="false" id="hypCENumber"  href='<%#Eval("PostBackUrl")%>'> <%# Eval("CENumber")%> </a>&nbsp;</span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <span>
                                     <%#IIf(Eval("CENumber").ToString = String.Empty, "&nbsp;", Eval("CENumber"))%></span></EditItemTemplate>
                             <HeaderStyle Width="90px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Req Code" ItemStyle-HorizontalAlign="Right" DataField="ReqCode" DataType="System.Int64"
                             SortExpression="ReqCode" UniqueName="ReqCode" Groupable="false">
                             <ItemTemplate>
                                 <span>
                                     <%#IIf(Container.DataItem("ReqCode") = String.Empty, "&nbsp;", Container.DataItem("ReqCode"))%></span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtReqCode" runat="server" Text='<%# Eval("ReqCode") %>' 
                                     Width="70px" MaxLength="50"></asp:TextBox>
                                   <telerik:RadComboBox Skin="Default" Width ="80px"  ID="ddlReqCode" AllowCustomText="true" OnClientSelectedIndexChanged ="ddlReqCode_OnClientSelectedIndexChanged"  runat="server" >
                                </telerik:RadComboBox>  
                             </EditItemTemplate>
                             <HeaderStyle Width="70px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                         
                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right" Visible="false"
                        SortExpression="Adjustment1Converted" DataField ="Adjustment1Converted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment1Converted [GridColumn_Adjustment1Converted] Group By Adjustment1Converted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment1Converted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustment1Converted" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right" Visible="false"
                        SortExpression="Adjustment2 Converted" DataField ="Adjustment2Converted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2Converted [GridColumn_Adjustment2Converted] Group By Adjustment2Converted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment2Converted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustment2Converted" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Tax Converted" UniqueName="TaxConverted" ItemStyle-HorizontalAlign="Right" Visible="false"
                        SortExpression="TaxConverted" DataField ="TaxConverted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="TaxConverted [GridColumn_TaxConverted] Group By TaxConverted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                        <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Container.DataItem("TaxConverted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                        </ItemTemplate>
                        <EditItemTemplate>
                                &nbsp;
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Total Price Converted" UniqueName="TotalPriceConverted" ItemStyle-HorizontalAlign="Right" Visible="false"
                            SortExpression="TotalPriceConverted" GroupByExpression="TotalPriceConverted [GridColumn_TotalPriceConverted] Group By TotalPriceConverted" DataField ="TotalPriceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Container.DataItem("TotalPriceConverted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTotalPriceConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Owner Budget Converted" SortExpression="OwnerBudgetConverted" Visible="false"
                            UniqueName="OwnerBudgetConverted" GroupByExpression="OwnerBudgetConverted [GridColumn_OwnerBudgetConverted] Group By OwnerBudgetConverted" DataField ="OwnerBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("OwnerBudgetConverted"), CurrencyId:=Eval("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Unit Price Converted" Visible="false" SortExpression="UnitPriceConverted" UniqueName="UnitPriceConverted"
                            GroupByExpression="UnitPriceConverted [GridColumn_UnitPriceConverted] Group By UnitPriceConverted" DataField ="UnitPriceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("UnitPriceConverted"), CurrencyId:=Eval("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                                  
                         <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate> 
                        <div style="padding:2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                           <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add"  CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'>
                               <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddItems"  CssClass="GridCmdAddItems"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=PrimeContractCO', 910, 580, true,'rdgPrimeContractCODetails');">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                          <asp:LinkButton ID="btnLinkCE" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add"  CssClass="GridCmdLinkCE"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenCEPopup(); ">
                              <span class="Icon"></span>
                                <asp:Label ID="lblLinkCE" runat="server" Text="Link CE"    meta:resourcekey="lblLinkChangeEvent"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgPrimeContractCODetails.MasterTableView.IsItemInserted %>'>
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton> 
                  
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" 
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                 <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                               <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            
                       <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard"
                            Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted)%>'>
                         
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>


                            <span style="width: 100%; text-align: right" >
                                <asp:CheckBox runat="server" ID="ckbUseUnits" CssClass="chkAlignMiddle mobile-switch" Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="ckbUseUnits" Text="Use Units" SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false" CssClass="Hide"
                                    OnClick="chkUserUnits_OnChekedChanged" />
                            </span>
 
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count > 0 Or rdgPrimeContractCODetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                 OnClientClick="return OpenPreviewConversion();" style="float:none !important" 
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgPrimeContractCODetails.EditIndexes.Count = 0 And (Not rdgPrimeContractCODetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">                                    
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                 &nbsp;&nbsp;
                            </asp:LinkButton>

                            <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                                 EnableShadows="true" CausesValidation="false"
                                 Visible="true">                                 
                             </telerik:RadMenu> 
                        </div>
                    </CommandItemTemplate>
                    
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true">
                    <Selecting AllowRowSelect="true" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                   <%-- <Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                   </ClientSettings>
                   
            </telerik:RadGrid>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
