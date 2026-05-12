<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Stamps.ascx.vb" Inherits="Website.Stamps" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript" src="JS/PMWebViewerSettings/Stamps.js"></script>
    <script language="javascript" type="text/javascript"></script>
    <style type="text/css">
        .SelectButtonStyle {
            text-align: center;
            height: 32px;
            text-transform: uppercase;
            background-color: #FFFFFF;
            color: #666666;
            border: 1px solid #666666;
            border-radius: 6px;
            margin: 4px;
        }

        span.ruButton.ruBrowse {
            background: none !important;
            border: none !important;
        }

        span.ruFileWrap.ruStyled {
            margin-top: -4px !important;
        }

      .ruDropZone{
          display:none !important;
      }
    </style>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgStamps">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgStamps" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="flsRepeat">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="flsRepeat" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" />

<table class="ToolBar documentSubToolbar" style="width: 100%; top: 68px;" cellpadding="0" cellspacing="0">
    <tr id="trToolBar">
        <td class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" CssClass="popup-toolbar">
                <Items>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" Value="Save" CommandName="Save"></telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>


<div class="PMMainPage" style="padding-top: 93px;">
    <div class="PMHeader">
        <div class="row">
            <div class="col-6">
                <asp:Panel ID="pnlQuickFileUpload" runat="server">
                    <%--<fieldset style="border: none !important;">
                                    <legend>
                                        <asp:Label ID="lblFilesUpload" runat="server" Text="Upload/Attach" meta:resourcekey="lblFilesUpload"></asp:Label>
                                    </legend>--%>
                    <fieldset style="border: 5px dashed #d5d5d5 !important; height: 100px;">
                        <div id="UploadDropZone" style="height:100px">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 80px;">
                                        <telerik:RadAsyncUpload runat="server" RenderMode="Native" CssClass="SelectButtonStyle" Width="80px" ID="rauStamps" OnClientFileUploadFailed="onDocFileUploadFailed"
                                            OnClientFileSelected="onDocFileSelected" OnClientFileUploading="onDocFileUploading" OnClientFileUploaded="onDocFileUploaded" OnClientAdded="addedDocFile" HideFileInput="true"
                                            MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" DropZones="#UploadDropZone" OnFileUploaded="rauStamps_FileUploaded">
                                            <Localization Select="<%$ Resources:PMWeb, btn_Select %>" />
                                        </telerik:RadAsyncUpload>
                                    </td>
                                    <td id="tdUploadOption" style="text-align: left; padding-left: 10px; color: #999999; background-color: #FFFFFF;" runat="server">
                                        <span id="lblUploadOption"></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </asp:Panel>
            </div>
            <div class="col-6">
                <fieldset style="border: 5px dashed #d5d5d5 !important; height: 100px; overflow: auto;">
                    <%--<fieldset style="border: none !important;" runat="server" id="flsRepeat">--%>
                    <%--  <legend>
                                    <asp:Label ID="lblSelected" runat="server" Text="Selected" meta:resourcekey="lblSelected"></asp:Label>
                                </legend>--%>
                    <div style="height: 42px !important;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="width: 80px; padding-top: 13px; padding-left: 5px; text-transform: uppercase; color: #999999; vertical-align: top;">
                                    <asp:Label ID="lblSelected" runat="server" Text="Selected" meta:resourcekey="lblSelected"></asp:Label>
                                </td>
                                <td style="text-align: left; padding-left: 10px; color: #999999; background-color: #FFFFFF;">
                                    <asp:Repeater runat="server" ID="rptSelected">
                                        <ItemTemplate>
                                            <table border="0">
                                                <tr>
                                                    <td style="vertical-align: top">
                                                        <asp:Label runat="server" ID="lblFile" Text='<%# CStr(Eval("NameWithExtension"))%>' Style="white-space: normal !important"></asp:Label>
                                                        <asp:Button ID="btnRemove" Text="Remove" FileGuid='<%# CStr(Eval("Guid"))%>' class="btnRemove" runat="server"></asp:Button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
            </div>
        </div>
        <%-- </fieldset>--%>
    </div>
</div>
<div class="PMHeader">
    <div class="row" style="padding-top: 24px;">
        <div class="col-12">
            <telerik:RadGrid ID="rdgStamps" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true" ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left" UseEditFormInMobile="true"
                AllowFilteringByColumn="true" Width="100%" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" SetWidth="true" AppendMenus="true" CssClass="ResponsiveMargin"
                AllowPaging="true" PageSize="10" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="true" ShowStatusBar="true" ShowGroupPanel="True" GroupPanelPosition="Top">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EditMode="InPlace" Width="100%"
                    DataKeyNames="Id" CommandItemDisplay="Top" ClientDataKeyNames="Id" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Image #" SortExpression="ImageNumber"
                            UniqueName="ImageNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ImageNumber"
                            GroupByExpression="ImageNumber [GridColumn_ImageNumber] Group By ImageNumber">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ImageNumber") = String.Empty, "&nbsp;", Container.DataItem("ImageNumber"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%# Eval("ImageNumber")%> &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="50px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image" Groupable="false" HeaderStyle-Width="50px">
                            <ItemTemplate>
                                <asp:Image ID="imgStampImage" runat="server" Width="100px" />&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Image ID="imgStampImage" runat="server" Width="100px" />&nbsp;
                            </EditItemTemplate>
                            <ItemStyle Wrap="false" HorizontalAlign="left" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Uploaded Date/time" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="UploadedDate"
                            SortExpression="UploadedDate" UniqueName="UploadedDate" GroupByExpression="UploadedDate [GridColumn_UploadedDate] Group By UploadedDate">
                            <ItemTemplate>
                                <span><%#FormatLongDateTime(Container.DataItem("UploadedDate"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle Wrap="true"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Uploaded By" DataField="UploadedBy"
                            AutoPostBackOnFilter="true" UniqueName="UploadedBy" SortExpression="UploadedBy" GroupByExpression="UploadedBy [GridColumn_UploadedBy] Group By UploadedBy ASC">
                            <ItemTemplate>
                                <span><%#Container.DataItem("UploadedBy")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" Groupable="false">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgStamps.EditIndexes.Count = 0 And (Not rdgStamps.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines"></asp:Label>
                                &nbsp;&nbsp; 
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save"
                                Visible='<%# rdgStamps.EditIndexes.Count > 0%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"></asp:Label>
                                &nbsp;&nbsp; 
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgStamps.EditIndexes.Count > 0 Or rdgStamps.MasterTableView.IsItemInserted%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                &nbsp;&nbsp; 
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgStamps.EditIndexes.Count = 0 And (Not rdgStamps.MasterTableView.IsItemInserted)%>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgStamps.EditIndexes.Count = 0 And (Not rdgStamps.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefresh1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"
                                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
            </telerik:RadGrid>
            <asp:Button ID="btnRefreshAttributesSelected" runat="server" CssClass="Hide" />
        </div>
    </div>
</div>






