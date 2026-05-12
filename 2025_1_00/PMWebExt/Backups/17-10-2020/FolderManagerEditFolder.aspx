<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="FolderManagerEditFolder.aspx.vb" Inherits="Website.FolderManagerEditFolder" %>

<%@ Register Src="FileManagerPermissions.ascx" TagName="FileManagerPermissions" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .documentTabs{
            top: 50px !important;
        }
    </style>
    <telerik:RadCodeBlock runat="server">
<script type="text/javascript">
        function OnTypeChanged(sender, args) {
            var value = sender.get_value();
            var row = $("[id=" + sender.get_id() + "]").parents("tr:first");
            var ddlLists = row.find("[id$='ddlLists']");
            if (value == '4') {
                ddlLists.show();
                ddlLists.removeClass("Hide");
            } else {
                ddlLists.hide();
            }
        }

        function CheckViewRight(chkViewOnly) {
            var tr = $(chkViewOnly).parents("tr:first");
            if (!chkViewOnly.checked) {
                tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                tr.find("input[id $= 'chkManageFolder']")[0].checked = false;
                tr.find("input[id $= 'chkUploadFiles']")[0].checked = false;
                tr.find("input[id $= 'chkDeleteFiles']")[0].checked = false;
                tr.find("input[id $= 'chkEditFiles']")[0].checked = false;
                tr.find("input[id $= 'chkEditPermissions']")[0].checked = false;

            }
        }


        function CheckRight(chkRight) {
            var tr = $(chkRight).parents("tr:first");
            var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
            var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
            var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
            var chkUploadFiles = tr.find("input[id $= 'chkUploadFiles']")[0];
            var chkEditFiles = tr.find("input[id $= 'chkEditFiles']")[0];
            var chkDeleteFiles = tr.find("input[id $= 'chkDeleteFiles']")[0];
            var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
            if (chkRight.checked) {
                chkViewOnly.checked = true;
                if (chkManageFolder.checked && chkUploadFiles.checked && chkEditFiles.checked && chkDeleteFiles.checked && chkEditPermissions.checked)
                    chkFullControl.checked = true;
            } else {
                chkFullControl.checked = false;
            }
        }

        function CheckFullControlRight(chkFullControl) {
            var tr = $(chkFullControl).parents("tr:first");
            var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
            var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
            var chkUploadFiles = tr.find("input[id $= 'chkUploadFiles']")[0];
            var chkEditFiles = tr.find("input[id $= 'chkEditFiles']")[0];
            var chkDeleteFiles = tr.find("input[id $= 'chkDeleteFiles']")[0];
            var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
            if (chkFullControl.checked) {
                chkViewOnly.checked = true;
                chkManageFolder.checked = true;
                chkUploadFiles.checked = true;
                chkEditFiles.checked = true;
                chkDeleteFiles.checked = true;
                chkEditPermissions.checked = true;
            } else {
                chkViewOnly.checked = false;
                chkManageFolder.checked = false;
                chkUploadFiles.checked = false;
                chkEditFiles.checked = false;
                chkDeleteFiles.checked = false;
                chkEditPermissions.checked = false;
            }
        }
    </script>
     <style>
        .PMMainPage .RadioCss input[type="radio" i]{position:relative;}
        .EditFolderToolbar .rtsLevel.rtsLevel1{width:100% !important}
        .EditFolderToolbar .rtsLI{width:50% !important}
    </style>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="tbsDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mlpFolderManager" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" BackgroundPosition="Center" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar"  runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                                <telerik:RadTabStrip ID="tbsDocument" runat="server" CausesValidation="False" EnableViewState="True"
                                    MultiPageID="mlpFolderManager" OnClientTabSelecting="onTabSelecting" CssClass="documentTabs EditFolderToolbar"
                                    OnTabClick="tbsDocument_TabClick" SelectedIndex="0" Skin="Default" Width="100%">
                                    <Tabs>
                                        <telerik:RadTab Selected="True" Text="General" Value="General" />
                                        <telerik:RadTab Text="Permissions" Value="Permissions" />
                                    </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage ID="mlpFolderManager" runat="server" meta:resourcekey="mlpFolderManagerResource1"
                                    RenderSelectedPageOnly="True" SelectedIndex="0" Width="99%" CssClass="documentMultiPages">
                                    <telerik:RadPageView ID="pvGeneral" runat="server" meta:resourcekey="pvGeneralResource1">
                                        <div class="PMMainPage">
                                            <div class="row">
                                                <div class="col-4 col-4-left">
                                                    <table class="colTable">
                                                        <tr style="display:none">
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblPath" runat="server" Text="Path" meta:Resourcekey="lblPath"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <asp:TextBox ID="txtPath" runat="server" Enabled="False" Width="100%"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblFolderName" runat="server" Text="Folder Name" meta:Resourcekey="lblFolderName"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <asp:TextBox ID="txtFolderName" runat="server" Width="100%"></asp:TextBox>
                                                                <asp:RequiredFieldValidator runat="server" ID="rfvFolderName" CssClass="Validator" ErrorMessage="Required"
                                                                    ValidationGroup="Save" ControlToValidate="txtFolderName" Display="Dynamic"
                                                                    meta:resourcekey="rfvFolderName"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="ErrorTR">
                                                            <td colspan="2">
                                                                <div id="ErrorLBL" runat="server" style="width: 100%; position: absolute; color: red; font-weight: bold;"></div>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblType" runat="server" Text="Default Type" meta:Resourcekey="lblType"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" AutoPostBack="false" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblCategory" runat="server" Text="Default Category" meta:Resourcekey="lblCategory"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" AutoPostBack="false" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblEnableVersions" runat="server" Text="Enable Versions" meta:Resourcekey="lblEnableVersions"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <asp:CheckBox runat="server" ID="chkEnableVersions" AutoPostBack="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="row" style="padding-top:0px">
                                                <div class="col-4 col-4-left">                                                  
                                                                <fieldset>
                                                                    <legend>
                                                                        <asp:Label runat="server" ID="lblDuplicateFile" Text="When Adding Duplicate Files..." meta:resourcekey="lblDuplicateFile"></asp:Label>
                                                                    </legend>
                                                                    <table class="colTable">
                                                                        <tr>
                                                                            <td style="width:18px;padding-right:15px">
                                                                                <asp:RadioButton runat="server" ID="rbnOverwriteDuplicateFile" CssClass="RadioCss" style="position:relative"
                                                                                    GroupName="DuplicateFile" AutoPostBack="false" />  
                                                                            </td>
                                                                            <td style="width:100%">
                                                                                <asp:Label ID="lblOverWriteDuplicateFile" runat="server" Text="Overwrite Duplicate files. (Does not apply to Checked Out files or to files in Workflow.)" style="text-transform:uppercase; color: #666666;"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width:18px;padding-right:15px">
                                                                                <asp:RadioButton runat="server" ID="rbnSkipDuplicateFile" CssClass="RadioCss" style="position:relative"
                                                                                     GroupName="DuplicateFile" AutoPostBack="false" />
                                                                            </td>
                                                                            <td style="width:100%">
                                                                                <asp:Label ID="lblSkipDuplicateFile" runat="server" Text="Skip duplicate files" style="text-transform:uppercase; color: #666666;"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>  
                                                    </div>
                                                </div>
                                            <div class="row" style="padding-top:0px">
                                                <div class="col-12">
                                                    <fieldset>
                                                                    <legend>
                                                                        <asp:Label runat="server" ID="lblAttributes" Text=" Define Attributes" meta:resourcekey="lblAttributes"></asp:Label></legend>
                                                                    <telerik:RadGrid ID="rdgFolderAttributes" runat="server" AllowMultiRowEdit="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                                        AllowMultiRowSelection="True" AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" UseEditFormInMobile="true"
                                                                        ShowStatusBar="True" Width="100%">
                                                                        <HeaderStyle Font-Size="8pt" />
                                                                        <ClientSettings Selecting-AllowRowSelect="true" AllowRowsDragDrop="true" ClientEvents-OnRowDblClick="RowDblClick">
                                                                            <Selecting AllowRowSelect="True" />
                                                                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                                                        </ClientSettings>
                                                                        <MasterTableView CommandItemDisplay="Top" CssClass="MaxWidth" DataKeyNames="Id" EditMode="InPlace">
                                                                            <CommandItemStyle />
                                                                            <CommandItemTemplate>
                                                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                                    SecurityButtonType="ItemMode_Edit" Visible="<%# rdgFolderAttributes.EditIndexes.Count = 0 And (Not rdgFolderAttributes.MasterTableView.IsItemInserted) %>">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label runat="server" ID="lblEditSelected" Text="Edit Selected Lines"></asp:Label>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                                                    SecurityButtonType="ItemMode_Add" Visible="<%# rdgFolderAttributes.EditIndexes.Count = 0 And (Not rdgFolderAttributes.MasterTableView.IsItemInserted) %>">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label runat="server" ID="lblAdd" Text="Add Line"></asp:Label>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                                                    SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                                                    Visible="<%# rdgFolderAttributes.EditIndexes.Count = 0 And (Not rdgFolderAttributes.MasterTableView.IsItemInserted) %>">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label
                                                                                        runat="server" ID="lblDelete"></asp:Label>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                                                    meta:resourcekey="btnSaveResource1" ValidationGroup="SaveRow"
                                                                                    Visible="<%# rdgFolderAttributes.MasterTableView.IsItemInserted %>" CausesValidation="true">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label runat="server" ID="lblSave"></asp:Label>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="PerformUpdate" CssClass="GridCmdPerformUpdate"
                                                                                    Visible="<%# rdgFolderAttributes.EditIndexes.Count > 0 %>" ValidationGroup="SaveRow" CausesValidation="true">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label Text="" runat="server" ID="lblUpdate"></asp:Label>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                                                    Visible="<%# rdgFolderAttributes.EditIndexes.Count > 0 OrElse rdgFolderAttributes.MasterTableView.IsItemInserted %>">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label runat="server" ID="lblCancel" Text="Cancel"></asp:Label>
                                                                                </asp:LinkButton>
                                                                            </CommandItemTemplate>
                                                                            <Columns>
                                                                                <telerik:GridTemplateColumn HeaderText="FolderId" ItemStyle-HorizontalAlign="Right"
                                                                                    Visible="false">
                                                                                    <ItemTemplate>
                                                                                        <asp:TextBox ID="txtAttributeFolderID" runat="server" CssClass="Right" Enabled="false"
                                                                                            Text='<%#Eval("FolderId")%>' Width="50px"></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                                                                    SortExpression="LineNumber" Groupable="false" Reorderable="false" AllowFiltering="false">
                                                                                    <ItemTemplate>
                                                                                        <span>
                                                                                            <%#Container.DataItem("LineNumber").ToString%></span>
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <%#Eval("LineNumber").ToString%>
                                                                                    </EditItemTemplate>
                                                                                    <HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
                                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn UniqueName="Attribute" HeaderText="<%$Resources:GridColumn_Attribute %>"
                                                                                    ItemStyle-Width="120px" HeaderStyle-Width="120px">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblAttributeName" runat="server" Text='<%#Eval("AttributeName")%>' />
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <asp:TextBox ID="txtAttributeName" MaxLength="500" runat="server" Text='<%#Eval("AttributeName")%>'
                                                                                            Width="98%"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="rfvAttributeName" ControlToValidate="txtAttributeName" Display="Dynamic" ValidationGroup="SaveRow"
                                                                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                                                                    </EditItemTemplate>
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GridColumn_Type %>" UniqueName="Type"
                                                                                    ItemStyle-Width="250px" HeaderStyle-Width="250px">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblAttributeType" runat="server" Text=""></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <telerik:RadComboBox ID="ddlAttributeTypes" runat="server" OnClientSelectedIndexChanged="OnTypeChanged"
                                                                                                        Skin="Default" Width="80px">
                                                                                                    </telerik:RadComboBox>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <telerik:RadComboBox ID="ddlLists" AllowCustomText="false" runat="server" CssClass='<%#IIf(ParseInt(Eval("AttributeTypeId")) = 4, "", "Hide")%>'
                                                                                                        Skin="Default" CloseDropDownOnBlur="true" Height="350px" Width="160px" DropDownWidth="200px"
                                                                                                        Filter="Contains" MarkFirstMatch="true" NoWrap="true" EnableLoadOnDemand="True"
                                                                                                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                                                        ShowToggleImage="true">
                                                                                                    </telerik:RadComboBox>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </EditItemTemplate>
                                                                                    <ItemStyle Wrap="False" />
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GridColumn_Required %>" UniqueName="Required" ItemStyle-Width="50px" HeaderStyle-Width="50px">
                                                                                    <ItemTemplate>
                                                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsRequired"), "checked.png", "unchecked.png")) %>' />
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <asp:CheckBox ID="chkRequired" runat="server" Checked='<%#ParseBool(Eval("IsRequired"))%>' />
                                                                                    </EditItemTemplate>
                                                                                    <ItemStyle />
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GridColumn_Unique %>" UniqueName="Unique"
                                                                                    ItemStyle-Width="50px" HeaderStyle-Width="50px">
                                                                                    <ItemTemplate>
                                                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsUnique"), "checked.png", "unchecked.png")) %>' />
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <asp:CheckBox ID="chkUnique" runat="server" Checked='<%#ParseBool(Eval("IsUnique"))%>' />
                                                                                    </EditItemTemplate>
                                                                                    <ItemStyle />
                                                                                </telerik:GridTemplateColumn>
                                                                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GridColumn_ShowInGrid %>" UniqueName="ShowInGrid"
                                                                                    ItemStyle-Width="50px" HeaderStyle-Width="50px">
                                                                                    <ItemTemplate>
                                                                                        <img src='Images/Global/<%# CStr(IIf(Eval("ShowInGrid"), "checked.png", "unchecked.png")) %>' />
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <asp:CheckBox ID="chkShowInGrid" runat="server" Checked='<%#ParseBool(Eval("ShowInGrid"))%>' />
                                                                                    </EditItemTemplate>
                                                                                    <ItemStyle />
                                                                                </telerik:GridTemplateColumn>
                                                                            </Columns>
                                                                            <NoRecordsTemplate>
                                                                                <table style="height: 200px; width: 100%">
                                                                                    <tr>
                                                                                        <td align="center" valign="middle">
                                                                                            <asp:Label ID="lblNoAvailableAttributes" meta:Resourcekey="lblNoAvailableAttributes"
                                                                                                runat="server" Text="No Available Attributes for this folder."></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </NoRecordsTemplate>
                                                                        </MasterTableView>
                                                                    </telerik:RadGrid>
                                                                </fieldset>
                                                </div>
                                            </div>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView ID="pvPermissions" runat="server">
                                        <uc1:FileManagerPermissions ID="FileManagerPermissions1" runat="server" />
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                           
    </form>
</body>
</html>
