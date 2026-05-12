<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CommitmentCODetails.ascx.vb" Inherits="Website.CommitmentCODetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgCommitmentCODetails" runat="server"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True"  HasPasteFromExcel="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true" ShowGroupFooter ="true"  GroupLoadMode ="Client">
                     <Columns> 
                        <telerik:GridTemplateColumn   HeaderText="Line #" Groupable="false" UniqueName="LineNumber" AllowFiltering="false" Reorderable="true">
                            <ItemTemplate>
                               <span> <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#IIf(CStr(Eval("LineNumber").ToString) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal" AllowFiltering="true"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal"> 
                            <ItemTemplate> 
                                 <asp:LinkButton runat="server" ID="btnAttachments"  > 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                    <span> <%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                             </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                     
                        <telerik:GridTemplateColumn HeaderText="Item " SortExpression="ItemCode" UniqueName="ItemCode" DataField="ItemCode"
                            GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" MaxLength ="50" runat="server"  Enabled="false"
                                    Text='<%#Eval("ItemCode")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                       </telerik:GridTemplateColumn> 
                     
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" DataField="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" MaxLength ="500" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
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
                             <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px"
                                    Skin="Default" Height="250px">
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
                                <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true" >
                                </telerik:RadComboBox>
                                <asp:Label runat="server" ID="lblUOM" Width="100%"></asp:Label>
                            </EditItemTemplate>
                       <HeaderStyle Width="100px"></HeaderStyle>
                       </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" 
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField ="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                               <div id='<%# "Detail_" & IIf(Eval("RevisedReference") = "C", "C_" & Eval("RevisedReferenceId").ToString(), "CO_" & Eval("RevisedReferenceId").ToString())%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right">  
                                <%# IIf(CDbl(ParseDouble(Container.DataItem("Quantity"), 1)) = CInt(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1), 5).TrimEnd("0"))%>

                                </span>&nbsp;</div>
                                
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" MaxLength ="15" Precision="5"
                                    Text='<%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>'  
                                    Width="100%" CssClass="Double"></asp:TextBox>
                                <asp:HiddenField ID="hdnRevisedBy" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost <br />Requested" SortExpression="UnitCostRequested" UniqueName="UnitCostRequested"
                            GroupByExpression="UnitCostRequested [GridColumn_UnitCostRequested] Group By UnitCostRequested" DataField ="UnitCostRequested" >
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("UnitCostRequested"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCostRequested" runat="server" MaxLength ="15" 
                                    Text='<%#FormatCurrency(Eval("UnitCostRequested"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' 
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                           <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>

                      
                        <telerik:GridTemplateColumn HeaderText="Amount Requested" SortExpression="AmountRequested" UniqueName="AmountRequested"
                            GroupByExpression="AmountRequested [GridColumn_AmountRequested] Group By AmountRequested" DataField ="AmountRequested">
                            <ItemTemplate>
                                 <div id='<%# "DetailVR_" & IIf(Eval("RevisedReference") = "C", "C_" & Eval("RevisedReferenceId").ToString(), "CO_" & Eval("RevisedReferenceId").ToString())%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"><%#FormatCurrency(Container.DataItem("AmountRequested"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>&nbsp;
                                 </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAmountRequested" runat="server" MaxLength ="15"   
                                    Text='<%#FormatCurrency(Eval("AmountRequested"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' 
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>
                      

                        <telerik:GridTemplateColumn HeaderText="Unit Cost<br />Approved" SortExpression="UnitCostApproved" UniqueName="UnitCostApproved"
                            GroupByExpression="UnitCostApproved [GridColumn_UnitCostApproved] Group By UnitCostApproved" DataField ="UnitCostApproved" >
                            <ItemTemplate>
                                <asp:Label ID="lblUnitCostApproved" runat="server"
                                    Text='<%#FormatCurrency(Container.DataItem("UnitCostApproved"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCostApproved" MaxLength ="15" runat="server" CssClass="Currency" 
                                    Text='<%#FormatCurrency(Eval("UnitCostApproved"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' 
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>


                      

                       <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField ="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'  runat="server" ID="lblEditAdjustment1" />
                        </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                      

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField ="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                    <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" /> </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                       

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField ="Adjustment2"  GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" /></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                      

                        <telerik:GridTemplateColumn HeaderText="Amount Approved" SortExpression="AmountApproved" UniqueName="AmountApproved"
                            GroupByExpression="AmountApproved [GridColumn_AmountApproved] Group By AmountApproved" DataField ="AmountApproved">
                            <ItemTemplate>
                                 <div id='<%# "DetailVA_" & IIf(Eval("RevisedReference") = "C", "C_" & Eval("RevisedReferenceId").ToString(), "CO_" & Eval("RevisedReferenceId").ToString())%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"><asp:Label ID="lblAmountApproved" runat="server"
                                    Text='<%#FormatCurrency(Container.DataItem("AmountApproved"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label></span>&nbsp;
                                 </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAmountApproved" MaxLength ="15" runat="server" CssClass="Currency" 
                                    Text='<%#FormatCurrency(Eval("AmountApproved"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' 
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
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
               <telerik:GridTemplateColumn HeaderText="Commitment Line" SortExpression="ContractLine" DataField="ContractLine"
                            UniqueName="ContractLine" GroupByExpression="ContractLine [GridColumn_ContractLine] Group By ContractLine ASC">
                            <ItemTemplate>
                               <span> <%# IIf(Container.DataItem("ContractLine") Is DBNull.Value OrElse Container.DataItem("ContractLine") = String.Empty, "&nbsp;", Container.DataItem("ContractLine"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlContractLine" Width="100%" DropDownWidth="300px" runat="server"  Skin="Default"
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnSelectedIndexChanged="ddlContractLine_OnSelectedIndexChanged" AutoPostBack ="true">
                                </telerik:RadComboBox>
                          <div>                            
                            
                           
                         
                        </div>
                                    <asp:Label runat="server" ID="lblContractLine" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" DataField="CostCode"
                            UniqueName="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCodeWithDescription")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCodeWithDescription") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"  Skin="Default"
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False" OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                          <div>                            
                            <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>" 
                                Display="Dynamic" Enabled ="false"  ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                           
                         
                        </div>
                                    <asp:Label runat="server" ID="lblCostCode" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded"
                    GroupByExpression="Funded [GridColumn_Funded] Group By Funded"   DataField ="Funded" CurrentFilterFunction="EqualTo"  FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("Funded"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                        <asp:linkbutton ID="btnGenerateFunding" CssClass="SearchButton" Text="" runat="server"> 
                            <span class="Icon"></span>
                        </asp:linkbutton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFunded" runat="server" 
                            Text='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' 
                            Width="80%" CssClass="Currency"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase"  DataField="Phase"
                            HeaderStyle-Width="150px" SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" Height="200px" CloseDropDownOnBlur="true" DropDownWidth="200px"
                                    Width="100%" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBSId" GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC" >
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                             <div style="width:100%; white-space:nowrap"> 
                                <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false" 
                                     Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" 
                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                                
                             <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
    					        <span class="Icon"></span>
				             </asp:LinkButton>
                             
                             </div>
                            </EditItemTemplate>
                             <HeaderStyle Width="150px"></HeaderStyle>
                                 <ItemStyle Wrap="false" />
                       </telerik:GridTemplateColumn> 

                              <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location"  DataField="Location"
                            HeaderStyle-Width="150px" SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLocation" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="200px"
                                    Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Period" SortExpression="Period" UniqueName="Period" DataField="PeriodId"
                             GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("PeriodId") = "-1", "&nbsp;", IIf(Container.DataItem("PeriodId") = "0", PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                   <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px"
                                    >
                                </telerik:RadComboBox>
                                  <asp:Label runat="server" ID="lblCostPeriod" Width="100%"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <%--<ItemStyle BackColor="#fffee3" />--%>
                       </telerik:GridTemplateColumn>
                       
                       <telerik:GridTemplateColumn HeaderText="Assigned To" SortExpression="AssignedTo" UniqueName="AssignedTo" DataField="AssignedTo"
                    GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" >
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("AssignedToId") = "-1" Or Container.DataItem("AssignedTo") = "0", "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                       <div style="width:100%; white-space:nowrap"> 
                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="85%" DropDownWidth="300px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                             OnClientDropDownClosed="dllcompClientClosed" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                            
                        
                           <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
    					    <span class="Icon"></span>
				        </asp:LinkButton>
                           
                           <asp:HiddenField ID="HiddenField1" runat="server" />
                        </div>
                    </EditItemTemplate>
                     <HeaderStyle Width="120px"></HeaderStyle>
                        <ItemStyle Wrap="false" />
               </telerik:GridTemplateColumn>
               
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                               
                            <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					        <span class="Icon"></span>
				            </asp:LinkButton>
                            
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            
                       </telerik:GridTemplateColumn>  
                         <telerik:GridTemplateColumn HeaderText="Change Request ID" ItemStyle-HorizontalAlign="left"  DataField="ChangeRequestID"
                                                SortExpression="ChangeRequestID" UniqueName="ChangeRequestID" GroupByExpression="ChangeRequestID [GridColumn_ChangeRequestID] Group By ChangeRequestID ASC">
                        <ItemTemplate>
                        <span>    <a  runat="server" id="hypOCRNumber" visible="false" href='<%#Eval("OCRPostBackUrl")%>'> <%# Eval("ChangeRequestID")%> </a>&nbsp;</span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <span>
                                     <%#IIf(Eval("ChangeRequestID").ToString = String.Empty, "&nbsp;", Eval("ChangeRequestID"))%></span>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="left"></ItemStyle>
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="CE Number" SortExpression="CENumber" UniqueName="CENumber" DataField="CENumber"
                             GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber ASC">
                             <ItemTemplate>
                                <span><a  runat="server" visible="false" id="hypCENumber"  href='<%#Eval("PostBackUrl")%>'> <%# Eval("CENumber")%> </a>&nbsp;</span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <span>
                                     <%#IIf(Eval("CENumber").ToString = String.Empty, "&nbsp;", Eval("CENumber"))%></span></EditItemTemplate>
                             <HeaderStyle Width="200px"></HeaderStyle>
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
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAdjustment1Converted" />
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
                                 <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right" Visible="false"
                            SortExpression="Adjustment2Converted" DataField ="Adjustment2Converted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2Converted [GridColumn_Adjustment2Converted] Group By Adjustment2Converted ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAdjustment2Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Amount Approved Converted" SortExpression="AmountApprovedConverted" UniqueName="AmountApprovedConverted" Visible="false"
                            GroupByExpression="AmountApprovedConverted [GridColumn_AmountApprovedConverted] Group By AmountApprovedConverted" DataField ="AmountApprovedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label ID="lblAmountApprovedConverted" runat="server"
                                    Text='<%#FormatCurrency(Container.DataItem("AmountApprovedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                    &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Unit Cost <br />Requested Converted" SortExpression="UnitCostRequestedConverted" UniqueName="UnitCostRequestedConverted" Visible="false"
                            GroupByExpression="UnitCostRequestedConverted [GridColumn_UnitCostRequestedConverted] Group By UnitCostRequestedConverted" DataField ="UnitCostRequestedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("UnitCostRequestedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                           <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Amount Requested Converted" SortExpression="AmountRequestedConverted" UniqueName="AmountRequestedConverted" Visible="false"
                            GroupByExpression="AmountRequestedConverted [GridColumn_AmountRequestedConverted] Group By AmountRequestedConverted" DataField ="AmountRequestedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("AmountRequestedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="Unit Cost<br />Approved Converted" SortExpression="UnitCostApprovedConverted" UniqueName="UnitCostApprovedConverted" Visible="false"
                            GroupByExpression="UnitCostApprovedConverted [GridColumn_UnitCostApprovedConverted] Group By UnitCostApprovedConverted" DataField ="UnitCostApprovedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <asp:Label ID="lblUnitCostApprovedConverted" runat="server"
                                    Text='<%#FormatCurrency(Container.DataItem("UnitCostApprovedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label>
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
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                           <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                                CommandName="InitNewRow" Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'>
                               <span class="Icon"></span>
                                <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddItems" CssClass="GridCmdAddItems" 
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=CommitmentCO', 910, 580, true);">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgCommitmentCODetails.MasterTableView.IsItemInserted %>'>
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnLinkCE" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLinkCE" 
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenCEPopup(); ">
                                <span class="Icon"></span>
                                <asp:Label ID="lblLinkCE" runat="server" Text="Link CE"    meta:resourcekey="lblLinkCE"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
  
                            <asp:LinkButton ID="btnLinkOCR" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdLinkOCR" 
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenPOPUp('OCRPopup.aspx?SourceId=CommitmentCO', 880, 500, true);">
                               <span class="Icon"></span>
                                <asp:Label ID="lblLinkOCR" runat="server" Text="Link Change Request(s)"    meta:resourcekey="lblLinkOCR"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>   
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>                  
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" 
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                 <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblExpToExcel" Text="Copy To Excel" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick=" return GetClipboardData();" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server" Text="Paste From Excel"></asp:Label>
                            </asp:LinkButton>

                            <span style="width: 100%; text-align: right" >
                                <asp:CheckBox runat="server" ID="ckbUseUnits"  cssclass="chkAlignMiddle mobile-switch"  meta:resourcekey="ckbUseUnits" Text="Use Units" SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false" CssClass="Hide"
                                    OnClick="chkUserUnits_OnChekedChanged" />
                            </span>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup ="Save"
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count > 0 Or rdgCommitmentCODetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                              <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                               <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                 OnClientClick="return OpenPreviewConversion();" style="float:none !important" 
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgCommitmentCODetails.EditIndexes.Count = 0 And (Not rdgCommitmentCODetails.MasterTableView.IsItemInserted)%>'
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
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                   <%-- <Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                   </ClientSettings>
                <ValidationSettings ValidationGroup="ChangeEventDetails" EnableValidation="true" CommandsToValidate="SaveChanges" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />   
                
   
