<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FilesAttributes.ascx.vb" Inherits="Website.FilesAttributes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc1" %>
<style type="text/css">
    .Width100 {
        width: 100% !important;
    }
</style>
<telerik:RadAjaxManagerProxy ID="PmAjaxManager" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAttributes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAttributes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <Calendar runat="server" Width="200px"></Calendar>
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<table class="ToolBar" style="width: 100%; position: static !important;" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table style="width: 100%; table-layout: fixed" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd  Recent" style="width: 24px;">
                        <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                        </asp:LinkButton>
                    </td>
                    <td class="ToolbarTd" style="width: calc(100% - 24px);">
                        <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="DetailCommandClicked" runat="server" Skin="Default" AutoPostBack="True" Width="100%">
                            <Items>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="DMSearch" ImageUrl="Images/ToolBar/lookup.png"
                                    Value="DMSearch" PostBackUrl="SearchDocument.aspx?O=59">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                <%--   <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="Upload" AccessKey="n" CausesValidation="false" PostBack="false">
                                    </telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                    CommandName="Save" ValidationGroup="Save" Value="Save" CausesValidation="true" AccessKey="s">
                                </telerik:RadToolBarButton>
                                <%-- <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete">
                                    </telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton IsSeparator="true">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/URL.png" PostBack="false"
                                    CommandName="CopyURL" Value="Save" CausesValidation="false">
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div class="PMMainPage">
    <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                    </td>

                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:Resourcekey="lblCategory"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblVersion" runat="server" Text="Version" meta:Resourcekey="lblVersion"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtVersion" CssClass="Integer" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:Resourcekey="lblStatus"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <uc1:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" width="90%" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="width: 100%;" valign="top">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblAttributes" Text="Attributes" meta:Resourcekey="lblAttributes"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgAttributes" ShowGroupPanel="false" runat="server" HeaderStyle-Font-Size="8" ClientSettings-Scrolling-SaveScrollPosition="true" Setidth="true"
                                AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" FitParentContainer="true"
                                ShowStatusBar="false" Width="100%" UseEditFormInMobile="true" ClientSettings-Scrolling-AllowScroll="true">
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id,AttributeId" CommandItemDisplay="Top" EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="140px"
                                            SortExpression="AttributeName" UniqueName="Attribute" HeaderText="Attribute">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttributeName" runat="server" Text='<%#Eval("AttributeName")%>'></asp:Label><%#CStr(IIf(Eval("IsRequired"), "*", ""))%><%#CStr(IIf(Eval("IsUnique"), "(u)", ""))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblEditAttributeName" runat="server" Text='<%#Eval("AttributeName")%>'></asp:Label><%#CStr(IIf(Eval("IsRequired"), "*", ""))%><%#CStr(IIf(Eval("IsUnique"), "(u)", ""))%>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="Value" HeaderText="Value" HeaderStyle-Width="150px" SortExpression="AttributeValue">
                                            <ItemTemplate>
                                                <asp:PlaceHolder ID="plcLabel" runat="server"></asp:PlaceHolder>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlAttribute" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                    NoWrap="True" Skin="Default" Width="100%" AllowCustomText="True" Visible="false">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="rfvOptionAttribute" ControlToValidate="ddlValues" meta:Resourcekey="rfvOptionAttribute"
                                                    runat="server" ErrorMessage="Required" Display="Dynamic" CssClass="Validator" ValidationGroup="SaveAttr">
                                                </asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtAttributeValue" MaxLength="500" Width="99%" runat="server"></asp:TextBox>
                                                <asp:TextBox ID="txtAttributeDate" MaxLength="100" Style="text-align: right" Visible="false" Width="99%" onclick="showFileAttributeDatePopup(this, event, true);" onfocus="showFileAttributeDatePopup(this, event, true);"
                                                    onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                                <asp:CheckBox ID="chkAttributeValue" Visible="false" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfvAttribute" Display="Dynamic" ControlToValidate="txtAttributeValue"
                                                    runat="server" ErrorMessage="Required" CssClass="Validator" meta:Resourcekey="rfvAttribute" ValidationGroup="SaveAttr">
                                                </asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="rfvAttributeDate" Display="Dynamic" ControlToValidate="txtAttributeDate"
                                                    runat="server" CssClass="Validator" meta:Resourcekey="rfvAttribute" ValidationGroup="SaveAttr">
                                                </asp:RequiredFieldValidator>
                                                <asp:Label ID="lblUnique" runat="server" Text="Should be unique in this folder" CssClass="Validator" Visible="False" meta:Resourcekey="lblUnique"></asp:Label>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <table cellpadding="2" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                                    CommandName="EditRows" Visible='<%# rdgAttributes.EditIndexes.Count = 0 %>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lbledit" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="SaveAttr" CssClass="GridCmdUpdateEdited"
                                                                    CommandName="UpdateEdited" Visible='<%# rdgAttributes.EditIndexes.Count > 0 %>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                                    CommandName="CancelAll" Visible='<%# rdgAttributes.EditIndexes.Count > 0 %>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                        </table>

                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="false" ClientEvents-OnRowDblClick="RowDblClick">
                                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4 col-4-middle">
            <table class="colTable">
                <tr>
                    <td>
                        <asp:Panel ID="pnlPreview" runat="server" Style="width: 100%">
                            <img id="imgPreview" runat="server" src="Images/Global/WhiteDot.gif" class="Width100" />
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlPreviewUnavailable" runat="server" Style="padding-left: 5px; width: 100%; height: 260px; border: 1px solid gray; text-align: center; line-height: 260px;">
                            <asp:Label runat="server" ID="lblPreviewUnavailabe" meta:Resourcekey="lblPreviewUnavailabe" Text="Preview Unavailable"></asp:Label>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
