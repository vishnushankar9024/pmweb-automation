<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="Copy Portfolio Plan" CodeBehind="CopyPortfolioPlanningPopup.aspx.vb" Inherits="Website.CopyPortfolioPlanningPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Copy Portfolio Plan</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>


<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="fldrdgInitiatives">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="fldrdgInitiatives" />
                        <telerik:AjaxUpdatedControl ControlID="fldRecap" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="fldIncludedInitiatives">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="fldIncludedInitiatives" />
                        <telerik:AjaxUpdatedControl ControlID="fldRecap" />
                        <telerik:AjaxUpdatedControl ControlID="fldrdgInitiatives" />
                        <telerik:AjaxUpdatedControl ControlID="fldLinkedInitiatives" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="fldLinkedInitiatives">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="fldLinkedInitiatives" />
                        <telerik:AjaxUpdatedControl ControlID="fldRecap" />
                        <telerik:AjaxUpdatedControl ControlID="fldrdgInitiatives" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>

        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarDone"
                                CommandName="SaveAndExit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>

            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row R3Cols">
                <div class="col-4 col-4-left">
                    <fieldset id="fldIncludedInitiatives" runat="server">
                        <legend class="legend">
                            <asp:Label ID="lblInclude" runat="server" meta:resourcekey="lblInclude" Text="Include In New Plan">
                            </asp:Label></legend>
                        <table>
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="rdbInitiativesincluded" runat="server" Height="45px" AutoPostBack="true" Style="padding: 3px;" CssClass="RadioCss RadioPadding">
                                        <asp:ListItem Text="All Initiatives" meta:resourcekey="rdbAllInitiatives" Value="AllInitiatives"
                                            Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Unfunded Initiatives Only" meta:resourcekey="rdbUnfundedInitiativesOnly" Value="UnfundedInitiativesOnly"></asp:ListItem>
                                        <asp:ListItem Text="No Initiatives" meta:resourcekey="rdbNoInitiatives" Value="NoInitiatives"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-4 col-4-middle">
                    <fieldset id="fldLinkedInitiatives" runat="server">
                        <legend class="legend">
                            <asp:Label ID="lblLinkedInitiatives" runat="server" meta:resourcekey="lblLinkedInitiatives" Text="Linked Initiatives">
                            </asp:Label>
                        </legend>
                        <table>
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="rdbLinkedInitiatives" runat="server" Height="30px" AutoPostBack="true" CssClass="RadioCss RadioPadding">
                                        <asp:ListItem Text="Link To Existing Initiatives" meta:resourcekey="rdbLinkToExistingInitiatives" Value="LinkToExistingInitiatives"
                                            Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Copy Linked Initiatives" meta:resourcekey="rdbCopyLinkedInitiatives" Value="CopyLinkedInitiatives"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <asp:CheckBox Style="padding-left: 13px;" runat="server" ID="chkIncrementRevision" Text="Increment Revision" AutoPostBack="true" meta:resourcekey="chkIncrementRevision" />
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset id="fldRecap" runat="server">
                        <legend class="legend">
                            <asp:Label ID="lblRecap" runat="server" meta:resourcekey="lblRecap" Text="Recap">
                            </asp:Label></legend>
                        <table>
                            <tr>
                                <td style="height: 20px;">
                                    <asp:Label ID="lblCreate" runat="server" Text="1 New Portfolio Plan Will Be Created" meta:resourcekey="lblCreate" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 20px;">
                                    <asp:Label ID="LblInitiativesIncluded" runat="server" Text="" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 20px;">
                                    <asp:Label ID="LblLinkedInitiativesCopied" runat="server" Text="" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <fieldset id="fldrdgInitiatives" runat="server" style="height: 100%">
                        <legend class="legend">
                            <asp:Label ID="lblInitiatives" runat="server" meta:resourcekey="lblInitiatives" Text="Initiatives">
                            </asp:Label>
                        </legend>

                        <telerik:RadGrid ID="rdgInitiatives" AllowMultiRowSelection="false" runat="server"
                            HeaderStyle-Font-Size="8" setwidth="true" allow-scroll="true"
                            AutoGenerateColumns="False" ShowStatusBar="true"
                            PageSize="250">
                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" ClientDataKeyNames="Id"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Include" UniqueName="Include"
                                        Reorderable="false">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkIsIncluded" OnCheckedChanged="chkSelected_OnChekedChanged" AutoPostBack="true" runat="server" Checked='<%#CBool(Eval("Included"))%>' />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblIncluded" runat="server" Text="Include" meta:resourcekey="lblIncluded"></asp:Label>
                                            <asp:CheckBox ID="chkallIncluded" OnCheckedChanged="chkAll_OnChekedChanged" AutoPostBack="true" runat="server" TextAlign="Left" />
                                        </HeaderTemplate>
                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" Reorderable="true">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("LineNumber").ToString%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="60px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Fund" HeaderStyle-Width="43px" ItemStyle-Wrap="false" SortExpression="Fund" UniqueName="Fund">
                                        <ItemTemplate>
                                            <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Fund"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Initiative" HeaderStyle-Width="150px" HeaderStyle-Wrap="false"
                                        UniqueName="Initiative" SortExpression="Initiative">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("Initiative")%>&nbsp;</span>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Initiative ID" SortExpression="InitiativeID" UniqueName="InitiativeID">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("InitiativeID")%>&nbsp;</span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="70px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Budget Year" SortExpression="BudgetYear" UniqueName="BudgetYear">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("BudgetYear") %></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Funding Source" UniqueName="FundingSource"
                                        SortExpression="FundingSource">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("FundingSource") = String.Empty, "&nbsp;", Container.DataItem("FundingSource"))%></span>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Project Manager" UniqueName="ProjectManager"
                                        SortExpression="ProjectManager">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("ProjectManager") = String.Empty, "&nbsp;", Container.DataItem("ProjectManager"))%></span>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="120px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total" ItemStyle-HorizontalAlign="Right"
                                        SortExpression="Total">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Total") = "0", "&nbsp;", FormatCurrency(Container.DataItem("Total")))%></span>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Type" UniqueName="InitiativeType" SortExpression="InitiativeType">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("InitiativeType") = String.Empty, "&nbsp;", Container.DataItem("InitiativeType"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Start" SortExpression="Start" UniqueName="Start">
                                        <ItemTemplate>
                                            <span><%#FormatDate(Container.DataItem("Start"))%>&nbsp;</span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Finish" SortExpression="Finish" UniqueName="Finish">
                                        <ItemTemplate>
                                            <span><%#FormatDate(Container.DataItem("Finish"))%>&nbsp;</span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="80px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" UniqueName="Priority">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Priority") = String.Empty, "&nbsp;", Container.DataItem("Priority"))%></span>
                                        </ItemTemplate>

                                        <HeaderStyle Width="90px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Score" UniqueName="Score" ItemStyle-HorizontalAlign="Right" SortExpression="Score">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Score") = "0", "&nbsp;", FormatNumber(Container.DataItem("Score")))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="66px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Rating" UniqueName="Rating" ItemStyle-HorizontalAlign="Right" SortExpression="Rating">
                                        <ItemTemplate>
                                            <span><%#FormatNumber(Container.DataItem("Rating"),1)%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="66px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Sponsor" UniqueName="Sponsor" SortExpression="Sponsor">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Sponsor") = String.Empty, "&nbsp;", Container.DataItem("Sponsor"))%></span>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" meta:resourcekey="GridTemplateColumnResource15">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="UserDef1" SortExpression="UserDef1" UniqueName="UserDef1">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("UserDef1") = String.Empty, "&nbsp;", Container.DataItem("UserDef1"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="UserDef2" SortExpression="UserDef2" UniqueName="UserDef2">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("UserDef2") = String.Empty, "&nbsp;", Container.DataItem("UserDef2"))%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field1" UniqueName="Field1" Groupable="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field2" UniqueName="Field2">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field3" UniqueName="Field3">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field4" UniqueName="Field4"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field5" UniqueName="Field5"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field6" UniqueName="Field6">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field7" UniqueName="Field7">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field8" UniqueName="Field8">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field9" UniqueName="Field9">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field10" UniqueName="Field10">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="115px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                            </MasterTableView>
                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            <ClientSettings EnableRowHoverStyle="False" AllowRowsDragDrop="False">
                                <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                            </ClientSettings>
                        </telerik:RadGrid>

                        <%--     <div style="height:245px; width:870px !important; overflow:auto;-ms-overflow-y :Hidden;">
                    </div>--%>
                    </fieldset>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
