<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkflowAssignments.ascx.vb" Inherits="Website.WorkflowAssignments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style type="text/css">
        .rgHeaderDiv{margin-right:0px !important}
    </style>
    <script language="javascript" type="text/javascript">
        
        function DisableWarningTabs() {
            DisableTemplateTab();
            DisableRuleTab();
            DisableAssignmentsTab();
            $("div[id$='pnlWarningPanel']").show();
        }

        function EnableWarningTabs() {
            EnableTemplateTab();
            EnableAssignmentsTab();
            EnableRuleTab();
            $("div[id$='pnlWarning']").hide();

        }

        function EnableTemplateTab() {
            $("a[tabindex='1']").removeClass("rtsDisabled").css("cursor", "");
            $("a[tabindex='1']").attr("href", "#");
        }

        function EnableRuleTab() {
            $("a[tabindex='3']").removeClass("rtsDisabled").css("cursor", "");
            $("a[tabindex='3']").attr("href", "#");
        }

        function EnableAssignmentsTab() {
            $("a[tabindex='2']").removeClass("rtsDisabled").css("cursor", "");
            $("a[tabindex='2']").attr("href", "#");
        }

        function DisableAssignmentsTab() {
            $("a[tabindex='2']").addClass("rtsDisabled").css("cursor", "no-drop");
            $("a[tabindex='2']").attr("href", "Javascript:stop(event)");
        }

        function DisableTemplateTab() {
            $("a[tabindex='1']").addClass("rtsDisabled").css("cursor", "no-drop");
            $("a[tabindex='1']").attr("href", "Javascript:stop(event)");
        }

        function DisableRuleTab() {
            $("a[tabindex='3']").addClass("rtsDisabled").css("cursor", "no-drop");
            $("a[tabindex='3']").attr("href", "Javascript:stop(event)");
        }
        function pageLoad() {
            CheckParentBox();

        }


        function CheckParentBox() {


            var rdgRights = $("div[id$='rdgDefaultTemplate']");
            var ParentIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkSelect") > 0)
                            ParentIsNotChecked = false;
                    }
                }
                i++;
            });

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;

            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }

            }
        }
        function RowClicked(sender, eventArgs) {
            var i = 0;
            var rdgRights = $("div[id$='rdgDefaultTemplate']");
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                  
                        this.checked = false;
                 
                }
                i++;
            });

        }

        function RowSelected(sender, eventArgs) {
        var ParentIsNotChecked = true;
        var i = 0;
        var grid = $find("<%=rdgDefaultTemplate.ClientID%>")
       
            var rdgRights = $("div[id$='rdgDefaultTemplate']");
            eventArgs.get_item().findElement("chkSelect").checked = true;

            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (this.checked == false) {
                        ParentIsNotChecked = false;
                    };

                }
                i++;
            });
            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;

            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }

            }


             }
        
        function SelectParent(chk) {
            var rdgRights = $("div[id$='rdgDefaultTemplate']");
            if (rdgRights.find("input[type='checkbox']")[0] == null) return;
            var chkPArent = rdgRights.find("input[type='checkbox']")[0];
           
            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (chk.checked) {
                        if (!this.checked) isChecked = false;
                    }
                }
                i++;
            });
            var row=$find("ctl00_CPH1_ucAssignments_rdgDefaultTemplate")._getRow(chk.parentElement.parentElement.id);
            if (row.get_selected() == false && chk.checked == true) {
                row.set_selected(true);
            }
            else {
                row.set_selected(false);
            
            }
            if (!chk.checked) {
                chkPArent.checked = false;
               


            } else {
                chkPArent.checked = isChecked;
             
            }
          
            return false;
        }
        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgDefaultTemplate']");
            var chk = rdgRights.find("input[type='checkbox']");
            var grid = $find("ctl00_CPH1_ucAssignments_rdgDefaultTemplate");
            var selected= iObj.checked;
            chk.each(function () {
                if (i > 0) {
                    if (this.parentElement.parentElement.id == '') return;
                    this.checked = selected;
                    grid._getRow(this.parentElement.parentElement.id).set_selected(selected);
                }
                i++;
            });
           
        }

    </script>
</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxyBP" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDefaultTemplate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDefaultTemplate" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpBusinessProcesses" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row WorkflowSinglePageWithoutToolbar">
        <div class="col-12">
<telerik:RadGrid ID="rdgDefaultTemplate" runat="server"  AutoGenerateColumns="False" AllowSorting="true" FilterType="HeaderContext"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" HeaderStyle-Font-Size="8" ShowStatusBar="true" ClientSettings-Resizing-AllowColumnResize="true"
                PageSize="60" AllowPaging="True" ShowFooter="false" ShowGroupPanel="true" GroupingEnabled="true" AllowFilteringByColumn="true" AllowMultiRowSelection="true">
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="RecordTypeId"
                    CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>

                         <telerik:GridTemplateColumn Reorderable="true" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false"  HeaderStyle-Width="50px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Record Type11" 
                            UniqueName="TranslatedRecordType" SortExpression="TranslatedRecordType" Groupable="true" Reorderable="true"
                            DataField="TranslatedRecordType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="TranslatedRecordType [GridColumn_TranslatedRecordType] Group By TranslatedRecordType ASC">
                            <ItemTemplate>
                                <span><%# Eval("TranslatedRecordType")%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Module11"
                            UniqueName="TranslatedModuleName" SortExpression="TranslatedModuleName" Groupable="true" Reorderable="true"
                            DataField="TranslatedModuleName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="TranslatedModuleName [GridColumn_TranslatedModuleName] Group By TranslatedModuleName ASC">
                            <ItemTemplate>
                                <span><%# Eval("TranslatedModuleName")%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Level11" SortExpression="EntityLevelName" GroupByExpression="EntityLevelName [GridColumn_Level] Group By EntityLevelName ASC" DataField="EntityLevelName"
                            UniqueName="Level" Groupable="true" Reorderable="true" AllowSorting="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" >
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlLevel" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged" Filter="Contains" AllowCustomText="false"
                                    runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%" Height="80px" >
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Action11"
                            UniqueName="Template" SortExpression="Template" Groupable="true" Reorderable="true"
                            DataField="Template" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Template [GridColumn_Template] Group By Template ASC">
                            <ItemTemplate>
                                <table cellpadding="0" cellspacing="0" border="0" >
                                    <tr>
                                        <td style="width:280px">
                                            <telerik:RadComboBox ID="ddlDefaultTemplate" runat="server" Width="250px" Height="350px" AllowCustomText="false" Filter="Contains" Skin="Default"></telerik:RadComboBox>
                                        </td>
                                        <td style="vertical-align:middle">
                                            <asp:LinkButton runat="server" ID="imgTemplateLink" CssClass="TemplateLinkEnabledIcon" OnClick="imgTemplateLink_Click" ><span class="Icon"></span></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                </ItemTemplate>
                            <HeaderStyle Width="300px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px;">
                                    <asp:LinkButton ID="btnSaveTemplates" runat="server" CommandName="PerformInsert" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdPerformInsert"  >
                                       <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows" 
                                        CommandName="EditRows" SecurityButtonType="ItemMode_Edit">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                                        SecurityButtonType="ItemMode"
                                        Visible='<%# rdgDefaultTemplate.EditIndexes.Count = 0 And (Not rdgDefaultTemplate.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true" AllowRowsDragDrop="false">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false"/>
                    <ClientEvents onRowSelected="RowSelected"   onRowClick="RowClicked" /> 
                </ClientSettings>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
            </telerik:RadGrid>
        </div>
    </div>
</div>
            

