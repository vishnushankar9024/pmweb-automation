<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Submittals.ascx.vb"
    Inherits="Website.Submittals" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSubmittals">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSubmittals" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />
<telerik:RadAjaxPanel ID="pnlSubmittals" runat="server">
    <div class="PMHeader">
        <div class="row">
            <div class="col-12 ResponsiveMargin">
                <telerik:RadGrid ID="rdgSubmittals" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                    AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15" CssClass="WithoutTopBorder"
                    AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                    AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" UseEditFormInMobile="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true" Width="100%"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                        TableLayout="Fixed">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="CSI Code"
                                SortExpression="CSICode"
                                GroupByExpression="CSICodeId [GridColumn_CSICodeId] Group By CSICodeId"
                                UniqueName="CSICodeId" CurrentFilterFunction="Contains" DataField="CSICodeId"
                                DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "CSICodeId")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "CSICodeId")), "&nbsp;", DataBinder.Eval(Container.DataItem, "CSICodeId"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <%--<telerik:RadComboBox ID="ddlCSICode" runat="server" Filter="Contains" MarkFirstMatch="True"
                            Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                            CausesValidation="False" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>--%>
                                    <asp:TextBox ID="txtCSICode" runat="server" Width="100%" Text='<%# Eval("CSICodeId") %>' MaxLength="100"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
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
                                    <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "("+Eval("AttachmentTotal").ToString()+")")%></span>
                                </EditItemTemplate>
                                <HeaderStyle Width="75px" />
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Company"
                                SortExpression="Company" UniqueName="Company"
                                CurrentFilterFunction="Contains" DataField="Company" DataType="System.String"
                                AutoPostBackOnFilter="true" FilterListOptions="VaryByDataType"
                                GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="80%" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged2"
                                            OnClientDropDownClosed="dllcompClientClosed2"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:LinkButton runat="server" ID="imgfilter2"
                                            OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter2','HiddenField3'),this.id.replace('imgfilter2','ddlCompanies'),'Companies')"
                                            CssClass="SearchButton">
                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField3" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Sub #" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="DocNumber" DataType="System.String" FilterListOptions="VaryByDataType"
                                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" SortExpression="DocNumber"
                                HeaderStyle-Wrap="false" GroupByExpression="DocNumber [GridColumn_DocNumber] Group By DocNumber" UniqueName="DocNumber">
                                <ItemTemplate>
                                    <span><%#DataBinder.Eval(Container.DataItem, "DocNumber")%> &nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDocNumber" runat="server" Width="100%" Text='<%# Eval("DocNumber") %>' MaxLength="100"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Item" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="ItemId" DataType="System.String" FilterListOptions="VaryByDataType"
                                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" SortExpression="ItemId"
                                HeaderStyle-Wrap="false" GroupByExpression="ItemId [GridColumn_ItemId] Group By ItemId" UniqueName="ItemId">
                                <ItemTemplate>
                                    <asp:Label ID="lblItemItemTemplate" runat="server" Text='<%#IIf(Eval("ItemId") = "0", "&nbsp;", Eval("ItemId").toString)%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblItemEditItemTemplate" runat="server"></asp:Label>
                                    <input type="hidden" id="hdItemId" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Submittal Item #" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="SubItemCode" DataType="System.String" FilterListOptions="VaryByDataType"
                                HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" SortExpression="SubItemCode"
                                HeaderStyle-Wrap="false" GroupByExpression="SubItemCode [GridColumn_SubItemCode] Group By SubItemCode" UniqueName="SubItemCode">
                                <ItemTemplate>
                                    <a href='<%# iif(IsDBNull(Eval("SubmittalItemId")),"#","SubmittalsItem.aspx?Id=" & Eval("SubmittalItemId") & "&ModuleId=2&PageId=235")  %>'>
                                        <asp:Label ID="lblsubItem" runat="server" Text='<%#iif(IsDBNull(Eval("SubmittalItemId")), "",Eval("SubItemCode"))%>'></asp:Label>
                                    </a>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblEditsubItem" runat="server" Text='<%#iif(IsDBNull(Eval("SubmittalItemId")),"&nbsp;",Eval("SubItemCode"))%>'></asp:Label>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Phase"
                                SortExpression="PhaseName" UniqueName="PhaseName"
                                CurrentFilterFunction="Contains" DataField="PhaseName" DataType="System.String"
                                AutoPostBackOnFilter="true" FilterListOptions="VaryByDataType"
                                GroupByExpression="PhaseName [GridColumn_PhaseName] Group By PhaseName ASC">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlPhases" runat="server" Width="80%"  Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Phase..."
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Description" DataType="System.String" FilterListOptions="VaryByDataType"
                                GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description">
                                <ItemTemplate>
                                    <span>
                                        <%#Eval("Description")%>
                        &nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" Width="100%" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Category" SortExpression="Category" DataField="Category"
                                GroupByExpression="Category [GridColumn_Category] Group By Category"
                                UniqueName="Category">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCategory" runat="server" AllowCustomText="True" AutoPostBack="False"
                                        CausesValidation="False" Filter="Contains" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        MarkFirstMatch="True" NoWrap="True" Skin="Default" Width="100%">
                                        <CollapseAnimation Duration="150" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Mfr." CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Manufacturer" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="ManufacturerId" GroupByExpression="Manufacturer [GridColumn_ManufacturerId] Group By Manufacturer"
                                UniqueName="ManufacturerId">
                                <ItemTemplate>
                                    <span>
                                        <%#Eval("Manufacturer")%>
                        &nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="80%" 
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlManufacturer'),'Companies')"
                                            CssClass="SearchButton">
                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Mfr. #" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="ManufacturerNumber" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="ManufacturerNumber"
                                GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber" UniqueName="ManufacturerNumber">
                                <ItemTemplate>
                                    <span><%#IIf(Not IsDBNull(Container.DataItem("ManufacturerNumber")) AndAlso String.IsNullOrWhiteSpace(Container.DataItem("ManufacturerNumber")), "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtManufacturerNumber" Width="100%" MaxLength="50" runat="server"
                                        Text='<%# Eval("ManufacturerNumber") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Supplier" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Supplier" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="Supplier" GroupByExpression="Supplier [GridColumn_SupplierId] Group By Supplier"
                                UniqueName="SupplierId">
                                <ItemTemplate>
                                    <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Supplier")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Supplier")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Supplier"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlSupplier" runat="server" Width="80%"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                                            OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:LinkButton runat="server" ID="imgfilter1" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlSupplier'),'Companies')"
                                            CssClass="SearchButton">
                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Rev." CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="Revision" DataType="System.Int32" FilterListOptions="VaryByDataType"
                                SortExpression="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                                UniqueName="Revision">
                                <ItemTemplate>
                                    <span><%#Eval("Revision")%>&nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtRevision" MaxLength="9" CssClass="PositiveInteger" Width="100%" runat="server"
                                        Text='<%# Eval("Revision") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Status"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Status" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="Status" GroupByExpression="Status [GridColumn_StatusId] Group By Status"
                                UniqueName="StatusId">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlStatus" Width="100%" runat="server" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Task" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Task" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="Task" GroupByExpression="Task [GridColumn_Task] Group By Task"
                                UniqueName="Task">
                                <ItemTemplate>
                                    <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Task")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Task")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Task"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlTask" runat="server" Width="100%"  Filter="Contains" DropDownWidth="463px"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..."
                                        NoWrap="True" AllowCustomText="true"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="SubmittalddlTasksSelectedIndexChanged"
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
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Start Date"
                                CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="TaskStartDate" DataType="System.DateTime"
                                Groupable="false" UniqueName="TaskStartDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblTaskDate" runat="server"></asp:Label>

                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblTaskDate" runat="server"></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnStart" />
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Finish Date"
                                CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="TaskFinishDate" DataType="System.DateTime"
                                Groupable="false" UniqueName="TaskFinishDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblTaskFinishDate" runat="server"></asp:Label>
                                    &nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblTaskFinishDate" runat="server"></asp:Label>
                                    &nbsp;
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Lead Time"
                                CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="LeadTime" DataType="System.Int32"
                                UniqueName="LeadTime" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="LeadTime [GridColumn_LeadTime] Group By LeadTime ASC" SortExpression="LeadTime">
                                <ItemTemplate>
                                    <span><%#iif(IsDBNull(Container.DataItem("LeadTime")),0,Container.DataItem("LeadTime"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLeadTime" runat="server" Width="100%" CssClass="Integer"
                                        MaxLength="5" Text='<%#IIF(Eval("LeadTime") is system.DBNULL.value, "0", Eval("LeadTime")) %>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Due Date" SortExpression="DueFromDate" GroupByExpression="DueFromDate [GridColumn_DueFromDate] Group By DueFromDate"
                                UniqueName="DueFromDate" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="DueFromDate" DataType="System.DateTime">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("DueFromDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                        Width="100%" Skin="Default"
                                        EnableTyping="True">
                                        <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                            runat="server">
                                        </DateInput>
                                        <Calendar ID="Calendar3" Skin="Default" runat="server">
                                        </Calendar>
                                    </telerik:RadDatePicker>

                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Received" SortExpression="ReceivedDate" GroupByExpression="ReceivedDate [GridColumn_ReceivedDate] Group By ReceivedDate"
                                UniqueName="ReceivedDate" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="ReceivedDate" DataType="System.DateTime">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("ReceivedDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtReceivedDate" Width="100%" Text='<%#FormatDate(Eval("ReceivedDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Sent"
                                CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="SentDate" DataType="System.DateTime"
                                SortExpression="SentDate" GroupByExpression="SentDate [GridColumn_SentDate] Group By SentDate"
                                UniqueName="SentDate">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("SentDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSentDate" Width="100%" Text='<%#FormatDate(Eval("SentDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <%--<ItemStyle HorizontalAlign="Left"></ItemStyle>--%>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Return Due" SortExpression="ReturnDueDate" GroupByExpression="ReturnDueDate [GridColumn_ReturnDueDate] Group By ReturnDueDate"
                                UniqueName="ReturnDueDate" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="ReturnDueDate" DataType="System.DateTime">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("ReturnDueDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtReturnDueDate" Width="100%" Text='<%#FormatDate(Eval("ReturnDueDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>

                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Days Overdue" AllowFiltering="false" SortExpression="DaysOverdue" GroupByExpression="DaysOverdue [GridColumn_DaysOverdue] Group By DaysOverdue"
                                UniqueName="DaysOverdue">
                                <ItemTemplate>
                                    <asp:Label ID="lblDaysOverdue" runat="server"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblDaysOverdue" runat="server"></asp:Label>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Returned Date" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="ReturnedDate" DataType="System.DateTime"
                                SortExpression="ReturnedDate" GroupByExpression="ReturnedDate [GridColumn_ReturnedDate] Group By ReturnedDate"
                                UniqueName="ReturnedDate">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("ReturnedDate")) %> &nbsp;</span>

                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtReturnedDate" Width="100%" Text='<%#FormatDate(Eval("ReturnedDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Days +/-" AllowFiltering="false" SortExpression="DaysPlusMinus" GroupByExpression="DaysPlusMinus [GridColumn_DaysPlusMinus] Group By DaysPlusMinus"
                                UniqueName="DaysPlusMinus">
                                <ItemTemplate>
                                    <asp:Label ID="lblDaysPlusMinus" runat="server"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblDaysPlusMinus" runat="server"></asp:Label>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Forward Due" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="ForwardDueDate" DataType="System.DateTime" SortExpression="ForwardDueDate"
                                GroupByExpression="ForwardDueDate [GridColumn_ForwardDueDate] Group By ForwardDueDate" UniqueName="ForwardDueDate">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("ForwardDueDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtForwardDueDate" Width="100%" Text='<%#FormatDate(Eval("ForwardDueDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Forwarded Date" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"
                                DataField="ForwardedDate" DataType="System.DateTime"
                                SortExpression="ForwardedDate" GroupByExpression="ForwardedDate [GridColumn_ForwardedDate] Group By ForwardedDate"
                                UniqueName="ForwardedDate">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("ForwardedDate")) %> &nbsp;</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtForwardedDate" Width="100%" Text='<%#FormatDate(Eval("ForwardedDate"))%>'
                                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                                        runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Review Task"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="ReviewTask" DataType="System.String"
                                SortExpression="ReviewTask" GroupByExpression="ReviewTask [GridColumn_ReviewTask] Group By ReviewTask"
                                UniqueName="ReviewTask">
                                <ItemTemplate>
                                    <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "ReviewTask")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "ReviewTask")), "&nbsp;", DataBinder.Eval(Container.DataItem, "ReviewTask"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlReviewTask" runat="server" Width="100%" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..."
                                        NoWrap="True" AllowCustomText="true"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested"
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
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Notes"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="Notes" DataType="System.String"
                                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                                UniqueName="Notes">
                                <ItemTemplate>
                                    <span><%#IIf(Not IsDBNull(Container.DataItem("Notes")) AndAlso Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%">
                                        <asp:TextBox ID="txtNotes" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                        <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                            CssClass="SearchButton">
                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="RFI #"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="RFIs" DataType="System.String"
                                HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Right"
                                HeaderStyle-Wrap="false" Groupable="false" Reorderable="true" UniqueName="RFIs">
                                <ItemTemplate>
                                    <asp:Label ID="lblRFIsItemTemplate" runat="server" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "RFIs")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "RFIs")), "&nbsp;", Eval("RFIs"))%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblRFIsEditItemTemplate" runat="server" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "RFIs")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "RFIs")), "&nbsp;", Eval("RFIs"))%>'></asp:Label>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <%--                <telerik:GridTemplateColumn HeaderText="Transmittal" SortExpression="TransmittleCode" GroupByExpression="TransmittleCode [GridColumn_Transmittal] Group By TransmittleCode"
                    UniqueName="Transmittal">
                    <ItemTemplate>
                       <asp:HyperLink ID="hliTransmittal" runat="server" CssClass="NoWrap,Link"
             Text='<%#IIf(Container.DataItem("TransmittleCode") = 0, "&nbsp;", Container.DataItem("TransmittleCode").ToString.PadLeft(3, "0"c))%>'
              NavigateUrl='<%# CStr(Container.DataItem("TransmittleLink"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                              <span>        
                     <%#Eval("TransmittleCode").ToString.PadLeft(3, "0"c)%>
                       &nbsp;</span>    
                    </EditItemTemplate>
                    <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>--%>
                            <telerik:GridTemplateColumn HeaderText="Workflow Status"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                DataField="DocStatusName" DataType="System.String"
                                SortExpression="DocStatusName" GroupByExpression="DocStatusName [GridColumn_DocStatusName] Group By DocStatusName"
                                UniqueName="DocStatusName">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("DocStatusName") = String.Empty, "&nbsp;", Container.DataItem("DocStatusName"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <span>
                                        <asp:Label ID="LblDocStatusName" Text='<%#Eval("DocStatusName")%>' runat="server"></asp:Label>

                                        &nbsp;</span>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field1"
                                AllowFiltering="false"
                                GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field2"
                                CurrentFilterFunction="Contains" AllowFiltering="false"
                                GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field3"
                                AllowFiltering="false"
                                GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field4"
                                AllowFiltering="false"
                                GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field5"
                                AllowFiltering="false"
                                GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field6"
                                CurrentFilterFunction="Contains" AllowFiltering="false"
                                GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field7"
                                AllowFiltering="false"
                                GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field8"
                                AllowFiltering="false"
                                GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field9"
                                AllowFiltering="false"
                                GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field10"
                                AllowFiltering="false"
                                GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">

                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 AND (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgSubmittals.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgSubmittals.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgSubmittals.EditIndexes.Count > 0 Or rdgSubmittals.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False"
                                    Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'
                                    SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('Document_ItemsSelect.aspx?Type=0',900,600,true)">
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAddSubmittalItems" OnClientClick="return OpenSubmittalPopup();" runat="server" CausesValidation="False" CommandName="AddSubmittalItems" CssClass="GridCmdAddSubmittalItems"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 AND (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddSubmittalItems" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                    Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnGenerateSubmittal" runat="server"
                                    SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="GenerateSubmittal" CssClass="GridCmdGenerateSubmittal"
                                    Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblGenerateSubmittal" runat="server"></asp:Label>
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
                    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true"
                        ColumnsReorderMethod="Reorder" AllowDragToGroup="true" AllowRowsDragDrop="false">
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True"></Resizing>
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
</telerik:RadAjaxPanel>
<input type="hidden" id="hdClipboard" runat="server" />
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClosedItems" runat="server" />
<input type="hidden" id="hdTotalRowCount" runat="server" />