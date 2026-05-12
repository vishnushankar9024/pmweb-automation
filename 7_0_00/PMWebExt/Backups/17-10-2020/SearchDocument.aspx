<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SearchDocument.aspx.vb" Inherits="Website.SearchDocument" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
  
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <ajaxsettings>  
            <telerik:AjaxSetting AjaxControlID="RDG1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
                  <telerik:AjaxUpdatedControl ControlID="hfIsClearCommand"  />               
            </UpdatedControls>
        </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="btnSaveAsLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnSaveAsLayout" />
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
            </UpdatedControls>
        </telerik:AjaxSetting>    
      <telerik:AjaxSetting AjaxControlID="btnProjectFilter">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnProjectFilter" />
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
                <telerik:AjaxSetting AjaxControlID="btnProgramFilter">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnProgramFilter" />
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btnActiveFilter">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnActiveFilter" />
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
      </ajaxsettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpPM2" runat="server" Skin="Default" />
<style type="text/css">
  
/*.rtbOuter ,.rtbMiddle {
background-image: none !important; 
border-style : none !important;
}

 .RadMenu_PM .rmRootGroup {

}
.rmSized ul.rmRootGroup {
float: none;
background-image: none; 
}
.rmLink 
{   
    display:inline-block !important;
    float: none !important;
    }
       .Icon1 .rmLeftImage {
margin: 4px 6px 0 -3px !important;
padding-bottom: 4px;
}*/

Table.rgMasterTable
{
    overflow:visible !important;    
}
#ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_rdmLayouts.RadMenu
{
    position:static;
}
.SearchDoctdRecent{padding-left:10px;}
.SearchDocumentGrid .trvSearchDocContextMenu{line-height:24px}
  </style>
 <%--<script  runat="server" >
     Private Sub RDG1_ItemDataBound1(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RDG1.ItemDataBound
         If TypeOf e.Item Is GridCommandItem Then
             Dim PageId As Integer = GetPageId(SourceObjectType)
             If PageId = 10014 Then
                 Dim rtbInitiative As RadToolBar = DirectCast(e.Item.FindControl("rtbInitiative"), RadToolBar)
                 Dim lblPrograms As Label = DirectCast(e.Item.FindControl("lblPrograms"), Label)
                 Dim lblProjects As Label = DirectCast(e.Item.FindControl("lblProjects"), Label)
                 lblProjects.Visible = False
                 lblPrograms.Visible = False
                 Dim ddlPrograms As RadComboBox = DirectCast(e.Item.FindControl("ddlPrograms"), RadComboBox)
                 Dim ddlProjects As RadComboBox = DirectCast(e.Item.FindControl("ddlProjects"), RadComboBox)
                 Dim ddlActive As RadComboBox = DirectCast(e.Item.FindControl("ddlActive"), RadComboBox)
                 Dim btnAdd As LinkButton = DirectCast(e.Item.FindControl("btnAdd"), LinkButton)
                 rtbInitiative.Attributes.Add("pageId", PageId.ToString)
                 rtbInitiative.Visible = False
                 ddlPrograms.Visible = False
                 ddlProjects.Visible = False
                 ddlActive.Visible = False
                 If btnAdd.Visible Then
                     btnAdd.Visible = False
                     rtbInitiative.Visible = True
                 End If
             End If
            
         End If
     End Sub
 </script>--%>
  <script type="text/javascript">
      var Grid;
      var btnDelete;
      var ClientID
     function GridCreated(sender, args) {
          Grid = $find($("[id$=RDG1]")[0].id);
          btnDelete = $($("a[id$=btnDelete]")[0]);
          ClientID = sender.ClientID;
     }

      function GoToDocument(sender, eventArgs) {
          window.location = eventArgs.getDataKeyValue("PostBackUrl");
      }

      function SearchDocument_OnRowSelected(sender, eventArgs) {
          if (SearchDocObjectTypeId == 19) {
              var grid = $find($("[id$=RDG1]")[0].id);
              var selectedCount = grid.get_masterTableView().get_selectedItems().length
              if (selectedCount == 1) {
                  btnDelete.removeClass("GridCmdDeleteRecordss_disabled").addClass("GridCmdDeleteRecords");
                  btnDelete.attr("onclick", "ConfirmSearchDelete()");
              }
              else {
                  disablebtnDeleteCompany()
              }
          }
      }

      function disablebtnDeleteCompany() {
          btnDelete.removeClass("GridCmdDeleteRecords").addClass("GridCmdDeleteRecordss_disabled");
          btnDelete.attr("onclick", "return false;");
      }

      function SearchDocument_OnRowSelecting(sender, eventArgs) {
        var IsSystemMap = $("#" + eventArgs.get_id())[0].getAttribute("IsSystemMap")
        var IsUsedMap = $("#" + eventArgs.get_id())[0].getAttribute("IsUsedMap")
        var IsUseWorkFlow = $("#" + eventArgs.get_id())[0].getAttribute("IsUseWorkFlow")
        var IsLatestRevision = $("#" + eventArgs.get_id())[0].getAttribute("IsLatestRevision")
        var IsUseDocumentTeam = $("#" + eventArgs.get_id())[0].getAttribute("IsUseDocumentTeam")
        var IsInSession = $("#" + eventArgs.get_id())[0].getAttribute("IsInSession")
        if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
            return;

        if (Grid.get_masterTableView().get_selectedItems().length > 0) {
            if (btnDelete.is(":visible") == true) {
                if (IsUseWorkFlow == "true" || IsLatestRevision == 0) { btnDelete.hide(); }
                if (IsSystemMap == "true" || IsUsedMap == "true") { btnDelete.hide(); }
                if (IsUseDocumentTeam == "true") { btnDelete.hide(); }
                if (IsInSession == "true") { btnDelete.hide(); }
            } 
        }
        else {
            if (IsUseWorkFlow == "true" || IsLatestRevision == 0 || IsSystemMap == "true" || IsUsedMap == "true" || IsUseDocumentTeam == "true" || IsInSession == "true") {
                //eventArgs.set_cancel(true);
                btnDelete.hide();
            } else {
                btnDelete.show();
            }
        }

         }
      function OpenAddInitiativeTemplatePopup(sender, eventArgs) {
          var value = eventArgs.get_item().get_commandName();
          if (value == 'NewInitiativeFromTemplate') {
              var PageId = sender.get_attributes().getAttribute("pageId");
              return OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?PageId=' + PageId, 1020, 520);
          }

          if (value == 'NewInitiative') {
              window.location = "InitiativesBudget.aspx?Id=0&ModuleId=1&PageId=190";
              return;
          }

          //if (value != 'Add') {
          //    sender.collapse();
          //}
          return false;

      }

         function openSaveCustomLayoutPopup(sender, eventArgs) {
         
            
             var item = eventArgs.get_item().get_value();
             if (item == -7) {

                 var wnd = window.radopen('SaveCustomLayoutPopup.aspx?SourceId=SearchDocument');
             wnd.setSize(450, 125);
             wnd.add_close(ClickHiddenButton);
             wnd.Center();
             var iframe = $(document).find('iframe')[0];

             iframe.onload = function () {
                 var pageName = $(document).find('iframe').contents().find("form").attr('action');
                 if (pageName.indexOf('SaveCustomLayoutPopup') > -1) {
                     $(document).find('iframe').css('height', 125);

                 }
             }
             sender.close();
             eventArgs.set_cancel(true);
            

             return false;
     
         }
         if (item == -8) {
             var result;
                 result = confirm(Msg_ConfirmDeleteLayout);
                 eventArgs.set_cancel(!result);
                 return false;
             }
             eventArgs.set_cancel(false);
         return true;
     }

     function ClickHiddenButton(Opener) {
         
         var btnHiddenButton = $("[id$=btnSaveAsLayout]");
         var hfSaveAsLayout = $("[id$=hfSaveAsLayout]")[0];

         if (hfSaveAsLayout.value == "1") {
             $(window.document).find("[id$=hfSaveAsLayout]").val(0);
             btnHiddenButton.click();
         }
         
         
     }
          function ddlProjectsIndexChanged(sender, eventArgs) {
          var value=sender.get_value();
          if(value=='')
          value=0;
         var btnProjectFilter = $("[id$=btnProjectFilter]");
         var hfProjectFilter = $("[id$=hfProjectFilter]")[0];
          hfProjectFilter.value=value;
          btnProjectFilter.click();
          
          }
    function ddlProgramsIndexChanged(sender, eventArgs) {
          var value=sender.get_value();
          if(value=='')
          value=0;
         var btnProgramFilter = $("[id$=btnProgramFilter]");
         var hfProgramFilter = $("[id$=hfProgramFilter]")[0];
          hfProgramFilter.value=value;
          btnProgramFilter.click();
          
          }
             function ddlActiveIndexChanged(sender, eventArgs) {
          var value=sender.get_value();
          if(value=='')
          value=0;
         var btnActiveFilter = $("[id$=btnActiveFilter]");
         var hfActiveFilter = $("[id$=hfActiveFilter]")[0];
          hfActiveFilter.value=value;
          btnActiveFilter.click();
          
          }
          function OnCommand(sender,args){ 
      
         
          }
          function ConfirmSearchDelete() { 
           var grid = $find($("[id$=RDG1]")[0].id); 
           var hfdeletedIds = $("[id$=hfdeletedIds]")[0];
           hfdeletedIds.value='';
          for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
            var row = grid.MasterTableView.get_selectedItems()[i];
            hfdeletedIds.value=hfdeletedIds.value + "," + row.getDataKeyValue("Id")
          }

        return confirm(Msg_ConfirmDelete);
    }

    function querySt(ji) {
        hu = window.location.search.substring(1);
        gy = hu.split("&");
        for (i = 0; i < gy.length; i++) {
            ft = gy[i].split("=");
            if (ft[0] == ji) {
                return ft[1];
            }
        }
    }

    function pageLoad() {
        if (querySt("O") == 9000 || querySt("O") == 9001 || querySt("O") == 9002 || querySt("O") == 9003 || querySt("O") == 9004)
            $("#ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_tblDropDownLists").hide();
        if (querySt("O") == 134) {
            $("#ctl00_CPH1_RDG1_ctl00_ctl02_ctl00_tblAddNewRecord").attr("width", "50");
        }

        var tFind = $telerik.$;
        tFind("[id$=HCFMClearFilterButton]").on("click", function (e) {
            var hfIsClearCommand = tFind("[id$=hfIsClearCommand]")[0];
            hfIsClearCommand.value = 1;
        });
    };

  </script>  
    <table style="width: 100%"  cellspacing="0" cellpadding="0" border="0">
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="RDG1" CssClass="SearchDocumentGrid" runat="server" ShowGroupPanel="true" Skin="Default" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        AllowPaging="true" PageSize="20" AutoGenerateColumns="false" ShowStatusBar="False" OnFilterCheckListItemsRequested="CheckListItemsRequested" SetWidth="true" AppendMenus="true" IsSearchDoc="true"
        AllowMultiRowEdit="True" AllowSorting="true" AllowMultiRowSelection="true" GridLines="None" EnableViewState="true" Width="99.5%">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
        <MasterTableView GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EnableColumnsViewState="False"
            DataKeyNames="Id,PostBackUrl" ClientDataKeyNames="Id,PostBackUrl" CommandItemDisplay="Top"
            InsertItemDisplay="Top" EnableHeaderContextMenu="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" TableLayout="Fixed" AllowMultiColumnSorting="true" Width="1px">
            <CommandItemTemplate>
                <div style="padding: 2px" style="width: 100%">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                               <td class="NoWrap SearchDoctdTreeView">
                                            <asp:LinkButton ID="btnItemsTreeView" runat="server" CausesValidation="False" CommandName="ItemsTreeView" CssClass="GridCmdTreeView"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                             <td class="NoWrap SearchDoctdTreeView">
                                            <asp:LinkButton ID="btnPmwebReportingTreeView" runat="server" Visible="false" CausesValidation="False" CommandName="PmwebReportingTreeView" CssClass="GridCmdTreeView"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                             <td class="NoWrap SearchDoctdRecent">
                                <asp:LinkButton ID="btnSearchDocRecent" CausesValidation="False" OnClientClick=""
                                    SecurityButtonType="ItemMode" runat="server" CommandName="RecentRecords" CssClass="GridCmdRecentRecords">
                                    <span class="Icon"></span>                                    
                                </asp:LinkButton>
                                  <telerik:RadToolBar ID="RadToolBar1" runat="server" Style="z-index: 0; border: 0px transparent none; position: static">
                                                <Items>
                                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                                  </Items>
                                      </telerik:RadToolBar>
                            </td>
                            <td id="tblDropDownLists" runat="server" class="NoWrap">
                                <table style="display: inline; padding: 0px; border: 0px transparent none; border-spacing: 10px 0;" cellpadding="0"
                                    cellspacing="0">
                                    <tr>
                                        <td class="NoWrap" orderindex="0">
                                            <b>
                                                <asp:Label ID="lblPrograms" meta:resourcekey="lblPrograms" runat="server" Text="Program" Width="50px"></asp:Label></b>
                                            &nbsp;&nbsp;
                                       <telerik:RadComboBox ID="ddlPrograms" OnClientSelectedIndexChanged="ddlProgramsIndexChanged"
                                           runat="server" AutoPostBack="false" AllowCustomText="true" Style="font-size: 11px" Width="205px"
                                           Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                           EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                       </telerik:RadComboBox>
                                        </td>
                                        <td class="NoWrap" orderindex="1" style="padding-left:10px;">
                                            <b>
                                                <asp:Label ID="lblProjects" meta:resourcekey="lblProjects" runat="server" Text="Project" Width="50px"></asp:Label></b>
                                            &nbsp;&nbsp;
                                       <telerik:RadComboBox ID="ddlProjects" runat="server" OnClientSelectedIndexChanged="ddlProjectsIndexChanged"
                                           Width="205px" AutoPostBack="false" AllowCustomText="true" Height="400px"
                                           Style="font-size: 11px"
                                           EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                           EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                       </telerik:RadComboBox>
                                  &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td id="tblActive" runat="server" class="NoWrap SearchDoctdComboFilters">
                                <telerik:RadComboBox ID="ddlActive" runat="server" OnClientSelectedIndexChanged="ddlActiveIndexChanged"
                                    Width="90px" AutoPostBack="false" Style="font-size: 11px"
                                    DropDownWidth="120px">
                                </telerik:RadComboBox>
                                &nbsp;&nbsp;
                            </td>
                            <td class="NoWrap">
                                <table id="tblGridStates" runat="server" style="padding: 0px; border: 0px transparent none; height: 15px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td id="tblAddNewRecord" runat="server" class="NoWrap SearchDoctdAdd">
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRecord" CssClass="SearchDocGridCmdInitNewRecord"
                                                SecurityButtonType="ItemMode_Add">
                                                <div>
                                                    <span class="Icon"></span>
                                                     &nbsp;&nbsp;
                                                </div>
                                            </asp:LinkButton>

                                            <telerik:RadToolBar ID="rtbInitiative" runat="server" AutoPostBack="true" Style="z-index: 0; border: 0px transparent none; position: static"
                                                OnClientButtonClicked="OpenAddInitiativeTemplatePopup">
                                                <Items>
                                                    <telerik:RadToolBarSplitButton  EnableImageSprite="true" CssClass="ToolbarButtonNewInitiative"
                                                        EnableDefaultButton="false" PostBack="false" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative">
                                                        <Buttons>
                                                            <telerik:RadToolBarButton PostBack="false" Width="120px" EnableImageSprite="true" meta:resourcekey="ContextMenu_NewInitiative"
                                                                CommandName="NewInitiative" CssClass="ToolbarButtonNewInitiative">
                                                            </telerik:RadToolBarButton>
                                                            <telerik:RadToolBarButton PostBack="false" Width="150px" EnableImageSprite="true" meta:resourcekey="ContextMenu_NewInitiativeFromTemplate"
                                                                CommandName="NewInitiativeFromTemplate" CssClass="ToolbarButtonNewInitiative">
                                                            </telerik:RadToolBarButton>
                                                        </Buttons>
                                                    </telerik:RadToolBarSplitButton>
                                                </Items>
                                            </telerik:RadToolBar>

                                        </td>
                                        <td class="NoWrap SearchDoctdDelete">
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmSearchDelete()"
                                                SecurityButtonType="ItemMode_Delete"
                                                runat="server" CommandName="DeleteRecords" CssClass="GridCmdDeleteRecords">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td class="NoWrap SearchDoctdRefresh">
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                 &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <%--      <td class="NoWrap">
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState">
                                        <asp:Label ID="Label3" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState">
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="label4" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </td>--%>
                                     
                                        <td class="NoWrap SearchDoctdLayout">
                                            <telerik:RadMenu ID="rdmLayouts" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                CollapseAnimation-Type="None" CssClass="trvContextMenu trvSearchDocContextMenu"
                                                runat="server" EnableSelection="true"
                                                EnableShadows="true"
                                                OnItemClick="rdmLayouts_ItemClick"
                                                OnClientItemClicking="openSaveCustomLayoutPopup" Visible="true">
                                            </telerik:RadMenu>
                                        </td>
                                        <td class="NoWrap SearchDoctdClearProjectFilter">
                                            <asp:LinkButton ID="btnClearFilter" runat="server" CausesValidation="False" CommandName="ClearFilter" CssClass="GridCmdClearFilerGrid"
                                                SecurityButtonType="ItemMode" ToolTip="Clear Filter">
                                                <span style="font-weight: bold">Project: </span>
                                                <asp:Label ID="lblProjectFilter" runat="server" CssClass="SDProjectFilter"></asp:Label>
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>


                </div>

            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowGroupExpandCollapse="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="True">
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                AllowColumnResize="True"></Resizing>
            <ClientEvents OnCommand="OnCommand" OnGridCreated="GridCreated" OnRowDblClick="GoToDocument" OnRowSelecting="SearchDocument_OnRowSelecting" OnRowSelected="SearchDocument_OnRowSelected" />
            <Scrolling UseStaticHeaders="true" AllowScroll="true" />
            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />

        </ClientSettings>
    </telerik:RadGrid>
              <asp:Button ID="btnSaveAsLayout" runat="server" CssClass="Hide" />
              <asp:HiddenField ID="hfSaveAsLayout" runat="server" Value="0" />
               <asp:Button ID="btnProjectFilter" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hfProjectFilter" runat="server" Value="0" />
                <asp:Button ID="btnProgramFilter" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hfProgramFilter" runat="server" Value="0" />
                 <asp:Button ID="btnActiveFilter" runat="server" CssClass="Hide" />
                <asp:HiddenField ID="hfActiveFilter" runat="server" Value="0" />
                <asp:HiddenField ID="hfdeletedIds" runat="server" Value="0" />
                <asp:HiddenField ID="hfIsClearCommand" runat="server" Value="0" />
</asp:Content>
