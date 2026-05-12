<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ReportsManager.aspx.vb" Inherits="Website.ReportsManager" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
        <tr valign="top" class="ToolBar">
            <td class="Padding7" style="width: 293px;padding:5px;">
                <asp:Label ID="lblReportManager" runat="server" Text="Report manager" CssClass="Bold"></asp:Label>
            </td> 
            <td>
            
            </td>          
        </tr>
    </table>
    <table style="width: 100%; padding: 0px;" cellpadding="3" cellspacing="0">
        <tr>
            <td valign="top" style="width: 20%" class="AllLightBlueBorder">
                <telerik:RadTreeView ID="treeReports" runat="server" Skin="Default" Width="300" Height="600px"
                    MultipleSelect="true" EnableDragAndDrop="true" AllowNodeEditing="false"  
                    OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                    OnClientContextMenuShowing="onClientContextMenuShowing" CausesValidation="false">
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu" >
                            <Items>
                                <telerik:RadMenuItem Value="Rename" Text="Rename"  EnableImageSprite="true" CssClass="MenuRename">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="NewFile" Text="New Report"  EnableImageSprite="true" CssClass="MenuAdd">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="NewFolder" Text="New Folder"  EnableImageSprite="true" CssClass="MenuAdd">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="Delete" Text="Delete"  EnableImageSprite="true" CssClass="MenuDelete">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
            </td>
            <td valign="top" style="width: 80%" class="AllLightBlueBorder">
                <asp:Panel ID="pnlReportDetail" runat="server">
                    <table style="width: 100%" cellpadding="1" cellspacing="0">
                        <tr>
                            <td style="width: 15%" nowrap>
                                <asp:Label ID="lblReportName" runat="server" Text="Report Name*"></asp:Label>
                            </td>
                            <td style="width: 35%" >
                                <asp:TextBox ID="txtReportName" MaxLength="100" runat="server" Width="85%"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtReportName" runat="server" ID="rfvReportName"
                                    ErrorMessage="<br>Enter Report Name" meta:resourcekey="rfvReportName" Enabled="true" Display="Dynamic" CssClass="Validator"
                                    ForeColor=""></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 15%" nowrap >
                                <asp:Label ID="lblReportType" runat="server" Text="Report Type"></asp:Label>
                            </td>
                            <td style="width: 35%" >
                                <telerik:RadComboBox ID="ddlReportTypes" OnClientSelectedIndexChanged="DisplayReportType"
                                    runat="server" AllowCustomText="true" MarkFirstMatch="True" Skin="Default" CloseDropDownOnBlur="true"
                                    Height="100" Width="200">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    <Items>
                                        <telerik:RadComboBoxItem Text="SQL Report" Value="SQLReport" /> 
                                        <telerik:RadComboBoxItem Text="Crystal Report" Value="CrystalReport" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap>
                                <asp:Label ID="lblFullFilePath" runat="server" Text="Folder Path"></asp:Label>
                            </td>
                            <td colspan="3" >
                                <asp:HyperLink ID="hliFullFilePath" runat="server" SecurityButtonType="Edit" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr id="trCrystalReport" runat="server">
                            <td colspan="4">
                                <table style="width: 100%" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td nowrap>
                                            <asp:Label ID="lblUploadFile" runat="server" Text="Upload File"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <input type="file" style="width: 600px" runat="server" id="flReportFile" />
                                            <%--<asp:ImageButton ID="imgUploadFiles" CausesValidation="false" runat="server" AlternateText="Upload File"
                                                ImageUrl="Images/Global/up.png" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%" nowrap>
                                            <asp:Label ID="lblFileName" runat="server" Text="File Name"></asp:Label>
                                        </td>
                                        <td style="width: 35%">
                                            <asp:TextBox ID="txtFileName" ReadOnly runat="server" Width="85%"></asp:TextBox>
                                        </td>
                                        <td style="width: 15%" nowrap>
                                            <asp:Label ID="lblDatabase" runat="server" Text="Database Name"></asp:Label>
                                        </td>
                                        <td style="width: 35%">
                                            <telerik:RadComboBox ID="ddlDatabaseName" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                                Skin="Default" CloseDropDownOnBlur="true" Height="100" Width="85%">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkEnableParameterPrompt" Text="Enable Parameter Prompt" runat="server" />
                                        </td>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkEnableDatabaseLogonPrompt" Text="Enable Database Logon Prompt"
                                                runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trSqlReport" runat="server">
                            <td colspan="4">
                                <table style="width: 100%" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td style="width: 15%" nowrap>
                                            <asp:Label ID="lblServerURL" runat="server" Text="Server URL"></asp:Label>
                                        </td>
                                        <td style="width: 35%" >
                                            <asp:TextBox ID="txtServerURL" MaxLength="1000" runat="server" Width="85%"></asp:TextBox>
         <asp:RequiredFieldValidator ControlToValidate="txtServerURL" runat="server" ID="rfvServerURL"
                                    ErrorMessage="<br>Enter Server URL" Enabled="true" meta:resourcekey="rfvServerURL" Display="Dynamic" CssClass="Validator"
                                    ForeColor=""></asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 15%" nowrap>
                                            <asp:Label ID="lblPath" runat="server" Text="Path"></asp:Label>
                                        </td>
                                        <td style="width: 35%" >
                                            <asp:TextBox ID="txtPath" MaxLength="1000" runat="server" Width="85%"></asp:TextBox>
                 <asp:RequiredFieldValidator ControlToValidate="txtPath" runat="server" ID="rfvPath"
                                    ErrorMessage="<br>Enter Path" Enabled="true" meta:resourcekey="rfvPath" Display="Dynamic" CssClass="Validator"
                                    ForeColor=""></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trParameters" runat="server">
                            <td colspan="4">
                                Project Parameter multiple select goes here
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table style="width: 99%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="15%" valign="top">
                                                <asp:Button ID="btnRegenerateParameters" CssClass="LargeButton" runat="server" Text="Regenerate Parameters" />
                                        </td>
                                        <td width="15%" valign="top">
                                                <asp:Button ID="btnPreview" runat="server" Text="Preview" />
                                        </td>
                                        <td width="15%" valign="top">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" />
                                        </td>
                                        <td width="55%" valign="top">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
