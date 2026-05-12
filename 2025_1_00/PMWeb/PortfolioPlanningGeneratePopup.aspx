<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="PortfolioPlanningGeneratePopup.aspx.vb" Inherits="Website.PortfolioPlanningGeneratePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        var grid;
        function GetGridObject(sender, eventArgs) {
            grid = sender;

        }
        function Plan_OnRowSelecting(sender, eventArgs) {
            var CanCreateRecords = $("#" + eventArgs.get_id())[0].getAttribute("CanCreateRecords")

            if (CanCreateRecords == "false")
                eventArgs.set_cancel(true);
        }



        function CreateRecords() {

            var selectedRowCount = grid.get_masterTableView().get_selectedItems().length;

            if (selectedRowCount == 0) {
                radalert(alertMessage, null, null, alertTitle);
                return false;
            }

            else

                var introduction = varContinue + '<br/><br/>' + ifContinue;

            var message = introduction + '<br/><br/>';
            message = message + funding;
            message = message + '<br/>' + project;
            message = message + '<br/>' + budget;
            //if ($("input[type='checkbox'][Id$=chkEstimate]").is(':checked'))
            //message = message + '<br/>' + estimate;
            message = message + '<br/>' + schedule;
            message = message + '<br/><br/>' + conclusion;
            radconfirm(message, function (arg) { if (arg) { $("[id$=btnSave]").click(); } }, 400, 500, null, confirmTitle);
        }

  

        function Close() {
            var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
            radWindow.close();
        }

        function MoreMenuClicked(sender, args) {
            maintoolbarClick(args.get_item().get_value())
        }
        function click_handler(sender, args) {
            maintoolbarClick(args.get_item().get_commandName())
        }

        function maintoolbarClick(value) {
            switch (value) {
                case 'Cancel':
                    Close();
                    return false;
                    break;
                case 'CreateRecords':
                    CreateRecords();
                    return false;
                    //$("#btnSave").click();
                    break;
            }
        }

    </script>
    <style type="text/css">
        .RadWindow .rwWindowContent .radconfirm{
            background-image: none !important;
        }
        .RadWindow .rwDialogPopup.radconfirm{
            padding: 8px 8px 0px 8px !important;
        }
        .RadWindow .rwDialogPopup.radconfirm .rwPopupButton {
            border: 1px solid #666666;
            width: 60px;
            border-radius: 5px;
            height: 25px;
            /*margin-top: 170px !important;*/
            float:none !important;
            /*margin-left: 15px;*/
            display:inline-block !important;
        }
            .RadWindow .rwDialogPopup.radconfirm > div:last-child {
                margin-top: 170px;
                float: right;
            }

        .RadWindow .rwWindowContent .rwPopupButton .rwInnerSpan {
            text-align: center;
            padding: 0 !important;
            line-height: 24px;
            text-transform: uppercase;
        }
        .RadWindow .rwWindowContent .rwPopupButton .rwInnerSpan:hover {
            text-align: center ;
            cursor: pointer;
        }
        .RadWindow .rwDialogPopup.radconfirm .rwPopupButton span {
            display: block;
            float: none !important;
        }
    </style>
</telerik:RadCodeBlock>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <script type="text/javascript">
            //window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj, oTitle) {
            //    var ev = mozEvent ? mozEvent : window.event; //Moz support requires passing the event argument manually 
            //    //Cancel the event 
            //    ev.cancelBubble = true;
            //    ev.returnValue = false;
            //    if (ev.stopPropagation) ev.stopPropagation();
            //    if (ev.preventDefault) ev.preventDefault();

            //    //Determine who is the caller 
            //    var callerObj = ev.srcElement ? ev.srcElement : ev.target;
            //    if (callerObj) {
            //        //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again. 
            //        var callBackFn = function (arg) {
            //            if (arg) {
            //                callerObj["onclick"] = "";
            //                if (callerObj.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz 
            //                else if (callerObj.tagName == "A") //We assume it is a link button! 
            //                {
            //                    try {
            //                        eval(callerObj.href)
            //                    }
            //                    catch (e) { }
            //                }
            //            }
            //        }

            //        radconfirm(text, callBackFn, oWidth, oHeight, callerObj, oTitle);
            //    }
            //    return false;
            //}
            //         function confirmCallBackFn(arg) {
            //  
            //             if (arg) {

            //                 __doPostBack($("[id$=btnSave]")[0].id);
            //                
            //             }
            //             
            //         }

        </script>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgInitiatives">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInitiatives" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCreateProjects" CommandName="CreateProjects" Text="<%$ Resources:PMWeb, CreateProjects %>"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCreateRecords" PostBack="false" CommandName="CreateRecords" Text="<%$ Resources:PMWeb, CreateRecords %>"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Cancel" Value="Cancel"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
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
                            <td class="labelWidth" style="width: 160px !important">
                                <asp:Label ID="lblPlanYear" runat="server" meta:resourcekey="lblPlanYear" Text="Plan Year"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPlanYear" ReadOnly="true" runat="server" Text="" Style="text-align: right;"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPortfolioName" runat="server" meta:resourcekey="lblPortfolioName" Text="Portfolio Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPortfolioName" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrency" Text="Currency"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrency" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblInitiativeApproved" runat="server" Text="Mark Linked Initiatives as Approved" meta:Resourcekey="chkInitiativeApproved"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:CheckBox Checked="true" runat="server" ID="chkInitiativeApproved" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblFundPortfolio" runat="server" Text="Fund Portfolio, Not the Project" meta:Resourcekey="chkFund_Portfolio"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:CheckBox runat="server" ID="chkFundPortfolio" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblInitiativeID" runat="server" Text="Use Initiative ID as Project ID" meta:Resourcekey="chkInitiativeID"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:CheckBox Checked="true" runat="server" ID="chkInitiativeID" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblFundBudget" runat="server" Text="Fund Budgets" meta:Resourcekey="chkFundBudget"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:CheckBox Checked="true" runat="server" ID="chkFundBudget" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%--  <td style ="padding-left :10px;">
                                                                <asp:CheckBox Checked ="true" runat="server" ID ="chkCombineFunding" Text ="Combine Funding Transactions" meta:Resourcekey="chkCombineFunding" />
                                                              </td>--%>
                             
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgInitiatives" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8"
                        AutoGenerateColumns="False" AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Create<br/>Project" UniqueName="CreateProject"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkProject" Enabled='<%# CBool(IIf(Eval("ProjectNumber") <> String.Empty, 0, 1))%>' runat="server" Checked='<%# CBool(IIf(Eval("ProjectNumber") <> String.Empty, 0, 1))%>' />
                                    </ItemTemplate>

                                    <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Plan Line<br/>#" UniqueName="PlanLineNumber"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("LineNumber").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Initiative ID" UniqueName="InitiativeID"
                                    GroupByExpression="InitiativeID [GridColumn_InitiativeID] Group By InitiativeID ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("InitiativeID").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Initiative" UniqueName="Initiative"
                                    GroupByExpression="Initiative [GridColumn_Initiative] Group By Initiative ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("Initiative").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Funding Year" UniqueName="FundingYear"
                                    GroupByExpression="FundingYear [GridColumn_FundingYear] Group By FundingYear ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("FundingYear") Is System.DBNull.Value, "&nbsp;", Eval("FundingYear"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Funding Source" UniqueName="FundingSource"
                                    GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("FundingSource") = String.Empty, "&nbsp;", Eval("FundingSource"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("Total"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Priority" UniqueName="Priority"
                                    GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Priority") = String.Empty, "&nbsp;", Eval("Priority"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Project ID" UniqueName="ProjectID"
                                    Groupable="False">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("ProjectNumber") = String.Empty, "&nbsp;", Eval("ProjectNumber"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndoPortfolio"
                                        Visible='<%# rdgInitiatives.EditIndexes.Count = 0 And (Not rdgInitiatives.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">

                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <ClientEvents OnRowSelecting="Plan_OnRowSelecting" OnGridCreated="GetGridObject" />
                            <Scrolling UseStaticHeaders="true" />
                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

        <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator" Style="margin: 5px"></asp:Label>
        <asp:Button ID="btnSave" CssClass="Hide" runat="server" Text="<%$ Resources:PMWeb, CreateRecords %>"></asp:Button>
        <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
