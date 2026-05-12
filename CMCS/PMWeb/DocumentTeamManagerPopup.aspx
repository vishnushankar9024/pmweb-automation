<%@ Page meta:resourcekey="PageTitle" Language="vb" AutoEventWireup="false" CodeBehind="DocumentTeamManagerPopup.aspx.vb" Inherits="Website.DocumentTeamManagerPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
       <style type="text/css">
        .ContactBox {
            white-space : pre-wrap !important;
            background-color: white !important;
                  }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            function OnClientLoad(sender, args) {
                var hdnFirstLoad = $("[id$=hdnFirstLoad]")[0];
                window.parent.TeamInputIds = '<%= PM.Workflow.DocumentInfo.TeamInputIds %>';
                if (hdnFirstLoad.value == "1") {
                    $("textarea[id$='txtMessage']").val(window.parent.jQuery("textarea[id$='txtComments']").val());
                    hdnFirstLoad.value = "0"
                }
            }
       

            function OpenTeamInputMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {          
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                ObjectType = '<%= PM.Team.DocumentTeamInfo.DocumentType %>';
                EntityId = '<%= PM.Team.DocumentTeamInfo.EntityId %>';
                if (ObjectType == 'ESTIMATE_PROCUREMENT') {
                    Bidder = 1;
                }
                if (ObjectType == 'PREBID') {
                    Bidder = 2;
                }
                var ProjectId = 0;
                if ((ObjectType != 'BUDGETINITIATIVES')) {
                    ProjectId = EntityId;
                }
                var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
                   'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                return false;
            }

            function AddTeamInputUserContact(argContactId, argContactName, argEmail, SpnClientId) {
                var tmpId = parseInt(Math.random() * 100000);
                document.getElementById(SpnClientId).innerHTML = document.getElementById(SpnClientId).innerHTML + '<div id="divContactBox_' + tmpId + '" class="ContactBox"  ContactId="' + argContactId + '" Email="' + argEmail + '">' +
                                '<span class="nowrap">&nbsp;&nbsp;' + argContactName + '</span>' +
                                '<a style="margin-left:5px;text-decoration: none;" href="#" onclick="javascript:return RemoveContactBox(\'' + String(tmpId) + '\');"><b>x&nbsp;&nbsp;</b></a>' +
                                '</div>';
            }


            function RemoveContactBox(argId) {
                    $("#divContactBox_" + String(argId)).remove();
                    return false;
            }

            function SaveContacts(sender, args) {
                var value = args.get_item().get_commandName();
                if (value == 'OpenGridDiv') {
                    $('#GridDiv').css("display", "block")
                    return false;
                } else if (value == 'OpenDetailDiv') {
                    $('#DetailDiv').css("display", "block")
                    return false;
                } else if (value == 'Save' || value == 'SaveAndExit') {
                    args.get_item().set_enabled(false)
                }
                CopyToHidden();
            }

            function CopyToHidden() {
                document.getElementById('<%=hdnTeamInputUserContact.ClientID %>').value = document.getElementById('<%=spnTeamInputCompany.ClientID%>').innerHTML;
        }

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

            function RefreshGrids() {
                var btnRefresh = window.parent.$("[id$=btnRefreshGrids]")[0];
                if (btnRefresh) {
                    btnRefresh.click();
                }
                
            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager1" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar"  OnClientLoad="OnClientLoad"
                         OnClientButtonClicking="SaveContacts">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" style="margin-right:-8px !important;"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row" style="margin-bottom:24px !important;margin-left:16px !important;">
                <div class="col-4 col-4-left">
                    <asp:Label ID="lblWorkflowMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:200px !important;">
                                <asp:Label ID="lblSubmitter" runat="server" Text="Submitter" meta:resourcekey="lblSubmitter"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:500px !important;">
                                <asp:TextBox ID="txtSubmitter" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                             <td valign="middle" class="labelWidth">
                                  <div style="float: left;">
                                     <asp:Label ID="lblRequestTeamInput" runat="server" Text="Request Team Input" meta:resourcekey="lblRequestCollaboration" Width="100%"></asp:Label>
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton ID="btnRequest" runat="server" CssClass="SearchButton"
                                        OnClientClick="return OpenTeamInputMultipleCompanyFilterPopup(this.id.replace('btnRequest', 'spnTeamInputCompany'), this.id.replace('btnTo', 'txtTo'), this.id.replace('btnTo', 'hddnIds'), 'TeamInputUserContacts', 'TeamInput')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                 <asp:TextBox ID="txtTest" CssClass="Hide" runat="server" Width="80%" Text="test"></asp:TextBox>
                                    <div id="dvTo" style="min-height:24px;border: 1px solid #666666; box-sizing: border-box; background: #EDEDED;" class="AllLightBlueBorder  divContactBox" runat="server" >
                                        <span id="spnTeamInputCompany" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap"></span>
                                        <asp:HiddenField ID="hdnTeamInputUserContact" runat="server" ValidateRequestMode="Disabled" />
                                    </div>
                                <asp:Button runat="server" CssClass="Hide" ID="btnRequestTeamInput" />



                                <asp:Label ID="lblMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditRecord" runat="server" Text="Can Edit Record" meta:resourcekey="lblCanEditRecord"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditRecord" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditNotes" runat="server" Text="Can Edit Notes" meta:resourcekey="lblCanEditNotes"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditNotes" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditAttachments" runat="server" Text="Can Edit Attachments" meta:resourcekey="lblCanEditAttachments"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditAttachments" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" >
                                <asp:Label ID="lblNotifyOnTeamChanges" runat="server" Text="Notify On Team Changes" meta:resourcekey="lblNotifyOnTeamChanges" ></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkNotifyOnTeamChanges" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDueDate" runat="server" Text="Due Date" meta:resourcekey="lblDueDate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <%-- <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 130px">--%>
                                <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default" Culture="English (United States)"
                                    EnableTyping="true" DatePopupButton-Visible="true">
                                    <DateInput ID="DateInput2" ReadOnly="false" runat="server"></DateInput>
                                </telerik:RadDatePicker>
                            </td>
                            <%--<td>
                                            <telerik:RadTimePicker ID="tmpDueDate" runat="server" Culture="English (United States)"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" Skin="Default" Width="120px">
                                                <dateinput id="DateInput1" runat="server" labelcssclass="radLabelCss_Office2007"
                                                    skin="Default">
                                            </dateinput>
                                                <calendar id="Calendar1" runat="server"   skin="Default">
                                            </calendar>
                                            </telerik:RadTimePicker>
                                        </td>--%>
                            <%--        </tr>
                                </table>
                            </td>--%>
                        </tr>
                           <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessage"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="80px" InputType="Text"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblTeamProgress" runat="server" Text="Team Progress" meta:resourcekey="lblTeamProgress"></asp:Label>
                                    </legend>
                                    <telerik:RadGrid ID="rdgTeamProgress" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                                        Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False"
                                        AllowSorting="False" GridLines="None" Width="100%" FitParentContainer="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true">

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="None" TableLayout="Fixed"
                                            Width="300px" UseAllDataFields="true" EnableHeaderContextMenu="False">

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <%#Eval("TeamMemberName").ToString%>&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProgress" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="198px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                            </Columns>

                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                                AllowColumnResize="False" />
                                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
        <asp:HiddenField runat="server" ID="hdnFirstLoad" Value="1"></asp:HiddenField>
    </form>
</body>
</html>
