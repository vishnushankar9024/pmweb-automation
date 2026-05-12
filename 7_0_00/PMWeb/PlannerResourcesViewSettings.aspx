<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PlannerResourcesViewSettings.aspx.vb" Inherits="Website.PlannerResourcesViewSettings"%>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
        <asp:PlaceHolder ID="phPlannerResourcesSettings" runat="server"></asp:PlaceHolder>

        <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlPrograms"> 
            <UpdatedControls >
                <telerik:AjaxUpdatedControl ControlID="ddlPrograms"  />  
            </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ddlProjects"> 
            <UpdatedControls >
                <telerik:AjaxUpdatedControl ControlID="ddlProjects"  />  
                                <telerik:AjaxUpdatedControl ControlID="ddlLinkedTo"  />
            </UpdatedControls>
            </telerik:AjaxSetting>

     
                 <telerik:AjaxSetting AjaxControlID="btnUpdateRequirements"> 
            <UpdatedControls >
                <telerik:AjaxUpdatedControl ControlID="fldtest"  />  
            </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server" >

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

            function PlannerResources_GetValueToReturn(combo, eventArgs) {
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
                            if (SelectedNames[i].trim() != SelectedName.trim() || find == 0) {
                                text = text + ' ; ' + SelectedNames[i].trim();
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
        <tr valign="top">

            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr class="ToolBar">
                        <td colspan="2" style="width: 250px;" class="NoWrap">&nbsp;&nbsp;&nbsp;
                            <telerik:RadComboBox ID="ddlResourcesView" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" Width="200px" AutoPostBack="True" NoWrap="True" AllowCustomText="True" OnItemsRequested="ddl_ItemsRequested"
                                CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                meta:resourcekey="ddlResourcesView" DropDownWidth="350px" EmptyMessage="Select Resource View..."
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td style="width: 100%;">&nbsp;&nbsp;&nbsp;
              <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                  <Items>
                      <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                          SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                          <Buttons>
                              <telerik:RadToolBarButton PostBack="false" Width="100px" ImageUrl="Images/Global/AddLine.png"
                                  CommandName="New">
                              </telerik:RadToolBarButton>
                              <telerik:RadToolBarButton PostBack="false" Width="100px" ImageUrl="Images/Global/AddLine.png"
                                  CommandName="NewFromTemplate">
                              </telerik:RadToolBarButton>
                          </Buttons>
                      </telerik:RadToolBarSplitButton>
                      <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true" ValidationGroup="Save" CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                      <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/CopyRecord.png" CommandName="Copy"
                          SecurityButtonType="Copy" EnableDefaultButton="false" PostBack="false"  ValidationGroup="Save">
                          <Buttons>
                              <telerik:RadToolBarButton PostBack="false" Width="120px"
                                  CommandName="CopyPlannerSettings">
                              </telerik:RadToolBarButton>
                              <telerik:RadToolBarButton PostBack="false" Width="150px"
                                  CommandName="RevisePlannerSettings">
                              </telerik:RadToolBarButton>
                          </Buttons>
                      </telerik:RadToolBarSplitButton>
                      <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                          CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                      </telerik:RadToolBarButton>
                      <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                  </Items>
              </telerik:RadToolBar>
                            <asp:Button runat="server" ID="btnApplyAndExit" meta:resourcekey="btnApplyAndExit" Text="Apply And Exit" />
                            <asp:Button runat="server" ID="btnCancel" meta:resourcekey="btnCancel" Text="Cancel" />

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width: 1254px;" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td style="width:418px;">
                <table style="margin-left:2px;">
                    <tr>
                        <td >
                            <asp:Label ID="lblViewID" runat="server" Text="View ID" meta:Resourcekey="lblViewID"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtViewID" runat="server" Width="100px"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfvViewId" meta:Resourcekey="rfvViewId" runat="server" ControlToValidate="txtViewID"
                                    CssClass="Validator" InitialValue="" ErrorMessage="View ID Required"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblViewName" runat="server" Text="View Name" meta:Resourcekey="lblViewName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtViewName" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                </table>

            </td>
            <td style="width:418px;">
                <table style="margin-left:110px;">
                    <tr>
                        <td>
                            <asp:Label ID="lblPlannerPeriod" runat="server" Text="Planner Period" meta:Resourcekey="lblPlannerPeriod"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlPlannerPeriod" runat="server" Width="100px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblThreshold" runat="server" Text="Close Requirements Threshold" meta:Resourcekey="lblThreshold"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtThreshold" Style="float: right" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:418px;">
                <table style="margin-left:204px;">
                    <tr>
                        <td>
                            <asp:Label ID="lblSynchLocator" runat="server" Text="Synch Locator By Default" meta:Resourcekey="lblSynchLocator"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkSynchLocator" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPublic" runat="server" Text="Public?" meta:Resourcekey="lblPublic"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPublic" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>

        </tr>
    </table>

    <table>
        <tr>
            <td style="vertical-align: top; width: 570px;">
                <fieldset runat="server" id="fldDates" style="padding-bottom: 69px;width:570px;">
                    <legend>
                        <asp:Label runat="server" ID="lblResourcesSettings" meta:resourcekey="lblResourcesSettings" Text="Resources Settings"></asp:Label>
                    </legend>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblSortBy" meta:resourcekey="lblSortBy" Text="Sort By" Style="font-weight: 700"></asp:Label>
                            </td>
                            <td style="width: 240px">
                                <telerik:RadComboBox ID="ddlSortBy" runat="server" Skin="Default" Width="240px"
                                    CloseDropDownOnBlur="true" NoWrap="False">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                            <td style="width: 170px">
                                <asp:Button runat="server" Width="170px" meta:resourcekey="btnUpdateRequirements" ID="btnUpdateRequirements" />
                            </td>
                        </tr>
                    </table>
                    <table style="width: 570px">
                        <tr>
                            <td style="width:231px;">
                                <asp:Label ID="lblID" runat="server" Text="ID" meta:Resourcekey="lblID"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;" >
                                <asp:TextBox ID="txtID" runat="server" Width="240px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" Text="First Name" meta:Resourcekey="lblFirstName"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <asp:TextBox ID="txtFirstName" runat="server" Width="240px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" Text="Last Name" meta:Resourcekey="lblLastName"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <asp:TextBox ID="txtLastName" runat="server" Width="240px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr>
                            <td>
                                <asp:Label ID="lblDescriptionResources" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <asp:TextBox ID="txtDescriptionResources" runat="server" Width="240px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCompany" runat="server" Text="Company(s)" meta:Resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="243px" DropDownWidth="320px"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company(s)..." NoWrap="False" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                     OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApplyCompanies" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApplyCompanies"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnddlCompaniesValues" />
                                <asp:HiddenField runat="server" ID="hddnddlCompaniesNames" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblContacts" runat="server" Text="Contact(s)" meta:Resourcekey="lblContacts"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlContacts" runat="server" Height="200px" Skin="Default" Width="243px" DropDownWidth="320px"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlContacts" EmptyMessage="Select Contact(s)..." NoWrap="False" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"  OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApplyContacts" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chkApplyContacts"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnddlContactsValues" />
                                <asp:HiddenField runat="server" ID="hddnddlContactsNames" />
                            </td>
                        </tr>
                          <tr>
                            <td>
                                <asp:Label ID="lblTypes" runat="server" Text="Type" meta:Resourcekey="lblTypes"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                 <telerik:RadComboBox ID="ddlTypes"  runat="server" Height="200px" Skin="Default" Width="243px" 
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true" Filter="Contains"   meta:resourcekey="ddlTypes" EmptyMessage="Select Types(s)...">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkType" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chkType"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnTypes" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country(s)"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlCountriesResources" Width="243px" Height="350px" AllowCustomText="true" Filter="Contains" DropDownWidth="405px"
                                    runat="server" Style="font-size: 11px" meta:resourcekey="ddlCountries" EmptyMessage="Select Country(s)...">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnCountriesIds" />
                                <asp:HiddenField runat="server" ID="hddnCountriesNames" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblRegion" meta:resourcekey="lblRegion" runat="server" Text="Region(s)"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlRegionsResources" Width="243px" Height="350px" AllowCustomText="true" Filter="Contains" DropDownWidth="405px"
                                    runat="server" Style="font-size: 11px" meta:resourcekey="ddlRegionsResources" EmptyMessage="Select Region(s)...">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnRegionsIds" />
                                <asp:HiddenField runat="server" ID="hddnRegionsNames" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTitle" runat="server" Text="Title" meta:Resourcekey="lblTitle"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <asp:TextBox ID="txtTitle" runat="server" Width="240px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblResourceGroup" runat="server" meta:Resourcekey="lblResourceGroup" Text="Resource Group(s)"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlResourceGroups" meta:Resourcekey="ddlResourceGroups" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                    Skin="Default" NoWrap="true" Width="245px" Height="200px" EmptyMessage="Select Resource Group(s)...">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnResourceGroupIds" />
                                <asp:HiddenField runat="server" ID="hddnResourceGroupNames" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 130px;">
                                <asp:Label ID="lblManager" runat="server" Text="Manager(s)" meta:Resourcekey="lblManager"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlManagers" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                    Skin="Default" NoWrap="true" Width="245px" Height="200px" meta:Resourcekey="ddlManager" EmptyMessage="Select Manager(s)...">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnManagerIds" />
                                <asp:HiddenField runat="server" ID="hddnManagerNames" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 130px;">
                                <asp:Label ID="lblPaytype" runat="server" Text="Default Pay Type(s)" meta:Resourcekey="lblPaytype"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlPayTypes" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                    Skin="Default" Width="245px"  CloseDropDownOnBlur="true" Height="300"
                                    EnableItemCaching="false" EmptyMessage="Select PayType(s)..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" meta:Resourcekey="ddlPayTypes"  OnClientItemsRequesting="PlannerResources_GetValueToReturn">
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
                            <td style="width: 130px;">
                                <asp:Label ID="lblClassificationsResources" runat="server" Text="Default Classification(s)" meta:Resourcekey="lblClassificationsResources"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlClassificationsResources" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                    Skin="Default" Width="245px"  CloseDropDownOnBlur="true" Height="300"
                                    EnableItemCaching="false" 
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" EmptyMessage="Select Classification(s)..."  OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    meta:resourcekey="ddlClassificationsResources"  OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnddlClassificationsResourcesValues" />
                                <asp:HiddenField runat="server" ID="hddnddlClassificationsResourcesNames" />
                            </td>
                        </tr>
                        <tr>
                            <td class="NoWrap">
                                <asp:Label ID="lblCostCode" runat="server" Text="Default Cost Code(s)" meta:resourcekey="lblCostCode"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="245px" DropDownWidth="300px"
                                    EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code(s)..." meta:resourcekey="ddlCostCode"
                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"  OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hddnddlCostCodesValues" Value="0" />
                                <asp:HiddenField runat="server" ID="hddnddlCostCodesNames" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSkillsResources" runat="server" Text="Skills" meta:resourcekey="lblSkillsResources"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlSkillsResources" runat="server" meta:resourcekey="ddlSkillsResources" EmptyMessage="Select Skill(s)..."
                                    AllowCustomText="True" Width="245px" DropDownWidth="405px" Filter="Contains">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApplySkills" />
                                            <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnSkillsResources"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmploymentStatus" runat="server" meta:Resourcekey="lblEmploymentStatus" Text="Employment Status(s)"></asp:Label>
                            </td>
                            <td style="width: 246px;padding-left: 93px;">
                                <telerik:RadComboBox ID="ddlEmploymentStatuses" meta:resourcekey="ddlEmploymentStatuses" runat="server" Height="200px" Skin="Default" Width="245px" 
                                    CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true" Filter="Contains" EmptyMessage="Select Employment Status(es)">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
<asp:HiddenField runat="server" ID="hdnEmploymentStatus"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblHoursPerDay" meta:resourcekey="lblHoursPerDay" runat="server" Text="Default Hours Per Day"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                <telerik:RadTextBox ID="txtHoursPerDayRequired"
                                    MinValue="0" MaxValue="24" runat="server" MaxLength="9" Width="125px" CssClass="PositiveIntegerDouble Right">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td >
                              <asp:Label  ID="lblDefaultStartTime" runat="server" meta:Resourcekey="lblDefaultStartTime" Text="Default Start Time"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                <telerik:RadTimePicker ID="dtpStartTimePicker" runat="server" Culture="English (United States)"
                                    EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
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
                                <asp:Label ID="lblDefaultFinishTime" runat="server" meta:Resourcekey="lblDefaultFinishTime" Text="Default End Time"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                  <asp:CompareValidator  ID="cmpFinishStartTime" runat="server"
                                        ControlToValidate="dtpFinishimePicker" ControlToCompare="dtpStartTimePicker"  CssClass="Validator"
                                        ErrorMessage="Finish Date should be greater than Start Date" Display="Dynamic"  meta:Resourcekey="cmpFinishStartTime"
                                        ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                <telerik:RadTimePicker ID="dtpFinishimePicker" runat="server" Culture="English (United States)"
                                    EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
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
                            <td>
                                <asp:Label ID="lblScheduling" runat="server" meta:Resourcekey="lblScheduling" Text="Scheduling"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                <telerik:RadComboBox ID="ddlScheduling" runat="server" Skin="Default" Width="125px"
                                    CloseDropDownOnBlur="true" NoWrap="False">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSub" runat="server" meta:Resourcekey="lblSub" Text="Sub"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                <telerik:RadComboBox ID="ddlSub" runat="server" Skin="Default" Width="125px"
                                    CloseDropDownOnBlur="true" NoWrap="False">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblOverbookingSetting" runat="server" meta:Resourcekey="lblOverbookingSetting" Text="Overbooking Setting"></asp:Label>
                            </td>
                            <td style="text-align: right">
                                <telerik:RadComboBox ID="ddlOverbookingSettings" runat="server" Skin="Default" Width="125px"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlOverbookingSettings" NoWrap="False">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                    </table>
                </fieldset>
            </td>

            <td style="vertical-align: top; width: 650px;">
                <telerik:RadAjaxPanel ID="pnlRequirements" runat="server" Width="100%" HorizontalAlign="NotSet">
                <fieldset style="width:570px;padding-bottom:7px;" id ="fldtest">
                    <legend>
                        <asp:Label ID="lblRequirementsSettings" runat="server" Text="Requirements Settings" meta:resourcekey="lblRequirementsSettings"></asp:Label>
                    </legend>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" meta:Resourcekey="lblSortBy" Width="100px" runat="server" Text="Sort By" Style="font-weight: 700"></asp:Label>
                            </td>
                            <td style="padding-left:20px;">
                                <telerik:RadComboBox ID="ddlSortByRequirements" runat="server" Width="250px" Skin="Default" Style="font-size: 11px">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label14" meta:Resourcekey="lblGroupBy" Width="100px" runat="server" Text="Group By" Style="font-weight: 700"></asp:Label>
                            </td>
                            <td style="padding-left:20px;">
                                <telerik:RadComboBox ID="ddlGroupBy" runat="server" Width="250px" Skin="Default" Style="font-size: 11px">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 570px">
                        <tr>
                            <td style="width: 270px" class="NoWrap">
                                <asp:Label ID="lblBasedOn" meta:Resourcekey="lblBasedOn" Width="100px" runat="server" Text="Based On"></asp:Label>
                            </td>
                            <td style="padding-left: 10px; width: 290px">
                                <telerik:RadComboBox  ID="ddlBasedOn" runat="server" Width="245px" Skin="Default" Style="font-size: 11px" AutoPostBack="true">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr runat="server" id="trProgram">
                            <td>
                                <asp:Label ID="lblProgram" runat="server" Text="Program(s)" meta:resourcekey="lblProgram"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlPrograms" AllowCustomText="true" runat="server" 
                                    DropDownWidth="245px" Width="245px" meta:resourcekey="ddlPrograms" EmptyMessage="Select Program(s)..."
                                    NoWrap="true" Height="200px" EnableLoadOnDemand="true"  AutoPostBack="true"
                                    ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" OnClientDropDownClosed ="ProjectLoad"
                                    OnClientSelectedIndexChanged="dllSelectedIndexChanged"  OnClientItemsRequesting="PlannerResources_GetValueToReturn"
                                    EnableVirtualScrolling="True">
                                     <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkProgram" />
                                            <asp:Label runat="server" ID="lblProgram" AssociatedControlID="chkProgram"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                 <asp:HiddenField runat="server" ID="hddnddlProgramsValues" />
                                <asp:HiddenField runat="server" ID="hddnddlProgramsNames" />

                               
                            </td>
                        </tr>
                        <tr runat="server" id="trProject">
                            <td>
                                <asp:Label ID="lblProject" runat="server" Text="Project(s)" meta:resourcekey="lblProject"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlProjects" Width="245px" UseProjectFilter="1" runat="server" meta:resourcekey="ddlProjects" EmptyMessage="Select Project(s)..."
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px" DropDownWidth="245px" CausesValidation="false"
                                    OnClientSelectedIndexChanged="dllSelectedIndexChanged"  OnClientItemsRequesting="PlannerResources_GetValueToReturn" 
                                    NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                    ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkProject" />
                                            <asp:Label runat="server" ID="lblProject" AssociatedControlID="chkProject"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                  <asp:HiddenField runat="server" ID="hddnddlProjectsValues" />
                                <asp:HiddenField runat="server" ID="hddnddlProjectsNames" />
                            </td>
                        </tr>
                        <tr runat="server" id="trLocationProgram" visible="false">
                            <td>
                                <asp:Label ID="lblLocationProgram" runat="server" Text="Location Program*" meta:resourcekey="lblLocationProgram"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlLocationPrograms" AllowCustomText="true" runat="server" AutoPostBack="true"
                                    DropDownWidth="405px" Width="245px" meta:resourcekey="ddlLocationPrograms" EmptyMessage="Select Location Program..."
                                    NoWrap="true" Height="200px" EnableLoadOnDemand="true"
                                    ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                    EnableVirtualScrolling="True">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvLocationPrograms" meta:Resourcekey="rfvLocationPrograms" runat="server" ControlToValidate="ddlLocationPrograms"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Location Program required"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CustomValidator meta:Resourcekey="csvLocationPrograms" ID="csvLocationPrograms" runat="server" ControlToValidate="ddlLocationPrograms"
                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                    CssClass="Validator" ErrorMessage="Location Program required">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="trLocation" visible="false">
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlLocations" Width="245px" runat="server" meta:resourcekey="ddlLocations" EmptyMessage="Select Location..."
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px"  CausesValidation="false"
                                    NoWrap="True" EnableLoadOnDemand="True" AutoPostBack="true" AllowCustomText="true"
                                    ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblLinkTypes" meta:Resourcekey="lblLinkTypes" Width="100px" runat="server" Text="Link Type(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlLinkTypes" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" AutoPostBack="true"
                                    NoWrap="True" OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkLinkApply" />
                                            <asp:Label runat="server" ID="Label4" AssociatedControlID="chkLinkApply"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                 <asp:HiddenField runat="server" ID="hddnddlLinkTypesValues" />
                                <asp:HiddenField runat="server" ID="hddnddlLinkTypesNames" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblLinkedTo" meta:Resourcekey="lblLinkedTo" Width="100px" runat="server" Text="Linked To"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlLinkedTo" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblRequirementID" meta:Resourcekey="lblRequirementID" Width="100px" runat="server" Text="Requirement ID"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtRequirementID" Width="240px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" Width="100px" runat="server" Text="Description"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtDescriptionRequirements" Width="240px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblResourceTypes" meta:Resourcekey="lblResourceTypes" Width="100px" runat="server" Text="Resource Type(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlResourceTypes" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" 
                                    NoWrap="True" meta:resourcekey="ddlResourceTypes" EmptyMessage="Select Types(s)...">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkResourceType" />
                                            <asp:Label runat="server" ID="Label1" AssociatedControlID="chkResourceType"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnResourceTypes" Value="" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblClassificationsRequirements" meta:Resourcekey="lblClassificationsRequirements" Width="100px" runat="server" Text="Classification(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlClassificationsRequirements" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    NoWrap="True" EmptyMessage="Select Classification(s)..." meta:resourcekey="ddlClassificationsRequirements" 
                                     OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chk" />
                                            <asp:Label runat="server" ID="Label6" AssociatedControlID="chk"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                 <asp:HiddenField runat="server" ID="hddnddlClassificationsRequirementsValues" />
                                <asp:HiddenField runat="server" ID="hddnddlClassificationsRequirementsNames" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblSkillsRequirements" meta:Resourcekey="lblSkillsRequirements" Width="100px" runat="server" Text="Skills"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlSkillsRequirements" runat="server" meta:resourcekey="ddlSkillsRequirements" EmptyMessage="Select Skill(s)..."
                                    AllowCustomText="True" Width="245px"  Filter="Contains">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chlSkillsApply" />
                                            <asp:Label runat="server" ID="Label7" AssociatedControlID="chlSkillsApply"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnSkillsRequirements" Value="" />
                                <asp:HiddenField runat="server" ID="hdnSkillsRequirementsNames" Value="" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblCountries" meta:Resourcekey="lblCountries" Width="100px" runat="server" Text="Country(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlCountriesRequirements" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True"  EnableVirtualScrolling="true"
                                     CloseDropDownOnBlur="true" 
                                    meta:resourcekey="ddlCountries" EmptyMessage="Select Country(s)..."
                                    NoWrap="True" Filter="Contains">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkCountriesApply" />
                                            <asp:Label runat="server" ID="Label8" AssociatedControlID="chkCountriesApply"></asp:Label>
                                             <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnCountries" Value="" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblRegions" meta:Resourcekey="lblRegions" Width="100px" runat="server" Text="Region(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlRegionsRequirements" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True"  EnableVirtualScrolling="true" Filter="Contains" 
                                     MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True" meta:resourcekey="ddlRegionsRequirements" EmptyMessage="Select Region(s)...">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkRegionApply" />
                                            <asp:Label runat="server" ID="Label10" AssociatedControlID="chkRegionApply"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:HiddenField runat="server" ID="hdnRegions" Value="" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblPriorities" meta:Resourcekey="lblPriorities" Width="100px" runat="server" Text="Priority(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlPriorities" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True"   EnableVirtualScrolling="true" Filter="Contains"
                                     MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True"  meta:resourcekey="ddlPriorities" EmptyMessage="Select Priority(ies)...">
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
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblProgress" meta:Resourcekey="lblProgress" Width="100px" runat="server" Text="Progress"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlProgress" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableVirtualScrolling="true" Filter="Contains"
                                    On MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True"  meta:resourcekey="ddlProgress" EmptyMessage="Select Progress...">
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
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblCategories" meta:Resourcekey="lblCategories" Width="100px" runat="server" Text="Category(s)"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlCategories" Width="245px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True"  EnableVirtualScrolling="true" Filter="Contains"
                                     MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True"  meta:resourcekey="ddlCategories" EmptyMessage="Select Category(ies)...">
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
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblNumberOfResources" meta:Resourcekey="lblNumberOfResources" Width="100px" runat="server" Text="# of Resources"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtNumberOfResources" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblWorkDays" meta:Resourcekey="lblWorkDays" Width="100px" runat="server" Text="Work Days"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtWorkDays" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="Label13" meta:Resourcekey="lblHoursPerDay" Width="100px" runat="server" Text="Hours Per Day"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtHoursPerDay" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblHoursTotal" meta:Resourcekey="lblHoursTotal" Width="100px" runat="server" Text="Hours Total"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtHoursTotal" Width="100px" CssClass="PositiveInteger" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblStart" meta:Resourcekey="lblStart" Width="100px" runat="server" Text="Start"></asp:Label>
                                        </td>
                                        <td align="right" style="padding-left: 100px">
                                            <telerik:RadComboBox ID="ddlStartOption" runat="server" Skin="Default" Width="100px" AutoPostBack="true"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left:8px;" runat="server" id="tdExpressionStart" >
                                <table>
                                    <tr>
                                        <td> <telerik:RadComboBox ID="ddlExpressionStart" runat="server" Skin="Default" Width="103px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox></td>
                                        <td style="padding-left:6px;padding-right:6px;">
                                            <telerik:RadTextBox ID="txtNbrOfTimePeriodsStart"
                                    MinValue="0"  runat="server" MaxLength="9" Width="29px" CssClass="PositiveIntegerDouble Right">
                                </telerik:RadTextBox></td>
                                        <td style="padding-left:0px;">
                                            <telerik:RadComboBox ID="ddlTimePeriodsStart" runat="server" Skin="Default" Width="100px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox></td>
                                       
                            </tr>
                        </table>
                    </td>
                             <td style="padding-left:8px;" runat="server" id="tdDatesStart" >
                                <table>
                                    <tr>
                                        <td>  <telerik:RadDatePicker ID="rdpStartFromDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default"  EnableTyping="true">
                                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar3"   Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker></td>
                                        <td style="padding-left:10px;"><asp:Label ID="lblTo" meta:Resourcekey="lblTo" Width="29px" runat="server" Text="To"></asp:Label></td>
                                        <td style="padding-left:0px;">
                                            <telerik:RadDatePicker ID="rdpStartToDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default"  EnableTyping="true">
                                                            <DateInput ID="DateInput4" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar4"   Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker></td>
                                       
                                    </tr>
                                    <tr >
                                        <asp:CompareValidator  ID="cmpStartFromToDate" runat="server" meta:ResourceKey="cmpStartFromToDate"
                                        ControlToValidate="rdpStartToDate" ControlToCompare="rdpStartFromDate"  CssClass="Validator" Type="Date"
                                        ErrorMessage="To Date should be greater than From Date" Display="Dynamic"
                                        ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                         <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label15" meta:Resourcekey="lblFinish" Width="100px" runat="server" Text="Finish"></asp:Label>
                                        </td>
                                        <td align="right" style="padding-left: 100px">
                                            <telerik:RadComboBox ID="ddlFinishOption" runat="server" Skin="Default" Width="100px" AutoPostBack="true"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left:8px;" runat="server" id="tdExpressionFinish" >
                                <table>
                                    <tr>
                                        <td> <telerik:RadComboBox ID="ddlExpressionFinish" runat="server" Skin="Default" Width="103px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox></td>
                                        <td style="padding-left:6px;padding-right:6px;">
                                            <telerik:RadTextBox ID="txtNbrOfTimePeriodsFinish"
                                    MinValue="0"  runat="server" MaxLength="9" Width="29px" CssClass="PositiveIntegerDouble Right">
                                </telerik:RadTextBox></td>
                                        <td style="padding-left:0px;">
                                            <telerik:RadComboBox ID="ddlTimePeriodsFinish" runat="server" Skin="Default" Width="100px"
                                                CloseDropDownOnBlur="true" NoWrap="False">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox></td>
                                       
                            </tr>
                        </table>
                    </td>
                             <td style="padding-left:8px" runat="server" id="tdDatesFinish" >
                                <table>
                                    <tr>
                                        <td>  <telerik:RadDatePicker ID="rdpFinishFromDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default"  EnableTyping="true">
                                                            <DateInput ID="DateInput5" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar5"   Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker></td>
                                        <td style="padding-left:10px;"><asp:Label ID="Label16" meta:Resourcekey="lblTo" Width="29px" runat="server" Text="To"></asp:Label></td>
                                        <td style="padding-left:0px;">
                                            <telerik:RadDatePicker ID="rdpFinishToDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="103px" Skin="Default"  EnableTyping="true">
                                                            <DateInput ID="DateInput6" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                runat="server">
                                                            </DateInput>
                                                            <Calendar ID="Calendar6"   Skin="Default" runat="server">
                                                            </Calendar>
                                                        </telerik:RadDatePicker></td>
                                       
                                    </tr>
                                    <tr>
                                         <asp:CompareValidator  ID="cmpFinishFromToDate" runat="server"
                                        ControlToValidate="rdpFinishToDate" ControlToCompare="rdpFinishFromDate"  CssClass="Validator" Type="Date"
                                        ErrorMessage="To Date should be greater than From Date" Display="Dynamic"
                                        ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
                                <asp:Label ID="lblClosed" meta:Resourcekey="lblClosed" Width="100px" runat="server" Text="Closed"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlClosed" Width="247px" runat="server" Height="250px" Style="font-size: 11px"
                                      EnableVirtualScrolling="true"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px" class="NoWrap">
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
                            <td style="padding-left: 10px;">
                                <telerik:RadComboBox ID="ddlRequestedBy" Width="247px" runat="server" Height="250px" Style="font-size: 11px"
                                    AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                    OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True" meta:resourcekey="ddlRequestedBy" EmptyMessage="Select User(s)..." OnClientItemsRequesting="PlannerResources_GetValueToReturn">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkRequestedByApply" />
                                            <asp:Label runat="server" ID="Label13" AssociatedControlID="chkRequestedByApply"></asp:Label>
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                 <asp:HiddenField runat="server" ID="hddnddlRequestedByValues" value="0" /> 
                                <asp:HiddenField runat="server" ID="hddnddlRequestedByNames" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
                    </telerik:RadAjaxPanel>
            </td>
        </tr>
    </table>
</asp:Content>

