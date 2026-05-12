<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SSRS.aspx.vb" Inherits="Website.SSRS" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 99%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>
                <asp:Button runat="server" ID="btnSave" Text="Save" Style="display: none" OnClick="btnSave_Click" />
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadGrid ID="rdgParameters" runat="server" EnableEmbeddedSkins="False" Skin="Default"
                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" AllowPaging="False"
                    ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="True"
                    AllowSorting="True" GridLines="None">
                    <HeaderContextMenu Skin="Default" EnableEmbeddedSkins="false">
                    </HeaderContextMenu>
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top"
                        UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                        EnableHeaderContextMenu="false" TableLayout="Fixed">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Group" HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left"
                                UniqueName="ParamName" HeaderStyle-Wrap="false" GroupByExpression="ParamName"
                                Groupable="true" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("ParamGroup")%>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Name" HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left"
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
                                <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
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

    <div class="PMMainPage" id="BIColors" runat="server">
        <div class="row" style="height: 450px;">
            <div class="col-4 col-4-left">
                <fieldset>
                    <legend>
                        <label>BI REPORT COLORS</label>
                    </legend>
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblColor1" Text="Color 1" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divColor1" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                </div>
                                <telerik:RadColorPicker ShowIcon="true" ID="rcpColor1" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker" KeepInScreenBounds="true"
                                    PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblColor2" Text="Color 2" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divColor2" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                </div>
                                <telerik:RadColorPicker ShowIcon="true" ID="rcpColor2" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker" KeepInScreenBounds="true"
                                    PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblColor3" Text="Color 3" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divColor3" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                </div>
                                <telerik:RadColorPicker ShowIcon="true" ID="rcpColor3" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker" KeepInScreenBounds="true"
                                    PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblColor4" Text="Color 4" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divColor4" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                </div>
                                <telerik:RadColorPicker ShowIcon="true" ID="rcpColor4" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker" KeepInScreenBounds="true"
                                    PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" valign="top">
                                <asp:LinkButton ID="btnUseDefault" runat="server" CssClass="lnkButton" OnClick="btnUseDefault_Click">
                                    <span runat="server"></span>
                                    <asp:Label ID="lblUseDefault" Text="Use Default" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
    </div>



    <script type="text/javascript">

        function OpenPalette(sender) {
            var id = sender.id;
            var cliendId = id.substring(0, id.lastIndexOf('_')) + "_rcpColor" + id[id.length - 1];
            var colorPicker = $find(cliendId);
            colorPicker.ShowPalette();
        }

        function HandleColorChanged(sender, eventArgs) {
            currColor = sender.get_selectedColor();
            var id = sender.get_id();
            var cliendId = id.substring(0, id.lastIndexOf('_')) + "_divColor" + id[id.length - 1];
            $("#" + cliendId).css("background", currColor);
        }



    </script>
</asp:Content>
