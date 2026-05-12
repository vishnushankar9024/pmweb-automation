<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TaskProjectCodes.ascx.vb" Inherits="Website.TaskProjectCodes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgProjectCodes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgProjectCodes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader" style="padding-top:24px;">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgProjectCodes" runat="server" CssClass="rdgProjectCodes ResponsiveMargin" SetWidth="true" AppendMenus="true"
                Height="100%" AllowPaging="False" AutoGenerateColumns="False" ShowHeader="false" ShowFooter="false"
                HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
                ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                <MasterTableView CommandItemDisplay="Top" Width="100%" TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="150px" HeaderText=""
                            UniqueName="ProjectCodeFriendlyName">
                            <ItemTemplate>
                                <span><%#Container.DataItem("ProjectCodeFriendlyName")%></span>&nbsp;                                          
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText=""
                            UniqueName="ProjectCodeItem">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlProjectCodeItems" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;
                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true"
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="Save" CssClass="GridCmdSave">
                        <span class="Icon"></span>
                        <asp:Label Text="Update records1" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</div>
