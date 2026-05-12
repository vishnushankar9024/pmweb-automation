<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TaskAdvancedDetails.aspx.vb" Inherits="Website.TaskAdvancedDetails" Title="Task Details"  meta:resourcekey="Page"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="DocumentCheckList.ascx" tagname="DocumentCheckList" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <asp:PlaceHolder ID="phVariables" runat="server"></asp:PlaceHolder>
    <telerik:RadCodeBlock ID="CodeBlock2" runat="server">
         <script type="text/javascript">
             function GetReferenceTelerikControls() {
                 RemDuration = $find("<%=rnbRemDuration.ClientID%>");
                 Duration = $find("<%=rnbDuration.ClientID%>");
                 OriginalDuration = $find("<%=rnbOriginalDuration.ClientID%>");
                 S = $find("<%= rdiStart.ClientID %>");
                 F = $find("<%= rdiFinish.ClientID %>");
                 AS = $find("<%= rdiActualStart.ClientID %>");
                 AF = $find("<%= rdiActualFinish.ClientID %>");
                 BS = $find("<%= rdiBaselineStart.ClientID %>");
                 BF = $find("<%= rdiBaselineFinish.ClientID %>");
             }
         </script>
     </telerik:RadCodeBlock>
    <script src="JS/Scheduling/TaskAdvancedDetails.js" type="text/javascript"></script>
    <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
     <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" >
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgPredecessors">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgPredecessors" LoadingPanelID="ldprdg" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgSuccessors">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgSuccessors" LoadingPanelID="ldprdg" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgResources">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldprdg" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldprdg" runat="server" Skin="Default" />
        <asp:PlaceHolder ID="phCalendars" runat="server"></asp:PlaceHolder>
         <telerik:RadDatePicker ID="RadDatePicker2" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default" >
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
     <table style="width: 100%; padding: 0px;" cellspacing="0">
       <tr >
            <td>
                <telerik:RadTabStrip ID="tbsAdvancedDetails" SelectedIndex="0"
                    runat="server" MultiPageID="mlpAdvancedDetails" Skin="Default" 
                    EnableViewState="False" CausesValidation="False" Width="100%">
                    <Tabs>
                        <telerik:RadTab Value="General" Selected="True" Text="General"/>
                        <telerik:RadTab Value="Predecessors" Text="Predecessors"/>
                        <telerik:RadTab Value="Successors" Text="Successors"/>
                        <telerik:RadTab Value="Resources" Text="Resources"/>
                         <telerik:RadTab Value="Checklists" Text="Checklists"/>
                        <telerik:RadTab Value="Codes" Text="Codes"/>
                        <telerik:RadTab Value="TaskNotes" Text="Notes"/>
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadMultiPage ID="mlpAdvancedDetails" runat="server" SelectedIndex="0" Width="100%">
                    <telerik:RadPageView ID="pvGeneral" runat="server" Selected="True">
                        <div>
                        <fieldset style="height:407px; "><legend><asp:Label ID="lblGeneral" runat="server" meta:resourcekey="lblGeneral" Text="General"></asp:Label></legend>
                                <table style="width: 100%; " cellspacing="0" border="0">
                                    <tr>
                                        <td style="width:135px;padding-left: 10px;"><asp:Label ID="lblTaskCode" runat="server" meta:resourcekey="lblTaskCode" Text="Code"></asp:Label></td>
                                        <td style="width:125px;"><asp:TextBox ID="txtTaskCode" MaxLength="100" runat="server" style="width:100%"></asp:TextBox></td>
                                        <td style="width:40px"></td>
                                         <td style="width:131px"><asp:Label ID="lblSummary" runat="server" meta:resourcekey="lblSummary" Text="Summary"></asp:Label></td>
                                        <td style="width:125px">
                                                <telerik:RadComboBox ID="ddlProjectPhases" runat="server" Width="100%" Filter="Contains" DropDownWidth="150px"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                   NoWrap="True">
                                                </telerik:RadComboBox>
                                        </td>
                                        <td style="width:65px"></td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px;"><asp:Label ID="lblTask" runat="server" meta:resourcekey="lblTask" Text="Task"></asp:Label></td>
                                        <td colspan="4"><asp:TextBox MaxLength="1000" ID="txtTask" runat="server" style="width:100%"></asp:TextBox></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px;"><asp:Label ID="lblStart" runat="server" meta:resourcekey="lblStart" Text="Start" ></asp:Label></td>
                                        <td><telerik:RadDateInput runat="server" ID="rdiStart" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                    OnClientDateChanged="StartChanged"></telerik:RadDateInput>
                                        </td>
                                        <td style="width:45px"></td>
                                        <td><asp:Label ID="lblFinish" runat="server" meta:resourcekey="lblFinish" Text="Finish"></asp:Label></td>
                                        <td><telerik:RadDateInput runat="server" ID="rdiFinish" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                    OnClientDateChanged="FinishChanged"></telerik:RadDateInput>
                                            </td>
                                        <td ></td>
                                    </tr>
                                    <tr>
                                       <td style="padding-left: 10px;"><asp:Label ID="lblPctComplete" runat="server" meta:resourcekey="lblPctComplete" Text="Complete"></asp:Label></td>
                                        <td><asp:TextBox ID="txtPctComplete" MaxLength="15" runat="server" CssClass="PositiveDouble" style="width:100%" onchange="PctCompleteChanged();"></asp:TextBox></td>
                                        <td></td>
                                         <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td ></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="lblDuration" runat="server" meta:resourcekey="lblDuration" Text="Dur."></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadNumericTextBox ID="rnbDuration" runat="server" EmptyMessage="" Font-Size="8px"
                                                ShowSpinButtons="True" Skin="Default" Type="Number" width="50%" MinValue="0">
                                                <ClientEvents OnValueChanged="DurationSpin" />
                                            </telerik:RadNumericTextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <asp:Label ID="lblRemDuration" runat="server" meta:resourcekey="lblRemDuration" Text="Rem. Duration"></asp:Label>
                                        </td>
                                        <td>
                                             <telerik:RadNumericTextBox ID="rnbRemDuration" runat="server" EmptyMessage="" Font-Size="8px"
                                                ShowSpinButtons="True" Skin="Default" Type="Number" width="50%" MinValue="0">
                                                <ClientEvents OnValueChanged="RemDurationSpin" />
                                            </telerik:RadNumericTextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="lblCost" runat="server" meta:resourcekey="lblCost" Text="Cost"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCost" MaxLength="15" runat="server" CssClass="PositiveDouble"   onchange="CostChanged();"
                                                style="width:100%"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRevenue" runat="server" meta:resourcekey="lblRevenue" Text="Revenue"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRevenue" MaxLength="15" runat="server" CssClass="PositiveDouble"  onchange="RevenueChanged();"
                                                style="width:100%"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                                <fieldset title="Baseline" ><legend><asp:Label ID="lblBaseline" runat="server" meta:resourcekey="lblBaseline" Text="Baseline"></asp:Label></legend>
                                   <table style="width: 100%;" cellspacing="0" border="0">


                                    <tr>
                                        <td style="width: 20%;" ><asp:Label ID="lblBaselineStart" runat="server" meta:resourcekey="lblBaselineStart" Text="Baseline Start" ></asp:Label></td>
                                        <td style="width: 30%;" >
                                            <telerik:RadDateInput runat="server" ID="rdiBaselineStart" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                                   OnClientDateChanged="BaselineStartChanged">
                                            </telerik:RadDateInput>
                                        </td>
                                        <td style="width: 19%;"><asp:Label ID="lblBaselineFinish" runat="server" meta:resourcekey="lblBaselineFinish" Text="Baseline Finish"></asp:Label></td>
                                        <td style="width: 36%;" >
                                            <telerik:RadDateInput runat="server" ID="rdiBaselineFinish" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                                   OnClientDateChanged="BaselineFinishChanged">
                                            </telerik:RadDateInput>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblOriginalDuration" runat="server" meta:resourcekey="lblOriginalDuration" Text="Original Duration"></asp:Label></td>
                                        <td><telerik:RadNumericTextBox ID="rnbOriginalDuration" runat="server" EmptyMessage="" Font-Size="8px"
                                                ShowSpinButtons="True" Skin="Default" Type="Number" width="40%">
                                                <ClientEvents OnValueChanged="OriginalDurationSpin" />
                                            </telerik:RadNumericTextBox>
                                            
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                   </table>
                                </fieldset>
                                <fieldset title="Actual" ><legend><asp:Label ID="lblActual" runat="server" meta:resourcekey="lblActual" Text="Actual"></asp:Label></legend>
                                   <table style="width: 100%;" cellspacing="0" border="0">

                                    <tr>
                                        <td style="width:100px"><asp:Label ID="lblActualStart" runat="server" meta:resourcekey="lblActualStart" Text="Actual Start"></asp:Label></td>
                                        <td style="width:150px"><telerik:RadDateInput runat="server" ID="rdiActualStart" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                                   OnClientDateChanged="ActualStartChanged"></telerik:RadDateInput>
                                                                </td>
                                        <td style="width:100px"><asp:Label ID="lblActualFinish" runat="server" meta:resourcekey="lblActualFinish" Text="Actual Finish"></asp:Label></td>
                                        <td style="width:150px"><telerik:RadDateInput runat="server" ID="rdiActualFinish" MinDate="1900-1-1" MaxDate="2100-1-1" 
                                                                   OnClientDateChanged="ActualFinishChanged"></telerik:RadDateInput>

                                                                </td>
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblActualCost" runat="server" meta:resourcekey="lblActualCost" Text="Actual Cost"></asp:Label></td>
                                        <td><asp:TextBox ID="txtActualCost" runat="server" MaxLength="15" CssClass="PositiveDouble"  onchange="ActualCostChanged();"></asp:TextBox></td>
                                        <td><asp:Label ID="lblActualRevenue" runat="server" meta:resourcekey="lblActualRevenue" Text="Actual Revenue"></asp:Label></td>
                                        <td><asp:TextBox ID="txtActualRevenue" runat="server" MaxLength="15" CssClass="PositiveDouble"  onchange="ActualRevenueChanged();"></asp:TextBox></td>
                                    </tr>
                                   </table>
                                </fieldset>
                                <fieldset title="Calculation" ><legend><asp:Label ID="lblCPM" runat="server" meta:resourcekey="lblCPM" Text="CPM"></asp:Label></legend>
                                   <table style="width: 100%; " cellspacing="0" border="0">
                                    <tr>
                                        <td style="width:100px"><asp:Label ID="lblEarlyStart" runat="server" meta:resourcekey="lblEarlyStart" Text="Early Start"></asp:Label></td>
                                        <td style="width:150px"><telerik:RadDateInput runat="server" ID="rdiEarlyStart" MinDate="1900-1-1" MaxDate="2100-1-1" Enabled="false"></telerik:RadDateInput></td>
                                        <td style="width:100px"><asp:Label ID="lblEarlyFinish" runat="server" meta:resourcekey="lblEarlyFinish" Text="Early Finish"></asp:Label></td>
                                        <td style="width:150px"><telerik:RadDateInput runat="server" ID="rdiEarlyFinish" MinDate="1900-1-1" MaxDate="2100-1-1" Enabled="false"></telerik:RadDateInput></td>
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblLateStart" runat="server" meta:resourcekey="lblLateStart" Text="Late Start"></asp:Label></td>
                                        <td><asp:TextBox ID="txtLateStart" runat="server"  Enabled="false"></asp:TextBox></td>
                                        <td><asp:Label ID="lblLateFinish" runat="server" meta:resourcekey="lblLateFinish" Text="Late Finish"></asp:Label></td>
                                        <td><asp:TextBox ID="txtLateFinish" runat="server" Enabled="false" ></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td><asp:Label ID="lblTotalFloat" runat="server" meta:resourcekey="lblTotalFloat" Text="Total Float"></asp:Label></td>
                                        <td><asp:TextBox ID="txtTotalFloat" runat="server" CssClass="PositiveDouble" Enabled="false"></asp:TextBox></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                   </table>
                                </fieldset>
                            </fieldset>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvPredecessors" runat="server">
                            <fieldset style="height:390px; padding:5px"><legend><asp:Label ID="lblPredecessors" runat="server" meta:resourcekey="lblPredecessors" Text="Predecessors"></asp:Label></legend>
                             <telerik:RadGrid ID="rdgPredecessors" runat="server"   
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
                                PageSize="12" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" 
                                ItemStyle-Height="20px">
                                <PagerStyle Mode="NextPrevAndNumeric"/>
                                <GroupPanel Text="Group by"></GroupPanel>
                                <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                                    EditMode="InPlace" EnableHeaderContextMenu="true">
                                <Columns> 
                                     <telerik:GridTemplateColumn HeaderText="Task" Groupable="false" SortExpression="predecessorID" UniqueName="predecessorID">
                                        <ItemTemplate>
                                           <asp:Label ID="lblTask" runat="server"></asp:Label>
                                        </ItemTemplate>
                                      <EditItemTemplate>
                                           <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="465px"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="200px">
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
                                        <HeaderStyle Width="60%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                                    
                                     <telerik:GridTemplateColumn HeaderText="Depend. Type" Groupable="false" SortExpression="TaskDepType" UniqueName="Type">
                                        <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTaskDepType"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlDependTypes" runat="server">
                                            <asp:ListItem Text='<%$Resources:DependTypes_fs %>' Value="fs"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_ff %>' Value="ff"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_sf %>' Value="sf"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_ss %>' Value="ss"></asp:ListItem>
                                          </asp:DropDownList>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="30%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>

                                   <telerik:GridTemplateColumn HeaderText="Lag" Groupable="false" SortExpression="Lag" UniqueName="Lag">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Lag")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtLag" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn> 
                                  <telerik:GridTemplateColumn HeaderText="Float" Groupable="false" SortExpression="Float" UniqueName="Float">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Float")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFloat" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>   
                                </Columns>
                                <ItemStyle Wrap="false" HorizontalAlign="Left"/>
                                <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="PredecessorId"></telerik:GridSortExpression>
                                </SortExpressions>
                                <CommandItemTemplate> 
                                    <div style="padding:2px">
                                        &nbsp;&nbsp;
                                         <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" 
                                            SecurityButtonType="AddEditMode_Add"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  Visible='<%# rdgPredecessors.MasterTableView.IsItemInserted %>'>
                                           <span class="Icon"></span>
                                           <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                                            SecurityButtonType="AddEditMode"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgPredecessors.EditIndexes.Count > 0 Or rdgPredecessors.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancelAll" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                                   
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" 
                                            SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgPredecessors.EditIndexes.Count = 0 AND (Not rdgPredecessors.MasterTableView.IsItemInserted) %>'>
                                             <span class="Icon"></span>
                                            <asp:Label ID="lblAdd" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgPredecessors.EditIndexes.Count = 0 AND (Not rdgPredecessors.MasterTableView.IsItemInserted) %>'
                                            SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                            runat="server" CommandName="DeleteRows">
                                        <span class="Icon"></span>
                                           <asp:Label ID="lblDelete" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                        
                                       
                                    </div>
                                </CommandItemTemplate>
                                
                            </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="False" />
                                        <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" />
                            </telerik:RadGrid>
                            </fieldset>
                    </telerik:RadPageView>
                     <telerik:RadPageView ID="pvSuccessors" runat="server">
                        <fieldset title="" style="height:390px; padding:5px"><legend><asp:Label ID="lblSuccessors" runat="server" meta:resourcekey="lblSuccessors" Text="Successors"></asp:Label></legend>
                                 <telerik:RadGrid ID="rdgSuccessors" runat="server"   
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
                                PageSize="12" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
                                AllowMultiRowEdit="false" AllowMultiRowSelection="true" AllowSorting="true" 
                                ItemStyle-Height="20px" >
                                <PagerStyle Mode="NextPrevAndNumeric"/>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top" EditMode="InPlace"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                                <Columns> 
                                  <telerik:GridTemplateColumn HeaderText="Task" Groupable="false" SortExpression="SuccessorID" UniqueName="SuccessorID">
                                        <ItemTemplate>
                                           <asp:Label ID="lblTask" runat="server"></asp:Label>
                                        </ItemTemplate>
                                      <EditItemTemplate>
                                           <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="465px"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="200px">
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
                                        <HeaderStyle Width="60%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                                    
                                     <telerik:GridTemplateColumn HeaderText="Depend. Type" Groupable="false" SortExpression="TaskDepType" UniqueName="Type">
                                        <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTaskDepType"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlDependTypes" runat="server">
                                            <asp:ListItem Text='<%$Resources:DependTypes_fs %>' Value="fs"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_ff %>' Value="ff"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_sf %>' Value="sf"></asp:ListItem>
                                            <asp:ListItem Text='<%$Resources:DependTypes_ss %>' Value="ss"></asp:ListItem>
                                          </asp:DropDownList>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="30%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
 
                                   <telerik:GridTemplateColumn HeaderText="Lag" Groupable="false" SortExpression="Lag" UniqueName="Lag">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Lag")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtLag" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn> 
                                  <telerik:GridTemplateColumn HeaderText="Float" Groupable="false" SortExpression="Float" UniqueName="Float">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Float")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFloat" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>   
                                </Columns>
                                <ItemStyle Wrap="false" HorizontalAlign="Left"/>
                                <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                                <CommandItemTemplate> 
                                    <div style="padding:2px">
                                        &nbsp;&nbsp;
                                        <asp:LinkButton ID="LinkButton5" runat="server" ValidationGroup="Save" 
                                            SecurityButtonType="AddEditMode_Add"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  Visible='<%# rdgSuccessors.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                           <asp:Label ID="Label7" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="false" 
                                            SecurityButtonType="AddEditMode"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSuccessors.EditIndexes.Count > 0 Or rdgSuccessors.MasterTableView.IsItemInserted %>'>
                                           <span class="Icon"></span>
                                            <asp:Label ID="Label8" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                                   
                                        <asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="false" 
                                            SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" Visible='<%# rdgSuccessors.EditIndexes.Count = 0 AND (Not rdgSuccessors.MasterTableView.IsItemInserted) %>'>
                                           <span class="Icon"></span>
                                            <asp:Label ID="Label9" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton8" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgSuccessors.EditIndexes.Count = 0 AND (Not rdgSuccessors.MasterTableView.IsItemInserted) %>'
                                            SecurityButtonType="ItemMode_Delete"
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                          <span class="Icon"></span>
                                           <asp:Label ID="Label10" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                        
                                       
                                    </div>
                                </CommandItemTemplate>
                                
                            </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                        AllowColumnResize="False" />
                                        <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                            </telerik:RadGrid>
                            </fieldset>
                     </telerik:RadPageView>
                    <telerik:RadPageView ID="pvResources" runat="server">
                            <fieldset title="" style="height:390px; padding:5px"><legend><asp:Label ID="lblResources" runat="server" meta:resourcekey="lblResources" Text="Resources"></asp:Label></legend>
                                    <telerik:RadGrid ID="rdgResources" runat="server"   
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
                                PageSize="12" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" 
                                ItemStyle-Height="20px">
                                <PagerStyle Mode="NextPrevAndNumeric"/>
                                <GroupPanel Text="Group by"></GroupPanel>
                                <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id,IsUsed" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                                    EditMode="InPlace" EnableHeaderContextMenu="true">
                                <Columns> 
                                    <telerik:GridTemplateColumn HeaderText="Resource" Groupable="false" SortExpression="Resource" UniqueName="Resource">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Resource") = String.Empty, "&nbsp;", Container.DataItem("Resource"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlResources" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="250px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ItemStyle Wrap="false" HorizontalAlign="Left"/>
                                <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                               
                                <CommandItemTemplate> 
                                    <div style="padding:2px">
                                        &nbsp;&nbsp;
                                        <asp:LinkButton ID="LinkButton12" runat="server" ValidationGroup="Save" 
                                            SecurityButtonType="AddEditMode_Add"
                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgResources.MasterTableView.IsItemInserted %>'>
                                           <span class="Icon"></span>
                                           <asp:Label ID="Label14" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton13" runat="server" CausesValidation="false" 
                                            SecurityButtonType="AddEditMode"
                                            CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgResources.EditIndexes.Count > 0 Or rdgResources.MasterTableView.IsItemInserted %>'>
                                          <span class="Icon"></span>
                                            <asp:Label ID="Label15" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                                   
                                        <asp:LinkButton ID="LinkButton14" runat="server" CausesValidation="false" 
                                            SecurityButtonType="ItemMode_Add"
                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgResources.EditIndexes.Count = 0 AND (Not rdgResources.MasterTableView.IsItemInserted) %>'>
                                          <span class="Icon"></span>
                                            <asp:Label ID="Label16" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton15" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgResources.EditIndexes.Count = 0 AND (Not rdgResources.MasterTableView.IsItemInserted) %>'
                                            SecurityButtonType="ItemMode_Delete"
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                           <span class="Icon"></span>
                                           <asp:Label ID="Label17" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>                        
                                        
                                    </div>
                                </CommandItemTemplate>
                                
                            </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="False" />
                                        <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" />
                            </telerik:RadGrid>
                            </fieldset>
                    </telerik:RadPageView>
                         <telerik:RadPageView ID="pvChecklist" runat="server">
                                  
                             <uc1:DocumentCheckList ID="DocumentCheckList1" runat="server" />
                                  
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvCodes" runat="server">
                            <fieldset title="" style="height:390px; padding:5px"><legend><asp:Label ID="lblCodes" runat="server" meta:resourcekey="lblCodes" Text="lblCodes"></asp:Label></legend>
                                <table width="100%" cellpadding="5" cellspacing="0">
                                    <tr id="trGroup1" runat="server">
                                        <td style=" width:30%" class="AllLightBlueBorder"><asp:Label ID="lblGroup1" runat="server" Text="Group1"></asp:Label></td>
                                        <td style=" width:70%" class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup1" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                      <tr id="trGroup2" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup2" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup2" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup3" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup3" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup3" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup4" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup4" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup4" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup5" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup5" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup5" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr  id="trGroup6" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup6" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup6" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup7" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup7" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup7" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup8" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup8" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup8" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup9" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup9" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup9" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                     <tr id="trGroup10" runat="server">
                                        <td class="AllLightBlueBorder"><asp:Label ID="lblGroup10" runat="server" Text="Group1"></asp:Label></td>
                                        <td class="AllLightBlueBorder"><asp:DropDownList ID="ddlGroup10" runat="server" Width="200px"></asp:DropDownList></td>
                                    </tr>
                                </table>
                            </fieldset>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server">
                            <fieldset title="Notes" style="height:390px; padding:5px"><legend><asp:Label ID="lblNotes" runat="server" meta:resourcekey="lblNotes" Text="Notes"></asp:Label></legend>
                                <asp:TextBox ID="txtNotes" MaxLength="3000" runat="server" TextMode="MultiLine" Height="300px" Width="100%"></asp:TextBox>
                            </fieldset>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%; padding: 5px;" cellspacing="0">
                    <tr><td><b><asp:Label ID="lblTasks" runat="server" meta:resourcekey="lblTasks" Text="Tasks"></asp:Label></b></td>
                        <td>
                            <telerik:RadComboBox ID="ddlTasksList" runat="server" Width="200px" Filter="Contains" DropDownWidth="465px"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" Autopostback="true" EmptyMessage='<%$Resources:ddlTasksList.EmptyMessage %>'
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="200px">
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
                        </td>
                        <td width="100%"></td>
                        <td><asp:Button ID="btnDelete" runat="server" Text="Delete" meta:resourcekey="btnDelete"/></td>
                        <td><asp:Button ID="btnNew" runat="server" Text="New" meta:resourcekey="btnNew"/></td>
                        <td><asp:Button ID="btnSave" runat="server" Text="Save" meta:resourcekey="btnSave"/></td>
                    </tr>
                </table>
                
            </td>
         </tr>
      </table>
        <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1970"
            MaxDate="12/31/2100" runat="server" Skin="Default" >
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
       <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            /*****************   Controls **************************/
            var S = $find("<%= rdiStart.ClientID %>");
            var F = $find("<%= rdiFinish.ClientID %>");
            var AS = $find("<%= rdiActualStart.ClientID %>");
            var AF = $find("<%= rdiActualFinish.ClientID %>");
            var BS = $find("<%= rdiBaselineStart.ClientID %>");
            var BF = $find("<%= rdiBaselineFinish.ClientID %>");
            var C = document.getElementById("txtPctComplete");
            var Duration = $get('<%=rnbDuration.ClientID%>' + '_text'); 
            var RemDuration = $get('<%=rnbRemDuration.ClientID%>' + '_text');
            var Cost = document.getElementById("txtCost");
            var ActualCost = document.getElementById("txtActualCost");
            var Revenue = document.getElementById("txtRevenue");
            var ActualRevenue = document.getElementById("txtActualRevenue");
        </script>
        </telerik:RadCodeBlock>
    </form>
</body>
</html>
