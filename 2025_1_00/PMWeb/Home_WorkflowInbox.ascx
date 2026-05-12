<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_WorkflowInbox.ascx.vb" Inherits="Website.Home_WorkflowInbox" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    .InboxItem {
        font-size: 11px;
        border-radius: 5px;
        -moz-border-radius: 5px;
    }

        .InboxItem.td {
            padding: 0px 0px 0px 0px !important;
        }

    img {
        border: 1px none;
    }

    .rdgInbox .rgRow TD, .rdgInbox .rgAltRow TD {
        padding-right: 0px !important;
        padding-left: 0px !important;
    }

    .RadDock .rdTop .rdLeft, .RadDock .rdTop .rdRight {
        Width: 0px !important;
    }

    .eSignButton {
        display: inline-block;
        padding: 5px 10px;
        margin: 5px;
        color: #666;
        border: 1px solid #666;
        border-radius: 5px;
        text-transform: uppercase;
        text-decoration: none;
    }

    .eSignText {
        display: inline-block;
        margin-left: 4px;
        text-transform: uppercase;
    }

        .eSignText.Info {
            color: black;
        }

        .eSignText.Error {
            color: red;
        }
</style>

<script type="text/javascript">

    function InboxRowClick(sender, eventArgs) {
        var dataItems = sender.get_masterTableView().get_dataItems();
        for (var i = 0; i < dataItems.length; i++) {
            dataItems[i].set_expanded(false);
        }
        eventArgs.get_item().set_expanded(!eventArgs.get_item().get_expanded());
    }
    var isCommentsRequired = false;
    var txtComments = null;
    var cvId = null;

    //function cvComments_validate(sender, args) {
    //    if ((isCommentsRequired == true) && (sender.id == cvId)) {
    //        if (txtComments.value == '') {
    //            args.IsValid = false;
    //        } else {
    //            args.IsValid = true;
    //        }
    //    } else {
    //        args.IsValid = true;
    //    }
    //}

    //function AC(sender, action) {
    //    var hdnAppRec = document.getElementById(sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_hdnAppRec');
    //    var hdnFAppRec = document.getElementById(sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_hdnFAppRec');
    //    var hdnRejRec = document.getElementById(sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_hdnRejRec');
    //    var hdnWithRec = document.getElementById(sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_hdnWithRec');
    //    txtComments = document.getElementById(sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_txtComments');
    //    cvId = sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_cvComments';
    //    isCommentsRequired = false;
    //    if ((hdnAppRec.value == 'True') && (action == 'Approve')) isCommentsRequired = true;
    //    if ((hdnAppRec.value == 'True') && (action == 'Return')) isCommentsRequired = true;
    //    if ((hdnFAppRec.value == 'True') && (action == 'FinalApprove')) isCommentsRequired = true;
    //    if ((hdnRejRec.value == 'True') && (action == 'Reject')) isCommentsRequired = true;
    //    if ((hdnWithRec.value == 'True') && (action == 'Withdraw')) isCommentsRequired = true;
    //}

    function ORP(sender, documentId, ValidationGroup) {

        if (Page_ClientValidate(ValidationGroup)) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();

            txtCommentsId = sender.id.substring(sender.id.lastIndexOf('_'), sender.id.lenght - 1) + '_txtComments';
            var wnd = window.radopen('WorkflowReturnToPopup.aspx?DocumentId=' + documentId + '&txtComment=' + txtCommentsId);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.3, browserHeight * 0.3);
                wnd.Center();
            }
            wnd.add_close(ReturnClosed);
        }
        return false;
    }
    function ODP(sender, documentId) {
        //if (Page_ClientValidate('Submit')) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('WorkflowDelegateStepPopup.aspx?DocumentId=' + documentId);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(450, browserHeight * 0.9);
            wnd.Center();
        }

        wnd.add_close(ReturnClosed);

        //}
        return false;
    }

    function ReturnClosed(Opener) {
        eval($("a[id$='lbtRefresh2']").attr('href'));
    }

    function OpenESignPopup(URL) {
        var left = (screen.width - 1400) / 2;
        var top = (screen.height - 700) / 2;
        window.open(URL, '', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + 1400 + ',height=' + 700 + ',top=' + top + ',left=' + left);
        return false;
    }

    function pageLoad() {
        $("a[id$='Comment']").each(function (index, n) {
            n.setAttribute('disabled', 'disabled');
        });

    }

    function onCommentChange(txt) {
        var lbtApproverComment = document.getElementById(txt.id.substring(txt.id.lastIndexOf('_'), txt.id.lenght - 1) + '_lbtApproverComment');
        var lbtComment = document.getElementById(txt.id.substring(txt.id.lastIndexOf('_'), txt.id.lenght - 1) + '_lbtComment');
        if (txt.value == '') {
            if (lbtApproverComment != null) {
                lbtApproverComment.setAttribute('disabled', 'disabled');
            }
            if (lbtComment != null) {
                lbtComment.setAttribute('disabled', 'disabled');
            }


        }
        else {
            if (lbtApproverComment != null) {
                lbtApproverComment.removeAttribute('disabled');
            }
            if (lbtComment != null) {
                lbtComment.removeAttribute('disabled', 'disabled');
            }
        }
    }

    function onCommentClick(btn) {
        if (btn.getAttribute('disabled')) {
            return false;
        }
        return true;
    }

</script>
<telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
    <script>
        function OpenPopupAttachToEmail(url, width = 900, height = 600) {
            var wnd = window.radopen(url);
            wnd.setSize(width, height);
            wnd.set_top(0);
            wnd.set_minWidth(580);
            wnd.set_minHeight(400)
            wnd.center();
            wnd.set_modal(true)
            wnd.set_keepInScreenBounds(true)
            wnd.set_reloadOnShow(true)
            let el = wnd.get_popupElement();
            el.style.position = "fixed";
            el.style.top = ((window.innerHeight - height) / 2) + 'px';
            return false;
        }
        //var ESignExternalPopup = null;
        //function checkESignExternalWindow() {
        //    debugger;
        //    console.log("Checking");
        //    console.log("Popup: " + ESignExternalPopup);
        //    console.log($('[id$=hdnESignWindowClosed]'));
        //    if (ESignExternalPopup != null && ESignExternalPopup.closed) {
        //        $('[id$=hdnESignWindowClosed]').val("1");
        //        ESignExternalPopup = null;
        //    }
        //}
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgI">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgI" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgI" runat="server" ShowGroupPanel="false" AllowPaging="true" CssClass="rdgInbox"
    PageSize="1" GroupingEnabled="false" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True"
    ShowStatusBar="false" ShowHeader="false">
    <PagerStyle Visible="true" AlwaysVisible="true"></PagerStyle>
    <MasterTableView HierarchyLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" TableLayout="Fixed" Width="100%" CommandItemDisplay="none">
        <Columns>
            <telerik:GridTemplateColumn>
                <ItemTemplate>
                    <div id="divWFDoc" style="margin: 0px 0px 0px 0px;" class="InboxItem">
                        <table style="width: 100%; min-width: 300px; height: 60px" border="0" cellpadding="0" cellspacing="4" class="InboxItem">
                            <tr>
                                <td>
                                    <div class="colWorkflowInbox">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRecord" meta:resourcekey="lblRecord" runat="server" Text="Record1"></asp:Label>
                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <asp:LinkButton Text='<%# Container.DataItem("RecordType") & " - " & Container.DataItem("RecordNumber")%>' CssClass="Link"
                                                        ID="lbtRecordId" runat="server" CausesValidation="False" CommandName="DocumentClicked"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description1"></asp:Label>

                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <%#Container.DataItem("Description")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top;">
                                                    <asp:Label ID="lblInstructions" meta:resourcekey="lblInstructions" runat="server" Text="Instructions1"></asp:Label>

                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <%#Container.DataItem("Instructions")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div class="colWorkflowInbox">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project1"></asp:Label>

                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <%# IIf(IsDBNull(Container.DataItem("Entity")), "&nbsp;", Container.DataItem("Entity")) %>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div class="colWorkflowInbox">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDueOn" meta:resourcekey="lblDueOn" runat="server" Text="Due On1"></asp:Label>

                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <%# FormatDate(Container.DataItem("DueDate"))%>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblProgress" meta:resourcekey="lblProgress" runat="server" Text="Progress1"></asp:Label>
                                                </td>
                                                <td style="word-break: break-word; white-space: normal;">
                                                    <%# String.Format(GetGlobalResourceObject("Workflow", "WorkflowStepNumber"), Container.DataItem("StepNumber"), Container.DataItem("NumberOfSteps"))%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <telerik:RadTextBox Width="95%" ID="txtComments" runat="server" TextMode="MultiLine" Resize="Both" Height="35px" meta:resourcekey="txtComments"
                                        EmptyMessage="Comments..." InputType="Text" onkeyup="onCommentChange(this);">
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="rfvComments" runat="server" CssClass="Validator" ErrorMessage="<br/>Comments are required111"
                                        ForeColor="" ControlToValidate="txtComments" meta:resourcekey="cvComments" Enabled="false" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <%--<asp:CustomValidator ID="cvComments" runat="server" CssClass="Validator" ClientValidationFunction="cvComments_validate" ErrorMessage="<br/>Comments are required111"
                                                        ValidationGroup="Submit" ForeColor="" meta:resourcekey="cvComments" Display="Dynamic"></asp:CustomValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" wrap="false" style="padding: 0px !important; text-align: left">
                                    <asp:Panel ID="pnlWorkflowAction" runat="server">
                                        <asp:LinkButton ID="lbtApprove" CommandName="Approve" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtApproveWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtReturn" meta:resourceKey="lbtReturn" CommandName="Return" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtReturnWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtReject" meta:resourceKey="lbtReject" CommandName="Reject" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtRejectWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtWithdraw" meta:resourceKey="lbtWithdraw" CommandName="Withdraw" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtWithdrawWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtFinalApprove" meta:resourceKey="lbtFinalApprove" CommandName="FinalApprove" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtFinalApproveWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtDelegate" meta:resourceKey="lbtDelegate" CommandName="Delegate" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtDelegateWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtApproverComment" meta:resourceKey="lbtApproverComment" CommandName="ApproverComment" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtCommentWorkflow" OnClientClick="javascript:return onCommentClick(this);">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtComment" meta:resourceKey="lbtComment" CommandName="comment" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtCommentWorkflow" OnClientClick="javascript:return onCommentClick(this);">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbtReviewComplete" meta:resourceKey="lbtReviewComplete" CommandName="ReviewComplete" CommandArgument='<%#Container.DataItem("DocumentId")%>'
                                            runat="server" CausesValidation="True" CssClass="lbtReviewCompleteWorkflow">
                                                    <span class="Icon"></span> 
                                        </asp:LinkButton>
                                    </asp:Panel>

                                    <%--<asp:Label runat="server" ID="lblDocuSignMessage" Style="margin-left: 4px;" Text="Waiting for DocuSign1" meta:resourceKey="lblWaitingDocuSign"></asp:Label>
                                        <asp:Label runat="server" ID="lblAdobeSignMessage" CssClass="eSignText Info" Text="Adobe Sign1" meta:resourceKey="lblAcrobatSignMessage"></asp:Label>--%>
                                    <asp:LinkButton runat="server" ID="btnBeginDocuSign" CommandName="BeginDocuSign" CssClass="eSignButton" meta:resourcekey="btnBeginDocuSign" Text="BEGIN DOCUSIGN11"></asp:LinkButton>
                                    <%--OnClientClick="checkESignExternalWindow();"--%>
                                    <asp:LinkButton runat="server" ID="btnCancelDocuSign" CommandName="CancelDocuSign" CssClass="eSignButton" meta:resourcekey="btnCancelDocuSign" Text="CANCEL DOCUSIGN11"></asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnBeginAdobeSign" CommandName="BeginAdobeSign" CssClass="eSignButton" meta:resourcekey="btnBeginAcrobatSign" Text="Begin Adobe Sign1"></asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnCancelAdobeSign" CommandName="CancelAdobeSign" CssClass="eSignButton" meta:resourcekey="btnCancelAcrobatSign" Text="Cancel Adobe Sign1"></asp:LinkButton>
                                    <%--<asp:Label runat="server" ID="lblAdobeSignError" CssClass="eSignText Error" Text="Adobe Sign Error1" meta:resourceKey="lblAcrobatSignError"></asp:Label>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%-- <asp:HiddenField ID="hdnAppRec" runat="server" Value='<%#Container.DataItem("ApproveReturnRequireComments")%>' />
                                    <asp:HiddenField ID="hdnFAppRec" runat="server" Value='<%#Container.DataItem("FinalApproveRequireComments")%>' />
                                    <asp:HiddenField ID="hdnRejRec" runat="server" Value='<%#Container.DataItem("RejectRequireComments")%>' />
                                    <asp:HiddenField ID="hdnWithRec" runat="server" Value='<%#Container.DataItem("WithdrawRequireComments")%>' />--%>
                </ItemTemplate>

            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="false" Resizing-AllowColumnResize="false" AllowDragToGroup="false" AllowExpandCollapse="false">
        <Resizing AllowColumnResize="false"></Resizing>
        <Scrolling AllowScroll="false" SaveScrollPosition="false" />
        <ClientMessages PagerTooltipFormatString="Record {0} of {1}" />
    </ClientSettings>
</telerik:RadGrid>
<asp:LinkButton runat="server" ID="btnReloadWorkflowDoc" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hdnESignWindowClosed" Value="0" />

