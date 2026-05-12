<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Issues.aspx.vb" Inherits="Website.Issues" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="SearchDetails.ascx" TagName="SearchDetails" TagPrefix="uc1" %>
<%@ Register Src="IssueDetails.ascx" TagName="IssueDetails" TagPrefix="uc2" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=154">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlIssues" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" CheckForDirt="True"
                    EmptyMessage="Select Issue..." Width="100%" AutoPostBack="True" NoWrap="true" meta:resourcekey="ddlIssues"
                    CausesValidation="False" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" AccessKey="s" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" 
                            CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <div class="PMMainPage documentSinglePage">
        <div class="row">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCode" meta:resourcekey="lblCode" runat="server" Text="Code*"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCode" MaxLength="30" Width="100%" runat="server"></asp:TextBox>
                            <asp:Panel ID="pnlBudgetUnique" runat="server" Visible="false">
                                <asp:Label ID="lblCodeUnique" runat="server" meta:resourcekey="lblCodeUnique" CssClass="Validator" Text="Code already used."></asp:Label>
                            </asp:Panel>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Code"
                                ValidationGroup="Save" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblDate" meta:resourcekey="lblDate" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadDatePicker ID="dtpDate" MinDate="01/01/1901" Width="100%"
                                MaxDate="12/31/2100" runat="server" Skin="Default">
                                <ClientEvents />
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblName" meta:resourcekey="lblName" runat="server" Text="Name"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtName" Width="100%" runat="server" MaxLength="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtDescription" Width="100%" runat="server" MaxLength="500"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <uc2:IssueDetails ID="IssueDetails1" runat="server" />
    </div>


</asp:Content>
