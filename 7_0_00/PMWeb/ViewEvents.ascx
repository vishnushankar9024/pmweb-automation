<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ViewEvents.ascx.vb" Inherits="Website.ViewEvents" %>
  <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
         <telerik:RadAjaxManagerProxy ID="PMAjaxManager" runat="server">
       <AjaxSettings>
          <telerik:AjaxSetting AjaxControlID="rdgHomeEvents">
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="rdgHomeEvents" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="btnRefreshEvents" />
                  <telerik:AjaxUpdatedControl ControlID="btnOpenSnoozePopup" />
            </UpdatedControls>
                </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btnRefreshEvents">
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="rdgHomeEvents" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="btnRefreshEvents" />
                  <telerik:AjaxUpdatedControl ControlID="btnOpenSnoozePopup" />
            </UpdatedControls>
        </telerik:AjaxSetting>
       </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server"/>

<style type="text/css">
    .lblshow{
        margin-right:62.77px;
    }

    .ddlShow{
        width:100px;
    }
    .chkColumns{
        text-align:center;  
    }

    .FilledDetails .Icon{
        background-position:-48px 0px;
    }
</style>

<script type="text/javascript">
    
    function OpenRemiderDetailPopup(Id) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('ReminderDetailsPopup.aspx?Id=' + Id);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }



    function OpenSubscriptionDetailPopup(Id) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('SubscriptionDetailPopup.aspx?Id=' + Id, 'welcome');
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.31, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }

    function OpenSnoozePopup(TotalNumber, SystemType, EventUserId) {
        if (TotalNumber == 1) {
            OpenPOPUp("SnoozePopup.aspx?TotalNumber=" + TotalNumber + "&Id=" + EventUserId + "&SystemType=" + SystemType, 400, 150, false);
            return false;
        }
        if (TotalNumber > 1) {
            OpenPOPUp("SnoozePopup.aspx?TotalNumber=" + TotalNumber, 400, 150, false);
        }
        return false;
    }
    function TryOpenSnoozePopup() {
        var btnOpenSnoozePopup = $("[id$=btnOpenSnoozePopup]");
        btnOpenSnoozePopup.click();
        return false;
    }
</script>
<table class="colTable">
    <tr>
        <td>
                <telerik:RadGrid ID="rdgHomeEvents" runat="server" Width="200px"   ShowGroupPanel="true" AllowPaging="true" PageSize="20"
                     AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True" SetWidth="true" AppendMenus = "true"
                     ClientSettings-Scrolling-AllowScroll= "true" ClientSettings-Scrolling-UseStaticHeaders="true"
                    ShowStatusBar="false" GridLines="None"  ShowHeader="true" AllowMultiRowSelection="true" >
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                      <HeaderContextMenu  EnableViewState="false">
                </HeaderContextMenu> 
                    <MasterTableView  NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="EventUserId,SystemType" TableLayout="Fixed" Width="100%" CommandItemDisplay="Top">
                        <Columns>
                    <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="Select" ItemStyle-CssClass="chkColumns"  Reorderable="false"> </telerik:GridClientSelectColumn>
                    <telerik:GridTemplateColumn HeaderText="" UniqueName="ReminderDetails" HeaderStyle-Width="45px" Groupable ="false">
                            <ItemTemplate>
                                    <div style="width:20px;"><asp:linkbutton runat="server" ID="imgReminderDetails" CssClass="FilledDetails" ><span class="Icon"></span></asp:linkbutton></div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn HeaderText="ID" UniqueName="EventUserId" ItemStyle-HorizontalAlign="Right"
                            SortExpression="EventUserId" 
                            Groupable="false" Reorderable="true" DataField="EventUserId" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:label runat="server" id="lblSystemId" text='<%#Container.DataItem("EventUserId")%>'></asp:label>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Date" SortExpression="Date"
                             UniqueName="Date" DataField ="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC"
                              CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                             <ItemTemplate>
                                 <asp:label runat="server" id="lblDate" text='<%# FormatDate(Container.DataItem("Date"))%>'></asp:label>  
                           &nbsp;
                            </ItemTemplate>
                             <HeaderStyle Width="90px" ></HeaderStyle>
                             <ItemStyle Wrap="false" HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Time" 
                                 AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" Groupable="false" DataType="System.String" FilterListOptions="VaryByDataType"
                              ItemStyle-HorizontalAlign="Right" SortExpression="Date"  UniqueName="DueDate">
                                <ItemTemplate>
                                 <asp:label runat="server" id="lblTime" text='<%# CultureFormatTime(Container.DataItem("Date"))%>'></asp:label>
                                                            &nbsp;  
                                </ItemTemplate>
                                <HeaderStyle Width="90px" />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn HeaderText="Subject" 
                                SortExpression="Subject" UniqueName="Subject"
                                 AutoPostBackOnFilter="true"  GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC"  CurrentFilterFunction="Contains" 
                                DataField="Subject" DataType="System.String" FilterListOptions="VaryByDataType">
                                <ItemTemplate>
                                <asp:label runat="server" id="lblSubject" text='<%#Container.DataItem("Subject")%>'></asp:label>
                                 &nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="300px" />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn HeaderText="Project/Location"
                             SortExpression="Entity"  UniqueName="EntityName"
                              AutoPostBackOnFilter="true" GroupByExpression="Entity [GridColumn_EntityName] Group By Entity ASC"  CurrentFilterFunction="Contains" DataField="Entity"
                               DataType="System.String" FilterListOptions="VaryByDataType">
                                <ItemTemplate>
                                  <asp:label runat="server" id="lblEntity" text='<%# IIf(IsDBNull(Container.DataItem("Entity")), "&nbsp;", Container.DataItem("Entity")) %>'></asp:label>
                                   &nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="250px" />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Record Type" 
                                SortExpression="RecordType" UniqueName="RecordType"
                                AutoPostBackOnFilter="true" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"  CurrentFilterFunction="Contains" 
                                DataField="RecordType" DataType="System.String" FilterListOptions="VaryByDataType"  >
                                <ItemTemplate>
                                <asp:label runat="server" id="lblRecordType" text='<%# Container.DataItem("RecordType")%>'></asp:label>
                                    &nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="200px" />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Record"   GroupByExpression="Record [GridColumn_Record] Group By Record ASC"  AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="Record" DataType="System.String" FilterListOptions="VaryByDataType" 
                            SortExpression="Record" UniqueName="Record">
                                <ItemTemplate>
                          
                          <asp:HyperLink ID="hliRecord" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("Record").ToString%>' NavigateUrl='<%#Eval("Link").ToString%>'></asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                                <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Trigger" UniqueName="Trigger" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="Trigger [GridColumn_Trigger] Group By Trigger ASC" SortExpression="Trigger" DataField ="Trigger" 
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                           
                              <asp:label runat="server" id="lblTrigger" text='<%#IIf(Container.DataItem("Trigger") = String.Empty, "&nbsp;", Container.DataItem("Trigger"))%>'></asp:label>
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-CssClass="chkColumns" HeaderText="Read" UniqueName="Read" ItemStyle-HorizontalAlign="Center"
                            GroupByExpression="Read [GridColumn_Read] Group By Read ASC" SortExpression="Read" DataField ="Read" 
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate >
                             <asp:CheckBox ID="chbRead" Checked='<%# CBool(IIf(Eval("Read") Is System.DBNull.Value, 0, Eval("Read")))%>'  runat="server" AutoPostBack="true" OnCheckedChanged="chRead_Changed" class="mobile-switch"/>
                            </ItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                            
                        </Columns>
                        <CommandItemTemplate>
                               <table style="padding: 0px; border:0px transparent none; height:30px;" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td  class="NoWrap">
                                      <asp:LinkButton ID="btnDismissSelected" SecurityButtonType="ItemMode_Edit" OnClientClick=""  runat="server" CausesValidation="False" CommandName="Dismiss" CssClass="GridCmdDismiss" 
                                                 meta:resourcekey="btnDismissSelected">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDismissSelected" runat="server" Text="Dismiss Selected" meta:resourcekey="lblDismissSelected"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            </td>
                                               <td  class="NoWrap">
                                            <asp:LinkButton ID="btnSnoozeSelected" SecurityButtonType="ItemMode_Edit" OnClientClick="javascript:return TryOpenSnoozePopup();" CssClass="GridCmdSnooze" 
                                                 runat="server" CausesValidation="False" CommandName="Snooze" 
                                                 meta:resourcekey="btnSnoozeSelected">   
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSnoozeSelected" runat="server" Text="Snooze Selected" meta:resourcekey="lblSnoozeSelected"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            </td>
                                              <td  class="NoWrap">
                                            <asp:LinkButton ID="btnMarkSelected" SecurityButtonType="ItemMode_Edit" OnClientClick=""  runat="server" CausesValidation="False" CommandName="MarkAsRead"  CssClass="GridCmdMarkAsRead" 
                                                 meta:resourcekey="btnSnoozeSelected">   
                                               <span class="Icon"></span>
                                                <asp:Label ID="lblMarkSelected" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            </td>
                                            <td  class="NoWrap">
                                            <asp:Label ID="lblShow" runat="server" Text="Show"
                                                 meta:resourcekey="lblShow" CssClass="lblshow"></asp:Label>
                                        <telerik:radcombobox runat="server" ID = "ddlShow" AutoPostBack="true" OnSelectedIndexChanged="ddlShow_Changed" CssClass="ddlShow">
                                            <Items>
                                                 <telerik:RadComboBoxItem Text="All" Value="All" meta:resourcekey="lstAll"></telerik:RadComboBoxItem>    
                                                <telerik:RadComboBoxItem Text="Today" Value="Today"  meta:resourcekey="lstToday"></telerik:RadComboBoxItem>    
                                                <telerik:RadComboBoxItem Text="Past" Value="Past"  meta:resourcekey="lstPast"></telerik:radcomboboxitem>   
                                            </Items>
                                                                                    
                                        </telerik:radcombobox>
                                            
                                            </td>
                                           <%--<td  class="NoWrap">--%>
                                          <%--<asp:LinkButton ID="btnGoToEventCenter" SecurityButtonType="ItemMode_Edit"  CssClass="GridCmdGoToEventCenter" 
                                          CommandName="GoToEventCenter" runat="server" CausesValidation="False"
                                                 OnClientClick="javascript:return GotoEventCenterFromHome();">
                                              <span class="Icon"></span>
                                                <asp:Label ID="lblGoToEventCenter" runat="server" Text="Go To Event Center" meta:resourcekey="lblGoToEventCenter"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            </td>
                                            <td  class="NoWrap">
                                 <asp:LinkButton ID="btnGotoMySettings"  CausesValidation="False" OnClientClick="javascript:return GotoMySettingsFromHome();" CssClass="GridCmdGotoMySettings" 
                                SecurityButtonType="ItemMode_Edit" runat="server" CommandName="GotoMySettings">
                                <span class="Icon"></span>
                                <asp:Label ID="lblGoToMySettings" runat="server" Text="Go To My Settings"
                                    meta:resourcekey="lblGoToMySettings"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            </td>--%>
                            <td  class="NoWrap">
                                      <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" >
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                     &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    </td>
                                    <td  class="NoWrap">
                                     <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False" 
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    </td>
                                    <td  class="NoWrap">
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    </td> 
                                </tr> 
                             </table> 
                                    
                            
                            </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    
                    <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                        <Resizing AllowColumnResize="True"></Resizing>
                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                    </ClientSettings>
                </telerik:RadGrid>
<asp:Button runat="server" id="btnSnooze" CssClass="Hide" />
         <asp:Button runat="server" id="btnOpenSnoozePopup" CssClass="Hide" />
        <asp:Button runat="server" id="btnRefreshEvents" CssClass="Hide" />
        </td>
    </tr>
</table>
