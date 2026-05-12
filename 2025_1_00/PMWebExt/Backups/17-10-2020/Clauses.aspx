<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Clauses.aspx.vb" Inherits="Website.Clauses" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ClauseDetails.ascx" TagName="ClauseDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc4" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
             <style>
            .labelChkWidth {
                width: 80% !important;
                height: 24px;
                line-height: 24px;
                background: #FFFFFF;
                color: #666666 !important;
                padding-bottom: 3px;
            }
                 </style>
        <script type="text/javascript">

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
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {

                var RecordDescription = '<%=JSEscape(PM.ClauseInfo.RecordNumber & " - " & PM.ClauseInfo.GroupDescription)%>';
                var Description = '<%=JSEscape(PM.ClauseInfo.GroupDescription)%>';
                var Id = '<%= PM.ClauseInfo.Id%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=CLAUSES&Id=" +
                     '<%= PM.ClauseInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0" + "&EntityType=0", 400, 150, false);

                        break;
                    default:

                        break;
                }
            }


            function Program_ResetCombos(combobox, eventArgs) {
                var ddlProject = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                ddlProject.clearItems();
                ddlProject.set_text("");
                ddlProject.set_value("0");



            }
            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    if (vlue.indexOf("-1") > -1 && resultId != "-1") {
                        hdnField.value = ""
                        hdnNames.value = "";
                        vlue = "";
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() == "-1") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                                break;
                            }

                        }

                    }
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                    if (resultId == "-1") {
                        hdnField.value = resultId;
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {

                            var item = items.getItem(i);
                            if (item.get_value() != "-1") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                            }

                        }



                    }

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

            function ValidateProgramCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();

                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value >= 0) {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                        if (value.length == 0)
                            args.IsValid = false;
                    }
                }
                else
                    args.IsValid = true;
            }



        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>   
            <telerik:AjaxSetting AjaxControlID="mlpClasue">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpClasue" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpClasue" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">

            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=194">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd  showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>

            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">

                <telerik:RadComboBox ID="ddlClauses" runat="server" meta:resourcekey="ddlClauses" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True" EmptyMessage="Select a clause.."
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--   <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>


              <%--          <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
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
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>

            </td>
            <td></td>
        </tr>

    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpClasue" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpClasue" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtId" runat="server" MaxLength="15"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="cmpId" runat="server" ControlToValidate="txtId"
                                            CssClass="Validator"  Display="Dynamic" ForeColor=""
                                            ValidationGroup="Save" Operator="NotEqual" meta:resourcekey="cmp_Id">
                                        </asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblGroupDescription" runat="server" Text="Group Description" meta:resourcekey="lblGroupDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGroupDescription" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type(s)" meta:resourcekey="lblRecordType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRecordTypes" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Height="200px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordTypes" meta:Resourcekey="rfvRecordTypes" runat="server"
                                            ControlToValidate="ddlRecordTypes" CssClass="Validator" InitialValue="" ErrorMessage="Record Type required."
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" AutoPostBack="true" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Height="200px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvProgram" runat="server"
                                            ControlToValidate="ddlProgram" CssClass="Validator" InitialValue="" ErrorMessage="Program required."
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvProgram" ID="csvProjects" runat="server"
                                            ControlToValidate="ddlProgram" ClientValidationFunction="ValidateProgramCombo"
                                            ValidationGroup="Save" Display="Dynamic" CssClass="Validator" ErrorMessage="Program required.">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project(s)" meta:Resourcekey="lblProjects"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" Height="250px" runat="server"
                                            AllowCustomText="True" Skin="Default" EnableItemCaching="false"
                                            OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />

                                                    <%#DataBinder.Eval(Container, "Attributes['ProjectName']")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnIds" />
                                        <asp:HiddenField runat="server" ID="hddnNames" />
                                    </td>
                                </tr>
                                </table>
                            <table class="colTable">
                                <tr>
                                    <td class="labelChkWidth">
                                        <asp:Label ID="lblnotes" runat="server" Text=" Include Notes With Clauses" meta:Resourcekey="chkIncludeNotes"></asp:Label>
                                        </td>
                                    <td style="text-align: right;" >
                                        
                                            <asp:CheckBox runat="server" ID="chkIncludeNotes" CssClass="mobile-switch" />
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelChkWidth" >
                                        <asp:Label ID="lblAttachments" runat="server" Text=" Include Attachments With Clauses" meta:Resourcekey="chkIncludeAttach"></asp:Label>
                                        </td>
                                    <td style="text-align: right;">
                                        
                                            <asp:CheckBox runat="server" ID="chkIncludeAttach" CssClass="mobile-switch" />
                                      
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc5:AssetRotator ID="PMrot" runat="server" />
                        </div>

                    </div>
                </div>

            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc1:ClauseDetails ID="ClauseDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc4:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
