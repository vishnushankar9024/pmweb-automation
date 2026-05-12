<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ProjectCodes.aspx.vb" Inherits="Website.ProjectCodes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="maintoolBar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="maintoolBar"/>
                    <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <script type="text/javascript">

        function VisibleCheckChange(chkVisible) {
            if (chkVisible.checked == true) {
                var chkRendered = document.getElementById((chkVisible.id.substring(chkVisible.id.lastIndexOf('_'), chkVisible.id.lenght - 1) + '_chkRendered'));
                chkRendered.checked = true;
            }
        }

        function RenderedCheckChange(chkRendered) {
            if (chkRendered.checked == false) {
                var chkVisible = document.getElementById((chkRendered.id.substring(chkRendered.id.lastIndexOf('_'), chkRendered.id.lenght - 1) + '_chkVisible'));
                chkVisible.checked = false;
            }
        }

        function openProjectCodeItemsPopup(ProjectCodeId,UniqueName) {
            var wnd = OpenPOPUp('ProjectCodeItemsPopup.aspx?ProjectCodeId=' + ProjectCodeId + '&UniqueName=' + UniqueName);           
            return false;
        }

        function RebindProjectsGrid(Opener) {
            var btnRefreshId = $("a[id*=rdgProjects][id$=btnRefresh]")[0];
            if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }

        }

        function OpenProjectCodesLookup() {
            var wnd = window.radopen('ProjectCodesLookup.aspx');
            wnd.setSize(450, 500);
            wnd.add_close(RefreshCalendar);
            wnd.Center();
            return false;
        }

        function RefreshCalendar() {
            __doPostBack("ddlProjects", 'CopyProjectCodes');
        }
    </script>

    <style>
        @media screen and (max-width: 843px) and (min-width: 320px) {
           /* .PMHeader {
                margin-top: 71px;
            }*/
             .MainPagedocumentSinglePage{
            margin-top:40px !important;
        }
        }
        .ToolbarTd {
            padding-left: 0px !important;
        }
        .ToolbarRebindGrid .rtbIcon {
            background-position: -960px 0;
        }
        .ToolbarUpdate  .rtbIcon{
            background-position: -720px 0;
        }
         /*   .divContentHolder {
    padding-top: 115px;
}*/
    </style>

    <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                <Items>
                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ProjectCodes"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/NewDoc.png" 
                                        CommandName="Update" AccessKey="s" ValidationGroup="Update" ToolTip="Save (Alt+s)"
                                        Value="Save">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton ToolTip="Refresh" CommandName="RebindGrid" ImageUrl="Images/Toolbar/Help.png" CausesValidation="true"></telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width:100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table class="colTable PMHeader" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <div >
                    <telerik:RadGrid ID="rdgProjects" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                        Skin="Default" HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                            EditMode="InPlace" TableLayout="Fixed" Width="100%">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Unique Name" UniqueName="UniqueName">
                                    <ItemTemplate>
                                        <%#Container.DataItem("UniqueName")%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Header Text" UniqueName="Text">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtText" MaxLength="150" runat="server" Text='<%#Container.DataItem("Text")%>' Width="100%"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Width" UniqueName="Width">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtWidth" MaxLength="50" runat="server" Text='<%#Container.DataItem("Width")%>' CssClass="PositiveInteger" Width="60px"></asp:TextBox>
                                        &nbsp;&nbsp;px   
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Order" UniqueName="OrderIndx">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOrderIndx" runat="server" MaxLength="9" Text='<%#Container.DataItem("OrderIndx")%>' CssClass="PositiveInteger" Width="99%"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Visible by Default" UniqueName="IsVisible">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkVisible" runat="server" Checked='<%#Container.DataItem("IsVisible")%>' onClick="VisibleCheckChange(this);" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="On/Off" UniqueName="IsRendered">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkRendered" runat="server" Checked='<%#Container.DataItem("IsRendered")%>' onClick="RenderedCheckChange(this);" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Bg-Color" UniqueName="BgColor">
                                    <ItemTemplate>
                                        <telerik:RadColorPicker ShowIcon="true" ID="rcpBgColor" runat="server" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                      
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Font Color" UniqueName="FontColor">
                                    <ItemTemplate>
                                          <telerik:RadColorPicker ShowIcon="true" ID="rcpFontColor" runat="server" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Values" UniqueName="Values">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnProjectCodeItems" CssClass="SearchButton" runat="server">
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                      <%--      <CommandItemTemplate>
                                <table style="padding: 0px" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <b>&nbsp;&nbsp;<asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label></b>
                                        </td>
                                        <td>--%>
                                            <%-- <telerik:RadComboBox ID="ddlProjects" runat="server" Width="150px"  DropDownWidth="250px" AutoPostBack="true"
                                 style="font-size:11px" Height="458px"  OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged">
                                <CollapseAnimation Duration="200" Type="OutQuint"  />
                            </telerik:RadComboBox>--%>

<%--                                            <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true"
                                                Skin="Default" DropDownWidth="250px" CausesValidation="false" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                                                Filter="Contains" MarkFirstMatch="true" EmptyMessage="<%$Resources:CostManagement, WarningMsg_ProjectRequired %>"
                                                NoWrap="true" Width="200px" Height="300px"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="False" CommandName="Update" CssClass="GridCmdUpdate">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdate" meta:resourcekey="lblUpdate" runat="server" Text="Update"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                                CommandName="RebindGrid">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                                            </asp:LinkButton>
                                        </td>

                                    </tr>
                                </table>
                            </CommandItemTemplate>--%>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings AllowDragToGroup="false">
                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                AllowColumnResize="True"></Resizing>
                            <Scrolling UseStaticHeaders="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>

            </td>
        </tr>
        <tr>
            <td style="padding-top: 0; padding-left: 24px; ">
                <asp:LinkButton ID="btnCopyProjectCodes" meta:resourcekey="btnCopyProjectCodes" runat="server" CausesValidation="false"
                    OnClientClick="return OpenProjectCodesLookup();" CssClass="lnkButton"
                    Text="Copy Project Codes" ></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
