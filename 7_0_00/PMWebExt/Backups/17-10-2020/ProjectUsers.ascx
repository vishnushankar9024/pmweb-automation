<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectUsers.ascx.vb" Inherits="Website.ProjectUsers" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        debugger;
        var griddId = "<%=rdgRoles.ClientID %>";
    </script>
    <style>
        .rgCommandRow {
            display: none;
        }

        #ctl00_ctl00_CPH1_ProjectUsers1_rdvUsersPanel {
            display: inline !important;
        }

        #ctl00_ctl00_CPH1_ProjectUsers1_rtvUsersPanel {
            display: inline !important;
        }

        /*@media screen and (min-width:1325px) {
            .PMHeader .row .col-16 {
                flex: 0 0 50% !important;
                max-width: 48% !important;
                float: left;
                min-width: 524px;
            }

            .PMHeader .row {
                padding-left: 24px;
                padding-right: 24px;
            }

            .row.rowJustify {
                display: flex;
                justify-content: space-between;
            }

            .col-16 fieldset .row .col-6 {
                width: 47% !important;
                max-width: 47% !important;
                min-width: 250px;
            }
        }

        @media screen and (max-width:1325px) and (min-width:557px) {

            .col-16 fieldset .row .col-6 {
                width: 47% !important;
                max-width: 47% !important;
                min-width: 250px;
            }

            .PMHeader .row .col-16 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
                float: left;
                min-width: 524px;
            }
        }

        @media screen and (max-width:556px) {
            .col-16 fieldset .row .col-6 {
                width: 100% !important;
                max-width: 100% !important;
            }

            .rowBlock {
                display: block !important;
            }
        }

        @media screen and (max-width:1325px) {
            .PMHeader .row {
                padding-left: 16px;
                padding-right: 16px;
            }
        }*/
    </style>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRoles">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRoles" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblGridError" />
                <telerik:AjaxUpdatedControl ControlID="pnlWarning" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rtvUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="lblGridError" />
                <telerik:AjaxUpdatedControl ControlID="rdgRoles" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
        <%--<telerik:AjaxSetting AjaxControlID="rdvUsers" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>--%>
        <telerik:AjaxSetting AjaxControlID="rdvEntities">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rtvUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="chkDisplayUserWithAccess">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="chkDisplayUserWithAccess" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="chkUnlockedRoles">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRoles" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="chkUnlockedRoles" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="chkRolesInUse">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRoles" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="chkRolesInUse" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="rdvUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdvUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdvEntities" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rtvUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpRoles" runat="server" Skin="Default" />


<div class="PMMainPage">
    <div class="row row-8-4-fit8">
        <div class="col-4">

            <fieldset>
                <legend>
                    <asp:Label ID="lblProjectAccess" runat="server" Text="Project Access" meta:resourcekey="lblProjectAccess" />
                </legend>


                <telerik:RadTreeView ID="rdvUsers" runat="server" Skin="Default" MultipleSelect="true" EnableDragAndDrop="True"
                    OnClientNodeDropping="EntityAccess_onUsersNodeDropping" OnClientNodeDragging="EntityAccess_onNodeDragging"
                    Height="383px" OnNodeDrop="rdvUsers_NodeDrop" Width="185px" Style="display: inline-block; vertical-align: top">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                    <NodeTemplate>
                        <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                    </NodeTemplate>
                </telerik:RadTreeView>


                <table class="colTable" style="width: 186px; display: inline-block; margin-left: 24px">
                    <tr>
                        <td>
                            <asp:CheckBox runat="server" ID="chkDisplayUserWithAccess" Text="Only display users with access" meta:resourcekey="chkDisplayUserWithAccess" AutoPostBack="true"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTreeView ID="rdvEntities" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="false" Style="border: 1px solid #e5e5e5; margin-top: 5px;"
                                OnClientNodeDropping="onNodeDropping" OnClientContextMenuShowing="onClientContextMenuShowingProjectUsers" OnContextMenuItemClick="rdvEntities_ContextMenuItemClick"
                                Height="338px" Width="186px">
                                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <ContextMenus>
                                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                        <Items>
                                            <telerik:RadMenuItem Value="RemoveAccess" Text="Remove Access" meta:ResourceKey="ContextMenu_RemoveAccess" EnableImageSprite="true" CssClass="MenuDelete">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="GrantAccess" Text="Grant Access" meta:ResourceKey="ContextMenu_GrantAccess" EnableImageSprite="true" CssClass="MenuAdd">
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadTreeViewContextMenu>
                                </ContextMenus>
                                <NodeTemplate>
                                    <asp:Literal ID="lblNodes" Mode="Encode" runat="server"></asp:Literal>
                                </NodeTemplate>
                            </telerik:RadTreeView>
                        </td>
                    </tr>
                </table>


            </fieldset>

        </div>
        <div class="col-8">
            <fieldset>
                <legend>
                    <asp:Label ID="lblWorkflowRoles" runat="server" Text="Workflow Roles11" meta:resourcekey="lblWorkflowRoles" />
                </legend>

                <telerik:RadTreeView ID="rtvUsers" runat="server" OnNodeDrop="rtvUsers_NodeDrop" Width="30%" Height="383px"
                    OnClientNodeDropping="rtvUsers_onNodeDropping" Style="display: inline-block"
                    OnClientNodeDragging="onNodeDragging" EnableDragAndDrop="True"
                    MultipleSelect="False">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>


                <table class="colTable" style="display: inline-block; margin-left: 24px; width: calc(69% - 24px); vertical-align: top;">
                    <tr>
                        <td style="padding-top: 0">
                            <asp:CheckBox runat="server" ID="chkUnlockedRoles" Text="View Unlocked Roles Only" meta:resourcekey="chkUnlockedRoles" AutoPostBack="true"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 2px">
                            <asp:CheckBox runat="server" ID="chkRolesInUse" Text="View Roles in Use Only" meta:resourcekey="chkRolesInUse" AutoPostBack="true"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 2px">
                            <div class="PMHeader">
                                <div class="row">
                                    <div class="col-12">
                                        <telerik:RadGrid ID="rdgRoles" runat="server" AutoGenerateColumns="False" Width="100%" Style="max-height: 350px; overflow: auto;"
                                            ShowStatusBar="True" PageSize="10" AllowPaging="True" AllowMultiRowEdit="True" ShowFooter="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                            AllowMultiRowSelection="True" HeaderStyle-Font-Size="8" GridLines="None">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                EditMode="InPlace">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Lock11" UniqueName="IsLocked">
                                                        <ItemTemplate>
                                                            <img src='Images/Global/<%# CStr(IIf(Eval("IsLocked"), "checked.png", "unchecked.png"))%>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="33px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Level" UniqueName="RoleLevel">
                                                        <ItemTemplate>
                                                            <%# CStr(IIf(Eval("RoleLevel") IsNot Nothing, GetGlobalResourceObject("PMWeb", Eval("RoleLevel")), String.Empty))%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="70px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Role*" UniqueName="Role">
                                                        <ItemTemplate>
                                                            <%#Container.DataItem("RoleName")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="142px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="User*" UniqueName="User">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("FullName") = String.Empty, "&nbsp;", Container.DataItem("FullName"))%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="180px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>

                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>

                                            <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowDblClick="RowDblClick"
                                                Resizing-AllowColumnResize="true">
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </div>
                                </div>
                            </div>
                            <asp:Label CssClass="Validator" ID="lblGridError" runat="server" />
                        </td>
                    </tr>
                </table>

            </fieldset>
        </div>
    </div>
</div>


