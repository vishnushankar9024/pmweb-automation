<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PlannerRequirementsViewSettings.aspx.vb" MasterPageFile="~/PmMaster.Master" Inherits="Website.PlannerRequirementsViewSettings" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <asp:placeholder ID="phRequirementsSettings" runat="server" />
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlPrograms" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlPrograms" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlProjects"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
       
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

   
        <script type="text/javascript">

            function ProjectLoad(combo, eventArgs) {

                var PreClientId = '';
                var ServerId = combo.get_id();
                if (ServerId.lastIndexOf('_') >= 0) {
                    ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                    PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                }
                var ddlProject = $("[id$=ctl00_CPH1_ddlProjects_Input]")[0];

                var hdnprojectValues = $("[id$= ctl00_CPH1_hddnddlProjectsValues]")[0];
                var hdnprojectNames = $("[id$= ctl00_CPH1_hddnddlProjectsNames]")[0];
                var hdnField = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                PageMethods.ProjectLoadTest(hdnField.value);
                ddlProject.value = "";
                hdnprojectValues.value = "";
                hdnprojectNames.value = "";
                var comboProjects = $find('ctl00_CPH1_ddlProjects');
                comboProjects.set_text('');
                comboProjects.clearItems();
                var comboLinkedTo = $find('ctl00_CPH1_ddlLinkedTo');
                comboLinkedTo.set_text('');
                return false;
            }

            function ValidateHoursPerDay(sender, args) {
                var value = sender.get_value();
                if (value > 24) {
                    sender.set_value(24);
                } else if (value < 0.01) {
                    sender.set_value(0.01);
                }
            }

            function Audit_GetValueToReturn(combo, eventArgs) {
                if ((combo.get_items().get_count() == 0 && combo.get_value() != '') || typeof $(combo).attr('InitialText') === 'undefined') {
                    $(combo).attr('InitialText', eventArgs.get_context()["Text"]);
                }
                var PreClientId = '';
                var ServerId = combo.get_id();
                if (ServerId.lastIndexOf('_') >= 0) {
                    ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                    PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                }
                var hdnField = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
                //if ($(combo).attr('InitialText') == eventArgs.get_context()["Text"]) {
                //    eventArgs.get_context()["Text"] = "";
                //}
            }

            function CheckComboItem(sender, ComboClientId, SelectedValue) {
                var combo = $find(ComboClientId);
                var SelectedName = combo.findItemByValue(SelectedValue).get_text();
                var PreClientId = '';
                var ServerId = combo.get_id();
                if (ServerId.lastIndexOf('_') >= 0) {
                    ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                    PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                }
                var hdnNames = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]")[0];
                var hdnValues = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                var isChecked = true;
                var text = hdnNames.value;
                var values = hdnValues.value;
                var items = combo.get_items();
                var chkParent;
                var AllItem = combo.findItemByValue('0');
                if (AllItem)
                    chkParent = $(AllItem.get_element()).find("input[type='checkbox']")[0];
                if (SelectedValue == '0') {
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
                        if (values == '0') {
                            values = SelectedValue;
                            text = SelectedName;
                        }
                        else {
                            values = values + ' ; ' + SelectedValue;
                            text = text + ' ; ' + SelectedName;
                        }
                    } else {
                        var results = values.split(' ; ');
                        var SelectedNames = text.split(' ; ');
                        values = '';
                        text = '';
                        var i = 0;
                        for (i = 0; i < results.length; i++) {
                            if (results[i] != SelectedValue)
                                values = values + ' ; ' + results[i];
                        }
                        var find = 1
                        for (i = 0; i < SelectedNames.length; i++) {
                            if (SelectedNames[i] != SelectedName || find == 0) {
                                text = text + ' ; ' + SelectedNames[i];
                            }
                            else
                                find = 0;
                        }
                    }
                }
                text = removeFirstSemiColon(text.trim()).trim();
                values = removeFirstSemiColon(values.trim()).trim();
                if (values == '') {
                    values = '0';
                    if (AllItem)
                        text = AllItem.get_text();
                    else
                        text = TranslatedAll;
                }
                if (AllItem)
                    chkParent.checked = (values == '0');
                hdnValues.value = values;
                if (text.length > 0) {
                    combo.set_text(text);
                    hdnNames.value = text;
                }
                else {
                    combo.set_text("");
                    hdnNames.value = "";
                }
                return false;
            }

            function removeFirstSemiColon(str) {
                return str.replace(/^;/, "");
            }

            function dllSelectedIndexChanged(combobox, eventArgs) {
            }

            function Skillscheck(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + 'hddnCompaniesIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + 'hddnCompaniesnames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }
        </script>
    </telerik:RadCodeBlock>
    <table style="vertical-align: top; width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top" style="width: 100%;">
            <td colspan="3">
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr class="ToolBar">
                        <td style="width: 250px; padding-left: 5px;">
                            <telerik:RadComboBox ID="ddlRequirementsViews" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" AllowCustomText="true" EmptyMessage="Select Requirement View..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                                Width="300px" DropDownWidth="360px" AutoPostBack="False" NoWrap="true" CausesValidation="False" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td colspan="5" valign="middle" style="width: 220px; padding-left: 5px;">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Delete" NavigateUrl="SearchDocument.aspx?O=244" CausesValidation="false">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="NewFromTemplate">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/CopyRecord.png" CommandName="Copy"
                                        SecurityButtonType="Copy" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="120px" CommandName="CopyPlannerSettings">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" CommandName="RevisePlannerSettings">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton IsSeparator="true">
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                            <asp:Button ID="btnApplyAndExit" meta:Resourcekey="btnApplyAndExit" runat="server" Text="Apply & Exit"  OnClick="btnApplyAndExit_Click"/>
                            <asp:Button ID="btnCancel" meta:Resourcekey="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100% !important;">
            <td colspan="3" style="padding-left: 10px; width: 100% !important;">
                <table style="width: 100%">
                    <tr style="width: 100%;">
                        <td style="width: 33%;">
                            <table>
                                <tr>
                                    <td style="width: 100px" class="NoWrap">
                                        <asp:Label ID="lblViewName" meta:Resourcekey="lblViewName" Width="100px" runat="server" Text="View Name"></asp:Label>
                                    </td>
                                    <td style="width: 200px; text-align: right">
                                        <asp:TextBox ID="txtViewName" Width="200px" ReadOnly="false" runat="server" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvViewName" runat="server" ValidationGroup="Save" ControlToValidate="txtViewName"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="View Name is required" meta:resourcekey="rfvViewName"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblUniqueViewName" runat="server" Text="<br/>the Pre-bid # must be unique by Project." meta:Resourcekey="lblUniqueCode" Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px" class="NoWrap">
                                        <asp:Label ID="lblPlannerPeriod" meta:Resourcekey="lblPlannerPeriod" Width="100px" runat="server" Text="Planner Period"></asp:Label>
                                    </td>
                                    <td style="width: 200px; text-align: right">
                                        <telerik:RadComboBox ID="ddlPlannerPeriod" runat="server" Width="100px" Skin="Default" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 33%; padding-right: 100px;">
                            <table>
                                <tr>
                                    <td style="width: 200px" class="NoWrap">
                                        <asp:Label ID="lblOverrideOverbookingWarning" meta:Resourcekey="lblOverrideOverbookingWarning" Width="100px" runat="server" Text="Override Overbooking Warning"></asp:Label>
                                    </td>
                                    <td style="width: 200px; text-align: right">
                                        <telerik:RadComboBox ID="ddlOverrideOverbookingWarning" runat="server" Width="123px" Skin="Default" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 200px" class="NoWrap">
                                        <asp:Label ID="lblCloseRequirementsThreshold" meta:Resourcekey="lblCloseRequirementsThreshold" Width="100px" runat="server" Text="Close Requirements Threshold"></asp:Label>
                                    </td>
                                    <td style="width: 200px; text-align: right">
                                        <asp:TextBox ID="txtCloseRequirementsThreshold" Width="90px" CssClass="Percent" ReadOnly="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 33%;">
                            <table>
                                <tr>
                                    <td style="width: 150px" class="NoWrap">
                                        <asp:Label ID="lblSynchLocatorByDefault" meta:Resourcekey="lblSynchLocatorByDefault" Width="100px" runat="server" Text="Synch Locator By Default"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkSynchLocatorByDefault" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px" class="NoWrap">
                                        <asp:Label ID="lblPublic" meta:Resourcekey="lblPublic" Width="100px" runat="server" Text="Public?"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkPublic" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%;" valign="top">
            <td style="padding-left: 10px; width: 40%;">
                <table width="100%">
                    <tr style="width: 90%;">
                        <td style="width: 90%;">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblRequirementsSettings" runat="server" Text="Requirements Settings" meta:resourcekey="lblRequirementsSettings"></asp:Label>
                                </legend>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label ID="lblSortBy" meta:Resourcekey="lblSortBy" runat="server" Text="Sort By" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td style="width: 200px; padding-right: 20px;">
                                            <telerik:RadComboBox ID="ddlSortBy" runat="server" Width="200px" Skin="Default" Style="font-size: 11px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="float: right;">
                                            <asp:Button ID="btnUpdateResourcesSettings" Width="170px" meta:Resourcekey="btnUpdateResourcesSettings" runat="server" Text="Update Resources Settings" OnClick="btnUpdateResourcesSettings_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table>
                                    <tr>
                                        <td class="NoWrap" style="width: 30%;">
                                            <asp:Label ID="lblBasedOn" meta:Resourcekey="lblBasedOn" Width="100px" runat="server" Text="Based On*"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlBasedOn" runat="server" Width="255px" Skin="Default" Style="font-size: 11px" AutoPostBack="true">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trProgram">
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:resourcekey="lblProgram"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlPrograms" AllowCustomText="true" runat="server" AutoPostBack="true"
                                                DropDownWidth="255px" Width="255px" meta:resourcekey="ddlPrograms" EmptyMessage="Select Program..."
                                                NoWrap="true" Height="200px" EnableLoadOnDemand="true" OnClientDropDownClosed="ProjectLoad"
                                                ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableVirtualScrolling="True"
                                                OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkPrograms" />
                                                        <asp:Label runat="server" ID="Label6" AssociatedControlID="chkPrograms"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlProgramsValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlProgramsNames" />
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trProject">
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblProject" runat="server" Text="Project(s)" meta:resourcekey="lblProject"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlProjects" Width="255px" UseProjectFilter="1" runat="server" meta:resourcekey="ddlProjects" EmptyMessage="Select Project..."
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px" DropDownWidth="255px" CausesValidation="false"
                                                NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                                ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                                OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkProject" />
                                                        <asp:Label runat="server" ID="Label6" AssociatedControlID="chkProject"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlProjectsValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlProjectsNames" />
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trLocationProgram" visible="false">
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblLocationProgram" runat="server" Text="Location Program*" meta:resourcekey="lblLocationProgram"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlLocationPrograms" AllowCustomText="true" runat="server" AutoPostBack="true"
                                                DropDownWidth="405px" Width="255px" meta:resourcekey="ddlLocationPrograms" EmptyMessage="Select Location Program..."
                                                NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                                ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvLocationPrograms" meta:Resourcekey="rfvLocationPrograms" runat="server" ControlToValidate="ddlLocationPrograms"
                                                CssClass="Validator" InitialValue="" ErrorMessage="location Program required"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator meta:Resourcekey="csvLocationPrograms" ID="csvLocationPrograms" runat="server" ControlToValidate="ddlLocationPrograms"
                                                ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                CssClass="Validator" ErrorMessage="location Program required">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trLocation" visible="false">
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlLocations" Width="255px" runat="server" meta:resourcekey="ddlLocations" EmptyMessage="Select Location..."
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px" DropDownWidth="255px" CausesValidation="false"
                                                NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                                ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblLinkTypes" meta:Resourcekey="lblLinkTypes" Width="100px" runat="server" Text="Link Type(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlLinkTypes" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Link Types..." OnClientItemsRequesting="Audit_GetValueToReturn"
                                                OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkLinkTypes" />
                                                        <asp:Label runat="server" ID="Label6" AssociatedControlID="chkLinkTypes"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlLinkTypesValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlLinkTypesNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblLinkedTo" meta:Resourcekey="lblLinkedTo" Width="100px" runat="server" Text="Linked To"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlLinkedTo" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Linked To...">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblRequirementID" meta:Resourcekey="lblRequirementID" Width="100px" runat="server" Text="Requirement ID*"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <asp:TextBox ID="txtRequirementID" Width="251px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" Width="100px" runat="server" Text="Description"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <asp:TextBox ID="txtDescription" Width="251px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblResourceTypes" meta:Resourcekey="lblResourceTypes" Width="100px" runat="server" Text="Resource Type(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlResourceTypes" Width="255px" runat="server" Style="font-size: 11px"
                                                AllowCustomText="false" EnableLoadOnDemand="True" EnableVirtualScrolling="false" Filter="Contains"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Resource Type(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkResourceTypeApply" />
                                                        <asp:Label runat="server" ID="Label6" AssociatedControlID="chkResourceTypeApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnResourceTypes" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblClassifications" meta:Resourcekey="lblClassifications" Width="100px" runat="server" Text="Classification(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlClassifications" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                                NoWrap="True" EmptyMessage="Select Classification(s)..." meta:Resourcekey="ddlClassification" OnClientItemsRequesting="Audit_GetValueToReturn"
                                                OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label6" AssociatedControlID="chk"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlClassificationsValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlClassificationsNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblSkills" meta:Resourcekey="lblSkills" Width="100px" runat="server" Text="Skills"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlSkills" runat="server" meta:resourcekey="ddlSkills"
                                                AllowCustomText="True" Width="255px" DropDownWidth="255px" EmptyMessage="Select Skills..." Filter="Contains">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chlSkillsApply" />
                                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chlSkillsApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnSkills" Value="-1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblCountries" meta:Resourcekey="lblCountries" Width="100px" runat="server" Text="Country(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlCountries" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" Filter="Contains" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Country(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkCountriesApply" />
                                                        <asp:Label runat="server" ID="Label8" AssociatedControlID="chkCountriesApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnCountries" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblRegions" meta:Resourcekey="lblRegions" Width="100px" runat="server" Text="Region(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlRegions" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Region(s)..." Filter="Contains">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkRegionApply" />
                                                        <asp:Label runat="server" ID="Label10" AssociatedControlID="chkRegionApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnRegions" Value="-1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblPriorities" meta:Resourcekey="lblPriorities" Width="100px" runat="server" Text="Priority(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlPriorities" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableVirtualScrolling="true" Filter="Contains"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Priority(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkPriorityApply" />
                                                        <asp:Label runat="server" ID="Label9" AssociatedControlID="chkPriorityApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnPriorities" Value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblProgress" meta:Resourcekey="lblProgress" Width="100px" runat="server" Text="Progress"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlProgress" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableVirtualScrolling="true" Filter="Contains"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Progress...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkProgressApply" />
                                                        <asp:Label runat="server" ID="Label11" AssociatedControlID="chkProgressApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnProgress" Value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblCategories" meta:Resourcekey="lblCategories" Width="100px" runat="server" Text="Category(s)"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlCategories" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableVirtualScrolling="true" Filter="Contains"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True" EmptyMessage="Select Category(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkCategoryApply" />
                                                        <asp:Label runat="server" ID="Label12" AssociatedControlID="chkCategoryApply"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnCategories" Value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblNumberOfResources" meta:Resourcekey="lblNumberOfResources" Width="100px" runat="server" Text="# of Resources"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <asp:TextBox ID="txtNumberOfResources" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblWorkDays" meta:Resourcekey="lblWorkDays" Width="100px" runat="server" Text="Work Days"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <asp:TextBox ID="txtWorkDays" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblHoursPerDay" meta:Resourcekey="lblHoursPerDay" Width="100px" runat="server" Text="Hours Per Day"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <asp:TextBox ID="txtHoursPerDay" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblHoursTotal" meta:Resourcekey="lblHoursTotal" Width="100px" runat="server" Text="Hours Total"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <asp:TextBox ID="txtHoursTotal" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 30%;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblStart" meta:Resourcekey="lblStart" Width="150px" runat="server" Text="Start"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <telerik:RadComboBox ID="ddlStart1" runat="server" Skin="Default" Width="100px" CloseDropDownOnBlur="true" NoWrap="False" OnSelectedIndexChanged="ddlStart1_SelectedIndexChanged" AutoPostBack="true">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="float: right;" id="tdExpression" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlInTheNext" runat="server" Skin="Default" Width="103px"
                                                            CloseDropDownOnBlur="true" NoWrap="False">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="padding-left: 6px; padding-right: 6px;">
                                                        <telerik:RadTextBox ID="txtNbrOfTimePeriods"
                                                            MinValue="0" runat="server" MaxLength="9" Width="29px" CssClass="PositiveIntegerDouble Right">
                                                        </telerik:RadTextBox></td>
                                                    <td style="padding-left: 0px;">
                                                        <telerik:RadComboBox ID="ddlTimePeriods" runat="server" Skin="Default" Width="100px"
                                                            CloseDropDownOnBlur="true" NoWrap="False">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>

                                                </tr>
                                            </table>
                                        </td>
                                        <td style="float: right;" id="tdDates" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="rdpStartDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default" EnableTyping="true">
                                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar3" Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td style="padding-left: 10px;">
                                                        <asp:Label ID="lblTo" meta:Resourcekey="lblTo" Width="29px" runat="server" Text="To"></asp:Label></td>
                                                    <td style="padding-left: 0px;">
                                                        <telerik:RadDatePicker ID="rdpEndDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default" EnableTyping="true">
                                                            <DateInput ID="DateInput4" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar4" Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </td>

                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="width: 30%;">
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblFinish" meta:Resourcekey="lblFinish" Width="150px" runat="server" Text="Finish"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <telerik:RadComboBox ID="ddlFinish1" runat="server" Skin="Default" Width="100px"
                                                            CloseDropDownOnBlur="true" NoWrap="False" OnSelectedIndexChanged="ddlFinish1_SelectedIndexChanged" AutoPostBack="true">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="float: right;" id="tdExpression1" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlInTheNext1" runat="server" Skin="Default" Width="103px"
                                                            CloseDropDownOnBlur="true" NoWrap="False">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="padding-left: 6px; padding-right: 6px;">
                                                        <telerik:RadTextBox ID="txtNbrOfTimePeriods1" MinValue="0" runat="server" MaxLength="9" Width="29px" CssClass="PositiveIntegerDouble Right">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left: 0px;">
                                                        <telerik:RadComboBox ID="ddlTimePeriods1" runat="server" Skin="Default" Width="100px"
                                                            CloseDropDownOnBlur="true" NoWrap="False">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="float: right;" id="tdDates1" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="rdpStartDate1" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default" EnableTyping="true">
                                                            <DateInput ID="DateInput5" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar5" Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td style="padding-left: 10px;">
                                                        <asp:Label ID="lblTo1" meta:Resourcekey="lblTo" Width="29px" runat="server" Text="To"></asp:Label>
                                                    </td>
                                                    <td style="padding-left: 0px;">
                                                        <telerik:RadDatePicker ID="rdpEndDate1" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default" EnableTyping="true">
                                                            <DateInput ID="DateInput6" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar6" Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblClosed" meta:Resourcekey="lblClosed" Width="100px" runat="server" Text="Closed"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlClosed" Width="255px" runat="server" Style="font-size: 11px"
                                                AllowCustomText="True" EnableVirtualScrolling="true" Filter="Contains"
                                                OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                NoWrap="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblTotalHoursRemaing" meta:Resourcekey="lblTotalHoursRemaing" Width="100px" runat="server" Text="Total Hours Remaining Threshold"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <asp:TextBox ID="txtTotalHoursRemaing" Width="100px" CssClass="Percentage" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px" class="NoWrap">
                                            <asp:Label ID="lblRequestedBy" meta:Resourcekey="lblRequestedBy" Width="100px" runat="server" Text="Requested By"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <telerik:RadComboBox ID="ddlRequestedBy" Width="255px" runat="server" Height="250px" Style="font-size: 11px"
                                                AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                                NoWrap="True" EmptyMessage="Select Requested By..." OnClientItemsRequesting="Audit_GetValueToReturn"
                                                OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkRequestedByApply" />
                                                        <asp:Label runat="server" ID="Label13" AssociatedControlID="chkRequestedByApply"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlRequestedByValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlRequestedByNames" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 40%; padding-left: 10px;">
                <table style="width: 100%;">
                    <tr style="width: 90%;">
                        <td style="width: 90%;">
                            <fieldset runat="server" id="fldDates">
                                <legend>
                                    <asp:Label runat="server" ID="lblResourcesSettings" meta:resourcekey="lblResourcesSettings" Text="Resources Settings"></asp:Label>
                                </legend>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label runat="server" ID="lblSortByResources" meta:resourcekey="lblSortBy" Text="Sort By" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td style="width: 200px; padding-right: 20px;">
                                            <telerik:RadComboBox ID="ddlSortByResources" runat="server" Skin="Default" Width="200px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="float: right;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label runat="server" ID="lblGroupBy" meta:resourcekey="lblGroupBy" Text="Group By" Style="font-weight: 700"></asp:Label>
                                        </td>
                                        <td style="width: 200px; padding-right: 20px;">
                                            <telerik:RadComboBox ID="ddlGroupBy" runat="server" Skin="Default" Width="200px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="float: right;"></td>
                                    </tr>
                                </table>
                                <br />
                                <table>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblID" runat="server" Text="ID*" meta:Resourcekey="lblID"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <asp:TextBox ID="txtID" runat="server" Width="251px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblLastName" runat="server" Text="Last Name" meta:Resourcekey="lblLastName"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <asp:TextBox ID="txtLastName" runat="server" Width="251px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblFirstName" runat="server" Text="First Name" meta:Resourcekey="lblFirstName"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <asp:TextBox ID="txtFirstName" runat="server" Width="251px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%" class="NoWrap">
                                            <asp:Label ID="lblDescriptionResources" meta:Resourcekey="lblDescription" Width="100px" runat="server" Text="Description"></asp:Label>
                                        </td>
                                        <td style="padding-left: 10px; float: right;">
                                            <asp:TextBox ID="txtDescriptionResources" Width="251px" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblRegionResources" meta:resourcekey="lblRegion" runat="server" Text="Region(s)"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlRegionResources" Width="255px" Height="350px" AllowCustomText="true" Filter="Contains" DropDownWidth="255px"
                                                runat="server" Style="font-size: 11px" meta:resourcekey="ddlRegions" EmptyMessage="Select Region...">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnRegionsResources" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblTitle" runat="server" Text="Title" meta:Resourcekey="lblTitle"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <asp:TextBox ID="txtTitle" runat="server" Width="251px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblCompany" runat="server" Text="Company" meta:Resourcekey="lblCompany"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="255px" DropDownWidth="320px"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                 OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkApplyCompanies" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApplyCompanies"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlCompaniesValues" value="0"/>
                                            <asp:HiddenField runat="server" ID="hddnddlCompaniesNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblContacts" runat="server" Text="Contact" meta:Resourcekey="lblContacts"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlContacts" runat="server" Height="200px" Skin="Default" Width="255px" DropDownWidth="320px"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlContacts" EmptyMessage="Select Contact..." NoWrap="False"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                 OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkApplyContacts" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApplyContacts"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlContactsValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlContactsNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblTypes" runat="server" Text="Type(s)" meta:Resourcekey="lblTypes"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlTypes" runat="server" meta:resourcekey="ddlTypes" EmptyMessage="Select Type(s)..."
                                                AllowCustomText="True" Width="255px" DropDownWidth="255px" Filter="Contains">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkApplyTypes" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApplyTypes"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnApplyTypes" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblResourceGroup" runat="server" meta:Resourcekey="lblResourceGroup" Text="Resource Group(s)"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlResourceGroups" meta:Resourcekey="ddlResourceGroups" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                                Skin="Default" NoWrap="true" Width="255px" Height="200px" EmptyMessage="Select Resource Group(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlResourceGroupsValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlResourceGroupsNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblManager" runat="server" Text="Manager(s)" meta:Resourcekey="lblManager"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlManagers" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                                Skin="Default" NoWrap="true" Width="255px" Height="200px" meta:Resourcekey="ddlManager" EmptyMessage="Select Manager(s)...">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlManagersValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlManagersNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblPaytype" runat="server" Text="Pay Type(s)" meta:Resourcekey="lblPaytype"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlPayTypes" runat="server" AllowCustomText="true"
                                                Skin="Default" Width="255px" DropDownWidth="250px" CloseDropDownOnBlur="true" Height="300"
                                                EnableItemCaching="false" EmptyMessage="Select PayType(s)..."
                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" meta:Resourcekey="ddlPayTypes"
                                                OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlPayTypesValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlPayTypesNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblClassifications2" runat="server" Text="Default Classification(s)" meta:Resourcekey="lblClassifications"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlClassificationsResources" runat="server" AllowCustomText="true"
                                                Skin="Default" Width="255px" DropDownWidth="250px" CloseDropDownOnBlur="true" Height="300"
                                                EnableItemCaching="false" EmptyMessage="Select Classification(s)..."
                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" meta:Resourcekey="ddlClassification"
                                                 OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlClassificationsResourcesValues" Value="0" />
                                            <asp:HiddenField runat="server" ID="hddnddlClassificationsResourcesNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap" style="width: 30%;">
                                            <asp:Label ID="lblCostCode" runat="server" Text="Default Cost Code" meta:resourcekey="lblCostCode"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="255px" DropDownWidth="300px"
                                                EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code(s)..." meta:resourcekey="ddlCostCode"
                                                NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnClientItemsRequesting="Audit_GetValueToReturn" OnClientSelectedIndexChanged="dllSelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                        <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                        <%#DataBinder.Eval(Container, "Text")%>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlCostCodesValues" />
                                            <asp:HiddenField runat="server" ID="hddnddlCostCodesNames" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblSkills2" runat="server" Text="Skills" meta:resourcekey="lblSkills"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlSkillsResource" runat="server" meta:resourcekey="ddlSkills" EmptyMessage="Select Skills..."
                                                AllowCustomText="True" Width="255px" DropDownWidth="405px" Filter="Contains">
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chkApplySkills" />
                                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hdnSkillsResources" Value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblEmploymentStatus" runat="server" meta:Resourcekey="lblEmploymentStatus" Text="Employment Status(s)"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadComboBox ID="ddlEmploymentStatuses" meta:resourcekey="ddlEmploymentStatuses" runat="server" Height="200px" Skin="Default" Width="255px" DropDownWidth="250px"
                                                CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true" Filter="Contains" EmptyMessage="Select Employment Status(s)...">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                <ItemTemplate>
                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                        <asp:CheckBox runat="server" ID="chk" />
                                                    </div>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField runat="server" ID="hddnddlEmploymentStatusesValues" Value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%;">
                                            <asp:Label ID="lblHoursPerDay2" meta:resourcekey="lblHoursPerDay" runat="server" Text="Default Hours Per Day"></asp:Label>
                                        </td>
                                        <td style="float: right; padding-left: 10px; margin-left: 40px;">
                                            <telerik:RadTextBox ID="txtHoursPerDayRequired"
                                                MinValue="0" MaxValue="24" runat="server" MaxLength="9" Width="125px" CssClass="PositiveIntegerDouble Right">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDefaultStartTime" runat="server" meta:Resourcekey="lblDefaultStartTime" Text="Default Start Time"></asp:Label>
                                        </td>
                                        <td style="text-align: right; float: right; width: 50%;">
                                            <telerik:RadTimePicker ID="dtpStartTimePicker" runat="server" Culture="English (United States)"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                                Skin="Default" Width="125px">
                                                <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                    Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar1" runat="server" Skin="Default">
                                                </Calendar>
                                            </telerik:RadTimePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDefaultFinishTime" runat="server" meta:Resourcekey="lblDefaultFinishTime" Text="Default Finish Time"></asp:Label>
                                        </td>
                                        <td style="text-align: right; float: right; width: 50%;">
                                            <telerik:RadTimePicker ID="dtpFinishimePicker" runat="server" Culture="English (United States)"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1900-01-01" SelectedDate="<%# Date.Today %>"
                                                Skin="Default" Width="125px">
                                                <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                    Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server" Skin="Default">
                                                </Calendar>
                                            </telerik:RadTimePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 200px;">
                                            <asp:Label ID="lblScheduling" runat="server" meta:Resourcekey="lblScheduling" Text="Scheduling"></asp:Label>
                                        </td>
                                        <td style="text-align: right; float: right; width: 50%;">
                                            <asp:CheckBox runat="server" ID="chkScheduling" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSub" runat="server" meta:Resourcekey="lblSub" Text="Sub"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 50%; float: right;">
                                            <asp:CheckBox runat="server" ID="chkSub" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblOverbookingSetting" runat="server" meta:Resourcekey="lblOverbookingSetting" Text="Overbooking Setting"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 70%; float: right;">
                                            <telerik:RadComboBox ID="ddlOverbookingSettings" runat="server" Skin="Default" Width="125px"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlOverbookingSettings" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>

                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: auto;"></td>
        </tr>
    </table>
</asp:Content>

