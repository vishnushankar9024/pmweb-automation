<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="IMPORT RECORDS" CodeBehind="ImportPopup.aspx.vb" Inherits="Website.ImportPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server" ID="script1">
        <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
          <style type="text/css">
            .preview         .RadComboBox {
            text-align: left;
            display: inline-block;
            vertical-align: middle;
            white-space: nowrap;
            *display: inline;
            *zoom: 1;
            width: 20% !important;
        }
            
        </style>
        <script type="text/javascript">
            
            function DisplayMessage(innerText) {
                alert(innerText);

            }
             
            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnl]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }
            function SelectFile() {
                var upload = document.querySelector('#FileToUpload');


                upload.click();
                return false;
            }
            window.onload = function () {
                document.querySelector('#FileToUpload').addEventListener("change", FilePathName);
            }

            function OpenProgressImport() {
                var objecttype = "<%= ObjectType %>"
                OpenSmallestPopup("ImportResultsPopup.aspx?objecttype="+objecttype, 454, 500);
            }

            function SwitchSelectUpload() {
                 var selectUploadbtn = document.getElementById('SelectUploadbtn');              
                 if (selectUploadbtn.className === 'SelectFile') {
                     selectUploadbtn.className = 'UploadFile';
                     document.getElementById("lblUploadFile").style.display = "inline";
                     document.getElementById("lblSelectUpload").style.display = "none";
                    SelectFile();
                }
                 else if (selectUploadbtn.className === 'UploadFile') {
                     
                    UploadClick();

                }
                function UploadClick() {
                    var uploadFile = document.getElementById("btnUploadFile");
                    uploadFile.click();

                }

                return false;
               
            }

            function FilePathName() {
                var txtPath = document.querySelector('#txtPath');
                var file = document.querySelector('#FileToUpload');
                if (file.value.lastIndexOf('\\') > 0)
                    txtPath.value = file.value.substring(file.value.lastIndexOf('\\') + 1);
                else
                    txtPath.value = file.value;
            }
        </script>

    </telerik:RadCodeBlock>
    <style>
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .ToolBar {
                width: 100% !important;
                left: 0;
                position: static !important;
                table-layout: fixed;
            }
        }

        .lnkButtonBar:hover {
            background-color: #ededed;
        }

        .RadComboBox {
            text-align: left;
            display: inline-block;
            vertical-align: middle;
            white-space: nowrap;
            *display: inline;
            *zoom: 1;
            width: 100% !important;
        }
           .lnkButtonBar{
            width:auto !important;
        }
        a {
            text-decoration: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <telerik:RadWindowManager ID="PMWindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
       
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False" >
            <AjaxSettings>    
                <telerik:AjaxSetting AjaxControlID="btnhdnImport">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnhdnImport" />
                        <telerik:AjaxUpdatedControl ControlID="hdnImportState" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <table style="width: 100%; position: static !important" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td style="width: 100%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" >
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CssClass="lnkButtonBar" CommandName="Import" Value="Import" style="display:none;"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row Cols2">
                <div class="col-6">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important">
                                <asp:Label ID="lblDataFile" runat="server" meta:resourcekey="lblDataFile"></asp:Label>&nbsp;
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPath" ReadOnly="True" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-6">
                    <table class="colTable floatRightImport" style="width: 400px">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblUploaded" runat="server" meta:resourcekey="lblUploaded"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <input  type="text" runat="server" ID="UploadedDate" readonly="ReadOnly" />
                            </td>
                        </tr>

                    </table>
                </div>
            </div>


        </div>
        <div class="row">
            <div class="col-12">
                <div runat="server" id="divUpload" style="text-align:center">

                    <asp:LinkButton runat="server" ID="SelectUploadbtn" CssClass="SelectFile" OnClientClick="SwitchSelectUpload();return false;">
                                <div class="Icon"></div>
                    </asp:LinkButton><br />
                    <asp:FileUpload ID="FileToUpload" runat="server" CssClass="Hide"></asp:FileUpload>
                    <asp:LinkButton ID="btnUploadFile" runat="server" CssClass="UploadFile" style="display:none;">
                   
                    <div class="Icon"></div>
                    </asp:LinkButton> 
                    <br />
                    <asp:Label runat="server" ID="lblSelectUpload" meta:resourcekey="lblSelectUpload" CssClass="IconLabelsSelect"></asp:Label>
                    <asp:Label runat="server" ID="lblUploadFile" meta:resourcekey="lblUploadFile"  style="display:none;" CssClass="IconLabelsUpload"></asp:Label>
                </div>
                <asp:Panel runat="server" ID="PnlMapping" style="display:none">
                    <telerik:RadGrid ID="rdgImport" runat="server" SetWidth="true" FitParentContainer="true" FitPageHeightOffset="24" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None" style="margin:24px; width:auto;">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            CommandItemDisplay="none" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                            <Columns>
                                <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PM Field"
                                    UniqueName="PMField">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldFriendlyName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", "")) %>
                                    </ItemTemplate>
                                    <HeaderStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Import File Field"
                                    UniqueName="FieldName">
                                    <ItemTemplate>
                                        <%-- <asp:DropDownList ID="ddlExcelFields" runat="server"
                                                    Width="240px">
                                                </asp:DropDownList>--%>
                                        <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>

                                    </ItemTemplate>
                                    <HeaderStyle Width="50%" />
                                    <ItemStyle HorizontalAlign="Left" />
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
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                    </telerik:RadGrid>
                </asp:Panel>

                <asp:Panel runat="server" ID="pnlPreview"  style="display:none">
                   <%-- <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">--%>
                        <telerik:RadGrid ID="rdgPreview" CssClass="preview" runat="server" AllowPaging="true" PageSize="250" SetWidth="true" FitParentContainer="true" FitPageHeightOffset="24" ClientSettings-Scrolling-AllowScroll="true"
                            AutoGenerateColumns="True" ShowStatusBar="false" Font-Size="8px" GridLines="None" style="margin:24px; width:auto;">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                            <ClientSettings>
                                <Resizing AllowRowResize="true" />
                            </ClientSettings>
                            <MasterTableView CommandItemDisplay="Top">
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateImportPopup" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateImportPopup"
                                            ValidationGroup="DocumentAttachments" OnClientClick="DisablePanelAjax()"
                                            Visible="True">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                        </telerik:RadGrid>
                    <%--</telerik:RadAjaxPanel>--%>

                </asp:Panel>


                <asp:Button ID="btnSave" runat="server" CausesValidation="False" Text="Save" Style="display: none"
                    meta:resourcekey="btnSave" />


            </div>
        </div>
        <asp:HiddenField ID="hdnImportState" Value="" runat="server" />
        <asp:Button ID ="btnhdnImport"  runat="server" CssClass="Hide" />
    </form>
</body>
</html>
