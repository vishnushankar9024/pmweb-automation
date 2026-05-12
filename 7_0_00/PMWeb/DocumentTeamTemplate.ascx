<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentTeamTemplate.ascx.vb" Inherits="Website.DocumentTeamTemplate" %>


<script>
    function MoreMenuClicked(sender, args) {
        if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
            sender.close(true);
            debugger;
            if (args.get_item().get_value().indexOf("UpdateUnlockedTemplates") == 0) {
                $("[id$=btnUpdUnlockedTemplates]").click()
            }
        }
    }
</script>

<style>
    div#ctl00_CPH1_CollaborateTemplate1_RadEditor1 {
        height: 100% !important;
    }
</style>

<table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar MsgTemplateToolbarHomePage">
    <tr>
        <%-- <td class="HideOnMobileToolbar" style="background-color: transparent; height: 37px; width: 20%; color: #666666">
                                    <asp:Label runat="server" ID="lblRecordType" Text="Record Type" meta:resourcekey="lblRecordType"></asp:Label>
                                </td>--%>
        <td style="width: 240px;" class="ToolbarTd">
            <telerik:RadComboBox ID="ddlRecordType" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                Height="400px" Filter="Contains" Skin="Default" DropDownCssClass="ToolbarDropdownMessageTemplate">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>
        <td class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                <Items>
                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                    </telerik:RadToolBarButton>

                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                        <ItemTemplate>
                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                <Items>
                                    <telerik:RadMenuItem CssClass="menuMore">
                                        <Items>
                                            <telerik:RadMenuItem Text="Update Unlocked Templates" Value="UpdateUnlockedTemplates"></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </ItemTemplate>
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
        <td class="ToolbarTd">
            <asp:Button ID="btnUpdUnlockedTemplates" runat="server" meta:resourcekey="btnUpdUnlockedTemplates" CssClass="LargeButton HideOnMobileToolbar" Text="Update Unlocked Templates" Style="width: 200px;" />
        </td>
        <td></td>
    </tr>
</table>

<div class="PMMainPage">
    <div class="row" style="max-width: 800px; width: 100%">
        <div>
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblAction" runat="server" meta:resourcekey="lblAction" Text="Action"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlActionTypes" runat="server" AutoPostBack="True"
                            AllowCustomText="false" CausesValidation="False" EnableVirtualScrolling="True"
                            Height="165px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" meta:resourcekey="ddlActionTypes"
                            NoWrap="True" Skin="Default">
                            <CollapseAnimation Duration="150" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject*"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtSubject" runat="server" MaxLength="200"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                            CssClass="Validator" Display="Dynamic" ErrorMessage="Enter the subject" ForeColor=""
                            meta:resourcekey="rfvSubject"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr id="trLock" runat="server">
                    <td class="labelWidth">
                        <asp:Label ID="LblLock" runat="server" meta:resourcekey="lblLock" Text="Lock"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:CheckBox ID="CbxLock" runat="server" />

                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row JustifyContent R3Cols row-4-5-4">
        <div class="col-4 col-4-left">
            <fieldset>
                <legend>
                    <asp:Label ID="lblFields" runat="server" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                </legend>
                <telerik:RadTreeView ID="tree" Height="518px" runat="server" Width="100%"
                    OnClientNodeClicked="OnDocTeamClientItemDoubleClicked" ShowLineImages="false">
                </telerik:RadTreeView>
            </fieldset>
        </div>
        <div class="col-4 col-4-middle">
            <fieldset>
                <legend>
                    <asp:Label ID="lblEditor" runat="server" meta:resourcekey="lblEditor" Text="Editor"></asp:Label>
                </legend>
                <asp:Panel ID="pnlEditor" runat="server" Width="100%">
                    <telerik:RadEditor ID="RadEditor1" runat="server" Height="510px" Width="100%" DialogsScriptFile="~/JS/RadEditorDialog.js"
                        OnClientLoad="DocTeamOnClientNotLoad" Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                        <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000" SearchPatterns="*.*"
                            UploadPaths="~/Images/Shared" ViewPaths="~/Images/Shared" />
                    </telerik:RadEditor>
                </asp:Panel>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <fieldset>
                <legend>
                    <asp:Label ID="lblAttachToEmail" runat="server" meta:resourcekey="lblAttachToEmail"
                        Text="Select To Attach To Email"></asp:Label></legend>
                <telerik:RadGrid ID="rdgAttachToEmail" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    Height="100%" AllowPaging="true" PageSize="10" Width="100%" AutoGenerateColumns="False"
                    HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
                    ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true"
                        EnableHeaderContextMenu="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                AllowFiltering="false" HeaderStyle-Width="48px">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkAll" onClick="AllDocTeamCheckClicked(this)" runat="server" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" onClick="SelectDocTeamParent(this)" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Height="20px" />
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Type"
                                UniqueName="Type" Groupable="False">
                                <ItemTemplate>
                                    <%# Eval("TranslatedType").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Description"
                                UniqueName="Description" Groupable="False">
                                <ItemTemplate>
                                    <%# Eval("TranslatedDescription").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>

</div>








