<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="CustomFormTypes.aspx.vb" Inherits="Website.CustomFormTypes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CustomFormTypeValues.ascx" TagName="CustomFormTypeValues" TagPrefix="uc1" %>
<%@ Register Src="CustomFormPermissions.ascx" TagName="CustomFormPermissions" TagPrefix="uc2" %>
<%@ Register Src="CustomFormTypesTemplate.ascx" TagName="CustomFormTypesTemplate" TagPrefix="uc3" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <style>
        .rgDataDiv {
            width: auto !important;
            max-height: 184px !important;
            height: auto !important;
        }

        .RadWindow .rwWindowContent iframe {
            display: block;
            height: 100% !important;
        }

        .RadGrid .rgSelectedRow td {
            border: none !important;
        }

        .RadGrid .RadPicker.RadPicker_Default {
            width: 150px !important;
        }
    </style>



    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">

            //window.addEventListener("resize" , function(){
            //    var tab = document.querySelector('.rtsUL');
            //    if (tab) {
            //        var totalChildWidth = 0;
            //        var parentWidth = tab.parentElement.clientWidth;
            //        for (i = 0 ; i < tab.childElementCount ; i++) {
            //            totalChildWidth += tab.children[i].querySelector(".rtsTxt").clientWidth;
            //        }
            //        if (parentWidth > totalChildWidth) {
            //            for (i = 0 ; i < tab.childElementCount ; i++) {
            //                tab.children[i].style.width = tab.parentElement.clientWidth / tab.childElementCount + "px";
            //            }
            //            tab.style.width = parentWidth + 'px';
            //        } else {
            //            tab.style.width = totalChildWidth + 'px';
            //        }
            //    }
            //});




            var forceMoreMenuToClose = true;
            function CustomFormType_ResetCombos(combobox, eventArgs) {
                var ddlDefaultValues = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('CustomFormTypeValuesFieldType'), combobox.get_id().lenght - 1) + 'CustomFormTypeValuesDefaultValue_ddlDefaultValues');
                if (ddlDefaultValues != null) {
                    ddlDefaultValues.clearItems();
                    ddlDefaultValues.set_text('');
                    ddlDefaultValues.set_value('');
                }
            }




            function CustomFormType_GetValueToReturn(combobox, eventArgs) {
                var context = eventArgs.get_context();
                var ddlLists = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('CustomFormTypeValuesDefaultValue'), combobox.get_id().lenght - 1) + 'CustomFormTypeValuesFieldType_ddlLists');
                if (ddlLists != null) {
                    var selectedValue = ddlLists.get_value();
                    context["ListId"] = selectedValue;
                } else {
                    context["ListId"] = 0;
                }
            }

            function OpenCustomTableDesigner(Id) {
                OpenPOPUp('CustomFormTableDesigner.aspx?Id=' + Id, 790, 700, true, 'rdgCustomTables');
                return false;
            }

            function RequiredFieldsMessage(Required) {
                alert(Required);
            }
            function inValidateFieldsMessage(Validate) {
                alert(Validate);
            }

            function OnClientSelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                if (document.getElementById('divtxtLists')) {
                    if (item.get_index() == 6) {
                        document.getElementById('divtxtLists').style.display = 'inline';
                    } else {
                        document.getElementById('divtxtLists').style.display = 'none';
                    }
                }
            }


            function ShowHideLists(SelectedIndex) {
                if (document.getElementById('divtxtLists')) {
                    if (SelectedIndex == 6) {
                        document.getElementById('divtxtLists').style.display = 'inline';
                    } else {
                        document.getElementById('divtxtLists').style.display = 'none';
                    }
                }
            }


            function ddlList_GetCustomListItems(sender, eventArgs) {
                var x = $(combobox).parents("tr:first");
                var item = eventArgs.get_item();
                var ddlValues = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlValues');

            }

            function ColumnListsIndexChanging(sender, eventArgs) {
                var item = eventArgs.get_item();
                if (document.getElementById('divColumnLists')) {
                    if (item.get_index() == 5) {
                        document.getElementById('divColumnLists').style.display = '';
                    } else {
                        document.getElementById('divColumnLists').style.display = 'none';
                    }
                }
            }


            function CheckViewRight(chkViewOnly) {
                var tr = $(chkViewOnly).parents("tr:first");
                if (!chkViewOnly.checked) {
                    tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                    tr.find("input[id $= 'chkCanAdd']")[0].checked = false;
                    tr.find("input[id $= 'chkCanDelete']")[0].checked = false;
                    tr.find("input[id $= 'chkCanEdit']")[0].checked = false;
                    tr.find("input[id $= 'chkEditPermissions']")[0].checked = false;

                }
            }


            function CheckRight(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkRight.checked) {
                    chkCanRead.checked = true;
                    if (chkCanAdd.checked && chkCanEdit.checked && chkCanDelete.checked && chkEditPermissions.checked)
                        chkFullControl.checked = true;
                } else {
                    chkFullControl.checked = false;
                }
            }


            function CheckAdd(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkRight.checked) {
                    chkCanRead.checked = true;
                    if (chkCanAdd.checked && chkCanEdit.checked && chkCanDelete.checked && chkEditPermissions.checked)
                        chkFullControl.checked = true;
                } else {
                    chkFullControl.checked = false;
                }
                if (chkCanAdd.checked) {
                    chkCanEdit.checked = true;
                }
            }

            function CheckFullControlRight(chkFullControl) {
                var tr = $(chkFullControl).parents("tr:first");
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkFullControl.checked) {
                    chkCanRead.checked = true;
                    chkCanAdd.checked = true;
                    chkCanEdit.checked = true;
                    chkCanDelete.checked = true;
                    chkEditPermissions.checked = true;
                } else {
                    chkCanRead.checked = false;
                    chkCanAdd.checked = false;
                    chkCanEdit.checked = false;
                    chkCanDelete.checked = false;
                    chkEditPermissions.checked = false;
                }
            }

            function CheckSelectViewRight(chkViewOnly) {
                var tr = $(chkViewOnly).parents("tr:first");
                if (!chkViewOnly.checked) {
                    tr.find("input[id $= 'chkSelectFullControl']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanAdd']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanDelete']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanEdit']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectEditPermissions']")[0].checked = false;

                }
            }


            function CheckSelectRight(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkSelectFullControl = tr.find("input[id $= 'chkSelectFullControl']")[0];
                var chkSelectCanRead = tr.find("input[id $= 'chkSelectCanRead']")[0];
                var chkSelectCanAdd = tr.find("input[id $= 'chkSelectCanAdd']")[0];
                var chkSelectCanEdit = tr.find("input[id $= 'chkSelectCanEdit']")[0];
                var chkSelectCanDelete = tr.find("input[id $= 'chkSelectCanDelete']")[0];
                var chkSelectEditPermissions = tr.find("input[id $= 'chkSelectEditPermissions']")[0];
                if (chkRight.checked) {
                    chkSelectCanRead.checked = true;
                    if (chkSelectCanAdd.checked && chkSelectCanEdit.checked && chkSelectCanDelete.checked && chkSelectEditPermissions.checked)
                        chkSelectFullControl.checked = true;
                } else {
                    chkSelectFullControl.checked = false;
                }
            }

            function CheckSelectFullControlRight(chkFullControl) {
                var tr = $(chkFullControl).parents("tr:first");
                var chkSelectCanRead = tr.find("input[id $= 'chkSelectCanRead']")[0];
                var chkSelectCanAdd = tr.find("input[id $= 'chkSelectCanAdd']")[0];
                var chkSelectCanEdit = tr.find("input[id $= 'chkSelectCanEdit']")[0];
                var chkSelectCanDelete = tr.find("input[id $= 'chkSelectCanDelete']")[0];
                var chkSelectEditPermissions = tr.find("input[id $= 'chkSelectEditPermissions']")[0];
                if (chkFullControl.checked) {
                    chkSelectCanRead.checked = true;
                    chkSelectCanAdd.checked = true;
                    chkSelectCanEdit.checked = true;
                    chkSelectCanDelete.checked = true;
                    chkSelectEditPermissions.checked = true;
                } else {
                    chkSelectCanRead.checked = false;
                    chkSelectCanAdd.checked = false;
                    chkSelectCanEdit.checked = false;
                    chkSelectCanDelete.checked = false;
                    chkSelectEditPermissions.checked = false;
                }
            }

            function openCalculationPopup(FieldId, SenderId) {
                OpenPOPUp('UDFCalcutionHelper.aspx?Sender=CUSTOMFIELDS&FieldId=' + FieldId + '&SenderId=' + SenderId.id, 745, 563);
                return false;
            }
            function openCalculationPopup2(FieldId, SenderId) {
                OpenPOPUp('UDFCalcutionHelper.aspx?Sender=CUSTOMCOLUMNS&FieldId=' + FieldId + '&SenderId=' + SenderId.id, 745, 563);
                return false;
            }

            function removeClass() {
                setTimeout(function () {
                    var CustomFormTypeId = '<%=CStr(PM.Workflow.CustomFormTypeInfo.Id)%>'
                    var toolbar = $find("<%=mainToolBar.ClientID%>");
                    var element = toolbar.findItemByValue("Preview")
                    element.get_element().classList.remove("rtbItemFocused")
                    $(element).removeClass("rtbItemFocused");
                }, 10);

            }

            function OpenPOPUps(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "rmPreview") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Preview");
                        button.click();
                    }

                    if (args.get_item().get_value() == "Print") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Print");
                        button.click();
                    }

                    if (args.get_item().get_value() == "Active") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activate");
                        button.click();
                    }

                    if (args.get_item().get_value() == "InActive") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activate");
                        button.click();
                    }

                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), args.get_item().get_element())
            }


            function maintoolbarClick(Value, ItemElement) {
                if (Value == 'Preview') {
                    var CustomFormTypeId = '<%=CStr(PM.Workflow.CustomFormTypeInfo.Id)%>'
                    var element = ItemElement;
                    $(element).removeClass("rtbItemFocused");
                    OpenPOPUps('CustomFormTypePreviewPopup.aspx?Id=' + CustomFormTypeId + '&IsPreview=true', 1195, 570);
                    return false;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function fixSplitterSize(isRail) {
                if (mainsplitter == null) return;
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    mainsplitter.set_width(browserWidth - 80);
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
                }
                else {
                    mainsplitter.set_width(browserWidth - 200);
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
                }
                if (browserWidth <= 843) {
                    mainsplitter.set_width(browserWidth - 20);
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }


            }
            var mainsplitter = null;
            function onResized(sender, ags) {
                mainsplitter = $find(sender._element.id);
                var pane = mainsplitter._panes[0];
                if (getCookie('CustomFormTypesStatus') === 'none') {
                    $("#ctl00_CPH1_CustomFormTypesTemplate_Splitter").addClass("removeLeft");
                    pane.set_visible(false);
                }
                else {
                    $("#ctl00_CPH1_CustomFormTypesTemplate_Splitter").removeClass("removeLeft");
                    pane.set_visible(true);
                }
            }
            function OnClientCollapsed(sender, ags) {
                var pane = mainsplitter._panes[0];
                $("#ctl00_CPH1_CustomFormTypesTemplate_Splitter").addClass("removeLeft");
                pane.set_visible(false);
                setTimeout(FloatDivs, 100);
                setCookie('CustomFormTypesStatus', 'none', 60);
                ClientResized(sender, ags);
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_CustomFormTypesTemplate_Splitter").removeClass("removeLeft");
                setCookie('CustomFormTypesStatus', 'inline', 60);
                var pane = mainsplitter._panes[0];
                pane.set_visible(true);
                ClientResized(sender, ags);
            }

            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            }

        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgCustomFormFields">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomFormFields" />
                    <telerik:AjaxUpdatedControl ControlID="rdgUserDefinedGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgUserDefinedGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgUserDefinedGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgSystemFields">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSystemFields" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgCustomTables">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCustomTables" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlCustomFormTypes" LoadingMessage="<%$ Resources:PMWeb, Loading %>" OnItemsRequested="ddl_ItemsRequested"
                    runat="server" Skin="Default" Width="99%" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    AutoPostBack="True" AllowCustomText="True" CausesValidation="False" Height="400px" CheckForDirt="True"
                    meta:resourcekey="ddlCustomFormTypes">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientCheckedStateChanged="removeClass">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>


                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="true">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            PostBack="false" CssClass="ToolbarPrint HideOnMobileToolbar" Value="Print">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Preview" Value="rmPreview" CssClass="Preview"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" Value="Preview" PostBack="false" ToolTip="Preview the Form" CommandName="Preview" EnableImageSprite="true" CssClass="ToolbarPreview HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CssClass="ToolbarActive HideOnMobileToolbar"
                            Value="Activate" CausesValidation="false" CommandName="Active" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpCustomFormType" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab meta:resourcekey="tab_DefineFields" Text="Define Fields" Value="DefineFields" Selected="True" />
            <telerik:RadTab meta:resourcekey="tab_Template" Text="Advanced Designer" Value="Template" />
            <telerik:RadTab meta:resourcekey="tab_Permissions" Text="Permissions" Value="Permissions" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpCustomFormType" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHDefineFields" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCustomFormTypeRecordNumber" runat="server" Text="ID*" meta:resourcekey="lblCustomFormTypeRecordNumber"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCustomFormTypeRecordNumber" MaxLength="200" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCustomFormTypeId" runat="server" ControlToValidate="txtCustomFormTypeRecordNumber"
                                            CssClass="Validator" ValidationGroup="Save" Display="Dynamic" ForeColor="" meta:resourcekey="rfv_CustomFormTypeRecordNumber">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCustomFormTypeRecordNumberUnique" CssClass="Validator" runat="server" meta:resourcekey="lblCustomFormTypeRecordNumberUnique"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFormName" runat="server" Text="Name*" meta:resourcekey="lblFormName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFormName" MaxLength="200" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvFormName" runat="server" ControlToValidate="txtFormName"
                                            CssClass="Validator" ValidationGroup="Save" Display="Dynamic" ForeColor="" meta:resourcekey="rfv_FormName">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lbltxtFormNameUnique" CssClass="Validator" runat="server" meta:resourcekey="lbltxtFormNameUnique"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblModule" runat="server" Text="Module" meta:resourcekey="lblModule"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlModules" runat="server" Height="99%" Sort="Ascending"
                                            Skin="Default" CloseDropDownOnBlur="true" NoWrap="true" ShowToggleImage="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblUseTemplate" runat="server" meta:resourcekey="lblUseAdvancedDesign" Text="Use Advanced Design"></asp:Label>
                                    </td>
                                    <td class="controlWidth chkBox">
                                        <asp:CheckBox ID="ChkShowUseTemplate" runat="server" ClientIDMode="Static" />
                                        <label for="ChkShowUseTemplate">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="PMHeader">
                        <div class="row" style="padding: 0">
                            <div class="col-12" style="padding-bottom: 5px">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblSystemFields" runat="server" Text="System Fields" meta:resourcekey="lblSystemFields" />
                                    </legend>

                                    <telerik:RadGrid ID="rdgSystemFields" runat="server" GridLines="None" Skin="Default" SetWidth="true" FitParentContainer="true"
                                        HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True"
                                        ItemStyle-VerticalAlign="Top" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                        EditItemStyle-VerticalAlign="Middle" AlternatingItemStyle-VerticalAlign="Top" UseEditFormInMobile="true">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                        <AlternatingItemStyle VerticalAlign="Top"></AlternatingItemStyle>
                                        <ItemStyle VerticalAlign="Top"></ItemStyle>

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="Top" EditItemStyle-VerticalAlign="Middle"
                                            ItemStyle-VerticalAlign="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                            EditMode="InPlace" InsertItemDisplay="Top">

                                            <Columns>
                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Show" UniqueName="IsVisible" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsVisible"), "checked.png", "unchecked.png"))%>' alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkIsVisible" Checked='<%# CBool(IIf(Eval("IsVisible") Is System.DBNull.Value, 0, Eval("IsVisible")))%>' runat="server" CssClass="mobile-switch" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="70px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Order" UniqueName="FieldNumber" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("FieldNumber").ToString()%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("FieldNumber").ToString()%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="70px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Required" UniqueName="IsRequired" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsRequired"), "checked.png", "unchecked.png"))%>' alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkIsRequired" Checked='<%# CBool(IIf(Eval("IsRequired") Is System.DBNull.Value, 0, Eval("IsRequired")))%>' CssClass="mobile-switch"
                                                            runat="server" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="70px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderText="Field" UniqueName="DisplayFieldName">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("DisplayFieldName")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadLabel ID="lblFieldName" Text=' <%#Container.DataItem("DisplayFieldName")%>' runat="server"></telerik:RadLabel>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="110px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderText="Data Type" UniqueName="UserFieldType">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUserFieldType" Text=' <%#Container.DataItem("UserFieldType")%>' runat="server" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <uc1:CustomFormTypeValues ID="CustomFormTypeValuesFieldType" runat="server" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="200px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderText="Default Value" UniqueName="TextValue">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDefaultValue" runat="server" Text='<%#Container.DataItem("TextValue")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <uc1:CustomFormTypeValues ID="CustomFormTypeValuesDefaultValue" runat="server" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="250px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Width (px)" UniqueName="Width">
                                                    <ItemTemplate>
                                                        <%# IIf(Container.DataItem("Width") = 0, "", Container.DataItem("Width"))%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtFieldWidth" MaxLength="5" runat="server" Width="99%" Text='<%# Eval("Width")%>' CssClass="Integer"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="100px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("Notes")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("Notes")%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="555px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>

                                            <ItemStyle VerticalAlign="Middle"></ItemStyle>
                                            <EditItemStyle VerticalAlign="Middle"></EditItemStyle>

                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                        SecurityButtonType="ItemMode_Edit" Visible='<%# rdgSystemFields.EditIndexes.Count = 0 And (Not rdgSystemFields.MasterTableView.IsItemInserted)%>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="CustomFormFields"
                                                        SecurityButtonType="AddEditMode_Edit" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSystemFields.EditIndexes.Count > 0%>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="CustomFormFields" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                        SecurityButtonType="AddEditMode_Add" Visible='<%# rdgSystemFields.MasterTableView.IsItemInserted%>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                        SecurityButtonType="AddEditMode" Visible='<%# rdgSystemFields.EditIndexes.Count > 0 Or rdgSystemFields.MasterTableView.IsItemInserted%>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                        SecurityButtonType="ItemMode" Visible='<%# rdgSystemFields.EditIndexes.Count = 0 And (Not rdgSystemFields.MasterTableView.IsItemInserted)%>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>

                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                        <ClientSettings EnableRowHoverStyle="true" AllowRowsDragDrop="true">
                                            <Scrolling ScrollHeight="184px" />
                                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                                        </ClientSettings>
                                        <EditItemStyle VerticalAlign="Middle"></EditItemStyle>
                                    </telerik:RadGrid>
                                </fieldset>
                            </div>
                        </div>
                        <div class="row" style="padding: 0;">
                            <div class="col-6" style="padding-bottom: 5px">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblCustomFields" runat="server" Text="Custom Fields" meta:resourcekey="lblCustomFields" />
                                    </legend>
                                    <telerik:RadGrid ID="rdgCustomFormFields" runat="server" AllowPaging="true" PageSize="10" Width="100%" SetWidth="true"
                                        FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                        Skin="Default" HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True"
                                        ItemStyle-VerticalAlign="Top" AlternatingItemStyle-VerticalAlign="Top" AllowMultiRowEdit="True"
                                        AllowMultiRowSelection="True" EditItemStyle-VerticalAlign="Middle" GridLines="None" UseEditFormInMobile="true">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                        <AlternatingItemStyle VerticalAlign="Top"></AlternatingItemStyle>
                                        <ItemStyle VerticalAlign="Top"></ItemStyle>

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" TableLayout="Fixed" Width="100%"
                                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" EditItemStyle-VerticalAlign="Middle"
                                            ItemStyle-VerticalAlign="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                            <Columns>
                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Show" UniqueName="IsVisible" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsVisible"), "checked.png", "unchecked.png"))%>' alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkVisible" runat="server" CssClass="mobile-switch" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Order" UniqueName="FieldNumber" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("FieldNumber").ToString()%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("FieldNumber").ToString()%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Required" HeaderStyle-Width="8%" UniqueName="IsRequired">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsRequired"), "checked.png", "unchecked.png")) %>' alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkRequired" runat="server" CssClass="mobile-switch" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Field" UniqueName="LabelString">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("LabelString")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtLabel" MaxLength="4000" runat="server" Text='<%# Eval("LabelString") %>' Width="99%"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvLabel" runat="server" ValidationGroup="CustomFormFields"
                                                            ControlToValidate="txtLabel" CssClass="Validator" ErrorMessage="Enter the Label"
                                                            Display="Dynamic" ForeColor="" meta:resourcekey="rfvLabel"></asp:RequiredFieldValidator>
                                                    </EditItemTemplate>

                                                    <HeaderStyle Wrap="False" Width="150px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Data Type" UniqueName="Value">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("FieldType") = "String", "Text", Container.DataItem("FieldType"))%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <uc1:CustomFormTypeValues ID="CustomFormTypeValuesFieldType" runat="server" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="300px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Width (px)" UniqueName="FieldWidth"
                                                    ItemStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <%# Container.DataItem("FieldWidth")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtFieldWidth" MaxLength="5" runat="server" Width="99%"
                                                            Text='<%# Eval("FieldWidth") %>' CssClass="Integer"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
                                                    <HeaderStyle Wrap="False" Width="150px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderText="Default Value">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDefaultValue" runat="server" Text='<%#IIf(Container.DataItem("TextboxMode") = "FixDate", "Fixed Date", Container.DataItem("TextValue"))%>'></asp:Label>

                                                        <img runat="server" visible="false" id="imgCheck" alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <uc1:CustomFormTypeValues ID="CustomFormTypeValuesDefaultValue" runat="server" />
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="False" Width="280px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Calculation" UniqueName="Calculation" HeaderStyle-Width="500px" Groupable="false">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("Calculation") = String.Empty, "&nbsp;", RestoreCalculationFromUS(Container.DataItem("Calculation")))%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <div style="float: left; width: 90%">
                                                            <asp:TextBox ID="txtCalculation" MaxLength="500" runat="server" Width="90%"
                                                                Text='<%# RestoreCalculationFromUS(IIf(Eval("Calculation") Is System.DBNull.Value, "", Eval("Calculation"))) %>'>
                                                            </asp:TextBox>
                                                        </div>
                                                        <div style="float: right; width: 10%">
                                                            <asp:LinkButton ID="imgCalculation" runat="server" CssClass="FormulaButton"
                                                                OnClientClick='<%# "return openCalculationPopup(" & Eval("Id") & ",this);" %>'>
                                                                                                    <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="150px" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>

                                            <ItemStyle VerticalAlign="Middle"></ItemStyle>
                                            <EditItemStyle VerticalAlign="Middle"></EditItemStyle>

                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                        SecurityButtonType="ItemMode_Edit" Visible='<%# rdgCustomFormFields.EditIndexes.Count = 0 And (Not rdgCustomFormFields.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="CustomFormFields"
                                                        SecurityButtonType="AddEditMode_Edit" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCustomFormFields.EditIndexes.Count > 0 %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="CustomFormFields" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                        SecurityButtonType="AddEditMode_Add" Visible='<%# rdgCustomFormFields.MasterTableView.IsItemInserted %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                        SecurityButtonType="AddEditMode" Visible='<%# rdgCustomFormFields.EditIndexes.Count > 0 Or rdgCustomFormFields.MasterTableView.IsItemInserted %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                        SecurityButtonType="ItemMode_Add" Visible='<%# rdgCustomFormFields.EditIndexes.Count = 0 And (Not rdgCustomFormFields.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdgCustomFormFields.EditIndexes.Count = 0 And (Not rdgCustomFormFields.MasterTableView.IsItemInserted) %>'
                                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                        SecurityButtonType="ItemMode" Visible='<%# rdgCustomFormFields.EditIndexes.Count = 0 And (Not rdgCustomFormFields.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>

                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                        <ClientSettings EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                                        </ClientSettings>
                                        <EditItemStyle VerticalAlign="Middle"></EditItemStyle>
                                    </telerik:RadGrid>
                                </fieldset>
                            </div>
                            <div class="col-6">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblCustomTables" runat="server" Text="Custom Tables" meta:resourcekey="lblCustomTables" />
                                    </legend>
                                    <telerik:RadGrid ID="rdgCustomTables" runat="server" AllowPaging="true" PageSize="10" Width="100%" SetWidth="true"
                                        FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                        Skin="Default" HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True"
                                        ItemStyle-VerticalAlign="Top" AlternatingItemStyle-VerticalAlign="Top" AllowMultiRowEdit="True"
                                        AllowMultiRowSelection="True" EditItemStyle-VerticalAlign="Middle" GridLines="None">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                        <AlternatingItemStyle VerticalAlign="Top"></AlternatingItemStyle>
                                        <ItemStyle VerticalAlign="Top"></ItemStyle>

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" TableLayout="Fixed" Width="100%"
                                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" EditItemStyle-VerticalAlign="Middle"
                                            ItemStyle-VerticalAlign="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Show" UniqueName="IsVisible" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkTableUserUnits_OnChekedChanged" CssClass="mobile-switch" />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Order" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("LineNumber").ToString()%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("LineNumber").ToString()%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="120px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="ID" UniqueName="ID" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <%#Eval("Code").ToString%>&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Table Name" UniqueName="Name" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <%#Eval("Name").ToString%>&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Width (px)" UniqueName="Width"
                                                    ItemStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <%# Container.DataItem("Width")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtFieldWidth" MaxLength="5" runat="server" Width="99%" Text='<%# Eval("Width")%>' CssClass="Integer"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                    <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="Edit" Groupable="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="imgEdit" Style="cursor: pointer" meta:resourcekey="imgEdit" ToolTip="Edit" runat="server"><span class="Icon"></span> </asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>

                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                                        CommandName="InitNewRow" Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomTables.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                        Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomTables.MasterTableView.IsItemInserted)%>'
                                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                        CommandName="RebindGrid" Visible='<%# rdgCustomTables.EditIndexes.Count = 0 And (Not rdgCustomTables.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>

                                        </MasterTableView>
                                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                                            AllowDragToGroup="false" AllowRowsDragDrop="true">
                                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvTemplate" runat="server">
            <uc3:CustomFormTypesTemplate ID="CustomFormTypesTemplate" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPermissions" runat="server" Visible="False">
            <uc2:CustomFormPermissions ID="CustomFormPermissions" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
