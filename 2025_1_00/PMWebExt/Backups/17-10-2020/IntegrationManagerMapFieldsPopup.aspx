<%@ Page Language="vb" Title="Map Fields"  AutoEventWireup="false" CodeBehind="IntegrationManagerMapFieldsPopup.aspx.vb" Inherits="Website.IntegrationManagerMapFieldsPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

 <telerik:RadCodeBlock runat="server" ID="script1">
        <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>

        <script type="text/javascript">

            function DisplayMessage(innerText) {
                alert(innerText);
               
            }
       
       
    
        </script>

    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
       <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
          <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False">
        <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboFileType">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboFileType"/>
                 <telerik:AjaxUpdatedControl ControlID="txtDelimeter"/>
                  <telerik:AjaxUpdatedControl ControlID="lblDelimeter"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
    </telerik:RadAjaxManager>
        <table width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr>
            <td valign="middle" align="left" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Cssclass="popup-toolbar">
                    <Items>
                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save"
                            CommandName="Save" Value="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                            >
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
      </table>
        <div class="PMHeader documentTabs">
                <div class="row"> 
                     <fieldset>
            <legend>
             <asp:Label ID="lblfile" Text="File" runat="server" meta:resourcekey="lblfile"></asp:Label>
            </legend>
                         <div class="col-4">
                             <table class="colTable">
                                 <tr>
                                     <td class="labelWidth">
                                          <asp:Label ID="lblFileType" Text="Receive File Type" runat="server" meta:resourcekey="lblFileType"></asp:Label>
                                     </td>
                                     <td class="controlWidth">
                                          <telerik:RadComboBox ID="cboFileType" runat="server" AllowCustomText="false" MarkFirstMatch="false"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default" AutoPostBack="true">
                                        </telerik:RadComboBox>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td runat="server" class="labelWidth">
                                         <asp:Label ID="lblDelimeter" Text="Delimeter" runat="server" meta:resourcekey="lblDelimeter"></asp:Label>
                                     </td>
                                     <td runat="server" class="controlWidth">
                                         <asp:TextBox ID="txtDelimeter" runat="server" Width="99%"></asp:TextBox>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td colspan="2">
                                                     <asp:Panel runat="server" ID="pnlFile">
                    <table cellpadding="0" cellspacing="0" style="width:100%">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFileName" Text="File Name" runat="server" meta:resourcekey="lblFileName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPath" ReadOnly="True" runat="server" Width="99%"></asp:TextBox>
                            </td>
                            </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblHost" Text="Host" runat="server" meta:resourcekey="lblHost"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtHost" ReadOnly="True" runat="server" Width="99%"></asp:TextBox>
                            </td>
</tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPMWebUser" Text="PMWeb User" runat="server" meta:resourcekey="lblPMWebUser"></asp:Label>
                            </td>
                            <td  class="controlWidth">
                                <asp:TextBox ID="txtPmwebUser" ReadOnly="True" runat="server" Width="99%"></asp:TextBox>
                            </td>
                        </tr>
                      
                    </table>

                </asp:Panel>
                                     </td>
                                 </tr>
                                 
                             </table>

                         </div>
                         <div class="col-4">
                             <table class="colTable">
                                 <tr>
                                     <td style="width:100%">
                                          <asp:FileUpload ID="FileToUpload" runat="server" Width="280px" > </asp:FileUpload>
                                     </td>
                                 </tr>                               
                             </table>
                         </div>
                          <div class="col-4">
                             <table class="colTable">      
                                 <tr>
                                      <td style="width:100%">
                                          <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload File" meta:resourcekey="btnUpload"   />
                                      </td>
                                 </tr>
                             </table>
                         </div>
                         <div class="col-12">
                           <table class="colTable">
                                  <tr>
                                <td colspan="2">
                                 <asp:CheckBox ID="chkDisallowUpdatingCommitments" meta:ResourceKey="chkDisallowUpdatingCommitments" Visible="false" runat="server"
                                                    Text="Allow Adding Commitments Only, Disallow Updating Commitments (Highly Recommended!)" Checked="true"  />
                                </td>
                                    </tr>
                               </table>
                             </div>
                         </fieldset>
                 </div>
            <div class="row">
                <div>
                    <asp:Panel ID="pnlLoadFile" runat="server">
                        <telerik:RadAjaxPanel runat="server" ID="rdgMapFields" LoadingPanelID="ldpPM" HorizontalAlign="NotSet">
                            <telerik:RadGrid ID="rdgImport" Width="99%" runat="server"  SetWidth="true" AppendMenus = "true" FitPageHeightOffset="0"
                                 AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                                    CommandItemDisplay="None" AllowSorting="true" DataKeyNames="Id,Type" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>
                                     <telerik:GridTemplateColumn HeaderText="Type" 
                UniqueName="Type" SortExpression="Type">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="50px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn  HeaderText="PMWeb Field" 
                                            UniqueName="PMWebField" SortExpression="FieldFriendlyName">
                                            <ItemTemplate>
                                            <asp:Label runat="server" Text='<%#Container.DataItem("FieldFriendlyName")%>' ID="lblFriendyName"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="180px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Receive File Field" 
                                            UniqueName="FieldName">
                                            <ItemTemplate>
                                             <div onmouseover="StopPropagation(event)" class="combo-item-template">
                                              <%--  <asp:DropDownList ID="ddlFileFields1" runat="server"
                                                    Width="100%">
                                                </asp:DropDownList>--%>
                                                <telerik:RadComboBox ID="ddlFileFields" runat="server" Width="100%"></telerik:RadComboBox></div>
                                         <%--       <asp:CompareValidator runat="server" ControlToValidate="ddlExcelFields" CssClass="Validator"
                                                    Display="Dynamic" Enabled='<%# Container.DataItem("Required") %>' ErrorMessage="This field is required"
                                                    ForeColor="" ValidationGroup="ObjectImport" meta:resourcekey="CompareValidator"
                                                    Operator="NotEqual" ValueToCompare="PMWEBCOMPAREVALUE"></asp:CompareValidator>--%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="400px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Custom Value" ItemStyle-Wrap="false" SortExpression="CustomValue"
                                            UniqueName="CustomValue" >
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCustom" MaxLength="200" runat="server" Text='<%# Eval("CustomValue") %>'
                                                    Width="100%"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle Width="180px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                            UpdateImageUrl="Update.gif">
                                        </EditColumn>
                                    </EditFormSettings>
                                    <CommandItemTemplate>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings >
                <Scrolling AllowScroll="True"  UseStaticHeaders="True" SaveScrollPosition="True" ScrollHeight="400px">
                </Scrolling>
            </ClientSettings>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <HeaderContextMenu  EnableViewState="false">
                                </HeaderContextMenu>
                                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                            </telerik:RadGrid>
                        </telerik:RadAjaxPanel>
                    </asp:Panel>
                </div>
            </div>
</div>
        <table style="display:none">
            <tr>
                <td>
  <asp:Button Id="btnSave" runat="server"  meta:resourcekey="btnSave" Text="Save" style="margin-right:10px;" ValidationGroup="EquipmentMove"  />
                <asp:Button Id="btnCancel"   meta:resourcekey="btnCancel" runat="server" Text="Cancel" style="margin-right:10px;" />

                </td>
            </tr>
        </table>
            
    </form>
</body>
</html>
