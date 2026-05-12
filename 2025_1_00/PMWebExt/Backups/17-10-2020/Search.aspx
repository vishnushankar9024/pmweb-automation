<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Search.aspx.vb" Inherits="Website.Search" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="SearchDetails.ascx" TagName="SearchDetails" TagPrefix="uc1" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock runat="server" ID="script1">
        <script type="text/javascript">
            function pageLoad() {
                CheckParentBox();
            }

            function AllCheckClicked(iObj) {
                var rdgRights = $("div[id$='rdgSearchDetailsDetails']");
                rdgRights.find(".rgDataDiv input[type='checkbox']").each(function () {
                    if (!this.disabled)
                        this.checked = iObj.checked;
                });
            }
            function SelectParent(chk) {
                var rdgRights = $("div[id$='rdgSearchDetailsDetails']");
                if (rdgRights.find(".rgHeader input[id$='chkAll']").length == 0) return;
                var chkPArent = rdgRights.find(".rgHeader input[id$='chkAll']")[0];

                var isChecked = true;
                rdgRights.find(".rgDataDiv input[type='checkbox']").each(function () {
                        if (chk.checked) 
                            if (!this.checked) isChecked = false;
                });

                if (!chk.checked) {
                    chkPArent.checked = false;

                } else {
                    chkPArent.checked = isChecked;
                }

                return false;
            }

            function CheckParentBox() {

                var rdgRights = $("div[id$='rdgSearchDetailsDetails']");
                if (rdgRights.find(".rgHeader input[id$='chkAll']").length == 0) return;
                var ParentIsNotChecked = true;
                rdgRights.find(".rgDataDiv input[type='checkbox']").each(function () {
                        if (!this.checked) 
                            ParentIsNotChecked = false;                       
                });

                rdgRights.find(".rgHeader input[id$='chkAll']")[0].checked = ParentIsNotChecked;            
            }

            function OpenSmallPopupToRedirect(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(RedirectAfterClosed);
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <style>

        .lnkSearchLnkButton{
            width: 80px;
            height:29px;
            line-height:29px;
            padding-top:0;
        }
       

        .lnkSearchLnkButton .btnSearch{
            margin-bottom: 1px;
        }
    
    </style>
    <%--    <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:Label ID="lblSearch" runat="server" Text=" Search" meta:resourcekey="lblSearch"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                <Items>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--%>
    <div class="PMMainPage PMPopupMainPage">
        <div class="row R3Cols">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblKeyword" runat="server" Text="Keyword " meta:resourcekey="lblKeyword" />
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtKeyword" MaxLength="255" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="False"
                                Skin="Default" NoWrap="true" Width="100%" Height="300px"
                                EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-4 col-4-middle">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblRecordTye" runat="server" Text="Record Type " meta:resourcekey="lblRecordTye" />
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlRecordTypes" Height="200px" runat="server" Filter="Contains" MarkFirstMatch="true"
                                AllowCustomText="True" Skin="Default">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkApply" />
                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply"></asp:Label>
                                        <%#Eval("ObjectType")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblRecordStatus" meta:resourcekey="lblRecordStatus" runat="server" Text="Record Status"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlRecordStatus" runat="server" Filter="Contains" MarkFirstMatch="true"
                                AllowCustomText="True" Skin="Default">
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkApplySkills" />
                                        <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                        <%#Eval("value")%>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-4 col-4-right">               
                 <asp:LinkButton runat="server" ID="btnSearch" CssClass="lnkButton lnkSearchLnkButton" ValidationGroup="Submit">
                    <span runat="server" class="Icon btnSearch"></span>
                    <span runat="server">
                        <asp:Label runat="server" ID="lblSearch" Text="Search" meta:resourcekey="btnSearch"></asp:Label>
                    </span>
                </asp:LinkButton>                
            </div>
        </div>


        <%--<telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument"
                                            runat="server" MultiPageID="mlpIssues" Skin="Default"
                                            Width="100%" EnableViewState="True" CausesValidation="False">
                                            <Tabs>
                                                <telerik:RadTab Text="Result" Value="Result" Selected="true"></telerik:RadTab>

                                            </Tabs>
                                        </telerik:RadTabStrip>
                                        <telerik:RadMultiPage ID="mlpIssues" runat="server" SelectedIndex="0" Width="100%"
                                            RenderSelectedPageOnly="True">
                                            <telerik:RadPageView ID="pvDetails" runat="server" Width="100%"
                                                Selected="True">--%>

        <%--</telerik:RadPageView>
                                        </telerik:RadMultiPage>--%>
    </div>
    <uc1:SearchDetails ID="SearchDetails1" runat="server" style="padding-top:24px;" />
</asp:Content>

