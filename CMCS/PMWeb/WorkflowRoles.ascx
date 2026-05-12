<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkFlowRoles.ascx.vb"
    Inherits="Website.WorkFlowRoles" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script language="javascript" type="text/javascript" src="JS/workflow/roles.js"></script>
    <script language="javascript" type="text/javascript">
        var gridId = "<%=rdgRoles.ClientID %>";
    </script>
    <style type="text/css">
        .lnkButtonAnchor .Icon {
            background-image: url('../CSS/Images/ResponsiveIcons/16Enabled.png') !important;
            width: 16px !important;
            display: inline-block !important;
            height: 16px !important;
            vertical-align: middle !important;
            margin-right: 5px !important;
            background-repeat: no-repeat !important;
            background-position: -1248px 0px !important;
        }

        @media screen and (min-width:1550px) {
            .col-4-RolesOnMobile {
                padding-right: 8px;
            }

            .RoleTreeWidth {
                width: 300px !important;
            }

            .RoleGridWidth {
                width: 564px !important;
            }

            .PMMainPage > .row > .col-8.col-8-WorkflowRoles {
                width: 864px !important;
            }
        }

        @media screen and (min-width:1071px) and (max-width:1549px) {
            .RoleTreeWidth {
                width: 300px !important;
            }

            .RoleGridWidth {
                width: 500px !important;
            }

            .PMMainPage > .row > .col-8.col-8-WorkflowRoles {
                width: 800px !important;
            }

            .col-4-RolesOnMobile {
                padding-right: 8px;
            }
        }

        @media screen and (min-width:320px) and (max-width:1070px) {
            .RoleTreeWidth {
                width: 415px !important;
            }

            .RoleGridWidth {
                width: 417px !important;
            }

            .PMMainPage > .row > .col-8.col-8-WorkflowRoles {
                width: 417px !important;
                padding-left: 8px;
            }

            .DisplayOnMobileAsRow {
                display: table-row !important;
            }

            .DisplayOnMobileAsTable {
                display: table !important;
            }

            .col-4-RolesOnMobile {
                width: 417px !important;
                padding-left: 8px !important;
                padding-right: 0px !important;
            }

            .PMMainPage > div.row div.col-4.col-4-RolesOnMobile {
                padding-left: 8px !important;
                padding-right: 0px !important;
            }

            div#ctl00_CPH1_ucRoles_rtvUsers {
                width: 415px !important;
            }

            div#ctl00_CPH1_ucRoles_rdgRoles {
                border-left: 1px solid #666666 !important;
            }

            div#ctl00_ctl00_CPH1_ucRoles_rdgRolesPanel {
                padding-top: 20px !important;
            }
        }

        li.rtLI.rtFirst.rtLast {
            margin-left: 22px !important;
        }

        .trvUserGroup .rtSp, .trvUser .rtSp {
            margin-right: 0px !important;
        }
        .RadTreeView .trvUser .rtChecked, .RadTreeView .trvUser .rtUnchecked {
            margin-left: -36px !important;
        }

        .RadTreeView .rtChk, .RadTreeView .rtChecked, .RadTreeView .rtUnchecked, .RadTreeView .rtIndeterminate {
            margin-bottom: 2px;
        }
        .RadTreeViewUsers .rtUL{
            padding-left:24px !important;
            padding-top:10px !important;
        }
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
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpRoles" runat="server" />

<table class="ToolBarWorkflowRoles" style="width: 100%;background-color: RGB(237,237,237) !important;margin-top:38px;" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton ImageUrl="Images/Global/Save.png" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div class="PMMainPage JustifyContent">
    <div class="row WorkflowSinglePage">
        <div class="col-8 col-4-left col-8-WorkflowRoles" style="padding-bottom:24px;">
            <fieldset>
                <legend>
                    <asp:Label ID="lblUsers" runat="server" Text="USERS" CssClass="legend" meta:resourcekey="lblUsers"></asp:Label>
                </legend>
                <table style="width: 100% !important;" cellspacing="0" cellpadding="0">
                    <tr class="DisplayOnMobileAsTable">
                        <td class="RoleTreeWidth DisplayOnMobileAsRow">
                            <table class="colTable RoleTreeWidth">
                                <tr>
                                    <td style="border: 1px solid #666666; position: static !important; padding: 0px;" class="ToolBar RoleTreeWidth">
                                        <table class="ToolBar" style="width: 100%; position: static !important;" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 100%" class="ToolbarTd">
                                                    <asp:LinkButton ID="lbtDelegateReplace" runat="server" CausesValidation="False"
                                                        OnClientClick="return OpenDelegateReplaceUserPopup();" CssClass="lnkButtonAnchor" Visible="True">
                                                        <span class="Icon" runat="server"></span>
                                                        <asp:Label ID="lblDelegateReplace1" runat="server" meta:resourcekey="lblDelegateReplace"></asp:Label>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #666666; border-top: none !important; padding: 0px;" class="RoleTreeWidth">
                                        <div style="height: 445px; overflow: auto;position: relative;" class="RoleTreeWidth">
                                            <telerik:RadTreeView ID="rtvUsers" runat="server" OnNodeDrop="rtvUsers_NodeDrop" Height="100%" Width="100%"
                                                OnClientNodeDropping="onNodeDropping" CssClass="RadTreeViewUsers" CheckBoxes="true" TriStateCheckBoxes="true"
                                                OnClientNodeDragging="onNodeDragging" EnableDragAndDrop="True" OnClientNodeChecked="afterClientCheck"
                                                MultipleSelect="False">
                                                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                            </telerik:RadTreeView>
                                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">
                                                   &nbsp; 
                                                </div>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="padding: 0px;" class="RoleGridWidth DisplayOnMobileAsRow">
                            <telerik:RadGrid ID="rdgRoles" UseEditFormInMobile="true" GroupingEnabled="true" runat="server" AutoGenerateColumns="False" Width="100%" SetWidth="true"
                                AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Height="496px"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" CssClass="RoleGridWidth"
                                PageSize="250" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" ShowStatusBar="true" ClientSettings-Scrolling-AllowScroll="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                                    EnableHeaderContextMenu="true" ShowGroupFooter="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Lock11" HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center" UniqueName="IsLocked" DataField="IsLocked"
                                            CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" SortExpression="IsLocked" GroupByExpression="IsLocked [GridColumn_IsLocked] Group By IsLocked ASC">
                                            <ItemTemplate>
                                                <img src='Images/Global/<%# CStr(IIf(Eval("IsLocked"), "checked.png", "unchecked.png"))%>' />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkLocked" runat="server" class="mobile-switch" />
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Level11" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Left" UniqueName="RoleLevel" DataField="RoleLevelTranslation"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" SortExpression="RoleLevel"
                                            GroupByExpression="RoleLevelTranslation [GridColumn_RoleLevel] Group By RoleLevelTranslation ASC">
                                            <ItemTemplate>
                                                <%# CStr(IIf(Eval("RoleLevelTranslation") IsNot Nothing, Eval("RoleLevelTranslation"), String.Empty))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblRoleLevel" runat="server"></asp:Label>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="RoleName*" HeaderStyle-Width="80px" UniqueName="Role" DataField="RoleName"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" SortExpression="RoleName"
                                            GroupByExpression="RoleName [GridColumn_Role] Group By RoleName ASC">
                                            <ItemTemplate>
                                                <%#Container.DataItem("RoleName")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtRoleName" MaxLength="255" runat="server" Text='<%# Eval("RoleName") %>'
                                                    Width="100%" meta:resourcekey="txtRoleName"></asp:TextBox>
                                                <%--<asp:Label ID="lblUniqueRole" runat="server" CssClass="Validator" Text="Role name must be unique.11" Visible="false"
                                        meta:resourcekey="lblUniqueRole"></asp:Label>--%>
                                                <asp:RequiredFieldValidator ID="rfvRoleName" ControlToValidate="txtRoleName" Display="Dynamic"
                                                    runat="server" CssClass="Validator" ForeColor="" meta:resourcekey="rfvRoleName"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="User*" HeaderStyle-Width="80px" UniqueName="FullName" DataField="FullName"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            SortExpression="FullName" GroupByExpression="FullName [GridColumn_FullName] Group By FullName ASC" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("FullName") = String.Empty, "&nbsp;", Container.DataItem("FullName"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlFullName" runat="server" meta:resourcekey="ddlFullName" Width="100%" NoWrap="True"
                                                    CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>" DropDownWidth="250px" Height="250px">
                                                </telerik:RadComboBox>
                                                <%--<asp:CompareValidator ID="rfvFullName" Display="Dynamic" ControlToValidate="ddlFullName"
                                        runat="server" ValueToCompare="0" CssClass="Validator" ForeColor="" Operator="GreaterThan"
                                        meta:resourcekey="rfvFullName"></asp:CompareValidator>--%>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Delagate" HeaderStyle-Width="50px" UniqueName="Delegate" DataField="Delegate"
                                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            SortExpression="Delegate" GroupByExpression="Delegate [GridColumn_Delegate] Group By Delegate ASC" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <%# Eval("Delegate")%>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <%# Eval("Delegate")%>&nbsp;
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                SecurityButtonType="ItemMode_Edit"
                                                Visible='<%# rdgRoles.EditIndexes.Count = 0 And (Not rdgRoles.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit"
                                                Visible='<%# rdgRoles.EditIndexes.Count > 0 %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                SecurityButtonType="AddEditMode_Add"
                                                Visible='<%# rdgRoles.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                SecurityButtonType="AddEditMode"
                                                Visible='<%# rdgRoles.EditIndexes.Count > 0 Or rdgRoles.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                SecurityButtonType="ItemMode_Edit"
                                                Visible='<%# rdgRoles.EditIndexes.Count = 0 And (Not rdgRoles.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="Javascript:return DeleteSelectedRoles();" CssClass="GridCmdDeleteRows"
                                                SecurityButtonType="ItemMode_Edit"
                                                Visible='<%# rdgRoles.EditIndexes.Count = 0 And (Not rdgRoles.MasterTableView.IsItemInserted) %>'
                                                runat="server" CommandName="DeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode"
                                                Visible='<%# rdgRoles.EditIndexes.Count = 0 And (Not rdgRoles.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode"
                                                EnableRoundedCorners="true" EnableAutoScroll="true"
                                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                EnableShadows="true" CausesValidation="false"
                                                Visible="true">
                                            </telerik:RadMenu>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true"
                                    Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true" AllowDragToGroup="true">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-right col-4-RolesOnMobile" style="padding-bottom:24px;">
            <fieldset class="MarginTopOnMobileRoles">
                <legend>
                    <asp:Label ID="lblOptions" runat="server" Text="OPTIONS" CssClass="legend" meta:resourcekey="lblOptions"></asp:Label>
                </legend>
                <table cellpadding="0" cellspacing="0" class="colTable">
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td width="95%" style="color: #666666;">
                                        <asp:Label ID="lblMultipleRolesToUser" runat="server" Text="Allow users in multiple roles" meta:resourcekey="lblMultipleRolesToUser"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblErrorMultipleUsers" runat="server" CssClass="Validator" EnableViewState="False" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkMultipleRolesToUser" runat="server" class="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="trReturnEmailAddress" runat="server">
                        <td>
                            <table width="100%">
                                <tr>
                                    <td width="95%" style="color: #666666;">
                                        <asp:Label ID="lblReturnEmailAddress" runat="server" Text="Return Email Address" meta:resourcekey="lblReturnEmailAddress" Visible="false"></asp:Label>
                                        <br />
                                        <asp:RegularExpressionValidator ID="revReturnEmailAddress" meta:resourceKey="revReturnEmailAddress" CssClass="Validator" ControlToValidate="txtReturnEmailAddress"
                                            ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            runat="server" ErrorMessage="Invalid Email." ValidationGroup="Save" Display="Dynamic" Visible="false">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtReturnEmailAddress" runat="server" Width="100%" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td width="95%" style="color: #666666;">
                                        <asp:Label ID="lblRoleMoreThanOnce" runat="server" Text="Allow roles to be used more than once in a workflow" meta:resourcekey="lblRoleMoreThanOnce"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblErrorMultipleRoles" runat="server" CssClass="Validator" EnableViewState="False" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkRoleMoreThanOnce" runat="server" class="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblError" runat="server" CssClass="Validator" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div runat="server" id="pnlWarning" class="Top Padding7 Hide" style="background-color: #fdd997; border: solid 1px black">
                                <span style="padding-left: 6px; position: absolute">
                                    <asp:Label ID="lblWarning" runat="server" meta:resourcekey="lblWarning"></asp:Label>
                                </span>
                            </div>
                            <asp:Label CssClass="Validator" ID="lblGridError" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblDocManSettings" runat="server" Text="Document Manager Settings" CssClass="legend" meta:resourcekey="lblDocManSettings"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth" style="width: 160px !important;">
                                            <asp:Label ID="lblUser" runat="server" meta:resourcekey="lblUser" Text="User"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width: 240px !important;">
                                            <telerik:RadComboBox Width="100%" runat="server" ID="ddlDocumentManager" Height="250px"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:CompareValidator ID="rfvDocumentManager" ValidationGroup="Save" ControlToValidate="ddlDocumentManager"
                                                runat="server" ValueToCompare="0" CssClass="Validator" ForeColor="" Operator="GreaterThan"
                                                meta:resourcekey="rfvDocumentManager" Display="Dynamic">
                                            </asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCC" runat="server" Text="CC" meta:resourcekey="lblCC"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox Width="100%" runat="server" ID="ddlCC" Height="250px"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="width: 100%; height: 344px; overflow: auto; border: 1px solid #666666;">
                                <telerik:RadTreeView ID="RadTreeView11" runat="server" CheckBoxes="true" TriStateCheckBoxes="true">
                                    <Nodes>
                                        <telerik:RadTreeNode meta:resourcekey="lblNotifyOnAll" Text="Notify On All:">
                                            <Nodes>
                                                <telerik:RadTreeNode ID="chkNotifyOnSubmissions" runat="server" Text="Submissions" meta:resourcekey="chkNotifyOnSubmissions"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnApproval" runat="server" Text="Approvals" meta:resourcekey="chkNotifyOnApprovals"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnBranches" runat="server" Text="Branches" meta:resourcekey="chkNotifyOnBranches"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnReturns" runat="server" Text="Returns" meta:resourcekey="chkNotifyOnReturns"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnRejects" runat="server" Text="Rejects" meta:resourcekey="chkNotifyOnRejects"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnWithdrawals" runat="server" Text="Withdrawals" meta:resourcekey="chkNotifyOnWithdrawals"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnFinalApproval" runat="server" Text="Final Approval" meta:resourcekey="chkNotifyOnFinalApproval"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnDelegates" runat="server" Text="Delegates" meta:resourcekey="chkNotifyOnDelegates"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkNotifyOnOverdueSteps" runat="server" Text="Overdue Steps" meta:resourcekey="chkNotifyOnOverdueSteps"></telerik:RadTreeNode>
                                            </Nodes>
                                        </telerik:RadTreeNode>
                                        <telerik:RadTreeNode meta:resourcekey="lblCan" Text="Can:">
                                            <Nodes>
                                                <telerik:RadTreeNode ID="chkCanEditRecords" runat="server" Text="Edit Records" meta:resourcekey="chkCanEditRecords"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkCanEditWorkflow" runat="server" Text="Edit Workflow" meta:resourcekey="chkCanEditWorkflow"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkCanEditNotes" runat="server" Text="Edit Notes" meta:resourcekey="chkCanEditNotes"></telerik:RadTreeNode>
                                              <telerik:RadTreeNode ID="chkCanEditAttachments" runat="server" Text="Edit Attachments" meta:resourcekey="chkCanEditAttachments"></telerik:RadTreeNode>
                                                <telerik:RadTreeNode ID="chkCanDeleteWorkflow" runat="server" Text="Delete Workflow" meta:resourcekey="chkCanDeleteWorkflow"></telerik:RadTreeNode>
                                            </Nodes>
                                        </telerik:RadTreeNode>
                                    </Nodes>
                                </telerik:RadTreeView>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
</div>

