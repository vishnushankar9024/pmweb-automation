<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UserManagement.ascx.vb"
    Inherits="Website.UserManagement" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>


<script language="javascript" type="text/javascript" src="JS/User/AdministrationControl.js"></script>

<style type="text/css">
    .height650
    {
        height: 550px;
    }
    
    .height550
    {
        height: 450px;
    }
    
    .headerHeight
    {
        height:40px;
    }
    
    .columnLeft
    {
        width: 350px;
    }
    .columnRigth
    {
        width: 450px;
    }

    
</style>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnCreateUser">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="dlUserList" />
            </UpdatedControls>
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="divUserMainInfo" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="dlUserList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="divUserMainInfo" />
            </UpdatedControls>
             <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="divButtons" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnNewUser" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="divUserMainInfo" />
                 <telerik:AjaxUpdatedControl ControlID="divButtons" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnUpdateUser">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="dlUserList" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

  <telerik:RadAjaxLoadingPanel ID="ldpUserManagement" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
  
<table id="tblMain" class="height650" cellpadding="0" cellspacing="0">
    <tr>
        <td>
        </td>
    </tr>
    <tr>
        <td valign="top">
            <table id="tblADBody" class="height650 " border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top">
                        <table id="tblListFilterAD" cellpadding="0" cellspacing="0" class="columnLeft height650">
                            <tr>
                                <td height="50" valign="top" class="headerHeight">
                                    <table class="columnLeft">
                                        <tr>
                                            <td style="width: 80px">
                                                &nbsp;Source :
                                            </td>
                                            <td style="text-align: left">
                                                <telerik:RadComboBox ID="ddlTypeUser" runat="server" Skin="Default" Width="200px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="Active Directory" Value="AD" />
                                                        <telerik:RadComboBoxItem runat="server" Text="Prolog" Value="Prolog" />
                                                        <telerik:RadComboBoxItem runat="server" Text="PMWeb" Value="PMWeb" 
                                                            Selected="True" />
                                                    </Items>
                                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                                &nbsp;<asp:Button ID="btnGetUsers" runat="server" Text="Get" Width="35px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="height550 AllLightBlueBorder">
                                            <asp:DataList ID="dlUserList" runat="server" CellPadding="4" ForeColor="#333333"
                                                CssClass="columnLeft">
                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <AlternatingItemStyle BackColor="White" />
                                                <ItemStyle BackColor="#EFF3FB" />
                                                <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <ItemTemplate>
                                                   <%#Container.DataItem("FirstName") + " " + Container.DataItem("LastName") + " (" + Container.DataItem("UserName") + ")"%>  
                                               
                                                    <asp:LinkButton runat="server" ID="btnEditUser" CommandName="EditUser" CommandArgument='<%#Container.DataItem("Id")%>'  CssClass="EditButton">
    					                                <span class="Icon"></span>
				                                    </asp:LinkButton>
                                                
                                                
                                                </ItemTemplate>
                                            </asp:DataList>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                    </td>
                    <td valign="top"  >
                    <div id ="divUserMainInfo" runat="server">
                        <table id="tblUserMainInfo" class="height650" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="42" class="headerHeight BottomLightBlueBorder TopLightBlueBorder" style="background-color:#d0d0d0">
                                 <p id="pUser" style="margin:5px">
                                        <b>User Information</b>
                                        <br />
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="height550 AllLightBlueBorder">
                                    <table>
                                        <tr>
                                            <td colspan="4">
                                                <asp:ValidationSummary ID="vsUserInformation" runat="server" BorderStyle="Solid"
                                                    BorderWidth="1px" HeaderText="Please complete the information to continue :"
                                                    ValidationGroup="UserInfo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp; First Name:</td>
                                                <td style="width: 200px">
                                                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    &nbsp;Last Name:
                                                </td>
                                                <td>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtLastName" runat="server" TabIndex="2"></asp:TextBox>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp; Username:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvDisplayName" runat="server" ControlToValidate="txtUsername"
                                                    ErrorMessage="Username" Text="*" ValidationGroup="UserInfo"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                &nbsp; Email:
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="UserInfo">*</asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr id="trPassword" runat="server">
                                            <td>
                                                &nbsp; Password:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                                                    ErrorMessage="Password" Text="*" ValidationGroup="UserInfo">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trConfirmPassword" runat="server">
                                            <td>
                                                &nbsp; Confirm Password:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                                    Display="Dynamic" ErrorMessage="Confirm Password" Text="*" ValidationGroup="UserInfo"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="cpPassword" runat="server" ControlToCompare="txtPassword"
                                                    ControlToValidate="txtConfirmPassword" ErrorMessage="*" ValidationGroup="UserInfo">*</asp:CompareValidator>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;
                                                </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="BottomLightBlueBorder TopLightBlueBorder" style="background-color:#d0d0d0">
                                                <p id="pUserType" style="margin:5px">
                                                    <b>User</b>
                                                    <asp:CustomValidator ID="cvUser" runat="server" ClientValidationFunction="cvUserCheck"
                                                        ErrorMessage="Choose at least one target to create the user." ValidationGroup="UserInfo">*</asp:CustomValidator>
                                                    <br />
                                                    Choose at least one of the specifyied source to create the user
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;&nbsp;<asp:CheckBox ID="chkAcitveDirectory" Text="Acitve Directory User" runat="server" class="mobile-switch"/>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:Label ID="lblADError" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;&nbsp;<asp:CheckBox ID="chkProlog" onclick="chkProlog_click(this)" Text="Prolog User"
                                                    runat="server" class="mobile-switch"/>
                                            </td>
                                            <td>
                                                <span id="ddlPrologUser" class="Hide">
                                                    <telerik:RadComboBox ID="ddlPrologUserListType" runat="server" Skin="Default" Width="150px">
                                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </span>
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:Label ID="lblPrologError" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;&nbsp;<asp:CheckBox ID="chkPMWeb" Text="PM Web" runat="server" class="mobile-switch" />
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:Label ID="lbPMError" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:HiddenField ID="hdnPmId" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="AllLightBlueBorder">
                       <div id="divBottomLeft" runat="server"> <asp:Button ID="btnNewUser" runat="server" Text="New User" Width="100px" /></div>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="AllLightBlueBorder">
                   <div id="divButtons" runat="server"> <asp:Button ID="btnCreateUser" runat="server" Text="Create User" ValidationGroup="UserInfo" Width="100px" />
                        <asp:Button ID="btnUpdateUser" runat="server" Text="Update User" ValidationGroup="UserInfo"
                            Visible="False" Width="100px" /> 
                         &nbsp;<asp:Button ID="btnDeleteUser" runat="server" Text="Delete User" Visible="false" Width="100px" />
                         &nbsp;<asp:Button ID="btnResetPassword" runat="server" Text="Reset Password"  Width="120px"
                           Visible="false"/>
                         </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
