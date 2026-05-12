<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="Import Records" CodeBehind="ImportPopup.aspx.vb" Inherits="Website.ImportPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server" ID="script1">
        <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
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

        .RadComboBox {
            text-align: left;
            display: inline-block;
            vertical-align: middle;
            white-space: nowrap;
            *display: inline;
            *zoom: 1;
            width: 100% !important;
        }

        a {
            text-decoration: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <table style="width: 100%; position: static !important" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td style="width: 100%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarImport" CommandName="Import" Value="Import"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth"></td>
                            <td style="overflow: hidden; text-overflow: ellipsis">
                                <asp:Button ID="btnSelectFile" runat="server" CausesValidation="False" Text="Select File"
                                    OnClientClick="SelectFile();return false;" />
                                <asp:FileUpload ID="FileToUpload" runat="server" CssClass="Hide"></asp:FileUpload>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFileType" Text="File Type" runat="server" meta:resourcekey="lblFileType"></asp:Label>&nbsp;
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtFileType" ReadOnly="true" Text="Microsoft Excel"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFileName" Text="File Name" runat="server" meta:resourcekey="lblFileName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPath" ReadOnly="True" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td style="overflow: hidden; text-overflow: ellipsis">
                                <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload"
                                    meta:resourcekey="btnSaveUpload" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:Panel runat="server" ID="PnlMapping">
                        <telerik:RadGrid ID="rdgImport" Width="100%" runat="server" SetWidth="true" FitParentContainer="true" FitPageHeightOffset="24" ClientSettings-Scrolling-AllowScroll="true"
                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
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
                                            <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="100%" AllowCustomText="true" ></telerik:RadComboBox>

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

                    <asp:Panel runat="server" ID="pnlPreview">
                        <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                            <telerik:RadGrid ID="rdgPreview" runat="server" AllowPaging="true" PageSize="10" SetWidth="true" FitParentContainer="true" FitPageHeightOffset="24" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="True" ShowStatusBar="false" Font-Size="8px" GridLines="None">
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
                        </telerik:RadAjaxPanel>

                    </asp:Panel>


                    <asp:Button ID="btnSave" runat="server" CausesValidation="False" Text="Save" Style="display: none"
                        meta:resourcekey="btnSave" />


                </div>
            </div>
        </div>
    </form>
</body>
</html>
