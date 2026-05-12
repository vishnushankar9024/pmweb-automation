<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="GeneralSettings.aspx.vb" Inherits="Website.GeneralSettings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
        <%--   <tr valign="top" class="ToolBar">
            <td class="Padding7" colspan="2">
                <asp:Label ID="lblLanguageManager" runat="server" Text="General Settings" CssClass="Bold"></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td>
                <asp:Button runat="server" ID="btnSave" Text="Save" style="display:none" OnClick="btnSave_Click"/>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="rdgParameters" runat="server" EnableEmbeddedSkins="False" Skin="Default" Width="100%" EnableHeaderContextMenu="true"  SetWidth="true"
                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" AllowPaging="False"
                    ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="True"
                    AllowSorting="True" GridLines="None">
                    <GroupPanel Text='<%$Resources:PMWeb, Grid_GroupPanel %>'></GroupPanel>
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top"
                        UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                        EnableHeaderContextMenu="false" TableLayout="Fixed">

                        <%--   <GroupByExpressions  >
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldName="ParamGroup" FieldAlias="Group"></telerik:GridGroupByField>
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="ParamGroup" SortOrder="Ascending"></telerik:GridGroupByField>
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>--%>
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Group" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamGroup" HeaderStyle-Wrap="false" GroupByExpression="ParamGroup [Group] Group By ParamGroup ASC"
                                Groupable="true" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("ParamGroup")%>
                                </ItemTemplate>
                                <HeaderStyle Width="400px" Wrap="False"></HeaderStyle>
                                <ItemStyle   HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Name" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("ParamName")%>
                                </ItemTemplate>
                                <HeaderStyle Width="400px" Wrap="False"></HeaderStyle>
                                <ItemStyle  HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Value" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtString" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="txtInteger" MaxLength="1000" Visible="false" runat="server"></asp:TextBox>
                                    <asp:CheckBox ID="chkBoolean" Visible="false" runat="server" />
                                    <div>
                                        <asp:Image ID="imgPreview" runat="server" Width="210px" Visible="false" Height="70px" ImageUrl="Images/Global/WhiteDot.gif" />
                                    </div>
                                    <div>
                                        <asp:FileUpload ID="FileToUpload" runat="server" Width="280px" Visible="false" />
                                    </div>
                                    <asp:HiddenField runat="server" ID="hdnLogoFileName" />
                                    <telerik:RadUpload ID="FileToUpload1" runat="server" CssClass="Hide" Skin="Office2007" ControlObjectsVisibility="none"
                                        MaxFileInputsCount="1" Visible="true" Width="300px">
                                    </telerik:RadUpload>
                                </ItemTemplate>
                                <HeaderStyle Width="400px" Wrap="False"></HeaderStyle>
                                <ItemStyle  HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <%--<CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="False" CommandName="Update">
                                    <img style="border: 0px; vertical-align: middle;" src="Images/Global/save.gif" />
                                    <asp:Label ID="lblUpdate" Text="Save" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnReset" runat="server" OnClientClick="Javascript:return confirm('This command will Sign Out all connected Users, Are you sure you want to proceed?')"
                                    CausesValidation="False" CommandName="Reset">
                                    <img style="border: 0px; vertical-align: middle;" src="Images/Global/Refresh.gif" />
                                    <asp:Label ID="lblReset" Text="Restart PMWeb" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>--%>
                    </MasterTableView>
                    <ClientSettings AllowDragToGroup="true">
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Content>
