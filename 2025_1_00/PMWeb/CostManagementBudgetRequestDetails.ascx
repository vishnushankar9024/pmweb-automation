<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementBudgetRequestDetails.ascx.vb" Inherits="Website.CostManagementBudgetRequestDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgBudgetRequestDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgBudgetRequestDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgBudgetRequestDetails" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder"
                AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                HeaderStyle-Font-Size="8" AllowMultiRowEdit="True" ShowGroupPanel="true"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false" HasPasteFromExcel="true" HasCostCodePoup="true"
                ShowFooter="True" AllowPaging="true" PageSize="250" UseEditFormInMobile="true">
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EnableHeaderContextMenu="true" EditMode="InPlace" ShowGroupFooter="true" GroupLoadMode="Client">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <Columns>

                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectName" ItemStyle-Wrap="false" HeaderText="Project" DataField="ProjectName"
                            SortExpression="ProjectNumber" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("ProjectName")) = String.Empty, "&nbsp;", Eval("ProjectNumber") & " - " & Eval("ProjectName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                    CloseDropDownOnBlur="true" Height="300px"
                                    NoWrap="true" Skin="Default" Width="100%" ShowMoreResultsBox="True" OnClientSelectedIndexChanged="ResetCombos"
                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged">
                                </telerik:RadComboBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Project Required."
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency" DataField="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC">
                            <ItemTemplate>

                                <span><%#Eval("Currency")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                    Skin="Default" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Projection" AllowFiltering="false"
                            UniqueName="Projection" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgBudget" Style="cursor: pointer" meta:resourcekey="imgBudget" ToolTip="Projection" runat="server">
                        <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField runat="server" ID="hdnField" />
                            </EditItemTemplate>
                            <HeaderStyle Width="27px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" />

                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="35px" UniqueName="LineNumber" AllowFiltering="false"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True">
                            <ItemTemplate>
                                <%#Container.DataItem("LineNumber").ToString%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal" AllowFiltering="true"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="75px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code*" SortExpression="CostCode" DataField="CostCode"
                            UniqueName="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" Width="100%" runat="server"
                                    OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged" EnableItemCaching="true"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="False" AutoPostBack="false" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>">
                                    </asp:CustomValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" DataField="UOM"
                            GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlUOM" Height="300px" runat="server" Skin="Default"
                                    Filter="Contains" MarkFirstMatch="true" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" SortExpression="Quantity"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="65px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" SortExpression="UnitCost" DataField="UnitCost"
                            GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <%--            <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField ="ExtCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                              
                            <span><%#FormatCurrency(Container.DataItem("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" 
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>


                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Project Budget" UniqueName="ProjectBudget"
                            SortExpression="ProjectBudget" GroupByExpression="ProjectBudget [GridColumn_ProjectBudget] Group By ProjectBudget ASC" DataField="ProjectBudget">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("ProjectBudget"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProjectBudget" CssClass="Currency" runat="server" Width="100%"
                                    MaxLength="15" Text='<%#FormatCurrency(Eval("ProjectBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="65px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostTypeId] Group By CostType ASC"
                            UniqueName="CostTypeId" DataField="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCostType" Height="300px" runat="server" Skin="Default"
                                    Filter="Contains" MarkFirstMatch="true" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded" DataField="Funded" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            GroupByExpression="Funded [GridColumn_Funded] Group By Funded">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnGenerateFunding" CssClass="SearchButton" Text="" runat="server" style="float:left">
                            <span class="Icon"></span>
                                </asp:LinkButton>
                                <span><%#FormatCurrency(Container.DataItem("Funded"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFunded" runat="server"
                                    Text='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="80%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Price" SortExpression="UnitPrice" UniqueName="UnitPrice"
                            GroupByExpression="UnitPrice [GridColumn_UnitPrice] Group By UnitPrice ASC" DataField="UnitPrice">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("UnitPrice")), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitPrice" MaxLength="15" CssClass="Currency" runat="server"
                                    Text='<%#FormatCurrency(Eval("UnitPrice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="65px"></HeaderStyle>
                            <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Owner Budget" SortExpression="OwnerBudget"
                            UniqueName="OwnerBudget" GroupByExpression="OwnerBudget [GridColumn_OwnerBudget] Group By OwnerBudget ASC" DataField="OwnerBudget">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("OwnerBudget")), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOwnerBudget" MaxLength="15" CssClass="Currency" runat="server"
                                    Text='<%#FormatCurrency(Eval("OwnerBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                            <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Company" SortExpression="CompanyName" DataField="CompanyName" UniqueName="Company"
                            GroupByExpression="CompanyName [GridColumn_Company] Group By CompanyName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CompanyName") = String.Empty, "&nbsp;", Container.DataItem("CompanyName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlCompanies" Width="85%" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                        CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true" OnClientItemsRequesting="GetValueToReturn"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Height="400px" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed"
                                        OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton">
                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" DataField="PeriodId"
                            GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="75px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Location" SortExpression="Location" UniqueName="Location" DataField="Location"
                            GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLocations" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="140px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" SortExpression="Notes" DataField="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
<span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase" DataField="Phase"
                            HeaderStyle-Width="150px" SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" Height="200px" CloseDropDownOnBlur="true" OnClientItemsRequesting="GetValueToReturn"
                                    Width="100%" NoWrap="true" CausesValidation="False" EnableLoadOnDemand="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                          <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="85%" AutoPostBack="false" OnClientItemsRequesting="GetValueToReturn"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" Style="margin-left: -8px" Height="250px">
                                    </telerik:RadComboBox>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Ldgr ID" Groupable="false" UniqueName="CostLdgrID" Visible="false">
                            <ItemTemplate>
                                &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCostLdgrID" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName"
                            GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC" SortExpression="TaskName">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains" DropDownWidth="463px"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True" AllowCustomText="true" OnClientItemsRequesting="GetValueToReturn"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ddlTasks_SelectedIndexChanged"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Start" SortExpression="StartDate" UniqueName="StartDate" DataField="StartDate"
                            GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblStart" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStart"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Finish" SortExpression="FinishDate" UniqueName="FinishDate" DataField="FinishDate"
                            GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblFinish" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFinish"
                                    onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                    runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Curve" SortExpression="CurveType" DataField="CurveType"
                            UniqueName="CurveType" GroupByExpression="CurveType [GridColumn_CurveType] Group By CurveType ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CurveType") = String.Empty, "&nbsp;", Container.DataItem("CurveType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlCurves" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Height="200px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
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

                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="false" UniqueName="UnitCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitCostConverted" DataField="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <%--                <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible="false" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCostConverted"  DataField ="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               &nbsp;
                                </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" Visible="false" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1Converted" DataField="Adjustment1Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment1Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax Converted" Visible="false" UniqueName="TaxConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TaxConverted" DataField="TaxConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" Visible="false" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2Converted" DataField="Adjustment2Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment2Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Project Budget Converted" Visible="false" UniqueName="ProjectBudgetConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ProjectBudgetConverted" DataField="ProjectBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ProjectBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblProjectBudgetConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Funding Converted" SortExpression="FundedConverted" UniqueName="FundedConverted" DataField="FundedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" Visible="false" 
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("FundedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                               
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Price Converted" Visible="false" UniqueName="UnitPriceConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitPriceConverted" DataField="UnitPriceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("UnitPriceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitPriceConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Owner Budget Converted" Visible="false" UniqueName="OwnerBudgetConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="OwnerBudgetConverted" DataField="OwnerBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("OwnerBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblOwnerBudgetConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgBudgetRequestDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1" SecurityButtonType="AddEditMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count > 0 Or rdgBudgetRequestDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add Risk"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddCostCodes" CommandName="AddCostCodes" CssClass="GridCmdAddCostCodes" runat="server" CausesValidation="False"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddCostCodes" meta:resourcekey="lblAddCostCodes" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1"
                                SecurityButtonType="ItemMode_Delete">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1"
                                SecurityButtonType="ItemMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted)%>' ToolTip="Export to Excel">
                                <span class="Icon"></span>
                                <asp:Label ID="Label12" Text="Export To Exel" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <span style="width: 100%; text-align: right">
                                <asp:CheckBox runat="server" ID="ckbUseUnits" Style="line-height: 14px" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit"
                                    Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted) %>' />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false" CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                                <asp:Button runat="server" ID="btnEditRowsFromCostCodesPopup" CommandName="EditRowsFromCostCodesPopup" CausesValidation="false"
                                    CssClass="Hide" />
                            </span>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgBudgetRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetRequestDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="True" AllowRowsDragDrop="False">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>

<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />