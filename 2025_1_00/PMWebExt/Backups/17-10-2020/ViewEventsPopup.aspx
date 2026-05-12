<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewEventsPopup.aspx.vb" Inherits="Website.ViewEventsPopup" %>
  <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Events</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function GotoMySettings() {
            GetRadWnd().BrowserWindow.location.href = "UserProfile.aspx";
            CloseRadWnd();
            return false;
        }
        function OpenRecord(sender) {
            if ($(sender).attr("mysrc") != "") {
                GetRadWnd().BrowserWindow.location.href = $(sender).attr("mysrc");
                CloseRadWnd();
            }
            return false;
        }
        function GotoEventCenter() {
            GetRadWnd().BrowserWindow.location.href = "EventCenter.aspx";
            CloseRadWnd();
            return false;
        }
        function RedirectParentToPage(url) {
            GetRadWnd().BrowserWindow.location.href = url;
            CloseRadWnd();
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
        function OpenRemiderDetailPopup(Id) {
            var left = (screen.width - 390) / 2;
            var top = (screen.height - 395) / 2;
            window.open('ReminderDetailsPopup.aspx?Id=' + Id, 'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=390,height=395,top=' + top + ',left=' + left);
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
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
   
       <asp:scriptmanager id="PMScriptManager" runat="server">
    </asp:scriptmanager> 
       <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
       <AjaxSettings>
          <telerik:AjaxSetting AjaxControlID="rdgEvents">
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="rdgEvents" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="btnRefreshEvents" />
                  <telerik:AjaxUpdatedControl ControlID="btnOpenSnoozePopup" />
            </UpdatedControls>
                </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btnRefreshEvents">
            <UpdatedControls> 
                <telerik:AjaxUpdatedControl ControlID="rdgEvents" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="btnRefreshEvents" />
                  <telerik:AjaxUpdatedControl ControlID="btnOpenSnoozePopup" />
            </UpdatedControls>
        </telerik:AjaxSetting>
       </AjaxSettings>
    </telerik:RadAjaxManager>
      
         <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td valign="top">
                        <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="ToolbarTd">

                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>
     
             <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr id="trTbsDetails" runat="server">
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row documentSinglePage">
                                        <div class="col-4">
                                            <table class="colTable" border="0">
                                                <tr>
                                                    <td>
        
 <telerik:RadGrid ID="rdgEvents" runat="server" style="width:100%;border:none"    ShowGroupPanel="true" AllowPaging="true" PageSize="10" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                     AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True"  setwidth="true"
                    ShowStatusBar="false" GridLines="None" ShowHeader="true" AllowMultiRowSelection="true" TableLayout="Fixed">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="EventUserId,SystemType" TableLayout="Fixed"  Width="100%" CommandItemDisplay="Top">
                        <Columns>
                    <telerik:GridClientSelectColumn Groupable="false" UniqueName="Select" Reorderable="false"> </telerik:GridClientSelectColumn>
                    <telerik:GridTemplateColumn HeaderText="" UniqueName="ReminderDetails" Groupable="false">
                            <ItemTemplate>
                                    <div style="width:200px;">
                                        <asp:linkbutton runat="server" ID="imgReminderDetails" CssClass="FilledDetails" ><span class="Icon"></span></asp:linkbutton>
                                    </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn HeaderText="ID" UniqueName="EventUserId" ItemStyle-HorizontalAlign="Right" 
                            SortExpression="EventUserId" 
                            Groupable="false" Reorderable="true" DataField="EventUserId" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:label runat="server" id="lblSystemId"  text='<%#Container.DataItem("EventUserId")%>'></asp:label>
                            </ItemTemplate>
                          
                            <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Date" SortExpression="Date"
                             UniqueName="Date" DataField ="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC"
                              CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                             <ItemTemplate>
                                 <asp:label runat="server"  id="lblDate" text='<%# FormatDate(Container.DataItem("Date"))%>'></asp:label>  
                           &nbsp;
                            </ItemTemplate>
                             <HeaderStyle  ></HeaderStyle>
                             <ItemStyle Wrap="false" HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Time" 
                                 AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="Date" DataType="System.String" FilterListOptions="VaryByDataType"
                              ItemStyle-HorizontalAlign="Right" SortExpression="Date" Groupable="false"  UniqueName="DueDate">
                                <ItemTemplate>
                                 <asp:label runat="server" id="lblTime"   text='<%# CultureFormatTime(Container.DataItem("Date"))%>'></asp:label>
                                                            &nbsp;  
                                </ItemTemplate>
                                <HeaderStyle  />
                                   <ItemStyle Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn HeaderText="Subject" 
                                SortExpression="Subject" UniqueName="Subject"
                                 AutoPostBackOnFilter="true"   GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC"  CurrentFilterFunction="Contains" 
                                DataField="Subject" DataType="System.String" FilterListOptions="VaryByDataType">
                                <ItemTemplate>
                                <asp:label runat="server" id="lblSubject"  style="white-space:nowrap;display:inline-block;"  text='<%#Container.DataItem("Subject")%>'></asp:label>
                         
                                </ItemTemplate>
                                <HeaderStyle  />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn HeaderText="Project/Location"
                             SortExpression="Entity"  UniqueName="EntityName"
                              AutoPostBackOnFilter="true"  GroupByExpression="Entity [GridColumn_EntityName] Group By Entity ASC"  CurrentFilterFunction="Contains" DataField="Entity"
                               DataType="System.String" FilterListOptions="VaryByDataType">
                                <ItemTemplate>
                                  <asp:label runat="server" id="lblEntity"  style="white-space:nowrap;display:inline-block;" text='<%# IIf(IsDBNull(Container.DataItem("Entity")), "&nbsp;", Container.DataItem("Entity")) %>'></asp:label>
                                  
                                </ItemTemplate>
                                <HeaderStyle />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Record Type" 
                                SortExpression="RecordType" UniqueName="RecordType"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" 
                                DataField="RecordType" DataType="System.String"  GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC" FilterListOptions="VaryByDataType"  >
                                <ItemTemplate>
                                <asp:label runat="server" id="lblRecordType"  style="white-space:nowrap;display:inline-block;" text='<%# Container.DataItem("RecordType")%>'></asp:label>
                          
                                </ItemTemplate>
                                <HeaderStyle  />
                                   <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Record" GroupByExpression="Record [GridColumn_Record] Group By Record ASC"  AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="Record" DataType="System.String" FilterListOptions="VaryByDataType" 
                            SortExpression="Record" UniqueName="Record">
                                <ItemTemplate>
                          
                          <asp:HyperLink ID="hliRecord"  runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("Record").ToString%>' onclick="OpenRecord(this)"
                            mysrc='<%#Eval("Link").ToString%>'></asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle  />
                                <ItemStyle Wrap="false" /> 
                            </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Trigger" UniqueName="Trigger" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="Trigger [GridColumn_Trigger] Group By Trigger ASC" SortExpression="Trigger" DataField ="Trigger" 
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                            
                              <asp:label runat="server" id="lblTrigger"  text='<%#IIf(Container.DataItem("Trigger") = String.Empty, "&nbsp;", Container.DataItem("Trigger"))%>'></asp:label>
                            </ItemTemplate>
                            <HeaderStyle ></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Read" UniqueName="Read" ItemStyle-HorizontalAlign="Center"
                            GroupByExpression="Read [GridColumn_Read] Group By Read ASC" SortExpression="Read" DataField ="Read" 
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                             <asp:CheckBox ID="chbRead" Checked='<%# Cbool(IIF(Eval("Read") is system.DBNULL.value, 0,Eval("Read")))%>' runat="server" AutoPostBack="true" OnCheckedChanged="chRead_Changed" class="mobile-switch"/>
                            </ItemTemplate>
                            <HeaderStyle ></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                            
                        </Columns>
                        <CommandItemTemplate>
                               <table style="padding: 0px; border:0px transparent none; height:30px; Width:100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td  class="NoWrap">
                                    <asp:LinkButton ID="btnDismissSelected" SecurityButtonType="ItemMode_Edit" OnClientClick=""  runat="server" CausesValidation="False" CommandName="Dismiss"  CssClass="GridCmdDismiss"              >
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
                                                <asp:Label ID="lblSnoozeSelected"  runat="server" Text="Snooze Selected" meta:resourcekey="lblSnoozeSelected"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            
                                    </td>
                                               <td  class="NoWrap">
                                            <asp:LinkButton ID="btnMarkSelected" SecurityButtonType="ItemMode_Edit" OnClientClick=""  runat="server" CausesValidation="False" CommandName="MarkAsRead"  CssClass="GridCmdMarkAsRead" 
                                                 meta:resourcekey="btnSnoozeSelected">   
                                                <span class="Icon"></span>
                                                    <asp:Label ID="lblMarkSelected"  meta:resourcekey="lblMarkSelected" runat="server">
                                                    </asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            </td>
                                            <td  class="NoWrap">
                                            <asp:Label ID="lblShow" runat="server" Text="Show"
                                                 meta:resourcekey="lblShow"></asp:Label>
                                        <asp:DropDownList runat="server" ID = "ddlShow" AutoPostBack="true" OnSelectedIndexChanged="ddlShow_Changed">
                                                <asp:ListItem Text="All" meta:resourcekey="lstAll"    Value="All"></asp:ListItem>    
                                                <asp:ListItem Text="Today" meta:resourcekey="lstToday" Value="Today"></asp:ListItem>    
                                                <asp:ListItem Text="Past" meta:resourcekey="lstPast"  Value="Past"></asp:ListItem>                                        
                                        </asp:DropDownList>
                                            
                                            </td>
                                    <td class="NoWrap">
                                        <asp:LinkButton ID="btnGoToEventCenter" SecurityButtonType="ItemMode_Edit" CommandName="GoToEventCenter" CssClass="GridCmdGoToEventCenter" 
                                            runat="server" CausesValidation="False" OnClientClick="javascript:return GotoEventCenter();">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblGoToEventCenter" runat="server" Text="Go To Event Center" meta:resourcekey="lblGoToEventCenter"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                    </td>
                                    <td class="NoWrap">
                                        <asp:LinkButton ID="btnGotoMySettings" CausesValidation="False" OnClientClick="javascript:return GotoMySettings();" CssClass="GridCmdGotoMySettings" 
                                            SecurityButtonType="ItemMode_Edit" runat="server" CommandName="GotoMySettings">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblGoToMySettings" runat="server" Text="Go To My Settings" meta:resourcekey="lblGoToMySettings"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                    </td>
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
                    
                    <ClientSettings AllowColumnHide="true" EnableRowHoverStyle="true" AllowColumnsReorder="true" Resizing-AllowColumnResize="true" AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True"   ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                    </ClientSettings>
                </telerik:RadGrid>
    </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                 </table>

            
      <asp:Button runat="server" id="btnSnooze" CssClass="Hide" />
         <asp:Button runat="server" id="btnOpenSnoozePopup" CssClass="Hide" />
        <asp:Button runat="server" id="btnRefreshEvents" CssClass="Hide" />
         
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behaviors="Close,Move" 
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>
    </form>
</body>
</html>
