<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DailyReportTimeSheet.ascx.vb" Inherits="Website.DailyReportTimeSheet" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RamDailyTimesheet" runat="server">
    <AjaxSettings>
       <telerik:AjaxSetting AjaxControlID="rdgDailyReportTimesheet">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDailyReportTimesheet" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadGrid ID="rdgDailyReportTimesheet" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                  HeaderStyle-Font-Size="8" Width="100%" CssClass="WithoutTopBorder" UseEditFormInMobile ="true"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="15"
                AllowPaging="True" ShowFooter="false" ShowGroupPanel="True">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"  EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" DataField="LineNumber"
                            SortExpression="LineNumber" Groupable="false" Reorderable="true" allowfiltering="false">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("LineNumber").ToString%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn HeaderText="Resource" HeaderStyle-HorizontalAlign="left" DataField="Resource"
                            HeaderStyle-Width="150px" UniqueName="Resource" SortExpression="Resource" GroupByExpression="Resource [GridColumn_Resource] Group By Resource ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Resource").ToString = String.Empty, "&nbsp;", Container.DataItem("Resource").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                  <telerik:RadComboBox
                                        ID="ddlResources" runat="server" Height="200px"  Skin="Default" Width="100%" DropDownWidth="220px"
                                        CloseDropDownOnBlur="true" meta:resourcekey="ddlResources" EmptyMessage="Select Resource..." NoWrap="False"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                    GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                        </asp:HyperLink>
                        <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                           EnableItemCaching="true" AllowCustomText="False"
                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                            NoWrap="True"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" 
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                      </EditItemTemplate>
                     <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn SortExpression="TaskName"
                              HeaderText="Task" UniqueName="TaskName" DataField="TaskName" GroupByExpression="TaskName [GridColumn_TaskName] Group By TaskName ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("TaskName") = string.Empty , "&nbsp;", Container.DataItem("TaskName"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" 
                            NoWrap="True" AllowCustomText="true" meta:resourcekey="ddlTasks"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
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
                             <telerik:GridTemplateColumn HeaderText="% Complete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                             UniqueName="PctComplete" SortExpression="PctComplete" DataField="PctComplete" >
                            <ItemTemplate>
                                <span><%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctComplete" runat="server" Width="100%" CssClass="Percent"
                                    MaxLength="15"  MinNumber="0" MaxNumber="100" Text='<%# FormatPercent(IIF(Eval("PctComplete") is system.DBNULL.value, "0", Eval("PctComplete"))) %>'
                                   ></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn HeaderText="Classification" SortExpression="Classification" UniqueName="Classification"
                            GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC" DataField="Classification">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Classification") = "", "&nbsp;", Container.DataItem("Classification"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%"  DropDownWidth="200px"  meta:resourcekey="ddlResourceClasses"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                    NoWrap="True"  EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="180px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Pay Type" SortExpression="PayType" UniqueName="PayType" DataField="PayType"
                            GroupByExpression="PayType [GridColumn_PayType] Group By PayType ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("PayType") = "", "&nbsp;", Container.DataItem("PayType"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlResourcePayTypes" runat="server" Width="100%"  DropDownWidth="150px" meta:resourcekey="ddlResourcePayTypes"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                               <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate" 
                                HeaderStyle-Width="90px" SortExpression="StartDate" DataField="StartDate"
                                GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("StartDate"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="DateSelected" ID="tpStartTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                </EditItemTemplate>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="FinishDate" DataField ="FinishDate"
                                HeaderStyle-Width="90px" SortExpression="FinishDate"  
                               GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate ASC">
                                <ItemTemplate>
                                    <span><%#FormatTime(Container.DataItem("FinishDate"))%>&nbsp;</span> 
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadTimePicker ClientEvents-OnDateSelected="DateSelected" ID="tpFinishTime"
                                        runat="server" Skin="Default" Width="100%">
                                    </telerik:RadTimePicker>
                                </EditItemTemplate>
                                <ItemStyle Wrap="false" />
                       </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn UniqueName="Hours" HeaderText="Hours" HeaderStyle-Wrap="false"
                             HeaderStyle-Width="60px" SortExpression="Hours" DataField="Hours"
                            GroupByExpression="Hours [GridColumn_Hours] Group By Hours">
                            <ItemTemplate>
                                <span>
                                    <%#FormatNumber(IIf(Eval("Hours") Is System.DBNull.Value, "0", Eval("Hours")))%>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtHours" runat="server" Width="100%" CssClass="PositiveDouble"
                                    MaxLength="15" MinNumber="0" Text='<%#FormatNumber(IIF(Eval("Hours") is system.DBNULL.value, "0", Eval("Hours"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterStyle HorizontalAlign="Right"></FooterStyle>
                            <ItemStyle HorizontalAlign="Right" Wrap="False" Width="60px"></ItemStyle>
                        </telerik:GridTemplateColumn>

                     
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description"
                            UniqueName="Description">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="255" runat="server" Text='<%# Eval("Description") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                                   <telerik:GridTemplateColumn HeaderText="Req. Code" SortExpression="ReqCodeName" UniqueName="ReqCode"
                    GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC" DataField="ReqCodeName" >
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                             <telerik:RadComboBox ID="ddlReqCodes" Runat="server"  AllowCustomText="false"
                                Skin="Default" CloseDropDownOnBlur="true" Width="100%" DropDownWidth="300px" AutoPostBack="false" NoWrap="true"
                                height="250px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                                <Items>
                                    <telerik:RadComboBoxItem Text="" /> 
                                </Items>
                                <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvReqNodeClicking"
                                            OnNodeDataBound="rdvReqCode_NodeDataBound" OnNodeExpand="rdvReqCode_NodeExpand" >
                                        </telerik:RadTreeView> 
                                </ItemTemplate>                   
                            </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemStyle Wrap="false" />
                     <HeaderStyle Width="200px"></HeaderStyle>
               </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false" DataField="Notes"
                            HeaderStyle-Width="150px" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
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
                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Id" Visible="False" />
                        
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                    <div style="padding: 2px">
                            
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count = 0 AND (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgDailyReportTimesheet.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count > 0 Or rdgDailyReportTimesheet.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                              <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count = 0 AND (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count = 0 AND (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                             <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count = 0 AND (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            &nbsp;&nbsp;
                            </asp:LinkButton>

<%--                         <asp:Button ID="btnAddResources" runat="server" CausesValidation="False" CommandName="ChangeOrders"
                                SecurityButtonType="ItemMode_Add" Text="Add Rsources" meta:resourcekey="btnAddResources"
                                Visible='<%# rdgDailyReportTimesheet.EditIndexes.Count = 0 AND (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenResourcePopup(); " />--%>

                        <asp:LinkButton ID="btnAddResource" runat="server"  CausesValidation="False" CommandName="TimeSheetAddResources"  CssClass="GridCmdTimeSheetAddResources"
                                    SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=DailyReportTimeSheet',900,540,true)"
                                    Visible='<%# (rdgDailyReportTimesheet.EditIndexes.Count = 0 And (Not rdgDailyReportTimesheet.MasterTableView.IsItemInserted))%>'
                                    meta:resourcekey="btnAddResource1">
                                     <span class="Icon"></span>
                                    <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
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
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
                </ClientSettings>
                <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true"
                    ValidationGroup="WorkOrder" />
            </telerik:RadGrid>