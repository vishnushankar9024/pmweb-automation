<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="FolderManagerAdvancedSearch.aspx.vb" Inherits="Website.FolderManagerAdvancedSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-x:hidden;">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <style>
            input[type="submit"], input[type="button"] {
                width: 70px;
                margin-left: 15px;
                position: static !important;
                top: 0 !important;
                left: 0 !important;
            }


            @media screen and (max-width:843px) {
                .colTable > tbody > tr > td.PaddingBottom {
                    padding: 0 0 24px 0;
                }

                .controlWidth {
                    min-width: 240px !important;
                }

                .colTable tr {
                    display: table-row;
                }
            }
            .PMMainPage {
                padding-left: 24px !important;
                padding-right: 24px !important;
                box-sizing: border-box;
                        }
            .RadAjaxPanel {
                display: inline-block !important;
            }
       

        </style>
        <telerik:RadCodeBlock ID="rdcb" runat="server">
            <script type="text/javascript">
              

                function isMobileScreen() {
                    var browserWidth = $telerik.$(window.parent).width();
                    if (browserWidth <= MobileScreenWidth)
                        return true;
                    return false;
                }


                
                function ddlModifiedSelectedIndexChanged(sender, args) {
                    var index = sender.get_selectedIndex();
                    var trFrom = document.querySelector("#trFrom");
                    var trTo = document.querySelector("#trTo");
                    if (index == 6) {
                        trFrom.style.display = "table-row";
                        trTo.style.display = "table-row";
                    }
                    else {
                        trFrom.style.display = "none";
                        trTo.style.display = "none";
                    }

                }
                function CloseWindow() {
                    if (window.parent.location.toString().toLowerCase().indexOf("foldermanager.aspx") > -1)
                        window.parent.isSearch = 1;
                    else {
                        for (var i = 0; i < window.parent.length; i++) {
                            if (typeof window.parent[i].showAdvancedSearchResult == 'function') {
                                window.parent[i].isSearch = 1;
                                window.parent[i].showAdvancedSearchResult();
                            }
                        }

                    }
                    var wnd = GetRadWindow(window);
                    wnd.Close()
                }
                function activatePanel() {
                    $("#loadingPanel").css("display", "block");
                }
          
                function CheckComboItem(sender, ComboClientId, SelectedValue) {
                    var TranslatedAll = '<%= Me.PM.LanguagesInfo.ALL%>';
                    var combo = $find(ComboClientId);
                    var SelectedName = combo.findItemByValue(SelectedValue).get_text();
                    var PreClientId = '';
                    var ServerId = combo.get_id();
                    if (ServerId.lastIndexOf('_') >= 0) {
                        ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                        PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                    }
                    var hdnNames = null;
                    var hdnValues = null;
                    if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]").length > 0)
                        hdnNames = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]")[0];
                    if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]").length > 0)
                        hdnValues = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                    if (hdnNames == null) hdnNames = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Names' + "]")[0];
                    if (hdnValues == null) hdnValues = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Values' + "]")[0];
                    var isChecked = true;
                    var text = hdnNames.value;
                    var values = hdnValues.value;
                    var items = combo.get_items();
                    var chkParent;
                    var AllItem = combo.findItemByValue('0');
                    if (AllItem)
                        chkParent = $(AllItem.get_element()).find("input[type='checkbox']")[0];
                    if (SelectedValue == '0' && sender.checked) {
                        values = '0';
                        var j = 0;
                        if (AllItem)
                            text = AllItem.get_text();
                        else
                            text = TranslatedAll;
                        $("#" + ComboClientId + "_DropDown").find("input[type='checkbox']").each(function () {
                            var item = items.getItem(j);
                            var itemValue = item.get_value();
                            if (itemValue != '0') {
                                this.checked = false;
                            }
                            j++;
                        });
                    } else {
                        if (sender.checked) {
                            if (values == '0' || values == '') {
                                values = SelectedValue;
                                text = SelectedName;
                            }
                            else {
                                values = values + ';' + SelectedValue;
                                text = text + ';' + SelectedName;
                            }
                            if (chkParent) { chkParent.checked = false; }
                        } else {
                            var results = values.split(';');
                            var SelectedNames = text.split(';');
                            values = '';
                            text = '';
                            var i = 0;
                            for (i = 0; i < results.length; i++) {
                                if (results[i] != SelectedValue)
                                    values = values + ';' + results[i];
                            }
                            var find = 1
                            for (i = 0; i < SelectedNames.length; i++) {
                                if (SelectedNames[i] != SelectedName || find == 0) {
                                    text = text + ';' + SelectedNames[i];
                                }
                                else
                                    find = 0;
                            }
                        }
                    }
                    text = removeFirstSemiColon(text.trim()).trim();
                    values = removeFirstSemiColon(values.trim()).trim();
                    if (values == '' || values == '0') {
                        //values = '0';
                        //if (AllItem)
                        //    text = AllItem.get_text();
                        //else
                            text = '';
                    }
                    //if (AllItem)
                    //    if (chkParent.checked) = (values == '0');
                    var nbofSelectedValues = values.split(";").length
                    if (values == ''){ nbofSelectedValues = 0}
                    hdnValues.value = values;
                    switch (nbofSelectedValues) {
                        case 0:
                            combo.set_text("None");
                            hdnNames.value = "";
                            break;
                        case 1:
                            if (AllItem && chkParent.checked) {
                                combo.set_text(AllItem.get_text());
                                hdnNames.value = AllItem.get_text();
                            }
                            else {
                                combo.set_text(text);
                                hdnNames.value = text;
                            }
                            break;
                        default:
                            combo.set_text('Multiple');
                            hdnNames.value = text;
                    }
                    //if (text.length > 0) {
                    //    combo.set_text('Multiple');
                    //    hdnNames.value = text;
                    //}
                    //else {
                    //    if(AllItem && chkParent.checked) {
                    //        combo.set_text(AllItem.get_text());
                    //        hdnNames.value = AllItem.get_text();
                    //    }
                    //    else {
                    //        combo.set_text("None");
                    //        hdnNames.value = "";
                    //    }
                    //}
                    return false;
                }
                function removeFirstSemiColon(str) {
                    return str.replace(/^;/, "");
                }
                function GetValueToReturn(combo, eventArgs) {
                    if ((combo.get_items().get_count() == 0 && combo.get_value() != '') || typeof $(combo).attr('InitialText') === 'undefined') {
                        $(combo).attr('InitialText', eventArgs.get_context()["Text"]);
                    }
                    var PreClientId = '';
                    var ServerId = combo.get_id();
                    if (ServerId.lastIndexOf('_') >= 0) {
                        ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                        PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                    }
                    var hdnField = null
                    if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]").length > 0)
                        hdnField = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                    if (hdnField == null) hdnField = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Values' + "]")[0];
                    var context = eventArgs.get_context();
                    context["Ids"] = hdnField.value;

                }
                function Audit_StopPropagation(sender, args) {
                    var Items = $('[id$=' + sender.get_id() + '_DropDown' + '] .rcbItem.rcbTemplate');
                    for (var i = 0; i < Items.length; i++) {
                        Items[i].onclick = stop;
                    }
                }
                function ddl_SelectedIndexChanged(sender, args) {
                    var ServerId = sender.get_id()
                    var AllItem = sender.findItemByValue('0');
                    var chkParent;
                    if (AllItem)
                        chkParent = $(AllItem.get_element()).find("input[type='checkbox']")[0];
                    var PreClientId = '';
                    var hdnNames = null;
                    if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]").length > 0)
                        hdnNames = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]")[0];
                    if (hdnNames == null) hdnNames = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Names' + "]")[0];
                    var hdnValues = null;
                    if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]").length > 0)
                        hdnValues = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                    if (hdnValues == null) hdnValues = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Values' + "]")[0];
                    sender.clearSelection();
                    var nbofSelectedValues = hdnValues.value.split(";").length
                    if (hdnValues.value == '') { nbofSelectedValues = 0; }
                    switch (nbofSelectedValues) {
                        case 0:
                            sender.set_text("None");
                            break;
                        case 1:
                            if (AllItem && chkParent.checked) {
                                sender.set_text(AllItem.get_text());
                            }
                            else {
                                sender.set_text(hdnNames.value);
                            }
                            break;
                        default:
                            sender.set_text('Multiple');
                    }
                    return false;
                }

                function ddlSearchInFolders_SelectedIndexChanged(sender, args) {
                    var SelectedValue = sender.get_selectedItem().get_value();
                    switch (SelectedValue) {
                        case "1": //Select folder(s)
                            trLocations.style.display = ""
                            trProjects.style.display = ""
                            trShared.style.display = ""
                            trSearchInFolders.children[0].classList.remove("PaddingBottom")
                            trSearchInFolders.children[1].classList.remove("PaddingBottom")
                            break;
                        case "2": //This folder only
                        case "3": //This folder and subfolders
                            trLocations.style.display = "none"
                            trProjects.style.display = "none"
                            trShared.style.display = "none"
                            trSearchInFolders.children[0].classList.add("PaddingBottom")
                            trSearchInFolders.children[1].classList.add("PaddingBottom")
                            break;
                    }
                }
            </script>
        </telerik:RadCodeBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <div id="loadingPanel" class="RadAjax RadAjax_Default" style="position: absolute; width: 100%; height: 100%; left: 0; top: 0; text-align: center; z-index: 90000; display: none">
            <div class="raDiv"></div>
            <div class="raColor raTransp">
            </div>
        </div>
        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <asp:Panel ID="panel" runat="server">
        <table class="TableNoSpacingNoBorder" style="width: 100%; margin-top: 44px">
            <tr>
                <td style="border-bottom: 1px solid gray">
                    <div class="PMMainPage">
                        <div style="padding: 8px 0">

                            <asp:Button Text="Search" runat="server" ID="btnSearch" OnClientClick="activatePanel()" meta:Resourcekey="btnSearch" />
                            <asp:Button Text="Reset" runat="server" ID="btnReset" meta:Resourcekey="btnReset" />

                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="PMMainPage" >

                        <div class="row">
                            <div class="col-4">
                                <table class="colTable">
                                    <tr id="trSearchInFolders">
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblSearchInFolders" runat="server" Text="Search In Folders" meta:Resourcekey="lblSearchInFolders"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlSearchInFolders" runat="server" OnClientSelectedIndexChanged="ddlSearchInFolders_SelectedIndexChanged" OnClientLoad="ddlSearchInFolders_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Select" Value="1" />
                                                    <telerik:RadComboBoxItem Text="This Folder Only" Value="2" Selected="True" />
                                                    <telerik:RadComboBoxItem Text="This Folder Plus Subfolders" Value="3" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr id="trLocations">
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblLocations" runat="server" Text="Locations" meta:Resourcekey="lblLocations"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlLocations" runat="server"
                                                Skin="Default"
                                                CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false"
                                                NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested" Text="None" OnClientSelectedIndexChanged="ddl_SelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div>
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlLocationsValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlLocationsNames" />
                                        </td>
                                    </tr>
                                    <tr id="trProjects">
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblProjects" runat="server" Text="Projects" meta:Resourcekey="lblProjects"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlProjects" runat="server"
                                                Skin="Default"
                                                CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false"
                                                NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" Text="None" 
                                                EnableTextSelection="false" OnClientSelectedIndexChanged="ddl_SelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div>
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlProjectsValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlProjectsNames" />
                                        </td>
                                    </tr>
                                    <tr id="trShared">
                                        <td class="labelWidth PaddingBottom" style="width:160px !important">
                                            <asp:Label ID="lblShared" runat="server" Text="Shared" meta:Resourcekey="lblShared"></asp:Label>
                                        </td>
                                        <td class="controlWidth PaddingBottom" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlShared" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Selected="true" Text="Yes" Value="True" />
                                                    <telerik:RadComboBoxItem Text="No" Value="False" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <%-- <tr style="display: table-row !important">
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth"></td>
                                    </tr>--%>
                                    <tr>
                                        <td class="labelWidth PaddingBottom" style="width:160px !important">
                                            <asp:Label ID="lblSearchFor" runat="server" Text="Search For" meta:Resourcekey="lblSearchFor"></asp:Label>
                                        </td>
                                        <td class="controlWidth PaddingBottom" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlSearchFor" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Files And Folders" Value="3" />
                                                    <telerik:RadComboBoxItem Selected="True" Text="Files Only" Value="1" />
                                                    <telerik:RadComboBoxItem Text="Folders Only" Value="2" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <%--<tr style="display: table-row !important">
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth"></td>
                                    </tr>--%>
                                    <tr>
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblDocumentNbr" runat="server" Text="Document #" meta:Resourcekey="lblDocumentNbr"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <asp:TextBox ID="txtDocumentNbr" runat="server" CssClass="ZeroTrimInteger" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblFileExtension" runat="server" Text="File Extension" meta:Resourcekey="lblFileExtension"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlFileExtension" runat="server"
                                                Skin="Default"
                                                CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false"
                                                NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested" Text="<%# PM.LanguagesInfo.ALL %>"
                                                OnClientSelectedIndexChanged="ddl_SelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:CheckBox runat="server" ID="chk" />
                                                                </td>
                                                                <td>
                                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ItemTemplate>
                                                
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlFileExtensionValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlFileExtensionNames"
                                                Value="<%# PM.LanguagesInfo.ALL %>" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth PaddingBottom" style="width:160px !important">
                                            <asp:Label ID="lblNamed" runat="server" Text="Named" meta:Resourcekey="lblNamed"></asp:Label>
                                        </td>
                                        <td class="controlWidth PaddingBottom" style="width:240px !important">
                                            <asp:TextBox runat="server" MaxLength="256" TextMode="MultiLine" ID="txtNamed" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblContaining" runat="server" Text="File Attributes" meta:Resourcekey="lblContaining"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <asp:TextBox runat="server" MaxLength="256" TextMode="MultiLine" ID="txtContaining" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth PaddingBottom">
                                            <asp:Label ID="lblSearchContents" runat="server" Text="Search Contents Too" meta:Resourcekey="lblSearchContents"></asp:Label> 
                                        </td>
                                        <td class="controlWidth PaddingBottom">
                                            <telerik:RadComboBox ID="ddlSearchContents" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Yes" Value="True" />
                                                    <telerik:RadComboBoxItem Text="No" Value="False" Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr style="display: table-row !important">
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth"></td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblModifiedBy" runat="server" Text="Modified By" meta:Resourcekey="lblModifiedBy"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <asp:TextBox ID="txtModifiedBy" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width:160px !important">
                                            <asp:Label ID="lblModified" runat="server" Text="Modified" meta:Resourcekey="lblModified"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadComboBox ID="ddlModified" runat="server" OnClientSelectedIndexChanged="ddlModifiedSelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Any Time" Value="1" Selected="true" />
                                                    <telerik:RadComboBoxItem Text="Today" Value="2" />
                                                    <telerik:RadComboBoxItem Text="Yesterday" Value="3" />
                                                    <telerik:RadComboBoxItem Text="Last 7 days" Value="4" />
                                                    <telerik:RadComboBoxItem Text="Last 30 days" Value="5" />
                                                    <telerik:RadComboBoxItem Text="Last 90 days" Value="6" />
                                                    <telerik:RadComboBoxItem Text="Between..." Value="7" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr id="trFrom" style="display: none !important">
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker runat="server" ID="dtpFromDate"></telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr id="trTo" style="display: none !important">
                                        <td class="labelWidth" style="width:160px !important"></td>
                                        <td class="controlWidth" style="width:240px !important">
                                            <telerik:RadDatePicker runat="server" ID="dtpToDate"></telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
            </asp:Panel>
    </form>
</body>
</html>
