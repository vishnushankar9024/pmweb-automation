<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardsTemplate.ascx.vb" Inherits="Website.ActivityBoardsTemplate" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<style>
    div#ctl00_CPH1_ActivityBoardsTemplate1_RadEditor1 {
        height: 100% !important;
    }
</style>

<table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar MsgTemplateToolbarHomePage">
    <tr>
        <td style="width: 240px;" class="ToolbarTd">
            <telerik:RadComboBox ID="ddlActions" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False" Filter="Contains" Skin="Default" DropDownCssClass="ToolbarDropdownMessageTemplate">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>
        <td style="vertical-align: middle; width: 100px" class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                <Items>
                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
        <td>
        </td>
    </tr>
</table>


<div class="PMMainPage">
    <div class="row" style="max-width:800px;width:100%">
        <div>
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtSubject" runat="server" MaxLength="500"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row JustifyContent R3Cols row-4-5-4">
        <div class="col-4 col-4-lefts">
            <fieldset>
                <legend>
                    <asp:Label ID="lblFields" runat="server" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                </legend>
                <telerik:RadTreeView ID="tree" Height="510px" Width="100%" runat="server" OnClientNodeClicked=" OnActivityBoardClientItemDoubleClicked" ShowLineImages="false">
                </telerik:RadTreeView>
            </fieldset>
        </div>
        <div class="col-4 col-4-middle">
            <fieldset>
                <legend>
                    <asp:Label ID="lblEditor" runat="server" meta:resourcekey="lblEditor" Text="Editor"></asp:Label>
                </legend>
                <asp:Panel ID="pnlEditor" runat="server" Width="100%">
                    <telerik:RadEditor ID="RadEditor1" runat="server" DialogsScriptFile="~/JS/RadEditorDialog.js" Height="500px" Width="100%"
                        OnClientLoad="OnClientActivityBoardLoad" Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                        <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000" SearchPatterns="*.*"
                            UploadPaths="~/Images/Shared" ViewPaths="~/Images/Shared" />
                    </telerik:RadEditor>
                </asp:Panel>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <%--<fieldset>
                <legend>
                    <asp:Label ID="lblAttachToEmail" runat="server" meta:resourcekey="lblAttachToEmail" Text="Select To Attach To Email" Style="margin-left: 5px;"></asp:Label></legend>

                <telerik:RadGrid ID="rdgAttachSubToEmail" runat="server" Height="100%" AllowPaging="False" PageSize="10" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">

                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                        <Columns>
                            <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="48px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Height="20px" />
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" Groupable="False">
                                <ItemTemplate>
                                    <%# Eval("TranslatedType").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description" Groupable="False">
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

            </fieldset>--%>
        </div>
    </div>
</div>