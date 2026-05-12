<%@ Page Language="vb" Title="Cost Codes" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CostCodesPopup.aspx.vb" Inherits="Website.CostCodesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script src="JS/Costs/CostCodePopup.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            

            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value);
                openDivByCommandName(value);
            }

            function openDivByCommandName(value) {
                switch (value) {
                    case 'ToggleSplitter':

                        var pane = $find('rpnCostCodesTree');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        break;
                    case 'OpenHeadDiv':
                        var popup = $('#headpopup')[0];
                        popup.style.display = 'block';
                        break;
                }
            }
            function headToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'closeHead') {
                    var popup = $('#headpopup')[0];
                    $('#hdnopenDiv').val('');
                    popup.style.display = 'none';
                }
            }


            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    $('#hdnopenDiv').val('');
                    var pane = $find('rpnCostCodesTree');
                    pane.set_visible(false);
                    return false;
                }
            }

            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 10);
            }

        </script>
        <style type="text/css">
            .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                height: calc(100vh - 55px) !important;
                /*margin-top: 25px;*/
            }

            @media screen and (max-width: 843px) and (min-width: 320px) {
                .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                    margin-top: 0 !important;
                }
            }

            td.rspFirstItem {
                position: relative;
            }

            .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                margin-left: 16px !important;
                margin-right: 16px !important;
            }
        </style>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlGroups">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvCostCodes" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgCostCodes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCostCodes" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCostCodes" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="rtvCostCodes" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvCostCodes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCostCodes" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCostCodes" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvCostCodes" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarHeader ShowOnMobile" PostBack="false" CommandName="OpenHeadDiv"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter"
            Height="500px" SplitBarsSize="">
            <telerik:RadPane ID="rpnCostCodesTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <table class="treePaddingOnMobile TableNoSpacingNoBorder">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background: #EDEDED !important; padding-left: 24px; box-sizing: border-box; width: 160px !important;">
                            <asp:Label ID="lblTreeFilter" meta:resourcekey="lblTreeFilter" runat="server" Text="Group tree at this level"></asp:Label>
                        </td>
                        <td class="controlWidth" style="background: #EDEDED !important;">
                            <telerik:RadComboBox ID="ddlGroups" runat="server" Style="width: 240px !important;" AutoPostBack="true"></telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <telerik:RadTreeView ID="rtvCostCodes" runat="server" EnableDragAndDrop="True"
                                OnNodeDrop="rtvCostCodes_NodeDrop" OnClientNodeDropping="onNodeDropping"
                                OnClientNodeDragging="onNodeDragging" TriStateCheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                Skin="Default" MultipleSelect="True">
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                            </telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">&nbsp; </div>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="TreeToolbarSplitbar" CollapseMode="Forward" />
            <telerik:RadPane ID="rpnCostCodesGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane " OnClientResized="ClientResized"
                Index="2" Skin="">
                <div id="headpopup" class="popupDiv">
                    <telerik:RadToolBar ID="RadToolBar1" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                    <div class="PMMainPage PMPopupMainPage">
                        <div class="row">
                            <div class="col-4 col-4-left">
                                <table id="CompanyPeriodLocation" runat="server" class="colTable">
                                    <tr id="trCompany" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCompany" meta:resourcekey="lblCompany" runat="server" Text="Company"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPeriod" meta:resourcekey="lblPeriod" runat="server" Text="Period"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPeriods" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" AllowCustomText="true"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" Height="150px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr id="trLocations" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLocations" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Height="200px"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                                <table id="Resources1" runat="server" class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblResource" runat="server" meta:resourcekey="lblResource" Text="Resource"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlResources" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"
                                                OnClientSelectedIndexChanging="ResourceSelectedIndexChanging" Height="200px">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" meta:resourcekey="cmpddlResource" ID="cmpddlResource" ControlToValidate="ddlResources" Display="Dynamic" CssClass="Validator" ValidationGroup="Save"
                                                ErrorMessage="<br/>Select resource"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvResource" runat="server"
                                                ControlToValidate="ddlResources" ClientValidationFunction="ValidateResourceCombo"
                                                ValidationGroup="Save" Display="Dynamic" CssClass="Validator" ErrorMessage="<br/>Invalid Resource">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblResourceClassifications" runat="server" meta:resourcekey="lblResource" Text="Classification"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" Height="200px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblIncludeNotes" runat="server" Text="Include Notes" meta:resourcekey="chkIncludeNotes"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkIncludeNotes" runat="server" CssClass="mobile-switch" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table id="StartFinishCurve" runat="server" class="colTable">
                                    <tr id="trStart" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStart" meta:resourcekey="lblStart" runat="server" Text="Start"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="rdpStart" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="False">
                                                <DateInput ID="DateInput2" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr id="trFinish" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFinish" meta:resourcekey="lblFinish" runat="server" Text="Finish"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="rdpFinish" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="100%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="False">
                                                <DateInput ID="DateInput1" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr id="trCurve" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCurve" meta:resourcekey="lblCurve" runat="server" Text="Curve"></asp:Label>
                                        </td>
                                        <td class="controWidth">
                                            <telerik:RadComboBox ID="ddlCurves" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Height="200px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                                <table id="Resources2" runat="server" class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblResourcePayTypes" runat="server" meta:resourcekey="lblResource" Text="Pay Type"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlResourcePayTypes" runat="server" Width="100%" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" Height="200px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgCostCodes" runat="server" SetWidth="true" FitPageHeightOffset="24"
                                Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True"
                                GridLines="None" ClientSettings-Scrolling-AllowScroll="true">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Cost Code"
                                            UniqueName="CostCode">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="325px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description"
                                            UniqueName="Description">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="325px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Notes"
                                            UniqueName="Notes">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="325px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgCostCodes.EditIndexes.Count = 0 And (Not rdgCostCodes.MasterTableView.IsItemInserted) %>">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt" />
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />

        <telerik:RadCodeBlock ID="CodeBlock1" runat="server">
            <script type="text/javascript">
                //<![CDATA[
                var gridId;
                function pageLoad() {
                    gridId = $find("<%= rdgCostCodes.ClientID %>").get_id();
                    var value = $('#hdnopenDiv').val();
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('rpnCostCodesTree');
                    pane.set_visible(false);
                    openDivByCommandName(value);
                }
                //]]>
            </script>
        </telerik:RadCodeBlock>
    </form>
</body>
</html>
