<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_ProjectCenterNavigator.ascx.vb" Inherits="Website.Home_ProjectCenterNavigator" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Panel runat="server" ID="pnlNavigatorSection">
    <div>
        <asp:Label runat="server" ID="lblNavigatorTitle" Style="color: #0169aa; font-size: 16px;margin-left:10px;" Text="Navigator"> </asp:Label></div>
    <br />
    <div style="margin-left:15px">
        <telerik:RadAjaxPanel ID="pnlDetailPane"
            runat="server" Width="100%" ClientEvents-OnResponseEnd="ResponsenavigatorEnd">
            <asp:Repeater ID="rptModules" runat="server">

                <ItemTemplate>
                    <div style="margin-top: 5px;">
                        <asp:Image ID="imgToggleModule" Style="cursor: pointer;" runat="server" alt="" ImageUrl="Images/Workflow/wMinus.png" />
                        <asp:Label runat="server" Style="color: #007cca; font-size: 13px" ID="lblModuleName"></asp:Label></div>
                    <asp:Panel runat="server" ID="pnlModuleRecordTypes" Style="margin-left: 10px;" class="moduleToggle" moduleid='<%# Cstr(Eval("ModuleId")) %>'>
                        <asp:Repeater ID="rptModuleRecordTypes" runat="server">
                            <HeaderTemplate>
                                <table cellspacing="4" style="margin-top: 5px">
                                    <tr>
                                        <td style="width: 200px; font-weight: bold">
                                            <asp:Label runat="server" ID="lblRecordTypeTitle" Text="Record Type"></asp:Label></td>
                                        <td><b>
                                            <asp:Label runat="server" ID="lblPending" Text="Pending"></asp:Label></b></td>
                                        <td><b>
                                            <asp:Label runat="server" ID="lblApproved" Text="Approved"></asp:Label></b></td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:LinkButton SearchURL='<%# Cstr(Eval("SearchURL")) %>' PageURL='<%# Cstr(Eval("PageURL")) %>' ObjectType='<%# Cstr(Eval("ObjectType")) %>' runat="server" ID="btnRecordType" Text='<%# Cstr(Eval("Title")) %>'> </asp:LinkButton></td>
                                    <td align="right">
                                        <asp:Label runat="server" ID="lblPendingCount" Text='<%#  CInt(Eval("PendingCount")) %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label runat="server" ID="lblApprovedCount" Text='<%# CInt(Eval("ApprovedCount"))%>'></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </asp:Panel>
                </ItemTemplate>
            </asp:Repeater>
        </telerik:RadAjaxPanel>
    </div>

</asp:Panel>
