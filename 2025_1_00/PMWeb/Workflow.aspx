<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Workflow.aspx.vb" Inherits="Website.Workflow" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/PmMaster.Master" %>
<%@ Register TagPrefix="ucRoles" TagName="Roles" Src="~/WorkflowRoles.ascx" %>
<%@ Register TagPrefix="ucBusinessProcesses" TagName="BusinessProcesses" Src="~/WorkflowBusinessProcesses.ascx" %>
<%@ Register TagPrefix="ucRules" TagName="APMRules" Src="~/WorkflowRules.ascx" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<%@ Register Src="WorkflowAssignments.ascx" TagName="WorkflowAssignments"
    TagPrefix="ucAssignments" %>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <script language="javascript" src="JS/Workflow/Workflow.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">


        <script language="javascript" type="text/javascript">
            function ReloadWorkflowPage(arg) {
                __doPostBack("Reloadpage", arg);
            }

            function OpenRecordTypesPopup(RecordTypeIds) {
                OpenPOPUp("WorkflowRecordTypesPopup.aspx?RecordTypeIds=" + RecordTypeIds, 420, 240, true, "rdgDefaultTemplate");
            }


            function afterClientCheck(tree, eventArgs) {
                var node = eventArgs.get_node();
                if (node.get_checked()) {
                    for (var i = 0; i < tree.get_allNodes().length; i++) {
                        if (tree.get_allNodes()[i] != node)
                            tree.get_allNodes()[i].set_checked(false);
                    }
                }
                if (tree.get_checkedNodes().length > 0) {
                    $("[id$=btnTreeDropItems]").removeClass("Hide");
                }
                else
                    $("[id$=btnTreeDropItems]").addClass("Hide");
            }

            function ToggleAssetMenu() {
                var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
                var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
                var tdAssetrestofpage = $('[id$=tdAssetrestofpage]')[0];
                var dvExpression = $('[id$=dvExpression]')[0];
                var form = $('form')[0]
                var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    tdAssetExplorerBar.style.left = "285px";
                    tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    dvExpression.className = 'col-6 col-4-middle col-6-Exp'
                    setCookie('AssetMenuStatus', 'inline', 60);
                    ResizeAllGrids();
                } else {
                    tdAssetMenu.style.display = 'none';
                    tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.style.width = "4px";
                    tdAssetrestofpage.style.width = "100%";
                    tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    dvExpression.className = 'col-8 col-4-middle col-4-8'
                    setCookie('AssetMenuStatus', 'none', 60);
                    ResizeAllGrids();
                }
                return false;
            }
            var mainsplitter = null;
            function onResized(sender, ags) {
                ////var NewWidth = sender._panes[1].get_width() - 20;
                ////sender._panes[1].set_width(NewWidth);
                ////return false;
                mainsplitter = $find(sender._element.id);
                ClientResized(sender, ags);

            }
            function OnClientCollapsed(sender, ags) {
                $("#ctl00_CPH1_ucRules_Splitter").addClass("removeLeft");
                ClientResized(sender, ags);

            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_ucRules_Splitter").removeClass("removeLeft");
                ClientResized(sender, ags);
            }
            function AssetSplitterResized(sender, ags) {

                setTimeout(FloatDivs, 100);
                //var splitter = sender.get_parent();
                //var pane1 = splitter._panes[0];
                //var pane2 = splitter._panes[1];
                //var pane2Td = pane2._element;
                //pane2Td.style.width = splitter.get_width() - pane1.get_width() - 10 + "px";
                ClientResized(sender, ags);

            }

            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                if (sender.get_parent() != null)
                    var splitter = sender.get_parent();
                else
                    var splitter = sender;
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            }

            function onClientResized(sender, ags) {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 20
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
            }

                    function fixSplitterSize(isRail) {
            if (mainsplitter == null) return;
            var tabsDocuments = $find("<%=tbsWorkflow.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();

            if (value === "APMRules") {

                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0]._element.clientWidth - 80 - 1);
                    mainsplitter.set_width(browserWidth - 80);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200 - 9);
                    mainsplitter.set_width(browserWidth - 200);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                //ClientResized(mainsplitter,null)
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
            }
            

        }
            
        </script>

    </telerik:RadCodeBlock>
    <style type="text/css">
        .removeLeft {
            left: 0 !important;
        }

        .borderColor {
            border-bottom: 1px solid #999999 !important;
        }

        .colortabs {
            background-color: #ffffff !important;
            padding: 0px !important;
            border-bottom: none;
        }



        .WorkflowTabsOnMobile{
            position: sticky;
            z-index: 999;
            top:0;
        }
   
        .ToolBarWorkflowRoles{
            margin-top:0 !important;
            top:38px !important; 
        }

        .RDRightPane div.ToolBarWorkflowRoles{
            top:0 !important;
        }

        .WorkflowSinglePageWithoutToolbar{
            margin-top:0 !important;
        }


      
    </style>
    <uc1:Message ID="Message1" runat="server" />
    <table style="width: 100% !important; background-color: #F1EFEC; height: 25px; margin: 0px; position: fixed; z-index: 999;" cellpadding="3" cellspacing="0" class="TopToolbarWorkflowCss">
        <tr>
            <td width="10%" style="padding-left: 24px; width: 160px; color: #666666 !important;">
                <asp:Label ID="lblSelectLevel" runat="server" Text="Select Level" meta:resourcekey="lblSelectLevel" Width="160px"></asp:Label>
            </td>
            <td width="20%" style="min-width: 240px; width: 240px">
                <telerik:RadComboBox ID="ddlEntities" runat="server" Width="240px" AutoPostBack="True" AllowCustomText="true"
                    CausesValidation="False" Height="350px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Select Level...">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    <ItemTemplate>
                        <span class="Icon"></span>
                        <span runat="server" id="lblText"></span>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td width="75%" style="padding-left: 5px;"></td>
        </tr>
    </table>

                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsWorkflow" SelectedIndex="0"
                    runat="server" MultiPageID="mlpProjects" CausesValidation="False" ScrollButtonsPosition="Left" ScrollChildren="true" BackColor="White"
                    OnTabClick="tbsProjects_TabClick" Width="100%" EnableViewState="true" ShowBaseLine="True" CssClass="WorkflowTabsOnMobile documentTabs">
                    <Tabs>
                        <telerik:RadTab Value="Roles" Selected="True" PageViewID="0" TabIndex="0" meta:resourcekey="tab_Roles" />
                        <telerik:RadTab Value="BusinessProcesses" PageViewID="1" TabIndex="1" meta:resourcekey="tab_BusinessProcesses" />
                        <telerik:RadTab Value="Assignments" runat="server" PageViewID="2" TabIndex="2" meta:resourcekey="tab_Assignments"  />
                        <telerik:RadTab Value="APMRules" runat="server" PageViewID="3" TabIndex="3" meta:resourcekey="tab_APMRules"  />
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage ID="mlpWorkflow" runat="server" SelectedIndex="0" Width="100%"
                    RenderSelectedPageOnly="True">
                    <telerik:RadPageView ID="pvRoles" runat="server" CssClass="MaxWidth" Selected="True">
                        <ucRoles:Roles ID="ucRoles" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvBusinessProcesses" runat="server">
                        <ucBusinessProcesses:BusinessProcesses ID="ucBusinessProcesses" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAssignments" runat="server">
                        <ucAssignments:WorkflowAssignments ID="ucAssignments" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvRules" runat="server">
                        <ucRules:APMRules ID="ucRules" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
       

    <asp:HiddenField ID="hdnEntity" runat="server" />
</asp:Content>
