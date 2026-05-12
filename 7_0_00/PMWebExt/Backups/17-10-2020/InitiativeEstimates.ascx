<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InitiativeEstimates.ascx.vb" Inherits="Website.InitiativeEstimates" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEstimateDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEstimateDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy> 

<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgEstimateDetails" runat="server"  CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                 AutoGenerateColumns="false" ShowStatusBar="true" Font-Size="8px" PageSize="20" setWidth="true" appendMenus="true" FitParentContainer="true"
                ShowFooter="true" AllowPaging="true" ShowGroupPanel="true" EnableViewState="true" AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" ShowGroupFooter="true" 
                    Width="100%" UseAllDataFields="true" EnableHeaderContextMenu="true" FooterStyle-HorizontalAlign="Right">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber" DataField="LineNumber"
                        Groupable="false" Reorderable="true" AllowFiltering="false">
                        <ItemTemplate>
                           <span><%#Container.DataItem("LineNumber").ToString%></span>
                        </ItemTemplate>
                        <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Estimate" SortExpression="Estimate"
                        GroupByExpression="Estimate [GridColumn_Estimate] Group By Estimate"
                        UniqueName="Estimate" CurrentFilterFunction="Contains" DataField="Estimate" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Estimate") = String.Empty, "&nbsp;", Container.DataItem("Estimate"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="180px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Assembly" SortExpression="Assembly" GroupByExpression="Assembly [GridColumn_Assembly] Group By Assembly"
                         UniqueName="Assembly" CurrentFilterFunction="Contains" DataField="Assembly" DataType="System.String" FilterListOptions="VaryByDataType"  >     
                        <ItemTemplate>
                          <span>  <%#IIf(Container.DataItem("Assembly") = String.Empty, "&nbsp;", Container.DataItem("Assembly"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="60px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                   
                    <telerik:GridTemplateColumn HeaderText="Item" SortExpression="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC"
                         UniqueName="ItemCode" CurrentFilterFunction="Contains" DataField="ItemCode" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                           <span> <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="60px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="BIM ID" SortExpression="BIMId" GroupByExpression="BIMId [GridColumn_BIMId] Group By BIMId ASC"
                         UniqueName="BIMId" CurrentFilterFunction="Contains" DataField="BIMId" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("BIMId") = String.Empty, "&nbsp;", Container.DataItem("BIMId"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="60px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                        GroupByExpression="Description [GridColumn_Description] Group By Description"
                        UniqueName="Description"  CurrentFilterFunction="Contains" DataField="Description" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="230px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                      <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                         <HeaderStyle Width="120px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Resource" SortExpression="Resource"
                        GroupByExpression="Resource [GridColumn_Resource] Group By Resource"
                        UniqueName="Resource"  CurrentFilterFunction="Contains" DataField="Resource" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%# IIf(Container.DataItem("Resource") = String.Empty, "&nbsp;", Container.DataItem("Resource"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="230px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Resource Type" SortExpression="ResourceType"
                        GroupByExpression="ResourceType [GridColumn_ResourceType] Group By ResourceType"
                        UniqueName="ResourceType"  CurrentFilterFunction="Contains" DataField="ResourceType" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%# IIf(Container.DataItem("ResourceType") = String.Empty, "&nbsp;", Container.DataItem("ResourceType"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="110px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM"
                        GroupByExpression="UOM [GridColumn_UOMId] Group By UOM ASC" 
                        UniqueName="UOM" CurrentFilterFunction="Contains" DataField="UOM" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                           <span> <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC"
                        SortExpression="Quantity"  UniqueName="Quantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                        DataField="Quantity" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#FormatNumber(ParseDouble(Container.DataItem("Quantity")))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="Unit Cost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                        SortExpression="UnitCost"  UniqueName="UnitCost"  
                       DataField="UnitCost" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                          <span> <%# FormatCurrency(ParseDouble(Eval("UnitCost")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Quantity" GroupByExpression="ExtQuantity [GridColumn_ExtQuantity] Group By ExtQuantity ASC"
                        SortExpression="ExtQuantity"  UniqueName="ExtQuantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                       DataField="ExtQuantity" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                          <span> <%# FormatNumber(ParseDouble(Eval("ExtQuantity")))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                      <telerik:GridTemplateColumn HeaderText="Ext Cost" 
                        GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC" SortExpression="ExtCost"
                         UniqueName="ExtCost"  
                          DataField="ExtCost" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#FormatCurrency(ParseDouble(Container.DataItem("ExtCost")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                
                    <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                        SortExpression="Adjustment1" DataField ="Adjustment1"   GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span> <%# FormatCurrency(ParseDouble(Eval("Adjustment1")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right" DataType="System.String"
                        SortExpression="Tax" DataField ="Tax"   GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                        CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" >
                        <ItemTemplate>
                            <span> <%# FormatCurrency(ParseDouble(Eval("Tax")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="100px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                        SortExpression="Adjustment2" DataField ="Adjustment2"   GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span> <%# FormatCurrency(ParseDouble(Eval("Adjustment2")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                        <HeaderStyle Width="110px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Total Cost" 
                        GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC" SortExpression="TotalCost"
                         UniqueName="TotalCost"  
                          DataField="TotalCost" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#FormatCurrency(ParseDouble(Container.DataItem("TotalCost")), CurrencyId:=Eval("CurrencyId"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Cost Code" ItemStyle-Wrap="false" 
                        GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" SortExpression="CostCode"  UniqueName="CostCode"
                        CurrentFilterFunction="Contains" DataField="CostCode" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="120px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                         UniqueName="CostType" CurrentFilterFunction="Contains" DataField="CostType" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Funding Source" SortExpression="FundingSource"
                        UniqueName="FundingSource" GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource ASC" DataField="FundingSourceId">
                        <ItemTemplate>
                            <%#IIf(Container.DataItem("FundingSourceId") = -1, "&nbsp;", IIf(Container.DataItem("FundingSourceId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingSource")))%>
                        </ItemTemplate>
                        <HeaderStyle Width="100px"></HeaderStyle>
                        <ItemStyle Wrap ="false"   />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period">
                        <ItemTemplate> 
                            <span><%#IIf(Container.DataItem("Period") = String.Empty, "&nbsp;", Container.DataItem("Period"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Bid Category" SortExpression="BidCategory" GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC"
                         UniqueName="BidCategory" CurrentFilterFunction="Contains" DataField="BidCategory" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("BidCategory") = String.Empty, "&nbsp;", Container.DataItem("BidCategory"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="120px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Manufacturer" ItemStyle-Wrap="false" GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer ASC"
                SortExpression="Manufacturer" UniqueName="Manufacturer"
                 CurrentFilterFunction="Contains" DataField="Manufacturer" DataType="System.String" FilterListOptions="VaryByDataType">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
                     </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="Mfr. #" SortExpression="ManufacturerNumber" 
                GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber"
                UniqueName="ManufacturerNumber" CurrentFilterFunction="Contains" DataField="ManufacturerNumber" DataType="System.String" FilterListOptions="VaryByDataType">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("ManufacturerNumber") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName"
                        GroupByExpression="PhaseName [GridColumn_PhaseName] Group By PhaseName ASC" 
                        UniqueName="PhaseName" CurrentFilterFunction="Contains" DataField="PhaseName" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                           <span> <%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlProjectPhases" runat="server" Width="100%">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                        SortExpression="Location"  UniqueName="Location"
                         CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="160px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Company" ItemStyle-Wrap="false" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                        SortExpression="Company" UniqueName="Company"
                         CurrentFilterFunction="Contains" DataField="Company" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="160px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Year" ItemStyle-Wrap="false" GroupByExpression="Year [GridColumn_Year] Group By Year ASC"
                        SortExpression="Year" UniqueName="Year"
                         CurrentFilterFunction="Contains" DataField="Year" DataType="System.Int16" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Year") = 0, "&nbsp;", Container.DataItem("Year"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="160px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task"  DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("TaskId") = 0, "&nbsp;", Container.DataItem("TaskName"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="90px"></HeaderStyle>
                        <ItemStyle Wrap="False"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                        SortExpression="Notes"  UniqueName="Notes"
                         CurrentFilterFunction="Contains" DataField="Notes" DataType="System.String" FilterListOptions="VaryByDataType">
                        <ItemTemplate>
                           <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="80px"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    
                 <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" visible ="False" GroupByExpression="UnitCostConverted [GridColumn_UnitCostConverted] Group By UnitCostConverted ASC"
                SortExpression="UnitCostConverted"  UniqueName="UnitCostConverted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
               DataField="UnitCostConverted" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                <ItemTemplate>
                  <span> <%# FormatCurrency(ParseDouble(Container.DataItem("UnitCostConverted")), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
                <HeaderStyle Width="80px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

              <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible = "False" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                    SortExpression="ExtCostConverted" GroupByExpression="ExtCostConverted [GridColumn_ExtCostConverted] Group By ExtCostConverted ASC"
                    DataField ="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">

                    <ItemTemplate>
                            <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label3" />
                    </ItemTemplate>
                    <EditItemTemplate>
                     &nbsp;
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Right" ></ItemStyle>   
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>

             <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted"  Visible = "False" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1Converted" DataField ="Adjustment1Converted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment1Converted [GridColumn_Adjustment1Converted] Group By Adjustment1Converted ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label4" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                             </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
            
                        <telerik:GridTemplateColumn HeaderText="Tax Converted" UniqueName="TaxConverted"  Visible = "False" ItemStyle-HorizontalAlign="Right" 
                            SortExpression="TaxConverted" DataField ="TaxConverted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="TaxConverted [GridColumn_TaxConverted] Group By TaxConverted ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label5" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                   &nbsp;
                            </EditItemTemplate>                    
                        </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right" Visible = "False"
                            SortExpression="Adjustment2Converted" DataField ="Adjustment2Converted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2Converted [GridColumn_Adjustment2Converted] Group By Adjustment2Converted ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label7" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                   &nbsp;
                            </EditItemTemplate>  
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost Converted" Visible = "False"
                            GroupByExpression="TotalCostConverted [GridColumn_TotalCostConverted] Group By TotalCostConverted ASC" SortExpression="TotalCostConverted"
                             UniqueName="TotalCostConverted"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                              DataField="TotalCostConverted" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("TotalCostConverted")),CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>  
                        </telerik:GridTemplateColumn>
                </Columns>
                <CommandItemTemplate>
                    <div style="padding: 2px">
                            <asp:LinkButton ID="btnlinkEstimate" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="LinkEstimates" CssClass="GridCmdLinkEstimates"
                                OnClientClick="javascript:return OpenLinkEstimatesPopup();"
                                Visible='<%# rdgEstimateDetails.EditIndexes.Count = 0 AND (Not rdgEstimateDetails.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label runat="server" ID="lblAddestimate" Text = "link Estimate(s)" meta:resourcekey="lblAddestimate1"></asp:Label>
                        </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"   CssClass="GridCmdRebindGrid"
                            SecurityButtonType="ItemMode" Visible='<%# rdgEstimateDetails.EditIndexes.Count = 0 AND (Not rdgEstimateDetails.MasterTableView.IsItemInserted) %>'
                            meta:resourcekey="btnRefreshResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                        </asp:LinkButton>
                        <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">                                 
                        </telerik:RadMenu> 
                    </div>
                 </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnsReorder="true" EnableRowHoverStyle="true" AllowDragToGroup="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                </ClientSettings>
                </telerik:RadGrid> 
            </div>
        </div>
    </div>
