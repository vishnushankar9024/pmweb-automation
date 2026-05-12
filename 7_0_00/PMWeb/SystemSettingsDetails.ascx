<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SystemSettingsDetails.ascx.vb" Inherits="Website.SystemSettingsDetails" %>
<style>
    @media screen and (max-width:843px) {
        #tableEntity {
            padding-top: 0 !important;
            padding-bottom: 34px !important;
        }
    }
</style>
<table id="tableEntity" cellpading="0" cellspacing="0" style="padding-top: 42px; width: 100%">
    <tr>
        <td>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        

                         
                            <telerik:RadGrid ID="rdgSystemParameters" CssClass="rdgParameters" runat="server" AutoGenerateColumns="false" SetWidth="true"
                            ShowStatusBar="true" Font-Size="8px" AllowPaging="true" ShowGroupPanel="true" AllowMultiRowEdit="false" PageSize="20" ShowFooter="true"
                            AllowMultiRowSelection="true" AllowSorting="true" GridLines="None" FitPageHeightOffset="1">
                            <HeaderContextMenu></HeaderContextMenu>
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                EditMode="InPlace" EnableHeaderContextMenu="false" TableLayout="Fixed" GroupLoadMode="Client">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Setting2" ItemStyle-HorizontalAlign="Left"
                                        UniqueName="TranslatedSetting" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                        <ItemTemplate>
                                               <%#Container.DataItem("TranslatedSetting")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="680px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Setting2" ItemStyle-HorizontalAlign="Left"
                                        UniqueName="TranslatedGroup" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                        <ItemTemplate>
                                               <%#Container.DataItem("TranslatedGroup")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="325px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Value2" ItemStyle-HorizontalAlign="Left" UniqueName="ParamName" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtString" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                            <asp:TextBox ID="txtInteger" MaxLength="1000" Visible="false" runat="server"></asp:TextBox>
                                            <asp:CheckBox ID="chkBoolean" Visible="false" runat="server" class="mobile-switch" />
                                            <telerik:RadComboBox ID="ddlValues" Visible="false" runat="server"></telerik:RadComboBox>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="406px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="true"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <CommandItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="False" CommandName="Update" CssClass="GridCmdUpdate">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdate" Text="Save" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                            CollapseAnimation-Type="None" OnClientItemClicking="rdmLayouts_ItemClicking"
                                            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                            EnableShadows="true" CausesValidation="false"
                                            Visible="true">
                                        </telerik:RadMenu>
                                    </div>

                                    
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
  
                            </ClientSettings>
                            <GroupPanel Text="Group By"></GroupPanel>
                        </telerik:RadGrid>
                            
                    </div>

                </div>

            </div>
        </td>
    </tr>
</table>

<%--OnItemClick="Grid_rdmLayouts_ItemClick"--%>
                              <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>