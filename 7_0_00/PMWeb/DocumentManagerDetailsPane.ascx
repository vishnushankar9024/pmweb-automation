<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentManagerDetailsPane.ascx.vb" Inherits="Website.DocumentManagerDetailsPane" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Comments.ascx" TagName="Comments" TagPrefix="uc1" %>
<style>
   
    .Folder_DocumentManager .relative {
        position: relative;
    }

    .Folder_DocumentManager .rrButton {
        display: none !important;
    }

    .Folder_DocumentManager .colTable tr {
        display: table-row !important;
    }

    .Folder_DocumentManager .closeDetails{
        width:24px;
        height:24px;
        display:block;
        position:absolute;
        right:24px;
        top:24px;
        background-image:url('CSS/Images/ResponsiveIcons/24Enabled.png');
        background-position: 2184px 0px;
        cursor:pointer;
        z-index:100;
    }
  
    
    .Folder_DocumentManager .DetailsPaneTopLabel {
        float: left;
        display: inline;
        font-size: 16px;
        position: relative;
        top: 2px;
        padding-left: 16px;
        color: #999999;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }
    .DetailsPaneTopLabel{
        overflow: hidden;
        text-overflow: ellipsis;
        display: inline-block;
        white-space: nowrap;
        width: 340px;
    }
    .Folder_DocumentManager .BlueMarkStudio.inSession .Icon  {
        background-image: url('CSS/Images/ResponsiveIcons/ActivityBoardIcons/24x24 Enabled.png') !important;
        background-position: -24px 0;
    }

    @media screen and (min-width:320px) and (max-width:843px) {
        div#ctl00_CPH1_DetailsPane {
            height: 100vh;
            z-index: 10001 !important;
        }
}
</style>

<telerik:RadAjaxManagerProxy runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefreshComments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshComments" LoadingPanelID="ldpDetails" />
                <telerik:AjaxUpdatedControl ControlID="Comments" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

 <telerik:RadAjaxLoadingPanel ID="ldpDetails" IsSticky="true" CssClass="detailLoadingPanel" runat="server" ></telerik:RadAjaxLoadingPanel>
<div class="closeDetails ShowOnMobile" onclick="closeDetailPane()"></div>
<div id="divDetails" runat="server" class="PMHeader detailPane" visible="false">
    <div class="row">
        <div class="col-12">
            <asp:LinkButton ID="lnkBtnDocument" runat="server" Style="display: inline-block">
            <span id="topIcon" runat="server" class="TopIcon" style="width: 24px; height: 24px; display: inline-block"/>
                <asp:Label ID="lblDocument" runat="server" CssClass="DetailsPaneTopLabel"></asp:Label>
            </asp:LinkButton>
        </div>
    </div>
    <div style="margin-top:15px;" id="imgDiv" runat="server" visible="false">
        <div class="col-12">
            <div style="padding: 0 40px">
                <asp:Image ID="imgDisplay" CssClass="imgDisplay imgDisplayDetailsPane" runat="server" />
            </div>
        </div>
    </div>
    <div class="row" id="divTopButtons" runat="server" visible="true">
        <div class="col-12" style="display: flex; justify-content: space-between">
            <asp:LinkButton ID="btnView" OnClientClick="ShowImage();return false" Visible="false" CssClass="Folder" runat="server" meta:resourcekey="btnView">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnDownload" Visible="false" CssClass="Download" runat="server" meta:resourcekey="btnDownload">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="googleDrive" Visible="false" CssClass="GoogleDrive" runat="server" meta:resourcekey="googleDrive">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnFolder" Visible="false" OnClientClick="return FillFolder(this);return false;" CssClass="Folder" runat="server" meta:resourcekey="btnFolder">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnEdit" Visible="false" CssClass="Edit" OnClientClick="return OpenEditPopUp(this)" runat="server" meta:resourcekey="btnEdit">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnOneDrive" Visible="false" CssClass="OneDrive" runat="server" meta:resourcekey="btnOneDrive">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnCheck" OnClientClick="return CheckIn(this)" Visible="false" CssClass="Check" runat="server">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnBookMark" Visible="false" CssClass="BookMark" runat="server">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnUrl" Visible="false" OnClientClick="return CopyUrl(this)" CssClass="CopyUrl" runat="server" ToolTip="Copy URL" meta:resourcekey="btnUrl">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnSubscribe" Visible="false" CssClass="Subscribe" OnClientClick="return Subscribe(this);" runat="server">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="imgRedlining" Visible="false" CssClass="PmWebViewer" runat="server">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnBlueMarkStudio" Visible="false" CssClass="BlueMarkStudio" runat="server">
                    <span class="Icon"></span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnModelManager" Visible="false" CssClass="ModelManager" runat="server" meta:resourcekey="btnModelManager">
                    <span class="Icon"></span>
            </asp:LinkButton>

        </div>
    </div>

    <div id="documentManagerPane" runat="server" visible="true">
        <div class="row">
            <table class="colTable" id="fileContentTable" runat="server"> 
                <tr>
                    <td class="labelWidth">
                        <asp:Label  id="_lblDescription" runat="server" meta:resourcekey="_lblDescription">Description</asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentDescription" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label id="_lblType" runat="server" meta:resourcekey="_lblType">Type</asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentType" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblCategory" runat="server" meta:resourcekey="_lblCategory">Category</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentCategory" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblVersion" runat="server" meta:resourcekey="_lblVersion">Version</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentVersion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblStatus" runat="server" meta:resourcekey="_lblStatus">Status</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblAddedFrom" runat="server" meta:resourcekey="_lblAddedFrom">Added From</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentAddedFrom" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblAdded" runat="server" meta:resourcekey="_lblAdded">Added</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentAdded" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblAddedBy" runat="server" meta:resourcekey="_lblAddedBy">Added By</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentAddedBy" runat="server"></asp:Label>
                    </td>
                </tr>
                
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblLastUpdateDate" runat="server" meta:resourcekey="_lblLastUpdateDate">Last Updated </asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentLastUpdateDate" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblLastUpdatedByUserName" runat="server" meta:resourcekey="_lblLastUpdatedByUserName">Last Updated By</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentLastUpdatedByUserName" runat="server"></asp:Label>
                    </td>
                </tr>
                 
                 <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblLastCheckedInOut" runat="server" meta:resourcekey="_lblLastCheckedInOut">Last Checked In/Out</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentLastCheckedInOut" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:label id="_lblLastCheckedInOutBy" runat="server" meta:resourcekey="_lblLastCheckedInOutBy">Last Checked In/Out By</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentLastCheckedInOutBy" runat="server"></asp:Label>
                    </td>
                </tr>
               
                <tr id="trGeolocation" runat="server">
                     <td class="labelWidth">
                        <asp:label id="_lblGeolocation" runat="server" meta:resourcekey="_lblGeolocation">Geolocation</asp:label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label ID="lblContentGeolocation" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <%--<asp:Repeater ID="rptAttribute" runat="server">
            <ItemTemplate>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblAttribute" runat="server" Text="<%#Container.DataItem("Attribute") %>"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:Label ID="lblContentAttribute" runat="server" Text="<%#Container.DataItem("ContentAttribute") %>"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>--%>
            <table class="colTable" id="folderContentTable" runat="server">
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblFolderAdded" meta:ResourceKey="lblFolderAdded" Text="Added"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label runat="server" ID="lblContentDateAdded"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblFolderAddedBy" meta:ResourceKey="lblAddedBy" Text="Added By"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label runat="server" ID="lblContentFolderAddedBy"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblDefaultType" meta:ResourceKey="lblDefaultType" Text="Default Type"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label runat="server" ID="lblContentDefaultType"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblDefaultCategory" meta:ResourceKey="lblDefaultCategory" Text="Default Category"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label runat="server" ID="lblContentDefaultCategory"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblEnableVersions" meta:ResourceKey="lblEnableVersions" Text="Enable Versions"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span ID="spnEnableVersions" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label runat="server" ID="lblInstructions" meta:ResourceKey="lblInstructions" Text="Instructions"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Label runat="server" ID="lblContentInstructions"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row" style="padding-top: 16px !important">
            <asp:Button ID="btnAddComment" runat="server" meta:ResourceKey="btnAddComment" Text="Add Comment" Style="text-transform: uppercase; width: 100%" OnClientClick="return OpenCommentsPopup(this);" />
        </div>
    </div>
    <div class="row">
        <div class="col-12  relative">
            <uc1:Comments ID="Comments" runat="server" />
        </div>
    </div>
</div>
<asp:LinkButton ID="btnRefreshComments" runat="server" CssClass="Hide"></asp:LinkButton>
<asp:LinkButton ID="btnSaveNotes" runat="server" CssClass="Hide SaveNotes"></asp:LinkButton>
<asp:Button ID="btnDownloadAttachment" runat="server" CssClass="Hide downloadAttachment" OnClick="btnDownloadAttachment_Click" />

<div id="divNoFoldeOrFilerSelected" class="detailPane NoFileSelected" style="text-align: center;color:#666;" visible="true" runat="server">
    
    <span  meta:resourcekey="lblNoFoldeOrFilerSelected">Select a file or folder to see its details</span>
</div>
