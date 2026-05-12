<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FolderFileUpload.aspx.vb" Inherits="Website.FolderFileUpload" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload File</title>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript" src="JS/FileManager/FolderFileUpload.js"></script>
    <style type="text/css">
        .labelWidth.labelWidth_CheckIn{width:55% !important;}
        .controlWidth{color:#666666 !important;}

        .PMMainPage{
            padding-left:24px !important;
            padding-right:24px !important;
            padding-top:24px !important;
           
        }

        .ruFakeInput {
            width: 300px;
        }

        .ruDropZone {
            padding: 1px;
            width: 1px;
            height: 1px;
        }

        .CenterDiv {
            text-align: center;
            text-align: -moz-center;
        }

        .RadInput {
            display: initial !important;
        }

        .RadUpload .ruFakeInput {
            float: right !important;
            margin-top: 1px !important;
            margin-left: 3px !important;
            margin-right: 1px !important;
            display: none !important;
        }

        .RadUpload.ProjectCenterUpload {
                    max-width: none;
                    border-radius: 0px;
                    background-color: rgb(105,185,50);
                    border: 1px solid rgb(105,185,50) !important;
                    padding: 0px !important;
                }

         .RadUpload.ProjectCenterUpload .ruFileWrap {
                 height: 40px;
           }

         .RadUpload.ProjectCenterUpload .ruInputs li {
                    text-align: center;
          }

         #TelerikFileUpload{
             margin-bottom:19px;
             margin-top:19px;
         }

    </style>

    <script type="text/javascript">
        /*******Drag and Drop ***********/
            
        function displaySelectedFileName(sender,eventArgs) {
            
            var value = eventArgs.get_fileInputField().value;
           var index = value.lastIndexOf('\\');
           value = value.substring(index + 1);
           document.getElementById("txtSelectedFile").value = value;
           document.getElementById("txtHiddenSelectedFile").value = value;
        }

        function displayHiddenSelectedFile() {
            var value = document.getElementById("txtHiddenSelectedFile").value;
            document.getElementById("txtSelectedFile").value = value;
        }
        
        function clickDisplayButton() { 
            document.getElementById("displayButton").click();
        }

        var uploadsInProgress = 0;
   

            function onFileSelected(sender, args) {
                uploadsInProgress++;

            }

       

            function onFileUploaded(sender, args) {
                decrementUploadsInProgress();
                if (uploadsInProgress == 0) {
                    if ($("[id$=btnCreateEvent]").length > 0) {
                        $("[id$=btnCreateEvent]")[0].click();
                    }
                }
            }

            function onUploadFailed(sender, args) {
                decrementUploadsInProgress();
            }

            function decrementUploadsInProgress(){       
                uploadsInProgress--;
            }

            function added(sender, args) {

                if (document.getElementById('lblUploadOption')) {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $("#lblUploadOption").html(lblUploadOptionChFFText);
                    } else {
                        $("#lblUploadOption").html(lblUploadOptionIEText);
                    }
                }
            }

            function ClientValidationFailed(sender, args) {
                alert(WarningMsg_InvalidFile);
            }

            document.ready = (function (n) {
                $("[id$=btnSubmit]").hide();
            });

            
        </script>
        </telerik:RadCodeBlock>

</head>

<body onload="displayHiddenSelectedFile()" style="background: White !important;">
    <form id="form1" runat="server">

        

        <telerik:RadScriptManager ID="PMScriptManager" runat="server"
            EnableTheming="True">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true" DefaultLoadingPanelID="ldpFileUpload">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAttributeDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAttributeDetails" />
                        <telerik:AjaxUpdatedControl ControlID="txtBudgetTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpFileUpload" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <Calendar Width="200px"></Calendar>
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndExit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CausesValidation="false" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <%--<div class="row">--%>
                <%--<div class="col-6">--%>
                    <asp:Panel ID="pnlSingleFile" runat="Server">
                        <div runat="server" id="divFileName">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth labelWidth_CheckIn">
                                        <asp:Label ID="lblFileName" runat="server" Text="File" meta:resourcekey="lblFileName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:Label ID="lblFileNameValue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trVersion" runat="server">
                                    <td  class="labelWidth labelWidth_CheckIn">
                                        <asp:Label ID="lblVersion" Visible="false" Text="Version" meta:resourcekey="lblVersion" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:Label Visible="false" ID="lblVersionValue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="colTable">
                            
                            <tr id="trAttributesInfo" runat="server">
                                <td>
                                    <telerik:RadGrid ID="rdgAttributesInfo" runat="server" Skin="Default" AutoGenerateColumns="False"
                                        ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                        GridLines="None" Width="100%">
                                        <HeaderStyle Font-Size="8pt" />
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Id1" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFolderAttributeID1" runat="server" CssClass="Right" Enabled="false"
                                                            Text='<%#IIf(IsNewFile, Eval("Id"), Eval("FolderAttributeId"))%>' Width="1px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Attribute" UniqueName="Attribute1" ItemStyle-Width="20%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAttributeName1" runat="server" Text='<%#Eval("AttributeName")%>'></asp:Label><%#CStr(IIf(Eval("IsRequired"), "*", ""))%><%#CStr(IIf(Eval("IsUnique"), "(u)", ""))%>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value" ItemStyle-Width="52%">
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="ddlValues1" runat="server" Enabled="false" Filter="Contains" MarkFirstMatch="true"
                                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" NoWrap="True" Skin="Default" AllowCustomText="true"
                                                            Style="font-size: 11px">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                        <asp:TextBox ID="txtAttributeValue1" Width="100%" Enabled="false" runat="server"></asp:TextBox>
                                                        <asp:CheckBox ID="chkAttribute" runat="server" Visible="false" Enabled="false" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
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
                                </td>
                            </tr>
                            <tr id="trFileUpload" runat="server" style="width: 100%">
                                <td style="width: 100%">
                                    <%--<asp:FileUpload ID="FileUpload" runat="server" Width="300px"></asp:FileUpload>--%>
                                    <telerik:RadUpload ID="TelerikFileUpload" ControlObjectsVisibility="none" runat="server" MaxFileInputsCount="1" Style="box-sizing: border-box;"
                                        InitialFileInputsCount="1" Skin="Default" InputSize="45"  CssClass="ProjectCenterUpload" Localization-Select="DROP A FILE HERE OR CLICK TO ADD" OnClientFileSelected="displaySelectedFileName" />
                                
                                </td>

                               
                                
                            </tr>
                            </table>
                      <table class="colTable">

                         <tr>
                                    <td class="labelWidth labelWidth_CheckIn">
                                        <asp:Label ID="lblSelectedFile"  runat="server" Text="Selected File" meta:resourcekey="lblSelectedFile"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <input type="text" readonly="readonly" id="txtSelectedFile" />
                                        <asp:textbox runat="server" type="hidden" id="txtHiddenSelectedFile" />

                                    </td>
                                </tr>
                          <tr>
                              <td width="50%">

                              </td>
                                <td>
                                    <asp:Label ID="lblResult" runat="server" CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                          </table>
                        <table class="colTable" style="padding-top:19px">

                            <tr id="trAttributeDetails" runat="server" >
                               
                                
                                <td>
                                    <telerik:RadGrid ID="rdgAttributeDetails" runat="server" Skin="Default" AutoGenerateColumns="False"
                                        ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                        GridLines="None" Width="100%">
                                        <HeaderStyle Font-Size="8pt" />
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Id" ItemStyle-HorizontalAlign="Right" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFolderAttributeID" runat="server" CssClass="Right" Enabled="false"
                                                            Text='<%#IIf(IsNewFile, Eval("Id"), Eval("Id"))%>' Width="1px"></asp:TextBox>
                                                        <asp:HiddenField runat="Server" ID="hdnAttributeID" Value='<%#IIf(IsNewFile OrElse IsCreateNewVersion, "0", Eval("Id"))%>'></asp:HiddenField>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Attribute" UniqueName="Attribute" ItemStyle-Width="20%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAttributeName" runat="server" Text='<%#Eval("AttributeName")%>'></asp:Label><%#CStr(IIf(Eval("IsRequired"), "*", ""))%><%#CStr(IIf(Eval("IsUnique"), "(u)", ""))%>
                                                        <asp:HiddenField runat="Server" ID="hdnUnique" Value='<%#Eval("IsUnique")%>'></asp:HiddenField>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value" ItemStyle-Width="52%">
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="ddlValues" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" NoWrap="True" Skin="Default" DropDownWidth="270px"
                                                            Style="font-size: 11px">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="rfvOptionAttribute" ControlToValidate="ddlValues" meta:Resourcekey="rfvOptionAttribute"
                                                            runat="server" ErrorMessage="Required" Display="Dynamic" CssClass="Validator">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:TextBox ID="txtAttributeValue" MaxLength="500" Width="100%" runat="server"></asp:TextBox>
                                                        <asp:TextBox ID="txtAttributeDate" MaxLength="100" Style="text-align: right" Visible="false" Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                                            onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                                        <asp:CheckBox ID="chkAttributeValue" Visible="false" runat="server" />
                                                        <asp:RequiredFieldValidator ID="rfvAttribute" Display="Dynamic" ControlToValidate="txtAttributeValue"
                                                            runat="server" ErrorMessage="Required" CssClass="Validator" meta:Resourcekey="rfvAttribute">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RequiredFieldValidator ID="rfvAttributeDate" Display="Dynamic" ControlToValidate="txtAttributeDate"
                                                            runat="server" CssClass="Validator" meta:Resourcekey="rfvAttribute">
                                                        </asp:RequiredFieldValidator>
                                                        <br />
                                                        <asp:Label ID="lblUnique" runat="server" Text="Should be unique in this folder" CssClass="Validator" Visible="False" meta:Resourcekey="lblUnique"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
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
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="padding-right: 18px; padding-top: 18px;">
                                    <asp:Button ID="btnCancel" meta:ResourceKey="btnCancel" Visible="false" OnClientClick="CloseRadWnd();return false;" Text="Cancel" runat="server"></asp:Button>
                                    <asp:Button ID="btnUpdateFile" meta:ResourceKey="btnUpdateFile" CausesValidation="true" Visible="false" Text="Update file" runat="server"></asp:Button>
                                    <asp:Button ID="btnFileUpload" meta:ResourceKey="btnFileUpload" Text="Upload file" runat="server" ></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            <%--</div>--%>
            <%--<div class="row">--%>
              <%--  <div class="col-6">--%>
                    <asp:Panel ID="pnlMultipleFiles" runat="Server">
                        <table class="colTable">
                            <tr>
                                <td align="left"><span id="lblUploadOption"></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadAsyncUpload runat="server" ID="rauUpload" Skin="Default" OnClientFileUploadFailed="onUploadFailed" Width="100%" CssClass="ProjectCenterUpload"
                                        OnClientFileSelected="onFileSelected" OnClientFileUploaded="onFileUploaded" OnClientAdded="added" Style="box-sizing: border-box;"
                                        MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed" OnFileUploaded="rauUpload_FileUploaded">
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center;">
                                    <asp:Button Width="1px" runat="server" ID="btnSubmit" Text="1"  />
                                    <asp:Button Width="1px" runat="server" ID="btnCreateEvent" CssClass="Hide" Text="1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
         <%--   </div>--%>
      <%--  </div>--%>
    </form>
</body>
</html>

