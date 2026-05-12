<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="GenerateRecords.aspx.vb" Inherits="Website.GenerateRecords" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

   
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
    
    </script> 
</telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
        <telerik:AjaxSetting AjaxControlID="rtvFromRecordType">
            <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlMain" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgMapping">
            <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgMapping" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </ajaxsettings>
    </telerik:RadAjaxManagerProxy> 

    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
	MaxDate="12/31/2100" runat="server" Skin="Default">
	<ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

    <table style="width: 100%;" runat="server" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td align="left" style="padding-left: 10px;">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="false">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save"
                            ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlMain" runat="server">
    <table border="0">
        <tr>
            <td valign="top" style="width:310px; padding-right:10px">
                <fieldset>
                    <legend><asp:Label ID="lblFrom" runat="server" Text="From11" meta:ResourceKey="lblFrom"></asp:Label></legend>
                    <div style="overflow: auto; width:280px;border: 1px solid gray;border-width:1px 1px 1px 1px;height:600px">
                            <telerik:RadTreeView ID="rtvFromRecordType" runat="server" Skin="Default" CausesValidation="False">
                                <%--<ContextMenus>
                                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default">
                                        <Items>
                                            <telerik:RadMenuItem Value="SelectedComplete" meta:Resourcekey="MenuItem_SelectedComplete" Text="Selected Complete11" ImageUrl="~/Images/Toolbox/smallCheck.png"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="SelectedNotComplete" meta:Resourcekey="MenuItem_SelectedNotComplete"  Text="Selected Not Complete11"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AllComplete" meta:Resourcekey="MenuItem_AllComplete"  Text="All Complete11" ImageUrl="~/Images/Toolbox/smallCheck.png"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Value="AllNotComplete" meta:Resourcekey="MenuItem_AllNotComplete"  Text="All Not Complete11"></telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadTreeViewContextMenu>
                                </ContextMenus>--%>
                            </telerik:RadTreeView>
                        </div>
                </fieldset>
            </td>
            <td style="width:500px; padding-right:10px; padding-top:0;" valign="top">
                <table border="0">
                    <tr>
                        <td style="padding-top:0;" valign="top">
                            <fieldset style="height:47px">
                                <legend><asp:Label ID="lblTo" runat="server" Text="To11" meta:ResourceKey="lblTo"></asp:Label></legend>
                                <telerik:RadComboBox ID="ddlToRecordType" AutoPostBack="true" AllowCustomText="false" Filter="Contains"
                                    runat="server" Width="495px" Skin="Default" Style="font-size: 11px">
                                </telerik:RadComboBox>
                                <%--<div>
                                    <asp:CompareValidator ID="cmvToRecordType" runat="server"
                                        ControlToValidate="ddlToRecordType" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                        ForeColor="" Operator="GreaterThan" ValidationGroup="Save" ValueToCompare="0">
                                    </asp:CompareValidator>
                                </div>--%>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend><asp:Label ID="lblMapping" runat="server" Text="Mapping11" meta:ResourceKey="lblMapping"></asp:Label></legend>
                                    <telerik:RadGrid ID="rdgMapping" runat="server"  AutoGenerateColumns="False" AllowSorting="true"
                                        HeaderStyle-Font-Size="8" ShowStatusBar="true" PageSize="20" ShowFooter="false" >
                                        <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id"
                                            CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                            <Columns>
                                                <telerik:GridTemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblGenerateFrom" runat="server"></asp:Label>                           
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlFields" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFields_SelectedIndexChanged" Width="60%"></asp:DropDownList>&nbsp;&nbsp;
                                                        <asp:TextBox ID="txtCustomField" runat="server" Width="35%"></asp:TextBox> 
                                                        <asp:TextBox ID="txtCustomFieldDate" runat="server" Width="35%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);" onblur="parseDate(this, event);"></asp:TextBox>
                                                        <asp:TextBox ID="txtCustomFieldTime" runat="server" Width="35%"></asp:TextBox>
                                                        <asp:CheckBox ID="chkCustomField" runat="server" />
                                                        <asp:Label ID="lblRequired" CssClass="Validator" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="245px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblGenerateTo" runat="server"></asp:Label>                           
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFieldFriendlyName" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="150px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnSaveTemplates" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"  SecurityButtonType="ItemMode_Edit">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            </div>
                                        </CommandItemTemplate>
                                        </MasterTableView>
                                        <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="false" AllowRowsDragDrop="false">
                                            <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                        </ClientSettings>
                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    </telerik:RadGrid>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:300px; padding-top:0;" valign="top">
                <fieldset style="height:615px">
                    <legend><asp:Label ID="lblOptions" runat="server" Text="Options11" meta:ResourceKey="lblOptions"></asp:Label></legend>
                        <table style="padding-top:0;">
                            <tr>
                                <td style="width:150px;">
                                    <asp:Label ID="lblSubmitInWorkflow" runat="server" Text="Submit in Workflow11" meta:ResourceKey="lblSubmitInWorkflow"></asp:Label>
                                </td>
                                <td  align="right" style="width:150px;">
                                    <asp:CheckBox ID="chkSubmitInWorkflow" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSendLineItems" runat="server" Text="Send Line Items11" meta:ResourceKey="lblSendLineItems"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:CheckBox ID="chkSendLineItems" runat="server" />
                                </td>
                            </tr>
                            <%--<tr>
                                <td>
                                    <asp:Label ID="lblGroupLineItems" runat="server" Text="Group Line Items By11" meta:ResourceKey="lblGroupLineItems"></asp:Label>
                                </td>
                                <td align="right">
                                    <telerik:RadComboBox ID="ddlGroupLineItemsBy" runat="server" Width="145px" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                </td>
                            </tr>--%>
                        </table>
                </fieldset>
            </td>
        </tr>
    </table>
    </asp:Panel>
</asp:Content>
