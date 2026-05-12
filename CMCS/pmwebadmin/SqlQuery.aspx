<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SqlQuery.aspx.vb" Inherits="Website.SqlQuery" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .RadGrid_Default {
            border:none;
        }
    </style>
    <%--<div style="height:20px;width:100%;" class="ToolBar Padding7 Bold"> Sql Command</div>--%>

    <%--            <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="rdgResults">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="rdgResults" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManagerProxy>--%>
    <div>
        <asp:TextBox ID="txtSqlPane" runat="server" TextMode="MultiLine" Height="250px" Width="99%"></asp:TextBox>
    </div>
    <div style="padding: 7px;">
        <asp:LinkButton ID="btnExecute" runat="server" CssClass="lnkButton">
            <asp:Label ID="lblReset" Text="Execute SQL" runat="server"></asp:Label>
            &nbsp;&nbsp;
        </asp:LinkButton>

        <asp:Label runat="server" CssClass="Validator" ID="lblResultExec" Text="" />
    </div>

    <telerik:RadGrid ID="rdgResults" Width="100%" Skin="Default" 
        AllowPaging="True" PageSize="10" runat="server" AllowSorting="true" EnableEmbeddedSkins="False" GridLines="None">
        <MasterTableView Width="100%" />
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <FilterMenu EnableTheming="True">
            <CollapseAnimation Duration="200" Type="OutQuint" />
        </FilterMenu>
    </telerik:RadGrid>


</asp:Content>

