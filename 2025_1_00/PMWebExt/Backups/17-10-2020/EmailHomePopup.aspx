<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailHomePopup.aspx.vb" meta:resourcekey="Page" Inherits="Website.EmailHomePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EmailSend.ascx" TagName="EmailSend" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        
        .documentSplitter{
            padding-top: 50px;
        }

        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 55px) !important;
        }

        .ZIndex {
            z-index: 9001 !important;
        }
        @media screen and (max-width: 843px) {
            #RAD_SPLITTER_PANE_CONTENT_tdTree {
                height: 100vh !important;
                z-index: 3000;
            }

            #RadSplitter1.documentSplitter {
                z-index: 3000 !important;
                margin-top: 42px !important;
                border-top: black 1px solid;
                padding-top: 0 !important;
            }

            #RAD_SPLITTER_PANE_CONTENT_RadContentPane.fullWidthPane {
                width: 100vw !important;
            }

            .documentSinglePage {
                margin-top: 19px !important;
                margin-bottom: 0 !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgEmails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgEmails" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnShowEmail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="EmailDetailsView" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <%--<telerik:AjaxSetting AjaxControlID="btnRefreshEmails"  >
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="mainToolBar"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM"/>
				</UpdatedControls>
			</telerik:AjaxSetting>--%>

                <%--<telerik:AjaxSetting AjaxControlID="btnNewEmail"  >
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM"/>
				</UpdatedControls>
			</telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
            <script type="text/javascript">
                var forceMoreMenuToClose = true;
                /* <![CDATA[ */
                var toolbar;
                var grid;
                var searchButton;
                var gridId;
                var rowCheckColClicked;
                function DisableAttachmentLinkPostBack() {
                    return false;
                }
                function pageLoad() {
                    gridId = '<%=rdgEmails.ClientID %>';
                    grid = $find("<%=rdgEmails.ClientID %>");
                    $("[id$='chkProject']").change(function () { SetDirty_ddlProjects(); });

                    $("table[id$=rdgEmails_ctl00].rgMasterTable").find("tr>td:nth-child(1)").click(function () {
                        rowCheckColClicked = true;
                    });

                    appendCheckboxAll();
                    toolbar = $find("<%= mainToolBar.ClientID %>");
                    if (!toolbar) return;
                    ReplyButton = toolbar.findButtonByCommandName("EmailReply");
                    MobileReplyButton = toolbar.findButtonByCommandName("MobileMenu").findControl("MobileRadmen").findItemByValue("EmailReply");

                    if (grid) {
                        if (grid.get_masterTableView().get_selectedItems().length == 0) {
                            if (ReplyButton) {
                                ReplyButton.disable();
                            }
                            if (MobileReplyButton) {
                                MobileReplyButton.disable();
                            }
                        }
                        searchButton = toolbar.findButtonByCommandName("doSearch");

                        $telerik.$(".inbox-search-textbox")
                        .bind("keypress", function (e) {
                            // searchButton.set_imageUrl("images/Email/search.gif");
                            searchButton.set_value("search");
                        });
                    }
                }
                function Email_Selected(sender, eventArgs) {
                    var EmailId = eventArgs.getDataKeyValue("EmailId");
                    var Subject = eventArgs.getDataKeyValue("Subject");
                    var Notes = eventArgs.getDataKeyValue("FileNames");
                    if (Subject.length > 500) {
                        Subject = Subject.substring(0, 500);
                    }
                    var From = eventArgs.getDataKeyValue("EmailFrom");
                    var To = eventArgs.getDataKeyValue("EmailTo");
                    var ctlId = $(window.parent.document).find("input[id$='hdnSelectedElementId']");
                    var attachement_row = $(ctlId).parents("tr:first");
                    var txtLink = attachement_row.find("[id$=txtEmailName]").val('From:' + From + ',To:' + To);
                    var txtDescription = attachement_row.find("[id$=txtDescription]").val(Subject);
                    var hdnFileId = attachement_row.find("[id$=hdnSelectedEmailId]").val(EmailId);
                    if (Notes != "") {
                        var txtNotes = attachement_row.find("[id$=txtNotes]").val("Attachments:" + Notes);
                    }
                    CloseRadWnd();
                }

                function NodeChecked(sender, eventArgs) {
                    SetDirty_ddlProjects();
                    var combo = $find("ddlPropertiesAndProjects");
                    var node = eventArgs.get_node();
                    var checked = node.get_checked();
                    var childNodes = node.get_nodes();
                    if (checked == true) {
                        CheckParent(node);
                        //              UncheckAllChildren(childNodes);
                        //              UncheckAllParent(node);
                        var tree = $find(node.get_treeView().get_id());
                        if (node.get_value() == "-1") {
                            var allCheckedNodes = tree.get_checkedNodes();
                            var TotalChecked = allCheckedNodes.length
                            for (var i = TotalChecked - 1; i >= 0 ; i--) {
                                var CkeckedNode = allCheckedNodes[i];
                                if (CkeckedNode.get_value() != "-1") {
                                    CkeckedNode.set_checked(false);

                                }

                            }
                        }
                        else {
                            var AllNode = tree.findNodeByValue("-1");
                            if (AllNode != null)
                                AllNode.set_checked(false);
                        }
                        var selectedCount = tree.get_checkedNodes()
                        if (selectedCount.length == 1) {

                            var SelectedNode = tree.get_checkedNodes()[0];
                            combo.set_text(SelectedNode.get_text());


                        }
                        else if (selectedCount.length > 1) {

                            combo.set_text($("input[id$=hdnPropertyAndProjectSelectedMsg]").val());
                        }
                        else
                            combo.set_text("");

                        return;
                    }

                    var rdvtree = $find(node.get_treeView().get_id());
                    var AllCheckedCount = rdvtree.get_checkedNodes().length;
                    if (AllCheckedCount == 0) {
                        combo.set_text("");
                    }
                }
                function UncheckAllParent(node) {

                    node = node.get_parent();
                    while (node != null && node._element.id.toString().indexOf("ddlPropertiesAndProjects") == -1) {
                        node.set_checked(false);
                        node = node.get_parent();
                    }
                }
                function UncheckAllChildren(nodes) {
                    var i;
                    for (i = 0; i < nodes.get_count() ; i++) {
                        nodes.getNode(i).set_checked(false);

                        if (nodes.getNode(i).get_nodes().get_count() > 0)
                            UncheckAllChildren(nodes.getNode(i).get_nodes());

                    }

                }
                function CheckParent(node) {
                    node = node.get_parent();
                    while (node != null && node._element.id.toString().indexOf("ddlPropertiesAndProjects") == -1) {
                        node.set_checked(true);
                        node = node.get_parent();
                    }
                }

                function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                    var left = (screen.width - 920) / 2;
                    var top = (screen.height - 300) / 2;
                    var Bidder = 0;

                    var win = window.open('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source, '',
                       'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                    return false;
                }
                /* ]]> */

                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter') {
                        var pane = $find('tdTree');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        return false;
                    }
                    if (args.get_item().get_commandName() == 'Cancel') {
                        var pane = $find('tdTree');
                        pane.set_visible(false);
                    }

                }
                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                        sender.close(true);
                    if (args.get_item().get_value() == "ReceiveEmail" || args.get_item().get_value() == "Receive") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ReceiveEmail");
                        button.click();
                    }
                    if (args.get_item().get_value() == "EmailReply") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("EmailReply");
                        button.click();
                    }
                    if (args.get_item().get_value() == "SaveLayout") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("SaveLayout");
                        button.click();
                    }
                    if (args.get_item().get_value() == "LoadDefaultState") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("LoadDefaultState");
                        button.click();
                    }
                }
                function MoreMenuClosing(sender, args) {
                    if (forceMoreMenuToClose) {
                        //forceradmenuToClose = false;
                        return;
                    }
                    args.set_cancel(true);
                }
                function MoreMenuOpening(sender, args) {
                    if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

                }
            </script>
            <script type="text/javascript" src="JS/Email/EmailHomePopup.js"></script>
        </telerik:RadScriptBlock>
        <asp:HiddenField runat="server" ID="hdnPropertyAndProjectSelectedMsg" />
        <asp:HiddenField ID="hdnProjectId" runat="server" EnableViewState="true" />
        <asp:HiddenField ID="hdnPropertyId" runat="server" EnableViewState="true" />
        <asp:Button runat="server" ID="btnSearchEmails" Text="SearchEmails" CssClass="Hide" />
        <%--<div  ID="divEmailContent" class="Hide" ></div>--%>
        <asp:HiddenField runat="server" ID="hdnSearchValue" />
        <asp:Button runat="server" ID="btnNewEmail" Text="New Email" CssClass="Hide" />
        <asp:Button runat="server" ID="btnRefreshEmails" Text="Refresh Emails" CssClass="Hide" />
        <asp:Button runat="server" ID="btnReply" Text="Reply" CssClass="Hide" />
        <asp:Button runat="server" ID="btnShowEmail" Text="ShowEmail" CssClass="Hide" />
        <asp:Button runat="server" ID="btnRefreshWithPostback" Text="Refresh Emails" CssClass="Hide" />

        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadComboBox ID="ddlPropertiesAndProjects" runat="server" Skin="Default" AllowCustomText="True" DropDownCssClass="ddlTreeviewTemplate"
                        Width="240px" CloseDropDownOnBlur="true" DropDownWidth="500px" OnClientDropDownClosing="OnClientDropDownClosing_ddlProjects">
                        <Items>
                            <telerik:RadComboBoxItem Text="" />
                        </Items>
                        <ItemTemplate>
                            <telerik:RadTreeView ID="rdvPropertiesAndProjects" Skin="Default" runat="server" CheckBoxes="true"
                                Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeChecked="NodeChecked"
                                OnNodeExpand="rdvPropertiesAndProjects_NodeExpand">
                            </telerik:RadTreeView>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:Button ID="btnGetProjects" class="Hide" runat="server" Text="Go" />
                </td>
            </tr>
        </table>

        <telerik:RadSplitter ID="RadSplitter1" CssClass="documentSplitter" runat="server" Orientation="vertical" Skin="Default" Width="100%" Height="600px">
            <telerik:RadPane ID="tdTree" runat="server" CssClass="NormalWhiteBack SplitterPanePopup ZIndex" Height="600px" Width="420px">
                <table style="width: 100%; background-color: RGB(237,237,237);" class="TableNoSpacingNoBorder">
                    <tr>
                        <td style="padding-left: 24px;">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" Height="50px" OnClientButtonClicked="treeToolbarClick" Style="line-height: 50px;">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="Cancel" Height="50px"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>

                <telerik:RadTreeView Width="100%" Height="100%" runat="Server" ID="treeEmails" OnNodeClick="treeEmails_NodeClick"
                    EnableViewState="true">
                </telerik:RadTreeView>


            </telerik:RadPane>

            <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward"  CssClass="TreeToolbarSplitbar" />
            <telerik:RadPane ID="RadContentPane" runat="server" Height="600px" CssClass="fullWidthPane OverflowHidden">
                <div runat="server" id="divEmailsView">
                 
                                <div style="height: 32px;">
                                    <telerik:RadToolBar runat="server" ID="mainToolBar" CssClass="inbox-search-toolbar"
                                        Width="100%" Skin="Default" OnClientButtonClicked="treeToolbarClick" EnableViewState="false">
                                        <Items>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarNewEmail" CommandName="NewEmail" meta:resourcekey="ToolBar_NewEmail"
                                                ToolTip="New Email" PostBack="false" Enabled="True" Value="NewEmail" />
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarRefresh" CommandName="Refresh" ToolTip="Refresh"
                                                Enabled="True" />
                                            <telerik:RadToolBarButton SecurityButtonType="Delete" EnableImageSprite="true" CssClass="ToolbarDelete" CommandName="Delete" ToolTip="Delete"
                                                Enabled="True" Value="Delete"/>
                                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar" />
                                            <telerik:RadToolBarButton SecurityButtonType="Edit" Text="Receive" PostBack="false" EnableImageSprite="true" CssClass="ToolbarReceiveEmail" ToolTip="Receive Emails"
                                                CommandName="ReceiveEmail" Value="ReceiveEmail" OuterCssClass="HideOnMobileToolbar" />
                                            <telerik:RadToolBarButton Text="Reply" SecurityButtonType="Add" Value="EmailReply" PostBack="false" EnableImageSprite="true" CssClass="ToolbarEmailReply"
                                                CommandName="EmailReply" ToolTip="Reply" OuterCssClass="HideOnMobileToolbar" />
                                            <telerik:RadToolBarSplitButton EnableImageSprite="true" CssClass="ToolbarLayout" CommandName="Layout" PostBack="false"
                                                EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar">
                                                <Buttons>
                                                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="True" CommandName="SaveLayout" Value="SaveLayout" CssClass="ToolbarUser">
                                                    </telerik:RadToolBarButton>
                                                    <telerik:RadToolBarButton PostBack="True" EnableImageSprite="true" CommandName="LoadDefaultState" Value="LoadDefaultState" CssClass="ToolbarDelegate">
                                                    </telerik:RadToolBarButton>
                                                </Buttons>
                                            </telerik:RadToolBarSplitButton>
                                            <telerik:RadToolBarButton Value="searchTextBoxButton" PostBack="false" CommandName="searchText" OuterCssClass="HideOnMobileToolbar">
                                                <ItemTemplate>
                                                    <telerik:RadTextBox runat="server" ID="txtSearchInbox" EmptyMessage="Search Inbox" meta:resourcekey="txtSearchInbox"
                                                        CssClass="inbox-search-textbox" Width="300px" ClientEvents-OnKeyPress="onKeyPress" />
                                                </ItemTemplate>
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" Value="search" CssClass="ToolbardoSearch"
                                                CommandName="doSearch" OuterCssClass="HideOnMobileToolbar" />
                                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                                <ItemTemplate>
                                                    <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                        <Items>
                                                            <telerik:RadMenuItem CssClass="menuMore">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Receive" EnableImageSprite="true" CssClass="ToolbarReceiveEmail" Value="ReceiveEmail" />
                                                                    <telerik:RadMenuItem Text="Reply" Value="EmailReply" SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarEmailReply" />
                                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="Layout" Value="Layout" CssClass="ToolbarLayout" PostBack="True">
                                                                        <Items>
                                                                            <telerik:RadMenuItem Text="Save Layout" EnableImageSprite="true" PostBack="True" Value="SaveLayout" CssClass="ToolbarUser"></telerik:RadMenuItem>
                                                                            <telerik:RadMenuItem Text="Load Default State" EnableImageSprite="true" PostBack="True" Value="LoadDefaultState" CssClass="ToolbarDelegate"></telerik:RadMenuItem>
                                                                        </Items>
                                                                    </telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenu>
                                                </ItemTemplate>
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                </div>
                    
                                <div style="height: 250px; padding-top: 18px;">
                                    <telerik:RadGrid runat="server" ID="rdgEmails" AutoGenerateColumns="false" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                        GridLines="None" Height="250px" BorderWidth="0" SetWidth="true" Width="200px" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                        AllowMultiRowSelection="false" AllowSorting="true" Style="outline: none" ShowGroupPanel="true"
                                        AllowPaging="True" PageSize="5">
                                        <ClientSettings Scrolling-AllowScroll="True" Scrolling-UseStaticHeaders="true" Selecting-AllowRowSelect="true"
                                            AllowDragToGroup="true" EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="True"></Selecting>
                                            <ClientEvents OnRowSelected="onGridRowSelected" OnRowDblClick="Email_Selected"></ClientEvents>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                                        </ClientSettings>

                                        <MasterTableView TableLayout="Fixed" ClientDataKeyNames="EmailId,Subject,EmailTo,EmailFrom,FileNames" EnableHeaderContextMenu="true" GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderStyle-Width="18px" Groupable="false" HeaderStyle-CssClass="tdchkHeader">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelected" runat="server" CssClass="ChkEmail" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn UniqueName="Name" HeaderText="Project/Location Name" GroupByExpression="Name [GridColumn_Name] Group By Name ASC"
                                                    HeaderStyle-Width="120px" SortExpression="Name" DataField="Name">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("Name")%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="To" HeaderStyle-Width="170px" UniqueName="EmailTo" DataField="EmailTo"
                                                    GroupByExpression="EmailTo [GridColumn_EmailTo] Group By EmailTo ASC" SortExpression="EmailTo">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("EmailTo")%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="From" HeaderStyle-Width="170px" UniqueName="EmailFrom"
                                                    GroupByExpression="EmailFrom [GridColumn_EmailFrom] Group By EmailFrom ASC" SortExpression="EmailFrom" DataField="EmailFrom">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("EmailFrom")%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Subject" UniqueName="Subject" SortExpression="Subject" HeaderText="Subject" GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("Subject")%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="200px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Date" DataField="DeliveryDate" HeaderStyle-Width="150px" SortExpression="DeliveryDate" UniqueName="DeliveryDate" GroupByExpression="DeliveryDate [GridColumn_DeliveryDate]  GROUP BY DeliveryDate">
                                                    <ItemTemplate>
                                                        <span>
                                                            <%#FormatDate(CDate(Container.DataItem("DeliveryDate")))%>&nbsp;</span>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <HeaderStyle Width="100px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn Groupable="false" HeaderImageUrl="~/Images/Email/attachment-icon.png" HeaderStyle-Width="30px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="attachment"
                                                            runat="server" Visible='<%# CBool(CInt(Eval("AttachmentsCount")) > 0) %>'
                                                            class="AttachmentButton" OnClientClick="return DisableAttachmentLinkPostBack();">
                                                  <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                        &nbsp;
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                                    CancelImageUrl="Cancel.gif">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false"
                                            AllowDragToGroup="true">

                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                AllowColumnResize="True"></Resizing>
                                            <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                  


                    <div style="overflow: auto; height: 295px; border-top: 3px solid #C4DBF9">

                        <asp:DetailsView runat="server" ID="EmailDetailsView" AutoGenerateRows="false" CssClass="message-view"
                            GridLines="None" EnableViewState="false">
                            <Fields>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <ul style="list-style-type: none">
                                            <li>
                                                <h3 id="subject">
                                                    <%# Eval("Subject") %></h3>
                                            </li>
                                            <li>
                                                <asp:Label runat="server" ID="lblFrom" Text="From: " meta:resourcekey="lblFrom"></asp:Label>
                                                <span id="from">
                                                    <%# Eval("EmailFrom") %></span></li>
                                            <li>
                                                <asp:Label runat="server" ID="lblTo" Text="To: " meta:resourcekey="lblTo"></asp:Label>
                                                <span id="To">
                                                    <%# Eval("EmailTo") %></span></li>
                                            <li>
                                                <asp:Label runat="server" ID="lblDate" Text="Sent: " meta:resourcekey="lblDate"></asp:Label>
                                                <span id="sent">
                                                    <%#Eval("DeliveryDateTime")%></span></li>
                                            <li>
                                                <div class="MaxWidth" style="display: inline-block">
                                                    <div class="floatLeft">
                                                        <asp:Label runat="server" ID="lblAttachments" Text="Attachments:" meta:resourcekey="lblAttachments"></asp:Label>&nbsp;
                                                    </div>
                                                    <asp:Repeater ID="rptEmailAttachments" runat="server">
                                                        <ItemTemplate>
                                                            <div class="floatLeft">
                                                                <a id="lkDownload" runat="server" href="#" onclick='<%# Me.GetUrlLinkForDownload(Eval("FullFileName"), False) %>'>
                                                                    <%#Eval("FileWithExtension")%></a>&nbsp;
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </li>
                                        </ul>
                                        <div id="message-body">
                                            <%#Eval("Body").ToString().Replace("\n", "<br />")%>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </div>
                </div>
                <div runat="server" id="divEmailSend" visible="false">
                    <uc1:EmailSend ID="EmailSend1" runat="server" />
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
    </form>
</body>
</html>
