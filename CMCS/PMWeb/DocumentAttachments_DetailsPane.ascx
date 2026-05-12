<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentAttachments_DetailsPane.ascx.vb" Inherits="Website.DocumentAttachments_DetailsPane" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Comments.ascx" TagName="Comments" TagPrefix="uc1" %>
<style>
    .commentContainer {
        padding: 5px;
        overflow: auto;
        box-sizing: border-box;
        border: 1px solid transparent;
    }

        .commentContainer:hover {
            border: 1px solid gray;
            border-radius: 5px;
        }

    .rapComments {
        width: calc(100% - 50px) !important;
    }

        .rapComments .tblComments {
            width: 100% !important;
        }

    .divProfilePicture {
        margin-right: 0 !Important;
    }

    .relative {
        position: relative;
    }

    .rrButton {
        display: none !important;
    }

    .colTable tr {
        display: table-row !important;
    }

    .NoCursor {
        cursor: default !important;
    }

    .Web.Url .Icon {
        left: 4px !important;
    }

    .AttachmentDetailsPaneTopLabel {
        float: left;
        display: inline;
        font-size: 16px;
        position: relative;
        top: 2px;
        padding-left: 16px;
        color: #999999;
        width: 340px;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }

    .closeDetails {
        width: 24px;
        height: 24px;
        display: block;
        position: absolute;
        right: 24px;
        top: 24px;
        background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png');
        background-position: 2184px 0px;
        cursor: pointer;
        z-index: 100;
    }

    .Save .Icon {
        background-position: -464px 0px;
        width: 16px;
        height: 16px;
        background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/16x16 White.png') !important;
        display: block;
        position: relative;
        top: 4px;
        left: 4px;
    }

    .Save {
        width: 24px;
        height: 24px;
        border-radius: 12px;
        background-color: #68ba45;
        display: block !important;
    }

        .Save:hover .Icon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/16x16 Hovered.png') !important;
        }

    .chkDisabled + .slider:before {
        background: #EDEDED;
    }

    .Cancel {
        width: 24px;
        height: 24px;
        border-radius: 12px;
        background-color: #68ba45;
        display: block !important;
    }

        .Cancel .Icon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/16x16 White.png') !important;
            background-position: -208px;
            width: 16px;
            height: 16px;
            display: block;
            position: relative;
            top: 4px;
            left: 4px;
            background-color: #68ba45;
        }

        .Cancel:hover .Icon {
            background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/16x16 Hovered.png') !important;
        }
</style>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        function OpenPDFViewer(strFullFileName) {
            window.open('app/viewerpdf/' + strFullFileName, "_blank");
            return false;
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefreshComments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshComments" />
                <telerik:AjaxUpdatedControl ControlID="Comments" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="closeDetails ShowOnMobile" onclick="closeDetailPane()"></div>
<div id="divDetails" runat="server" class="PMHeader detailPane">
    <div class="row">
        <div class="col-12">
            <asp:LinkButton ID="lnkBtnDocument" runat="server" Style="display: inline-block;">
                <span id="topIcon" runat="server" class="TopIcon" style="width: 24px; height: 24px; display: inline-block" />
                <asp:Label ID="lblDocument" runat="server" CssClass="AttachmentDetailsPaneTopLabel"></asp:Label>
            </asp:LinkButton>
         <asp:TextBox ID="txtDocument" Visible="false" runat="server" style="margin-left: 5px !important; width: calc(100% - 29px)"></asp:TextBox>

        </div>
    </div>
    <div class="row" id="divImgDisplay" runat="server">
        <div class="col-12">
            <div style="padding: 0 40px">
                <asp:Image ID="imgDisplay" style="max-height:200px; max-width:400px; display:block;width:auto;height:auto; margin: 0 auto" runat="server" Visible="false" />
            </div>
        </div>
    </div>
    <div class="row" visible="true">
        <div class="col-12" style="display: flex; justify-content: space-between">
            <asp:LinkButton ID="btnPMWebWordView" Visible="false" CssClass="Folder" runat="server" meta:resourcekey="btnView" >
                     <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnEdit" Visible="true" runat="server" CssClass="Edit" meta:resourcekey="btnEdit">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnSave" Visible="false" runat="server" CssClass="Save" meta:resourcekey="btnSave">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancel" Visible="false" runat="server" CssClass="Cancel" meta:resourcekey="btnCancel">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnView" OnClientClick="ShowImage();return false" Visible="false" CssClass="Folder" runat="server" meta:resourcekey="btnView">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnDownload" Visible="false" CssClass="Download" runat="server" meta:resourcekey="btnDownload">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="googleDrive" Visible="false" CssClass="GoogleDrive" runat="server" meta:resourcekey="googleDrive">
                    <span class="Icon"></span>
            </asp:LinkButton>

            <asp:LinkButton ID="btnOneDrive" Visible="false" CssClass="OneDrive" runat="server" meta:resourcekey="btnOneDrive">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnUrl" Visible="false" OnClientClick="return CopyUrl(this)" CssClass="CopyUrl" runat="server" ToolTip="Copy URL" meta:resourcekey="btnUrl">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="imgRedlining" Visible="false" CssClass="PmWebViewer" runat="server" meta:resourcekey="imgRedlining">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnModelManager" Visible="false" CssClass="ModelManager" runat="server" meta:resourcekey="btnModelManager">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnBlueMarkStudio" Visible="false" CssClass="BlueMarkStudio" runat="server" meta:resourcekey="btnBlueMarkStudio">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnGoToRecord" Visible="true" CssClass="GoToRecord" runat="server" meta:resourcekey="btnGoToRecord">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnGoToWebsite" Visible="true" CssClass="Web Url" runat="server" meta:resourcekey="btnGoToWebsite">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnFolder" Visible="false" CssClass="FolderAttachment" runat="server" meta:resourcekey="btnFolder">
                    <span class="Icon"></span>
            </asp:LinkButton>
        </div>
    </div>
    <div class="row" id="attachmentsPane" runat="server" visible="true">
        <table class="colTable" runat="server">
            <tr id="trDesc" runat="server">
                <td class="labelWidth">
                    <asp:Label ID="lblDescription2" runat="server" Text="Description*" meta:resourcekey="lblDescription2"></asp:Label>
                </td>
                <td class="controlWidth">
                    <asp:TextBox ID="txtDescription2" Visible="false" runat="server" Width="100%"></asp:TextBox>
                    <asp:Label ID="lblContentDescription" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="trIncludeInBid" runat="server">
                <td class="labelWidth">
                    <asp:Label ID="lblIncludeInBid" runat="server" Text="Include In Bid" meta:resourcekey="lblIncludeInBid"></asp:Label>
                </td>
                <td class="controlWidth">
                    <label class="switch">
                        <input id="chkIncludeInBid" runat="server" type="checkbox" />
                        <span class="slider round"></span>
                    </label>
                </td>
            </tr>
            <tr id="trItems" runat="server">
                <td class="labelWidth">
                    <asp:Label ID="lblLinkedLine" runat="server" Text="Linked Line" meta:resourcekey="lblLinkedLine"></asp:Label>
                </td>
                <td class="controlWidth">
                    <telerik:RadComboBox ID="ddlLinkedLine" Width="100%" DropDownWidth="300px" Filter="Contains"
                        Skin="Metro" CloseDropDownOnBlur="true" EnableItemCaching="true"
                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="ddlItems_OnClientSelectedIndexChanged"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Visible="false"
                        OnItemsRequested="ddl_ItemsRequested" AutoPostBack="False" runat="server">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblContentLinkedLine" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelWidth">
                    <div style="float: left; display: inline-block">
                        <asp:Label ID="lblNotes" runat="server" Text="Notes" meta:resourcekey="lblNotes"></asp:Label>
                    </div>
                    <div style="float: right; display: inline-block">
                        <asp:LinkButton runat="server" ID="btnNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('btnNotes','txtNotes'))" CssClass="SearchButton">
                                    <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                </td>
                <td class="controlWidth">
                    <asp:TextBox runat="server" MaxLength="4000" TextMode="MultiLine" ID="txtNotes" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                </td>
            </tr>
            <tr id="trGeolocation" runat="server">
                <td class="labelWidth">
                    <div style="float: left; display: inline-block">
                        <asp:Label ID="lblGeolocation" runat="server" meta:resourcekey="lblGeolocation" Text="Geolocation"></asp:Label>
                    </div>
                    <div style="float: right; display: inline-block; position: relative; bottom: -1px;" runat="server" id="btnGeolocation">
                        <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleAddressesPicker();">
                                                                                                                <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>

                </td>
                <td class="controlWidth">
                    <asp:TextBox ID="txtGoogleAddress" Visible="false" runat="server" Width="100%" ></asp:TextBox>
                    <asp:Label ID="lblContentGeolocation" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="trEmailFrom" runat="server" visible="false">
                <td class="labelWidth">
                    <asp:Label ID="lblEmailFrom" runat="server" Text="From" meta:resourcekey="lblEmailFrom"></asp:Label>
                </td>
                <td class="controlWidth">
                    <%--<asp:TextBox ID="txtEmailFrom" Visible="false" runat="server" Width="100%"></asp:TextBox>--%>
                    <asp:Label ID="lblContentEmailFrom" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="trEmailTo" runat="server" visible="false">
                <td class="labelWidth">
                    <asp:Label ID="lblEmailTo" runat="server" Text="To" meta:resourcekey="lblEmailTo"></asp:Label>
                </td>
                <td class="controlWidth">
                    <%--<asp:TextBox ID="txtEmailTo" Visible="false" runat="server" Width="100%"></asp:TextBox>--%>
                    <asp:Label ID="lblContentEmailTo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="trDisplayImage" runat="server">
                <td class="labelWidth">
                    <asp:Label ID="lblDisplayImage" runat="server" Text="Display In Image Gallery" meta:resourcekey="lblDisplayImage"></asp:Label>
                </td>
                <td class="controlWidth">
                    <label class="switch">
                        <input id="chkDisplayImage" onchange="CheckChanged()" runat="server" type="checkbox" />
                        <span class="slider round"></span>
                    </label>
                </td>
            </tr>
            <tr id="trVersion" runat="server">
                <td class="labelWidth">
                    <asp:Label ID="lblVersion" runat="server" Text="Version" meta:resourcekey="lblVersion"></asp:Label>
                </td>
                <td class="controlWidth">
                    <asp:Label ID="lblContentVersion" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelWidth">
                    <asp:Label ID="lblAttachAddedFrom" runat="server" Text="Added From" meta:resourcekey="lblAttachAddedFrom"></asp:Label>
                </td>
                <td class="controlWidth">
                    <asp:Label ID="lblAttachContentAddedFrom" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelWidth">
                    <asp:Label ID="lblAttachAdded" runat="server" Text="Added" meta:resourcekey="lblAttachAdded"></asp:Label>
                </td>
                <td class="controlWidth">
                    <asp:Label ID="lblAttachContentAdded" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="labelWidth">
                    <asp:Label ID="lblAttachAddedBy" runat="server" Text="Added By" meta:resourcekey="lblAttachAddedBy"></asp:Label>
                </td>
                <td class="controlWidth">
                    <asp:Label ID="lblAttachContentAddedBy" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
        <div class="row" style="padding-top: 16px !important">
            <asp:Button ID="btnAddComment" runat="server" meta:ResourceKey="btnAddComment" Text="Add Comment" Style="text-transform: uppercase; width: 100%" OnClientClick="return OpenCommentsPopup(this);" />
        </div>
        <div class="row">
            <div class="col-12 relative">
                <uc1:Comments ID="Comments" runat="server" />
            </div>
        </div>
    </div>
</div>
<asp:LinkButton ID="btnRefreshComments" runat="server" CssClass="Hide"></asp:LinkButton>
<asp:LinkButton ID="btnSaveNotes" runat="server" CssClass="Hide SaveNotes"></asp:LinkButton>
<asp:Button ID="btnDownloadAttachment" runat="server" CssClass="Hide downloadAttachment" OnClick="btnDownloadAttachment_Click" />
<asp:Button ID="btnSaveCheck" runat="server" CssClass="Hide saveCheck" />
<asp:HiddenField ID="hfLatitude" runat="server" />
<asp:HiddenField ID="hfLongitude" runat="server" />
<asp:HiddenField ID="hfGoogleAddress" runat="server" />
<asp:HiddenField ID="hfIsGeoLocationUpdated" runat="server" />
<asp:HiddenField ID="hfZoomLevel" runat="server" />
<asp:HiddenField ID="hfCenter" runat="server" />
 <asp:HiddenField ID="hfElevation" runat="server" />
<div id="divNoFoldeOrFilerSelected" class="detailPane NoFileSelected" style="text-align: center; color: #666;" visible="true" runat="server">
    <span meta:resourcekey="lblNoFoldeOrFilerSelected">Select a file or folder to see its details</span>
</div>
