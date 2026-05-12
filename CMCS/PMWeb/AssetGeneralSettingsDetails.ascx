<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetGeneralSettingsDetails.ascx.vb" Inherits="Website.AssetGeneralSettingsDetails" %>
<style>
    @media screen and (max-width:843px) {
        #tableEntity {
            padding-top: 0 !important;
             padding-bottom: 34px !important;
        }
    }
</style>
  <table id="tableEntity" cellpadding="0" cellspacing="0" style="width:100%" >
                        <tr>
                            <td>
                               <table style="width: 100%;height:50px" cellpadding="0" cellspacing="0" >
                                    <tr style="background-color: RGB(237,237,237);background-image: none;" >
                                        <td style="width: 160px;padding-left:10px;"><b><asp:Label ID="lblTitle" meta:Resourcekey="lblTitle" runat="server" Text="Entities"></asp:Label></b></td>
                                        <td style="width:240px">              
                                            <telerik:RadComboBox ID="ddlAssetEntities" Runat="server"  Skin="Default" CloseDropDownOnBlur="true" 
                                                EmptyMessage="Select Entity..." AutoPostBack="True" AllowCustomText="true" Width="100%"
                                                CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"         
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true"  meta:Resourcekey="ddlEntities"
                                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">                                                               
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td></td>
                                     </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row">
                                        <div class="col-12">
                                            <telerik:RadGrid ID="rdgAssetParameters" cssclass="rdgParameters" runat="server"   AutoGenerateColumns="False" SetWidth="true"
                                                ShowStatusBar="True" Font-Size="8px" AllowPaging="true" ShowGroupPanel="true" AllowMultiRowEdit="False" PageSize="250" ShowFooter="true"
                                                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" FitPageHeightOffset="1">
                                                <HeaderContextMenu  ></HeaderContextMenu>
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"  />
                                                <MasterTableView DataKeyNames="Id"   CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false" TableLayout="Fixed" GroupLoadMode ="Client"  >
                                                       <%-- <GroupByExpressions  >
                                                            <telerik:GridGroupByExpression>
                                                                <SelectFields>
                                                                    <telerik:GridGroupByField FieldName="TranslatedGroup"  ></telerik:GridGroupByField>
                                                                </SelectFields>
                                                                <GroupByFields>
                                                                    <telerik:GridGroupByField FieldName="TranslatedGroup"  ></telerik:GridGroupByField>
                                                                </GroupByFields>
                                                            </telerik:GridGroupByExpression>
                                                        </GroupByExpressions>--%>
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Setting1" ItemStyle-HorizontalAlign="Left"
                                                            UniqueName="TranslatedSetting" HeaderStyle-Wrap="false" Groupable ="false" Reorderable="false">
                                                            <ItemTemplate>
                                                                <%#Container.DataItem("TranslatedSetting")%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Setting1" ItemStyle-HorizontalAlign="Left" UniqueName="TranslatedGroup" HeaderStyle-Wrap="false"
                                                            GroupByExpression="TranslatedGroup [GridColumn_TranslatedGroup] Group By TranslatedGroup ASC" Reorderable="false">
                                                            <ItemTemplate>
                                                                <%#Container.DataItem("TranslatedGroup")%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Value1" ItemStyle-HorizontalAlign="Left" UniqueName="ParamName" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false" >
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtString" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                                                <asp:TextBox ID="txtInteger" MaxLength="1000" Visible="false" runat="server"></asp:TextBox>
                                                                <asp:CheckBox ID="chkBoolean" Visible="false" runat="server" class="mobile-switch" />
                                                                <telerik:RadComboBox Id="ddlValues" Visible="false" runat="server" ></telerik:RadComboBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle Wrap="False" Width="250px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="true"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">
                                                            <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="False" CommandName="Update" CssClass="GridCmdUpdate" >
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblUpdate" Text="Save" runat="server"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                        </div>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">                        
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                                </ClientSettings>
                                                <GroupPanel Text="Group By"></GroupPanel>
                                            </telerik:RadGrid>
                                        </div>
                                    </div>
                                </div>
                              
                                            
                              
                            </td>
                        </tr>
                    </table>  

