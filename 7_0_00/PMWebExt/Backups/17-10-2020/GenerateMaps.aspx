<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="GenerateMaps.aspx.vb" Inherits="Website.GenerateMaps" %>



<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <style type="text/css">
        #ctl00_CPH1_chkSubmit,#ctl00_CPH1_chkSendDetails{
            float:right;
        }

        #ddlFields{
            margin-left:1px;
            margin-right:1px;
        }

        .PMMainPage > .row-6-5 {
            min-width: 424px;
        }

        .PMMainPage > .row > .col-6 {
            position: relative;
            min-height: 1px;
            width: 600px;
            min-width: 400px;
            padding-right: 24px !important;
        }

        .PMMainPage > .row > .col-5 {
            position: relative;
            min-height: 1px;
            width: 400px;
        }
        
        .PMMainPage > .row-6-5 > div:last-child, .PMMainPage > .row-8-4 > div:last-child {
            padding-left: 0px;
        }
    </style>
   

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
       
        <script type="text/javascript">
            function click_handler(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'New':
                        window.location = "GenerateMaps.aspx";
                        break;
                }
            }

            var ddlFromRecordId = 'a';
            function ddlFromSelectedIndexChanging(sender, args) {
                ddlFromRecordId = 'a';
                if (args.get_item()) ddlFromRecordId = args.get_item().get_value();
            }

            function ddlFromDropDownOpening(sender, args) {
            }

            function CheckddlFromRecord(sender, args) {
                var combo = $find(sender.controltovalidate);
                if (combo.get_selectedItem() != null) {
                    if (isNumeric(ddlFromRecordId) == true && ddlFromRecordId > 0) {
                        args.IsValid = true;
                    } else if (combo.get_selectedItem().get_index() > 0) {
                        args.IsValid = true;
                    }
                    else {
                        args.IsValid = false;
                    }
                } else {
                    args.IsValid = false;
                }
                return;
            }

            var ddlToRecordId = 'a';
            function ddlToSelectedIndexChanging(sender, args) {
                ddlToRecordId = 'a';
                if (args.get_item()) ddlToRecordId = args.get_item().get_value();
            }

            function ddlToDropDownOpening(sender, args) {
            }

            function CheckddlToRecord(sender, args) {
                var combo = $find(sender.controltovalidate);
                if (combo.get_selectedItem() != null) {
                    if (isNumeric(ddlToRecordId) == true && ddlToRecordId > 0) {
                        args.IsValid = true;
                    } else if (combo.get_selectedItem().get_index() > 0) {
                        args.IsValid = true;
                    }
                    else {
                        args.IsValid = false;
                    }
                } else {
                    args.IsValid = false;
                }
                return;
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgMapping">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgMapping" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server" Skin="Default">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=246">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar">
                <telerik:RadComboBox ID="ddlMaps" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="false" NoWrap="true"
                    Height="250px" CausesValidation="False" AllowCustomText="true" EmptyMessage="Select Map..."
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" meta:resourcekey="ddlMaps"
                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png" Value="Search" NavigateUrl="SearchDocument.aspx?O=246" CausesValidation="false"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save">
                        </telerik:RadToolBarButton>

                      <%--  <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>--%>
                                <telerik:RadToolBarButton SecurityButtonType="Add" Visible="true"
                                    ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                </telerik:RadToolBarButton>
                         <%--   </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
        <div class="PMMainPage documentSinglePage">
                <div class="row row-6-5">
                    <div class="col-6">
                        <table class="colTable" style="width: 400px;">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblMapID" Text="Map ID" runat="server" meta:resourcekey="lblMapID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtMapID" runat="server"></asp:TextBox>
                                    <asp:Label ID="lblMsgUnique" runat="server" CssClass="Validator" meta:resourcekey="lblMsgUnique"></asp:Label>
                                    <asp:RequiredFieldValidator ID="rfvMapID" runat="server" ValidationGroup="Save" ControlToValidate="txtMapID"
                                        CssClass="Validator" Display="Dynamic" ErrorMessage="Required" meta:resourcekey="rfvMapID"
                                        ForeColor=""></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" Text="Description" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDescription" Text="" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ValidationGroup="Save" ControlToValidate="txtDescription"
                                        CssClass="Validator" Display="Dynamic" ErrorMessage="Required" meta:resourcekey="rfvrequired"
                                        ForeColor=""></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFrom"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlFrom" AutoPostBack="true" AllowCustomText="true" Filter="Contains" OnClientSelectedIndexChanging="ddlFromSelectedIndexChanging"
                                        runat="server" Skin="Default" Style="font-size: 11px" Height="300px" OnClientDropDownOpening="ddlFromDropDownOpening">
                                    </telerik:RadComboBox>
                                    <asp:CustomValidator ID="csvFrom" runat="server" ControlToValidate="ddlFrom" ValidateEmptyText="true"
                                        ClientValidationFunction="CheckddlFromRecord" Display="Dynamic" ValidationGroup="Save"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblTo"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlTo" AutoPostBack="false" AllowCustomText="true" Filter="Contains" OnClientSelectedIndexChanging="ddlToSelectedIndexChanging"
                                        runat="server" Skin="Default" Style="font-size: 11px" Height="300px" OnClientDropDownOpening="ddlToDropDownOpening">
                                    </telerik:RadComboBox>
                                    <asp:CustomValidator ID="csvTo" runat="server" ControlToValidate="ddlTo" ValidateEmptyText="true"
                                        ClientValidationFunction="CheckddlToRecord" Display="Dynamic" ValidationGroup="Save"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                        </table>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblMapping" runat="server" Text="Mapping11" meta:ResourceKey="lblMapping"></asp:Label></legend>
                            <telerik:RadGrid ID="rdgMapping" runat="server" AutoGenerateColumns="False" AllowSorting="true" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                HeaderStyle-Font-Size="8" ShowStatusBar="true" PageSize="20" ShowFooter="false" ClientSettings-Scrolling-AllowScroll="true">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id"
                                    CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                    <Columns>
                                        <telerik:GridTemplateColumn >
                                            <HeaderTemplate>
                                                <asp:Label ID="lblGenerateFrom" runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlFields" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFields_SelectedIndexChanged" Width="240px"></telerik:RadComboBox>&nbsp;&nbsp;
                                                <asp:TextBox ID="txtCustomField" runat="server" Width="100px"></asp:TextBox>
                                                <asp:TextBox ID="txtCustomFieldDate" runat="server" Width="100px" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);" onblur="parseDate(this, event);"></asp:TextBox>
                                                <asp:TextBox ID="txtCustomFieldTime" runat="server" Width="100px"></asp:TextBox>
                                                <asp:CheckBox ID="chkCustomField" runat="server" />
                                                <asp:Label ID="lblRequired" CssClass="Validator" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="370px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn>
                                            <HeaderTemplate>
                                                <asp:Label ID="lblGenerateTo" runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblFieldFriendlyName" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="210px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                    <CommandItemTemplate>
                                        <div style="padding: 2px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnSaveTemplates" runat="server" CommandName="UpdateMapping" CssClass="GridCmdUpdateMapping" SecurityButtonType="ItemMode_Edit">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="false" AllowRowsDragDrop="false">
                                    <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                </ClientSettings>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                    <div class="col-5">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSystemMap" Text="System Map" runat="server" meta:resourcekey="lblSystemMap"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkSystemMap" runat="server" Enabled="false" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAccessedFrom" Text="Accessed From" runat="server" meta:resourcekey="lblAccessedFrom"></asp:Label>
                                </td>
                                <td class="labelWidth">
                                    <asp:Label ID="lblMsgAccessedFrom" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSystemNotes" Text="System Notes" runat="server" meta:resourcekey="lblSystemNotes"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtMsgSystemNotes" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblOptions" runat="server" Text="Options" meta:ResourceKey="lblOptions"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubmit" Text="Submit New Record in Workflow" runat="server" meta:resourcekey="lblSubmit" Width="200px"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkSubmit" runat="server" style="margin:0;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSendDetails" Text="Send Details" runat="server" meta:resourcekey="lblSendDetails"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkSendDetails" runat="server" Enabled="false" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
        </div>
    </telerik:RadAjaxPanel>

</asp:Content>
