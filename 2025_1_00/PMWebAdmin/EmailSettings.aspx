<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EmailSettings.aspx.vb" Inherits="Website.EmailSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 99%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>
                <asp:Button runat="server" ID="btnSave" Text="Save" style="display:none" OnClick="btnSave_Click"/>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="rdgParameters" runat="server" EnableEmbeddedSkins="False" Skin="Default"
                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" AllowPaging="False" 
                    ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="True" 
                    AllowSorting="True" GridLines="None">
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top"
                        UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                        EnableHeaderContextMenu="false" TableLayout="Fixed">
                         
                        <Columns>                            
                            <telerik:GridTemplateColumn HeaderText="Group"   HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName" 
                                Groupable="true" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("ParamGroup")%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Name"   HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName" 
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("ParamName")%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Value" HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtString" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="txtInteger" MaxLength="1000" Visible="false" runat="server"></asp:TextBox>
                                    <asp:CheckBox ID="chkBoolean" Visible="false" runat="server" />
                                    <div>
                                      <asp:Image ID="imgPreview" runat="server" Width="210px" Visible="false" Height="70px" ImageUrl="Images/Global/WhiteDot.gif"/>
                                      </div>
                                    <div>
                                      <asp:FileUpload ID="FileToUpload" runat="server" Width="280px" Visible="false" />
                                      </div>
                                      <asp:HiddenField runat="server" ID="hdnLogoFileName"  />
                                            <telerik:RadUpload ID="FileToUpload1" runat="server" CssClass="Hide" Skin="Office2007" ControlObjectsVisibility="none"
                                                MaxFileInputsCount="1" Visible="true" Width="300px">
                                            </telerik:RadUpload>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                       <%-- <CommandItemTemplate>
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
                    <FilterMenu EnableEmbeddedSkins="False">
                    </FilterMenu>
                     <GroupPanel Text='<%$Resources:PMWeb, Grid_GroupPanel %>'></GroupPanel>
                     <ClientSettings AllowDragToGroup="true">
                    </ClientSettings>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

</asp:Content>
 