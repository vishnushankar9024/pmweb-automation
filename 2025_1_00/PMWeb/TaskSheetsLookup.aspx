<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TaskSheetsLookup.aspx.vb" Inherits="Website.TaskSheetsLookup" Title="Select a Schedule"  meta:resourcekey="Page"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSchedules">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSchedules" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


                                    <div class="PMHeader">
                                        <div class="row">
      
    <telerik:RadGrid ID="rdgSchedules" runat="server"  HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="1"
    Width="98%" AutoGenerateColumns="False" ShowHeader="true" PageSize="250" 
    AllowPaging="True" AllowSorting="True"  AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"> 
    </PagerStyle>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id"> 
         <Columns>                                    
           <telerik:GridTemplateColumn HeaderText="Project Number" UniqueName="ProjectNumber" DataType="System.String"
           CurrentFilterFunction="Contains" DataField="ProjectNumber" AutoPostBackOnFilter="true" SortExpression="ProjectNumber" GroupByExpression="ProjectNumber [GridColumn_ProjectNumber] Group By ProjectNumber">
            <ItemTemplate>
                 <asp:LinkButton ID="lbtSchedule" runat="server" Text='<%# Eval("ProjectNumber") %>' CommandName="ScheduleClick" CommandArgument='<%# Eval("Id")%>' ></asp:LinkButton>
            </ItemTemplate>
           </telerik:GridTemplateColumn>           
               <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Project" UniqueName="Project" DataType="System.String" 
           CurrentFilterFunction="Contains" DataField="Project" AutoPostBackOnFilter="true" SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project">
            <ItemTemplate>
                <span><%# Eval("Project") %></span>
            </ItemTemplate>
           </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description" DataType="System.String"
           CurrentFilterFunction="Contains" DataField="TaskSheet" AutoPostBackOnFilter="true" SortExpression="TaskSheet" GroupByExpression="TaskSheet [GridColumn_TaskSheet] Group By TaskSheet" >
            <ItemTemplate>
                <span><%# Eval("TaskSheet") %></span>
            </ItemTemplate>
           </telerik:GridTemplateColumn>    
        </Columns>

        </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true">
    </ClientSettings>
</telerik:RadGrid>

  </div>
                                        </div>
                         

    </form>
</body>
</html>
