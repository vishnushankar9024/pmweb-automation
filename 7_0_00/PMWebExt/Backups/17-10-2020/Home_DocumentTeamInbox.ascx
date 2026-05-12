<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_DocumentTeamInbox.ascx.vb" Inherits="Website.Home_DocumentTeamInbox" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<style type="text/css">
    .InboxItem{
       
         font-size: 11px;
     border-radius: 5px;
    -moz-border-radius: 5px;
    }
    .InboxItem.td{
        padding:0px 0px 0px 0px !important;
    }
    img{ border:1px none;}
    .rdgInbox .rgRow TD, .rdgInbox .rgAltRow TD {
        padding-right: 0px !important;
        padding-left: 0px !important;
    }
    .RadDock .rdTop .rdLeft, .RadDock .rdTop .rdRight{Width:0px !important}
</style> 

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgI">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgI" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadGrid ID="rdgI" runat="server" ShowGroupPanel="false" AllowPaging="true" PageSize="1" GroupingEnabled="false" CssClass="rdgInbox"
     AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True" ShowStatusBar="false" ShowHeader="false">
    <PagerStyle Visible="true" AlwaysVisible="true" ></PagerStyle>
    <MasterTableView HierarchyLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" TableLayout="Fixed" Width="100%" CommandItemDisplay="none">
        <Columns>
            <telerik:GridTemplateColumn>
                <ItemTemplate>
                    <div id="divDocTeam" style="margin: 0px 0px 0px 0px;" class="InboxItem">
                        <table style="width: 100%; min-width: 300px; height: 60px" border="0" cellpadding="0" cellspacing="4" class="InboxItem">
                            <tr>
                                <td style="width: 5%">
                                    <div style="Width: 50px">
                                        <asp:Label ID="lblRecord" meta:resourcekey="lblRecord" runat="server" Text="Record1"></asp:Label></div>
                                </td>
                                <td style="width: 20%">
                                    <asp:LinkButton Text='<%# Container.DataItem("RecordType") & " - " & Container.DataItem("RecordNumber")%>' CssClass="Link"
                                        ID="lbtRecordId" runat="server" CausesValidation="False" CommandName="DocumentClicked"></asp:LinkButton>
                                </td>
                                <td style="width: 15%">
                                    <div style="Width: 85px">
                                        <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project11"></asp:Label></div>
                                </td>
                                <td style="width: 40%">
                                    <%# IIf(IsDBNull(Container.DataItem("Entity")), "&nbsp;", Container.DataItem("Entity")) %>
                                </td>
                                <td style="width: 5%">
                                    <div style="Width: 70px">
                                        <asp:Label ID="lblDueOn" meta:resourcekey="lblDueOn" runat="server" Text="Due On1"></asp:Label>
                                    </div>
                                </td>
                                <td style="width: 15%">
                                    <div style="Width: 100px"><%# FormatDate(Container.DataItem("DueDate"))%></div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description1"></asp:Label></td>
                                <td colspan="6"><%#Container.DataItem("Description")%></td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <telerik:RadTextBox Width="95%" ID="txtComments" runat="server" CausesValidation="true" TextMode="MultiLine"
                                        Resize="Both" Height="35px" meta:resourcekey="txtComments" InputType="Text">
                                    </telerik:RadTextBox>
                                    <asp:Label ID="lblRequiredComment" meta:resourcekey="lblRequiredComment" CssClass="Validator"
                                        Visible="false" runat="server" Text="Comment Required11"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" wrap="false" style="padding: 0px !important; text-align: left">
                                    <asp:LinkButton ID="lbtComment" meta:resourceKey="lbtComment" CommandName="comment" CommandArgument='<%#Container.DataItem("DocumentTeamId")%>'
                                        runat="server" CausesValidation="True" CssClass="lbtCommentWorkflow">
                                                    <span class="Icon"></span> 
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lbtReviewComplete" meta:resourceKey="lbtReviewComplete" CommandName="ReviewComplete" CommandArgument='<%#Container.DataItem("DocumentTeamId")%>'
                                        runat="server" CausesValidation="True" CssClass="lbtReviewCompleteWorkflow">
                                                    <span class="Icon"></span> 
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="false" Resizing-AllowColumnResize="false" AllowDragToGroup="false" AllowExpandCollapse="false">
        <Resizing AllowColumnResize="false"></Resizing>
        <Scrolling AllowScroll="false" SaveScrollPosition="false" />
    </ClientSettings>
</telerik:RadGrid>