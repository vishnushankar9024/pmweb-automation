<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CommitmentsDetails.ascx.vb" Inherits="Website.CommitmentsDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>

<telerik:RadAjaxLoadingPanel ID="ldpCommitmentsDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
   <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
<%--<table style="table-layout:fixed;"  cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>--%>
            <textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgCommitmentsDetails" runat="server" HasPasteFromExcel="true"
                  AutoGenerateColumns="False" ShowStatusBar="False" CssClass="WithoutTopBorder"
                Font-Size="8px" PageSize="15" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None"
                ShowGroupFooter ="true"  GroupLoadMode ="Client" AllowFilteringByColumn="true" FilterType="HeaderContext" 
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter ="true"  GroupLoadMode ="Client">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText=""
                            UniqueName="Projection" Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:linkbutton ID="imgBudget" Style="cursor: pointer" meta:resourcekey="imgBudget" ToolTip="Projection" runat="server" >
                                    <span class="Icon"></span>
                                </asp:linkbutton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField runat="server" ID="hdnField" />
                            </EditItemTemplate>
                            <HeaderStyle Width="27px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" />

                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right"
                            SortExpression="LineNumber"
                            Groupable="false" Reorderable="true" DataField="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                                <asp:HiddenField runat="server" ID="IsLinkedCommitmentDetail" Value='<%#Eval("IsLinkedCommitmentDetail").ToString%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
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

                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Item" DataField="ItemCode"  SortExpression="ItemCode" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty Or Container.DataItem("ItemCode") = "0", "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" runat="server" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" Enabled="false"
                                    ></asp:TextBox>
                            </EditItemTemplate> 
                            <HeaderStyle Width="100px"></HeaderStyle>        
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                               <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
             GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" >
                <ItemTemplate>
                    <span><%#Eval("Currency")%></span>
                </ItemTemplate>
                <EditItemTemplate>
                     <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="150px"
                                    Skin="Default" Height="250px"   >
                                </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="250px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" />
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                        DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" DropDownWidth="150px"
                                    Skin="Default" Height="250px" AllowCustomText ="true" MarkFirstMatch="true" Filter="Contains">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>                                                         
                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right" 
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity"
                           DataField ="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                       <ItemTemplate>
                            <div id='<%# "Detail_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"><%#FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;</div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'
                                    Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC" 
                             SortExpression="UnitCost" DataField ="UnitCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    ></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle  HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField ="ExtCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <div id='<%# "DetailV_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"> <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCost" /></span>&nbsp;</div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" 
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                                   <telerik:GridTemplateColumn HeaderText="Adjustment1" UniqueName="Shipping" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Shipping" GroupByExpression="Shipping [GridColumn_Shipping] Group By Shipping ASC"
                            DataField ="Shipping" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Shipping"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtShipping" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Shipping"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                          <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            DataField ="Tax" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTax" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                          <telerik:GridTemplateColumn HeaderText="Adjustment2" UniqueName="Adjustment" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment" GroupByExpression="Adjustment [GridColumn_Adjustment] Group By Adjustment ASC"
                            DataField ="Adjustment" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAdjustments" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("Adjustment"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                             <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC"
                            DataField ="TotalCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                         
                <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                 UniqueName="CostTypeId" DataField="CostType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" DropDownWidth="150px"
                        Skin="Default" Height="250px" AllowCustomText ="true" MarkFirstMatch="true" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" 
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True"  OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                                  <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>" 
                                Display="Dynamic" Enabled ="false"  ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                              
                         
                              </EditItemTemplate>
                             <HeaderStyle Width="150px"></HeaderStyle>
                       </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Period" UniqueName="Period" SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC"
                        DataField="Period" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Period")="*Split*", PM.LanguagesInfo.SPLIT,Container.DataItem("Period"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px"
                                    >
                                </telerik:RadComboBox> 
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName" DataField="PhaseName" 
                GroupByExpression="PhaseName [GridColumn_Phase] Group By PhaseName ASC" 
                UniqueName="Phase" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                   <span> <%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlProjectPhases" runat="server" Width="100%" DropDownWidth="300px" AllowCustomText="true"  CloseDropDownOnBlur="true" NoWrap="True">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Location" GroupByExpression="WBS [GridColumn_Location] Group By WBS ASC"
                SortExpression="WBS"  UniqueName="Location" DataField="WBS" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("WBS") = String.Empty, "&nbsp;", Container.DataItem("WBS"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AllowCustomText="true" CloseDropDownOnBlur="true" NoWrap="True">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="WBS" DataField="ProjectWBS"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"  SortExpression="ProjectWBS" UniqueName="ProjectWBS"
                    GroupByExpression="ProjectWBS [GridColumn_ProjectWBS] Group By ProjectWBS ASC" >
                    <ItemTemplate>
                        <span><%# IIf(Container.DataItem("ProjectWBSId") = 0, "&nbsp;", Container.DataItem("ProjectWBS"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                     <div style="width:100%; white-space:nowrap"> 
                        <telerik:RadComboBox ID="ddlProjectWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false" 
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

               <telerik:GridTemplateColumn HeaderText="Assigned To" SortExpression="AssignedTo" UniqueName="AssignedTo"
                    GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" DataField="AssignedTo" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
                        
                         <asp:HiddenField ID="HiddenField1" runat="server" /></div>
                    </EditItemTemplate>
                     <HeaderStyle Width="120px"></HeaderStyle>
                     <ItemStyle Wrap="false" />
               </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded"
                    GroupByExpression="Funded [GridColumn_Funded] Group By Funded"   DataField ="Funded"  CurrentFilterFunction="EqualTo"  FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
                        <telerik:GridTemplateColumn HeaderText="Funding Code" UniqueName="FundingCode" SortExpression="FundingCode"
                            GroupByExpression="FundingCode [GridColumn_FundingCode] Group By FundingCode ASC" DataField="FundingCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FundingCodeId") = -1, "&nbsp;", IIF(Container.DataItem("FundingCodeId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingCode")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlFundingCodes" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true" 
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <%--<ItemStyle BackColor="#ebffeb" />--%>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15"
                        DataField="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                               
                            <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" >
    					        <span class="Icon"></span>
				            </asp:LinkButton>
                            
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="Manufacturer" SortExpression="Manufacturer" UniqueName="Manufacturer"
                    GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer ASC" DataField="Manufacturer" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("MfrId") = "-1" Or Container.DataItem("MfrId") = "0", "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                    <div style="width:100%; white-space:nowrap"> 
                        <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="85%" DropDownWidth="300px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                             OnClientDropDownClosed="dllcompClientClosed1" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                         
                        <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlManufacturer'),'Companies')" >
    					    <span class="Icon"></span>
				        </asp:LinkButton>
                        
                        <asp:HiddenField ID="HiddenField2" runat="server" /></div>
                    </EditItemTemplate>
                     <HeaderStyle Width="130px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
               </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mfr. Number" SortExpression="MfrNumber" UniqueName="MfrNumber" GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber"
                        DataField="MfrNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("MfrNumber") = String.Empty, "&nbsp;", Container.DataItem("MfrNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" Width="100%" MaxLength="255" runat="server"
                                    Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="Field1"  AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2"  AllowFiltering="false"  GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3"  AllowFiltering="false"  GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4"  AllowFiltering="false"  GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5"  AllowFiltering="false"  GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6"  AllowFiltering="false"   GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7"  AllowFiltering="false"   GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8"  AllowFiltering="false"  GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9"  AllowFiltering="false"  GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10"  AllowFiltering="false"   GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="false" UniqueName="UnitCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitCostConverted"  DataField ="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible="false" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCostConverted"  DataField ="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment1 Converted" Visible="false" UniqueName="ShippingConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ShippingConverted"  DataField ="ShippingConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("ShippingConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblShippingConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax Converted" Visible="false" UniqueName="TaxConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TaxConverted"  DataField ="TaxConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Adjustment2 Converted" Visible="false" UniqueName="AdjustmentConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="AdjustmentConverted"  DataField ="AdjustmentConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("AdjustmentConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustmentConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost Converted" Visible="false" UniqueName="TotalCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalCostConverted"  DataField ="TotalCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("TotalCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCostTotalCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                   <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
                    </Columns>
                    <ItemStyle Wrap="false" />  
                    <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                    <FooterStyle CssClass="GridFooter" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber" meta:resourcekey="GridSortExpressionResource1">
                        </telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgCommitmentsDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count > 0 Or rdgCommitmentsDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Commitments', 910, 580, true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Export To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <span style="width: 100%; text-align: right;">
                                <asp:CheckBox runat="server" ID="ckbUseUnits" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false"
                                    CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                            </span>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgCommitmentsDetails.EditIndexes.Count = 0 And (Not rdgCommitmentsDetails.MasterTableView.IsItemInserted) %>'
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
                    <ClientSettings AllowColumnHide="true" ClientEvents-OnRowSelected="rdgCommitmentsDetails_OnRowClick" AllowColumnsReorder="true" AllowDragToGroup="true">                        
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                        <ClientEvents OnRowDblClick="RowDblClickDetails" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
            <input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>
            


        <%--</td>
    </tr>
</table>--%>