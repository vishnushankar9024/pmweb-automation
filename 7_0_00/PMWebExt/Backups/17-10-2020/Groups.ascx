<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Groups.ascx.vb" Inherits="Website.Groups" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link href="CSS/MainCss.css" rel="stylesheet" />
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="pnlGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlGroups" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <%--    <telerik:AjaxSetting AjaxControlID="rdgGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnCancel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnDelete">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>--%>
        <telerik:AjaxSetting AjaxControlID="rdgRights">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRights" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<telerik:RadAjaxLoadingPanel ID="ldpGroups" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<![if !IE]>
    <style type="text/css">
        @media screen and (min-width:320px) and (max-width:843px) {
            .marginBottomOnMobile {
                margin-bottom: 36px;
            }
        }

        .rdgRights.RadGrid.RadGrid_Default {
    border: none !important;
}

        p {
            Display: none !important;
        }

        .errorMsg{
            color:red;                          
       }
    </style>
<![endif]>

<script type="text/javascript">
    function SetMaxGridHeight()
    {
        SetGridHeight($("[id$=rdgRights]")[0].id,false)
    }
    function click_confirm(sender, args) {
        if (args.get_item().get_commandName() == "Delete") {
            result = ConfirmDelete();
            args.set_cancel(!result);
        }
    }
    function ConfirmDelete() {
        return confirm(Msg_ConfirmDeleteDocument);
    }
</script>

<asp:Panel ID="pnlGroups" runat="server">
    <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar GroupsToolbarOnHomePage" style="margin-top: 40.81px;">
            <td style="width: 240px" class="ToolbarTd ShowDropDown">
                <telerik:RadComboBox ID="ddlGroups" runat="server" NoWrap="True" OnClientTextChange="LOD_DropDownTextChange" OnItemsRequested="ddl_ItemsRequested"
                    Skin="Default" AllowCustomText="True" CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" AutoPostBack="true"
                    Width="240px" EnableVirtualScrolling="True" ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnSelectedIndexChanged="ddlGroups_SelectedIndexChanged">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnButtonClick="mainToolBar_ButtonClick" OnClientButtonClicking="click_confirm()">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="GroupRight" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="New" AccessKey="n" CausesValidation="false" PostBack="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <asp:Panel ID="pnlRights" runat="server" Width="100%">
        <div class="PMMainPage" style="padding-top:90.81px !important" >
            <div class="row row-8-4 marginBottomOnMobile"  >
                <div class="col-4 ">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblGroup" meta:resourcekey="lblGroup" runat="server" Text="Group*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtGroup" MaxLength="100" runat="server" Columns="25" Width="100%"></asp:TextBox>
                                <asp:Label ID="lblGroupUnique" meta:resourcekey="lblGroupUnique" Text="<br>Each group must have a unique name." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                <asp:RequiredFieldValidator ID="rfvGroup" meta:Resourcekey="rfvGroup" runat="server"
                                    ControlToValidate="txtGroup" CssClass="Validator" ErrorMessage="Enter the Group"
                                    Display="Dynamic" ForeColor="" ValidationGroup="GroupRight"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="lblErrorMessage"  runat="server" Visible="false" Text="ID must be unique" CssClass="errorMsg"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" MaxLength="255" runat="server" Columns="70" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" meta:resourcekey="rfvDescription"
                                    runat="server" ControlToValidate="txtDescription" CssClass="Validator" ErrorMessage="Enter the Description"
                                    Display="Dynamic" ForeColor="" ValidationGroup="GroupRight"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadGrid ID="rdgMiscellaneousPermission" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" Height="500px"
                                    ShowGroupPanel="false" AllowMultiRowEdit="true" AllowMultiRowSelection="true" CssClass="MiscellaneousPermissionTree"
                                    AllowSorting="False" GridLines="None" AllowFilteringByColumn="false" >
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="MiscellaneousPermissionId" CommandItemDisplay="none" InsertItemDisplay="Top"
                                        UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                                        EnableHeaderContextMenu="true" TableLayout="Fixed" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" UniqueName="MiscellaneousPermissionChecked" Groupable="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkMiscellaneousPermission" runat="server" Checked='<%# Eval("MiscellaneousPermissionChecked") %>' onclick="SelectParent(this);" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelectAll" TextAlign="Left" onclick="AllCheckClicked(this);" Style="cursor: default" />
                                                </HeaderTemplate>
                                                <HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Option" UniqueName="MiscellaneousPermissionDescription" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" SortExpression="DisplayType" Groupable="false">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnMiscellaneousPermission" runat="server"
                                                        Value='<%# Eval("MiscellaneousPermissionId") %>' />
                                                    <asp:HiddenField ID="hdnMiscellaneousKey" runat="server"
                                                        Value='<%# Eval("MiscellaneousPermissionKey") %>' />
                                                    <span><%# IIf(Eval("LanguageResource") <> "", GetLocalResourceObject("MiscPermission_" + Eval("MiscellaneousPermissionKey")), Eval("MiscellaneousPermissionDescription"))%></span>&nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Width="250px"></HeaderStyle>
                                                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-8 " style="overflow:auto">
                    <telerik:RadGrid ID="rdgRights" runat="server" Width="800px" ClientSettings-Scrolling-ScrollHeight="550px" ClientSettings-Scrolling-UseStaticHeaders="true"  ClientSettings-Scrolling-AllowScroll="true"
                                        AutoGenerateColumns="False" ShowStatusBar="true" ShowGroupPanel="false" HeaderStyle-Font-Size="8"
                                        AllowMultiRowEdit="True" AllowMultiRowSelection="false" CssClass="rdgRights" 
                                        AllowSorting="true" ValidationSettings-ValidationGroup="GroupRight">
                                        <PagerStyle Mode="NextPrevAndNumeric" />
                                        <MasterTableView  NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" TableLayout="Fixed"
                                            GroupLoadMode="Server" GroupsDefaultExpanded="false" DataKeyNames="MenuItemId" Name="Master" HorizontalAlign="Right">
                                            <%--<ExpandCollapseColumn Visible="false">
                                                <HeaderStyle Width="19px" />
                                            </ExpandCollapseColumn>
                                            <RowIndicatorColumn Visible="false">
                                                <HeaderStyle Width="19px" />
                                            </RowIndicatorColumn>--%>
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldName="ModuleName"></telerik:GridGroupByField>
                                                        <telerik:GridGroupByField FieldName="ModuleKey"></telerik:GridGroupByField>
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="ModuleId" SortOrder="Ascending"></telerik:GridGroupByField>
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Record %>" UniqueName="Record">
                                                    <ItemTemplate>
                                                        <%#If(Container.DataItem("UniqueName") Is System.DBNull.Value, "&nbsp;", GetGlobalResourceObject("PMPages", CStr(Container.DataItem("UniqueName"))))%><asp:HiddenField ID="hdnUniqueName" runat="server" Value='<%#IIf(Container.DataItem("UniqueName") Is System.DBNull.Value, "", Container.DataItem("UniqueName"))%>' />
                                                        <asp:HiddenField ID="hdnModuleKey" runat="server" Value='<%#IIf(Container.DataItem("ModuleKey") Is System.DBNull.Value, "", Container.DataItem("ModuleKey"))%>' />
                                                        <asp:HiddenField ID="hdnMenuItemId" runat="server" Value='<%#IIf(Container.DataItem("MenuItemId") Is System.DBNull.Value, 0, Container.DataItem("MenuItemId"))%>' />
                                                        <%--<asp:HiddenField ID="hdnFirstItemId" runat="server" Value='<%#IIf(Container.DataItem("FirstItemId") IS System.DBNULL.Value, 0, Container.DataItem("FirstItemId"))%>' />--%>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="331px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="90px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_View %>" UniqueName="View">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkCanRead" runat="server" Checked='<%#CStr(Container.DataItem("CanRead"))%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Create %>" UniqueName="Create">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkCanAdd" runat="server" Checked='<%#CStr(Container.DataItem("CanAdd"))%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Delete %>" UniqueName="Delete">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkCanDelete" runat="server" Checked='<%#CStr(Container.DataItem("CanDelete"))%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Edit %>" UniqueName="Edit">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkCanEdit" runat="server" Checked='<%#CStr(Container.DataItem("CanEdit"))%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>

                                            </Columns>
                                            <DetailTables>
                                                <telerik:GridTableView SkinID="PM" AllowSorting="false" AllowPaging="false"
                                                    Name="SubModules" ShowHeader="false" ShowFooter="false"
                                                    DataKeyNames="Id,TabId" HorizontalAlign="Right">

                                                    <Columns>
                                                        <telerik:GridTemplateColumn Visible="false">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdntabId" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn Visible="false">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnFieldId" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn Visible="false">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnObjectTypeId" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn Visible="false">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnIsTab" runat="server" />
                                                                <asp:HiddenField ID="hdnIsHeader" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="FieldFriendlyName" HeaderText="Tabs">
                                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                            <HeaderStyle Wrap="false" Width="317px" HorizontalAlign="Left" />

                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn>

                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="90px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="isVisible">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkFieldCanView" runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" BorderStyle="None" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="isEditable">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkFieldCanEdit" Visible="false" runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>

                                                    <DetailTables>
                                                        <telerik:GridTableView SkinID="PM" AllowSorting="false" AllowPaging="false" ShowFooter="false"
                                                            ShowHeader="false" Name="GridNames" HorizontalAlign="Right" DataKeyNames="TabId,GridID">

                                                            <Columns>
                                                                <telerik:GridTemplateColumn Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hiddenTabId" runat="server" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnGridId" runat="server" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridBoundColumn DataField="GridName">
                                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                            <DetailTables>
                                                                <telerik:GridTableView SkinID="PM" AllowSorting="false" AllowPaging="false" ShowFooter="false" ShowHeader="false"
                                                                    Name="DetailsModules" HorizontalAlign="Right" DataKeyNames="TabId,GridID">

                                                                    <Columns>
                                                                        <telerik:GridTemplateColumn Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdntabId" runat="server" />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnFieldId" runat="server" />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnObjectTypeId" runat="server" />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridTemplateColumn Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnIsTab" runat="server" />
                                                                                <asp:HiddenField ID="hdnIsHeader" runat="server" />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridBoundColumn DataField="FieldFriendlyName">
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                                            <HeaderStyle Wrap="false" Width="299px" HorizontalAlign="Left" />
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridTemplateColumn>
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                            <HeaderStyle Wrap="false" Width="90px" HorizontalAlign="Center" />
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="isVisible">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkFieldCanView" runat="server" Checked='<%#CStr(Container.DataItem("IsVisible"))%>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridTemplateColumn>
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridTemplateColumn>
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                                        </telerik:GridTemplateColumn>

                                                                        <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="isEditable">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkFieldCanEdit" runat="server" Checked='<%#CStr(Container.DataItem("isEditable"))%>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                            <HeaderStyle Wrap="false" Width="75px" HorizontalAlign="Center" />
                                                                        </telerik:GridTemplateColumn>
                                                                    </Columns>
                                                                </telerik:GridTableView>
                                                            </DetailTables>
                                                        </telerik:GridTableView>
                                                    </DetailTables>
                                                </telerik:GridTableView>
                                            </DetailTables>
                                        </MasterTableView>
                                        <ClientSettings EnableRowHoverStyle="true" AllowGroupExpandCollapse="True"
                                            Resizing-AllowColumnResize="false">
                                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="false" />
                                            <ClientEvents OnGridCreated ="SetMaxGridHeight" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                <asp:HiddenField ID="hdnExpandAll" runat="server" Value="False" />
                </div>
        </div>
    </asp:Panel>
</asp:Panel>

<%--<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <table class="colTable">
                <tr>
                    <td>
                        <fieldset id="fldsetGroup" runat="server">
                            <legend>
                                <asp:Label runat="server" ID="lblSelectGroup" meta:resourcekey="lblSelectGroup" Text="Select a Goup 11"></asp:Label></legend>

                            <telerik:RadGrid ID="rdgGroups" runat="server" CssClass="WithoutTopBorder" SetWidth="true" FitParentContainer="true" allow-scroll="true"
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                                PageSize="10" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="false"
                                AllowSorting="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Group" UniqueName="Group">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                            <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                            <HeaderStyle Wrap="false" Width="300px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Guest" UniqueName="Guest">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIF(Eval("IsGuest"),"checked.png" , "unchecked.png"))%>" />
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                            <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(Eval("IsDefault"), "checked.png", "unchecked.png"))%>" />
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                            <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="Group"></telerik:GridSortExpression>
                                    </SortExpressions>
                                    <CommandItemStyle HorizontalAlign="Left" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                                CommandName="EditRows" CssClass="GridCmdEditRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label3" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="GroupRight"
                                                CommandName="Save" CssClass="GridCmdPerformInsert" meta:resourcekey="btnSaveResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="GridCmdCancelAll"
                                                meta:resourcekey="btnCancelResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow" CommandName="InitNewRecord">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblAddLine" Text=""></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text=""
                                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode"
                                                CommandName="RebindGrid">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblRefresh" Text=""></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>

                                </MasterTableView>
                                <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                    </td>

                </tr>
            </table>
        </div>
        <br />
        
            <fieldset id="fldGroupDetails" runat="server">
                <legend>
                    <asp:Label runat="server" ID="lblGroupDetails" meta:resourcekey="lblGroupDetails" Text="Group Details 11"></asp:Label></legend>
                <div class="col-8">
                </div>
                <div class="col-4">
                    <table class="colTable">
                    </table>
                </div>
            </fieldset>
        </asp:Panel>
    </div>
</div>--%>
