<%@ Page Language="vb" AutoEventWireup="false" meta:Resourcekey="Page" Title="Generate Records" CodeBehind="InitiativeGeneratePopup.aspx.vb" Inherits="Website.InitiativeGeneratePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script language="javascript" type="text/javascript">
        function CreateRecords(event) {
            if (!$("input[type='checkbox'][Id$=chkBudget]").is(':checked') && !$("input[type='checkbox'][Id$=chkEstimate]").is(':checked') && !$("input[type='checkbox'][Id$=chkSchedule]").is(':checked') && !$("input[type='checkbox'][Id$=chkFunding]").is(':checked') && !$("input[type='checkbox'][Id$=chkProject]").is(':checked')) {

                radalert(alertMessage, null, null, alertTitle);
                return false;
            }
            else {

                var introduction = varContinue + '<br/><br/>' + ifContinue;

                var message = introduction + '<br/><br/>';
                if ($("input[type='checkbox'][Id$=chkFunding]").is(':checked'))
                    message = message + funding;
                if ($("input[type='checkbox'][Id$=chkProject]").is(':checked'))
                    message = message + '<br/>' + project;
                if ($("input[type='checkbox'][Id$=chkBudget]").is(':checked'))
                    message = message + '<br/>' + budget;
                //            if ($("input[type='checkbox'][Id$=chkEstimate]").is(':checked'))
                //                message = message + '<br/>' + estimate;
                if ($("input[type='checkbox'][Id$=chkSchedule]").is(':checked'))
                    message = message + '<br/>' + schedule;
                message = message + '<br/><br/>' + conclusion;
                //            if (navigator.userAgent.indexOf("Firefox") != -1) {
                //                radconfirm(message, confirmCallBackFn, 400, 300, null, confirmTitle);
                //               return false;
                //            }
                //            else 
                return blockConfirm(message, event, 400, 300, null, confirmTitle);
                // radconfirm(message, confirmCallBackFn, 400, 300, null, "Confirm Create Records");
                // return false;
            }


        }

        function Close() {

            var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
            radWindow.close();
        }
    </script>
 <script type="text/javascript">
            window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj, oTitle) {
                var ev = mozEvent ? mozEvent : window.event; //Moz support requires passing the event argument manually 
                //Cancel the event 
                ev.cancelBubble = true;
                ev.returnValue = false;
                if (ev.stopPropagation) ev.stopPropagation();
                if (ev.preventDefault) ev.preventDefault();

                //Determine who is the caller 
                var callerObj = ev.srcElement ? ev.srcElement : ev.target;
                if (callerObj) {
                    //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again. 
                    var callBackFn = function (arg) {
                        if (arg) {
                            callerObj["onclick"] = "";
                            if (callerObj.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz 
                            else if (callerObj.tagName == "A") //We assume it is a link button! 
                            {
                                try {
                                    eval(callerObj.href)
                                }
                                catch (e) { }
                            }
                        }
                    }

                    radconfirm(text, callBackFn, oWidth, oHeight, callerObj, oTitle);
                }
                return false;
            }

            //         function confirmCallBackFn(arg) {
            //  
            //             if (arg) {

            //                 __doPostBack($("[id$=btnSave]")[0].id);
            //                
            //             }
            //             
            //         }

        </script>
        <style type="text/css">
            input[type="checkbox" i] {
                float: right !important;
            }
           .labelWidth.rightLabel span{width:100% !important}
        </style>
</telerik:RadCodeBlock>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
       
        <table width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td valign="middle" align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="180px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save"
                                CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblInitiativeId" runat="server" meta:resourcekey="lblInitiativeId" Text="Initiative ID"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtInitiativeId" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName" Text="Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFundingYear" runat="server" meta:resourcekey="lblFundingYear" Text="Funding Year"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtFundingYear" ReadOnly="true" runat="server" Text="" style="text-align:right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFundingSource" runat="server" meta:resourcekey="lblFundingSource" Text="Funding Source"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtFundingSource" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblInitiativeTotal" runat="server" meta:resourcekey="lblInitiativeTotal" Text="Initiative Total"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtInitiativeTotal" ReadOnly="true" CssClass="Double" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right" style="color: #666666 !important;">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblGenerate" runat="server" Text="Generate" meta:Resourcekey="lblGenerate"></asp:Label></legend>
                        <table class="colTable">
                            <tr>
                                <td class="controlWidth">
                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                                </td>
                                <td class="labelWidth rightLabel">
                                    <asp:CheckBox Checked="true" Enabled="false" runat="server" AutoPostBack="true" ID="chkProject" />
                                </td>
                            </tr>
                            <tr>
                                <td class="controlWidth">
                                    <asp:Label ID="lblFunding" runat="server" meta:resourcekey="lblFunding" Text="Funding"></asp:Label>
                                </td>
                                <td class="labelWidth rightLabel">
                                    <asp:CheckBox Checked="false" runat="server" ID="chkFunding" />
                                </td>
                            </tr>
                            <tr>
                                <td class="controlWidth">
                                    <asp:Label ID="lblFundPortfolio" runat="server" meta:resourcekey="lblFund_Portfolio" Text="Fund Portfolio,Not the Project"></asp:Label>
                                </td>
                                <td class="labelWidth rightLabel">
                                    <asp:CheckBox runat="server" ID="chkFundPortfolio" />
                                </td>
                            </tr>
                            <tr>
                                <td class="controlWidth">
                                    <asp:Label ID="lblFundBudget" runat="server" meta:resourcekey="lblFundBudget" Text="Fund the Budget"></asp:Label>
                                </td>
                                <td class="labelWidth rightLabel">
                                    <asp:CheckBox Checked="false" runat="server" ID="chkFundBudget" />
                                </td>
                            </tr>
                            <tr>
                                <td class="controlWidth">
                                    <asp:Label ID="lblBudget" runat="server" meta:resourcekey="lblBudget" Text="Budget"></asp:Label>
                                </td>
                                <td class="labelWidth rightLabel">
                                    <asp:CheckBox Checked="false" runat="server" ID="chkBudget" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>
        <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator" Style="margin: 5px"></asp:Label>
        <%--<table cellpadding="0" cellspacing="0" width="99%">
             <tr>
                <td >
                    <table style="vertical-align: top; margin: 5px;" cellspacing="0">
                        <tr>
                        <td width="50%">
                         <fieldset style="text-align:left;width:200px;height:130px">
                           <legend><asp:Label ID="lblCreate" runat="server" Text="Create" meta:Resourcekey="lblCreate"></asp:Label></legend>
                            <table style="vertical-align: top; margin: 5px;" cellspacing="0">
                                
                                 <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" ID ="chkFunding" Text ="Funding" meta:Resourcekey="chkFunding" />
                              </td>
                             </tr>
                             <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" AutoPostBack="true" ID ="chkProject" Text ="Project" meta:Resourcekey="chkProject" />
                              </td>
                             </tr>
                             
                             <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" ID ="chkBudget" Text ="Budget" meta:Resourcekey="chkBudget" />
                              </td>
                             </tr>
                             
                             <tr>
                              <td>
                                <asp:CheckBox Visible ="false" Checked ="true" runat="server" ID ="chkEstimate" Text ="Estimate" meta:Resourcekey="chkEstimate" />
                              </td>
                             </tr>
                             
                              <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" ID ="chkSchedule" Text ="Schedule" meta:Resourcekey="chkSchedule" />
                              </td>
                             </tr>
                                
                            </table>
                         </fieldset> 
                        </td>
                        
                         <td width="50%"  style="height:130px">
                            <fieldset style="text-align:left;width:200px;height:130px">
                           <legend><asp:Label ID="lblOptions" runat="server" Text="Options" meta:Resourcekey="lblOptions"></asp:Label></legend>
                            <table style="vertical-align: top; margin: 5px;" cellspacing="0">
                            <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" ID ="chkInitiativeID" Text ="Use Initiative ID as Project ID" meta:Resourcekey="chkInitiativeID" />
                              </td>
                             </tr>
                             <tr>
                              <td>
                                <asp:CheckBox runat="server" ID ="chkFundPortfolio" Text ="Fund Portfolio,Not the Project" meta:Resourcekey="chkFundPortfolio" />
                              </td>
                             </tr>
                             
                             <tr>
                              <td>
                                <asp:CheckBox Checked ="true" runat="server" ID ="chkFundBudget" Text ="Fund the Budget" meta:Resourcekey="chkFundBudget" />
                              </td>
                             </tr>
                             
                              
                            </table>
                         </fieldset> 
                        </td>
                         </tr>
                         
                         <tr>
                            <td>
                                <br />
                            </td>
                            
                        </tr>
                           
                         <tr>
                             <td>
                             </td>
                            <td>
                            <table >
                                <tr>
                                    <td colspan="2" align="right">
                                        <asp:Button ID="btnSave" runat="server"  OnClientClick ="return CreateRecords(event);" Text="<%$ Resources:PMWeb, CreateRecords %>"></asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnClose" runat="server" OnClientClick ="Close();return false;" Text="<%$ Resources:PMWeb, Cancel %>"></asp:Button>&nbsp;&nbsp;
                                    </td>
                                </tr>
                             </table>
                            </td>
                         </tr>         
                        </table>
                </td>
            </tr>
            
            </table> --%>
        <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
