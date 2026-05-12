<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Scoring.aspx.vb" Inherits="Website.Scoring" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="ScoringDetails.ascx" tagname="ScoringDetails" tagprefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" tagname="DocumentNotes" tagprefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" tagname="DocumentAttachments" tagprefix="uc3" %>
<%@ Register Src="ngDocNotifications.ascx" tagname="NotificationLog" tagprefix="uc4" %>
<%@ Register src="AssetRotator.ascx" tagname="AssetRotator" tagprefix="uc5" %>



<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

<script src="JS/Scoring.js" type="text/javascript"></script>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">


    <script type="text/javascript">
        var forceMoreMenuToClose = true;
        function MoreMenuClicked(sender, args) {
            if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                sender.close(true);
                
                maintoolbarClick(args.get_item().get_value())
            }
        }

        function click_handler(sender, args) {
            maintoolbarClick(args.get_item().get_commandName())
        }


        function maintoolbarClick(Value) {

            var RecordDescription = '<%=JSEscape(PM.DocumentScoringInfo.RecordNumber & " - " & PM.DocumentScoringInfo.GroupDescription)%>';
            var Description = '<%=JSEscape(PM.DocumentScoringInfo.GroupDescription)%>';
            var Id = '<%= PM.DocumentScoringInfo.Id%>';
            switch (Value) {
                case 'Notification':
                    if (Id == 0) break;
                    OpenPOPUp("Notification.aspx?ObjectType=SCORING&Id=" +
                 '<%= PM.DocumentScoringInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0" + "&EntityType=0", 400, 150, false);
                    break;

                default:
                    break;
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
                    for (var i = 0; i < items.get_count(); i++) {
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
                    for (var i = 0; i < items.get_count(); i++) {

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


      
   
        function OpenDateTimeOptionPopup(hdnOptions, txtOptions, TypeId, LineId) {
            return OpenPOPUp('ScoringDateTimeOptionsPopup.aspx?hdnOptions=' + hdnOptions + '&txtOptions=' + txtOptions + '&typeId=' + TypeId + '&LineId=' + LineId, 320, 200, true);
        }

        function OpenRadioButtonsLabelPopup(hdnOptions, txtOptions, TypeId, LineId) {
            return OpenPOPUp('ScoringRadioButtonsLabelsPopup.aspx?hdnOptions=' + hdnOptions + '&txtOptions=' + txtOptions + '&TypeId=' + TypeId + '&LineId=' + LineId, 400, 300, true);
        }
        function ValidateOption(source, args) {
            args.IsValid = false;
            var hdnOption = document.getElementById(source.controltovalidate.replace('txtValidation', 'hdnOptions'));
            if (hdnOption.value == '') {
             args.IsValid = false;
            }
          else
              args.IsValid = true;
            
        }
    </script>

</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
         <telerik:AjaxSetting AjaxControlID="mlpScoring">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpScoring" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="tbsDocument">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpScoring" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr  valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false"  PostBack="true" ToolTip="New (Alt+n)" AccessKey="n" >
                                               
                                        </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true"  OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening"  >
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                             <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('SCORING');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
      
    </table>


    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr id="trTbsDetails" runat="server">
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
                                runat="server" MultiPageID="mlpScoring" Skin="Default" Width="100%" EnableViewState="True"  CssClass="documentTabs"
                                CausesValidation="False">
                                <Tabs>
                                    <telerik:RadTab Text="Header" Value="Header" Selected="True" />
                                    <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
                                    <telerik:RadTab Text="Notes" Value="Notes" />
                                    <telerik:RadTab Text="Attachments" Value="Attachments" />
                                    <telerik:RadTab Text="Notification"  Value="NotificationLog" />
                                </Tabs>
                            </telerik:RadTabStrip>

                            <telerik:RadMultiPage ID="mlpScoring" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
                                RenderSelectedPageOnly="True">
                                <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                                    <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
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
                                                                <asp:TextBox ID="txtGroupDescription" runat="server" ></asp:TextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblRecordType" runat="server" Text="Record Type(s)" meta:resourcekey="lbl_RecordType"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlRecordTypes" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true"  AllowCustomText="true" runat="server"
                                                                    Skin="Default" NoWrap="true" Height="200px">
                                                                    <itemtemplate>
                                                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                            <asp:CheckBox runat="server" ID="chk"/>
                                                                            <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                                            <%#DataBinder.Eval(Container, "Text")%>
                                                                        </div>
                                                                    </itemtemplate>
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="rfvRecordTypes" meta:Resourcekey="rfv_RecordType" runat="server"
                                                                    ControlToValidate="ddlRecordTypes" CssClass="Validator" InitialValue="" 
                                                                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lbl_Program"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlProgram"  AutoPostBack="true" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                                                    Skin="Default" NoWrap="true" Height="200px" >
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfv_Programs" runat="server"
                                                                    ControlToValidate="ddlProgram" CssClass="Validator" InitialValue="" 
                                                                    Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                                                </asp:RequiredFieldValidator>
                                                                <asp:CustomValidator meta:Resourcekey="csv_Program" ID="csvProjects" runat="server"
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
                                                                <telerik:RadComboBox ID="ddlProjects" height="250px" runat="server" AllowCustomText="True" Skin="Default" EnableItemCaching="false"
                                                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                                    <itemtemplate>
                                                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                            <asp:CheckBox runat="server" ID="chk"/>
                                                                            <%#DataBinder.Eval(Container, "Attributes['ProjectName']")%>
                                                                        </div>
                                                                    </itemtemplate>
                                                                </telerik:RadComboBox>
                                                                <asp:HiddenField runat="server" ID="hddnIds" />
                                                                <asp:HiddenField runat="server" ID="hddnNames" />
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="labelWidth NoWrap" >
                                                                <asp:Label ID="lblIncludeNotes" runat="server" Text="Include Notes With Scoring11" meta:Resourcekey="chkIncludeNotes"  Width="250px" ></asp:Label>
                                                            </td>
                                                            <td class="controlWidth" align="right">
                                                                <asp:CheckBox runat="server" ID="chkIncludeNotes"/>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="labelWidth NoWrap"  >
                                                                <asp:Label ID="lblIncludeAttach" runat="server" Text="Include Attachments With Scoring11" meta:Resourcekey="chkIncludeAttach" Width="250px"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth" align="right">
                                                                <asp:CheckBox runat="server" ID="chkIncludeAttach"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <div class="col-4 col-4-right">
                                                    <table class="colTable">
                                                        <tr>
                                                            <td>
                                                                <uc5:AssetRotator ID="PMrot" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div> 
                                    </telerik:RadAjaxPanel>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
                                    <uc1:ScoringDetails ID="ScoringDetails1" runat="server" />
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

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</asp:Content>
