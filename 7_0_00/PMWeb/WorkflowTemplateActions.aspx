<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowTemplateActions.aspx.vb" Inherits="Website.WorkflowTemplateActions" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadScriptBlock ID="rsbTemplate" runat="server">
        <script type="text/javascript">
            function AddUsersAndRolesToCC() {
                var btnAddCCs = $("[id$=btnAddCCs]");
                btnAddCCs.click();
            }

            function RemoveUserBox(argId) {

                var hfdeletedCCs = $("[id$=hfdeletedCCs]")[0];
                hfdeletedCCs.value = argId;
                var btnRemoveCCs = $("[id$=btnRemoveCCs]");
                btnRemoveCCs.click();

            }

            function OpenSelectUserPopup() {
                debugger;
                OpenPOPUp('SelectUserPopup.aspx?&Bidder=0&Source=WorkflowTemplateActionType&ShowRoles=1&IsSingleSelect=0', 920, 415, false);
                return false;
            }

            function CheckMails(sender, args) {
                var emails = args.Value;
                var emails_array = emails.split(";");
                var reg = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
                for (var i = 0; i < emails_array.length; i++) {
                    if (reg.test(emails_array[i]) == false) {
                        args.IsValid = false;
                        return;
                    }
                }
                args.IsValid = true;
                return;
            }

            function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }


            //////////////////////////////////////////////////////////////////////////////////////

            function DisplayAs_CheckedChanged() {
                var chkDisplayAs = $("input[id$=chkDisplayAs]")[0];
                var grid = $find($("[id$=rdgActions]")[0].id);
                var gridAllRows = grid.get_masterTableView().get_dataItems();
                for (var i = 0; i < gridAllRows.length; i++) {
                    var objGridRow = gridAllRows[i];
                    var txtDisplayAs = objGridRow.findElement('txtDisplayAs');
                    var strActionType = objGridRow.get_cell("ActionType").innerText;
                    if (chkDisplayAs.checked) {
                        txtDisplayAs.disabled = false;
                    } else {
                        txtDisplayAs.disabled = true;
                        txtDisplayAs.value = strActionType;
                    }
                }
            }


            function chkStepSecurity_CheckedChanged() {
                var chkStepSecurity = $("input[id$=chkStepSecurity]")[0];
                var toolbar = $find($("[id$=mainToolBar]")[0].id);
                var rtbStepSecurity = toolbar.findItemByText("StepSecurity");
                if (chkStepSecurity.checked) {
                    rtbStepSecurity.set_enabled(true);
                } else {
                    rtbStepSecurity.set_enabled(false);
                    rtbStepSecurity.onclick = "";
                }
            }


            function OpenRoleStepSecurity(sender, eventArgs) {
                OpenRoleSecurityPOPUp("WorkflowRoleStepSecurity.aspx?StepId=0", 440, 430, true);
                return false;
            }


            function OpenRoleSecurityPOPUp(URL, Width, Height, Refresh) {
                var wnd = window.radopen(URL);
                wnd.setSize(Width, Height);
                if (Refresh == true) {
                    wnd.add_close(ReloadPage);
                }
                wnd.Center();
                return false;
            }


            function ReloadPage() {
                var btn = $("[id$=btnReload]")[0];
                btn.click();
            }
        </script>
        <style type="text/css">
            @media screen and (max-width: 880px) and (min-width: 320px) {
                .ToolBar {
                    top: 0;
                }
            }
        </style>
    </telerik:RadScriptBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <script type="text/javascript">
            $(document).ready(function () {
                if (getUrlVars()[0] == 'FromTemplateImage') {
                    $(window).unload(function () {
                        for (var i = 0; i < window.parent.length; i++) {
                            if (typeof window.parent[i].CloseDesigner === 'function')
                                window.parent[i].CloseDesigner();
                        }
                    });
                }
            });

        </script>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarStepSecurity" onclick="return OpenRoleStepSecurity();"
                                CommandName="StepSecurity" Text="StepSecurity" meta:resourcekey="RadToolBarButton_StepSecurity">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton>
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkStepSecurity" runat="server" Enabled="false" onclick="chkStepSecurity_CheckedChanged();" />
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblStep" runat="server" Text="Step*" meta:resourcekey="lblStep"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <asp:TextBox ID="txtStep" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trDaysToResubmit" runat="server">
                            <td class="labelWidth">
                                <asp:Label ID="lblDaysToResubmit" runat="server" Text="# of days to resubmit*" meta:resourcekey="lblDaysToResubmit"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDaysToResubmit" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfvDaysToResubmit" CssClass="Validator"
                                    ValidationGroup="Save" ControlToValidate="txtDaysToResubmit" Display="Dynamic"
                                    meta:resourcekey="rfvDaysToResubmit">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblCC" runat="server" Text="CC" meta:resourcekey="lblCC"></asp:Label>
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton" OnClientClick="return OpenSelectUserPopup()">
                                        <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div style="min-height: 78px;overflow-x:auto;" class="AllLightBlueBorder" id="dvCC">
                                    <span id="spnCC" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblManualCC" runat="server" Text="Manual CC" meta:resourcekey="lblManualCC"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" TextMode="MultiLine" ID="txtManualCC" Height="80px"></asp:TextBox><br />
                                <asp:CustomValidator runat="server" ID="cvManualCC" ErrorMessage="Invalid Email" ControlToValidate="txtManualCC"
                                    CssClass="Validator" ClientValidationFunction="CheckMails" meta:resourcekey="cvManualCC" Display="Dynamic" ValidationGroup="Save" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblEventTypes" runat="server" CssClass="legend" meta:resourcekey="lblEventTypes" Text="Event Type(s)"></asp:Label>
                                    </legend>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblEmail" runat="server" meta:resourcekey="chkEmail" Text="Email"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkEmail" runat="server" class="mobile-switch" style="margin-left:-4px"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblOnscreenMessage" runat="server" Text="Onscreen Message" meta:resourcekey="chkOnscreenMessage"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkOnscreenMessage" runat="server" class="mobile-switch" style="margin-left:-4px"/>
                                            </td>
                                        </tr>
                                        <tr class="Hide">
                                            <td class="labelWidth">
                                                <asp:Label ID="lblTextSMS" runat="server" Text="Text (SMS)" meta:resourcekey="chkTextSMS" CssClass="Hide"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkTextSMS" runat="server" CssClass="Hide" class="mobile-switch" style="margin-left:-4px"/>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr id="trValidationProcedure" runat="server">
                            <td class="labelWidth">
                                <asp:Label ID="lblValidationProcedure" Text="Validation Procedure" meta:resourcekey="lblValidationProcedure" runat="server"></asp:Label>
                            </td>
                            <td class="HelpButton controlWidth">
                                <asp:TextBox ID="txtSubmitValidationProcedure" runat="server"></asp:TextBox>
                                <asp:TextBox ID="txtFinalApproveValidationProcedure" runat="server"></asp:TextBox>
                                <span runat="server" id="imgHelp" class="Icon"></span>
                                <telerik:RadToolTip ID="rtlHelp" runat="server" RelativeTo="Element" Height="40px"
                                    meta:resourcekey="rtlHelp" Text="The validation procedure must exist in the database along with the parameters 'RecordId' (BIGINT) and 'RecordTypeId' (BIGINT)."
                                    TargetControlID="imgHelp" IsClientID="true" Position="BottomCenter" EnableAriaSupport="true"
                                    EnableShadow="true" HideEvent="LeaveToolTip">
                                </telerik:RadToolTip>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblOptions" runat="server" CssClass="legend" meta:resourcekey="lblOptions" Text="Options"></asp:Label>
                                    </legend>
                                    <table border="0" class="colTable" style="width:400px !important;">
                                           <tr>
                                            <td class="labelWidth" style="width:160px !important;">
                                                <asp:Label ID="lblAllowEdit" runat="server" Text="Allow Edit"></asp:Label>
                                            </td>
                                            <td class="controlWidth" style="width:240px !important;">
                                                <asp:CheckBox ID="chkAllowEdit" runat="server"  class="mobile-switch" style="margin-left:-4px"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="Label1" runat="server" Text="Require Comments" meta:resourcekey="chkRequireComments"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkRequireComments" runat="server" style="margin-left:-4px" class="mobile-switch" />
                                            </td>
                                        </tr>
                                        <tr id="trCanRequestTeamInput" runat="server">
                                            <td class="labelWidth">
                                                <asp:Label ID="Label2" runat="server" Text="Can Request Team Input" meta:resourcekey="chkCanRequestTeamInput"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkCanRequestTeamInput" runat="server" style="margin-left:-4px" class="mobile-switch" />
                                            </td>
                                        </tr>
                                          <tr id="trDocuSign" runat="server" Visible="false">
                                            <td class="labelWidth">
                                                 <asp:Label ID="lblDocuSign" runat="server" Text="DocuSign" meta:resourcekey="chkDocuSign"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:CheckBox ID="chkDocuSign" runat="server" class="mobile-switch" Visible="false" style="margin-left:-4px" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlNotification" runat="server">
                                    <br />
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblNotifyOnAll" runat="server" CssClass="legend" meta:resourcekey="lblNotifyOnAll" Text="Notify Submitter On All"></asp:Label></legend>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkSubmissions" runat="server" Text="Submissions" meta:resourcekey="chkSubmissions" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkApprovals" runat="server" Text="Approvals" meta:resourcekey="chkApprovals" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkBranches" runat="server" Text="Branches" meta:resourcekey="chkBranches" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkReturns" runat="server" Text="Returns" meta:resourcekey="chkReturns" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkRejects" runat="server" Text="Rejects" meta:resourcekey="chkRejects" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkWithdrawals" runat="server" Text="Withdrawals" meta:resourcekey="chkWithdrawals" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkFinalApproval" runat="server" Text="Final Approval" meta:resourcekey="chkFinalApproval" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkDelegates" runat="server" Text="Delegates" meta:resourcekey="chkDelegates" class="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <div id="dvDisplayActionsAS" runat="server">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblActions" CssClass="legend" runat="server" meta:resourcekey="lblActions" Text="Actions11"></asp:Label>
                                        </legend>
                                        <table class="colTable">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkDisplayAs" runat="server" Text="Display As11" meta:resourcekey="chkDisplayAs" onclick="DisplayAs_CheckedChanged();" class="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div id="dvTemplateDiplayActions" runat="server">
                                                        <telerik:RadGrid ID="rdgActions" runat="server"
                                                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="100%" PageSize="10"
                                                            ShowStatusBar="false">
                                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                                DataKeyNames="Id,ActionTypeId" TableLayout="Fixed" EditMode="InPlace">
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Allow11" UniqueName="Allow" HeaderStyle-Width="50px" DataField="Allow" ItemStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkSelect" Checked='<%# Eval("Allow")%>' runat="server" class="mobile-switch" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="ActionType11" UniqueName="ActionType" DataField="ActionType">
                                                                        <ItemTemplate>
                                                                            <span><%# Eval("ActionType")%></span>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="Display AS11" UniqueName="DisplayAs" DataField="DisplayAs">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtDisplayAs" Width="100%" runat="server" Text='<%# Eval("DisplayAs")%>'></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="140px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </div>
                                                    <div id="dvDocumentDiplayActions" runat="server">
                                                        <telerik:RadGrid ID="rdgDocumentActions" runat="server"
                                                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False" Width="280px" PageSize="10"
                                                            ShowStatusBar="false">
                                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                                DataKeyNames="Id,ActionTypeId" TableLayout="Fixed" EditMode="InPlace">
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Allow11" UniqueName="Allow" HeaderStyle-Width="50px" DataField="Allow">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkSelect" Checked='<%# Eval("Allow")%>' runat="server" class="mobile-switch" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="ActionType11" UniqueName="ActionType" DataField="ActionType">
                                                                        <ItemTemplate>
                                                                            <span><%# Eval("ActionType")%></span>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="Display AS11" UniqueName="DisplayAs" DataField="DisplayAs">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtDisplayAs" Width="100%" runat="server" Text='<%# Eval("DisplayAs")%>'></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="140px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <asp:Button ID="btnAddCCs" runat="server" CssClass="Hide" />
        <asp:Button ID="btnRemoveCCs" runat="server" CssClass="Hide" />
        <asp:Button ID="btnReload" runat="server" CssClass="Hide" />
        <asp:HiddenField ID="hfdeletedCCs" runat="server" Value="0" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" Behaviors="Close,Move"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
