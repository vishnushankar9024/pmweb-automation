<%@ Page Language="vb" meta:resourcekey="Page" Title="Team Input" AutoEventWireup="false" CodeBehind="WorkflowTeamInput.aspx.vb" Inherits="Website.WorkflowTeamInput" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        @media screen and (min-width:320px) and (max-width:827px) {
            .width6col {
                width: 400px !important;
            }
        }

        @media screen and (min-width:828px) {
            .width6col {
                width: 424px !important;
            }
        }

        .divContactBox {
            width: 100% !important;
            min-height: 35px;
            overflow: auto;
            float: left;
            border: 1px solid #666666;
            box-sizing: border-box;
            background: #EDEDED;
        }

        div.ContactBox {
            padding: 4px 10px !important;
            background: #ffffff !important;
            border: 1px solid #7396AA !important;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
        <script type="text/javascript">
            var MobileScreenWidth = 1024;
            ObjectType = '<%= PM.Workflow.DocumentController.GetObjectTypeFromRecordTypeId(PM.Workflow.DocumentInfo.RecordTypeId) %>';
            ObjectTypeId = '<%= PM.Workflow.DocumentInfo.ObjectTypeId %>';
            ObjectId = '<%= PM.Workflow.DocumentInfo.ObjectId %>';

            function OnClientLoad(sender, args) {
                var hdnFirstLoad = $("[id$=hdnFirstLoad]")[0];
                window.parent.TeamInputIds = '<%= PM.Workflow.DocumentInfo.TeamInputIds %>';
                if (hdnFirstLoad.value == "1") {
                    $("textarea[id$='txtMessage']").val(window.parent.jQuery("textarea[id$='txtComments']").val());
                    hdnFirstLoad.value = "0"
                }
            }

            function CloseTeamInputPopup() {
                window.parent.TeamInputIds = '<%= PM.Workflow.DocumentInfo.TeamInputIds %>';
                window.parent.TeamInputPopup = '<%= PM.Workflow.DocumentInfo.IsTeamInputPopup %>';
                window.parent.jQuery("textarea[id$='txtComments']").val($("textarea[id$='txtMessage']").val());
                UpdateTeamInputAction();
                CloseRadWnd();
            }

            function ValidateCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value > 0 || value == '') {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                else
                    args.IsValid = true;
            }
     
            function OpenTeamInputMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                if (ObjectType == 'ESTIMATE_PROCUREMENT') {
                    Bidder = 1;
                }
                if (ObjectType == 'PREBID') {
                    Bidder = 2;
                }
                var ProjectId = 0;
                if (ObjectType != 'BUDGETINITIATIVES' && ObjectTypeId == 1) {
                    ProjectId = ObjectId;
                }
                var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
                   'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                return false;
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

            function AddTeamInputUserContact(argContactId, argContactName, argEmail, SpnClientId) {
                var tmpId = parseInt(Math.random() * 100000);
                document.getElementById(SpnClientId).innerHTML = document.getElementById(SpnClientId).innerHTML + '<div id="divContactBox_' + tmpId + '" class="ContactBox"  ContactId="' + argContactId +  '" Email="' + argEmail + '">' +
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
            document.getElementById('<%=hdnTeamInputUserContact.ClientID %>').value = document.getElementById('<%=spnTeamInputUserContact.ClientID%>').innerHTML;
          }

        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientLoad="OnClientLoad"
                        OnClientButtonClicking="SaveContacts">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent">
            <div class="PMHeader">
                <div class="row documentSinglePage">
                    <div class="col-6" style="padding-bottom:20px;">
                        <table class="colTable" style="width: 400px !important;">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStep" runat="server" Text="Step" meta:resourcekey="lblStep"></asp:Label>
                                </td>
                                <td class="controlWidth" style="width: 240px !important;">
                                    <asp:TextBox ID="txtStep" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblApprover" runat="server" Text="Approver" meta:resourcekey="lblApprover"></asp:Label>
                                </td>
                                <td class="controlWidth" style="width: 240px !important;">
                                    <asp:TextBox ID="txtApprover" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <div style="float: left;">
                                        <asp:Label ID="lblRequestTeamInput" runat="server" Text="Request Team Input" meta:resourcekey="lblRequestTeamInput"></asp:Label>
                                    </div>
                                    <div style="float: right">
                                        <asp:LinkButton ID="btnRequestTeamInput" runat="server" CssClass="SearchButton"
                                            OnClientClick="return OpenTeamInputMultipleCompanyFilterPopup(this.id.replace('btnRequestTeamInput', 'spnTeamInputUserContact'), this.id.replace('btnRequestTeamInput', 'txtTo'), this.id.replace('btnRequestTeamInput', 'hddnIds'), 'TeamInputUserContacts', 'TeamInput')">
                                                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtTest" CssClass="Hide" runat="server" Width="80%" Text="test"></asp:TextBox>
                                    <div style="" class="divContactBox" runat="server" id="dvTeamInput">
                                        <span id="spnTeamInputUserContact" runat="server" style="white-space: nowrap; display: flex; width: 100%; flex-wrap: wrap"></span>
                                        <asp:HiddenField runat="server" ID="hdnTeamInputUserContact" ValidateRequestMode="Disabled" />
                                    </div>
                                    <asp:Label ID="lblMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trCurrentTeam" runat="server">
                                <td class="labelWidth">
                                    <asp:Label ID="lblCurrentTeam" runat="server" Text="Current Team" meta:resourcekey="lblCurrentTeam"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCurrentTeam" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trReviewedBy" runat="server">
                                <td class="labelWidth">
                                    <asp:Label ID="lblReviewedBy" runat="server" Text="Reviewed By" meta:resourcekey="lblReviewedBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReviewedBy" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditRecord" runat="server" Text="Can Edit Record" meta:resourcekey="lblCanEditRecord"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditRecord" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditNotes" runat="server" Text="Can Edit Notes" meta:resourcekey="lblCanEditNotes"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditNotes" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditAttachments" runat="server" Text="Can Edit Attachments" meta:resourcekey="lblCanEditAttachments"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditAttachments" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessage"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="390px" InputType="Text"></telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-6 width6col">
                        <telerik:RadGrid ID="rdgTeamProgress" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                            Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False"
                            SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="400px"
                            AllowSorting="False" GridLines="None">
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="None" TableLayout="Fixed"
                                Width="300px" UseAllDataFields="true" EnableHeaderContextMenu="False">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("TeamMemberName").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="218px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("Progress").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="180px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                    AllowColumnResize="False" />
                                <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
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
