<%@ Page Language="vb" AutoEventWireup="False" MasterPageFile="~/PmMaster.Master"
    ValidateRequest="false" CodeBehind="Language.aspx.vb" Inherits="Website.Language" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="JS/Language/Language.js"></script>
    <script language="javascript" type="text/javascript">

        function ToggleAssetMenu() {
            var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
            var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>');
            var tdAssetrestofpage = document.getElementById('<%=tdAssetrestofpage.ClientID %>');
            var btnTranslate = document.getElementById('btnTranslate');
            var btnGetDefaultValues = document.getElementById('btnGetDefaultValues');
            var form = $('form')[0]
            var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
            if (tdAssetMenu.style.display == 'none') {
                tdAssetMenu.style.display = '';
                tdAssetExplorerBar.style.left = "485px";
                tdAssetrestofpage.style.width = "calc(100% - 290px)";
                tdAssetrestofpage.className = "ShowMenuTree";
                tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBar';
                btnTranslate.className = "GridCmdReset";
                btnGetDefaultValues.className = "GridCmdTranslate";

                btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                //  form.className = form.className + ' ReportManagerTabs';
            } else {
                tdAssetMenu.style.display = 'none';
                tdAssetExplorerBar.style.left = "0px";
                tdAssetExplorerBar.style.width = "5px";
                tdAssetrestofpage.className = "HideMenuTree";
                tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBarClosed'
                btnTranslate.className = "GridCmdResethiddentree";
                btnGetDefaultValues.className = "GridCmdTranslatehiddentree";
                btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                //  form.className = form.className.replace(' ReportManagerTabsVisiible', '')
            }
            ResizeAllGrids();
            return false;
        }
        function OpenNewLanguagePopup(URL, Width, Height) {
            var wnd = window.radopen(URL);
            wnd.setSize(Width, Height);
            wnd.Center();
            return false;
        }


    </script>
    <style>
        .Search {
            background-image: url('Images/24Enabled.png');
            background-position: -216px 0;
            width: 24px;
            height: 24px;
        }


        @media screen and (max-width:880px) {
        
            .TreeDiv{
                height:calc(100vh - 168px) !important;
            }
        }

        @media screen and (min-width:881px) {
            .ReportManagerTree {
                height: calc(100vh - 155px) !important;
            }
        }
    </style>
  
    <table class="ToolBar" style="width: calc(100% - 200px); margin-top: 0px !important;" cellpadding="0" cellspacing="0" valign="top">
        <tr>
            <td>
                       <div style="height: 30px; background: #7396AA; line-height: 30px; color: white; padding-left: 24px;">
        <asp:Label runat="server" ID="lblLanguage" Style="text-transform: uppercase"></asp:Label>
        <asp:Label runat="server" ID="lblBreadCumb"></asp:Label>
    </div>
            </td>
        </tr>
   
        <tr>
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="ToolbarTd">
                            <telerik:RadComboBox ID="ddlLanguages" runat="server" AllowCustomText="True" MarkFirstMatch="True" Visible="true"
                                AutoPostBack="True" Height="100%" Style="width: 205px; white-space: normal; font-size: 11px;">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                <ItemTemplate>
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <%--   <td style="width: 30px;">
                                                <img id="imgLang" style="width: 30px;" runat="server" />
                                            </td>--%>
                                            <td style="padding: 3px 5px;">
                                                <%#Eval("Description")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <asp:LinkButton ID="btnAddNewLanguage" runat="server" CausesValidation="False" OnClientClick="return OpenPOPUpToRedirect('NewLanguage.aspx',1024,700)" CssClass="ToolbarNewLanguage">
                                <%--<asp:Label ID="lblAddNewLanguage" runat="server" Text="Language Manager"></asp:Label>--%>
                                <span class="Icon"></span>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width: 100%; padding-top: 80px;" cellpadding="0" border="0" cellspacing="0">
        <tr>
            <td valign="top" id="tdAssetMenu" runat="server" class="MobileAssetTree ReportManagerTree">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tr>
                        <td style="border-top: 1px solid #000000;">
                            <div style="overflow: auto; width: 300px; height: calc(100vh - 155px);padding-top:24px;background-color:#666666" class="TreeDiv">
                                <telerik:RadTreeView ID="treePages" runat="server" EnableEmbeddedSkins="False"
                                    ShowLineImages="False" CausesValidation="False" CssClass="DarkTree ReportManagerTree WhitePlusMinus">
                                    <ExpandAnimation Duration="100" />
                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                </telerik:RadTreeView>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="tdAssetExplorerBar" runat="server" class="AssetExplorerBar MobileAssetExplorerBar" style="width: 5px !important; background-color: #ffffff !important;">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="return ToggleAssetMenu();" />
            </td>
            <td valign="top" id="tdAssetrestofpage" runat="server" class="ShowMenuTree">
                <table cellpadding="0" cellspacing="0" style="width: calc(100% - 200px); height: calc(100vh - 150px);" class="RadGridDiv">
                    <tr>
                        <td style="vertical-align: top;">
                            <telerik:RadAjaxPanel runat="server" ID="rapLanguageManager" LoadingPanelID="ldpLanguage"
                                HorizontalAlign="NotSet" Width="100%">
                                <asp:Panel ID="pnlResource" runat="server">
                                    <asp:HiddenField ID="hdnResourceType" runat="server" />
                                    <div id="divAlert" style="display: none; padding: 7px;"></div>
                                    <telerik:RadGrid ID="rdgResource" Width="99%" SetWidth="true" runat="server" EnableEmbeddedSkins="False" AppendMenus="true"
                                        Skin="Default" AutoGenerateColumns="False" GroupingEnabled="false" ShowStatusBar="False" ClientSettings-Scrolling-AllowScroll="true"
                                        Font-Size="8px" PageSize="15" AllowPaging="False" ShowGroupPanel="False" AllowMultiRowEdit="False"
                                        AllowMultiRowSelection="true" AllowSorting="true" GridLines="None">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                        <MasterTableView CommandItemDisplay="Top" EditMode="InPlace" EnableHeaderContextMenu="false"
                                            InsertItemPageIndexAction="ShowItemOnFirstPage">
                                            <Columns>
                                                <telerik:GridClientSelectColumn ButtonType="PushButton">
                                                    <HeaderStyle Width="50px" />
                                                    <ItemStyle HorizontalAlign="center" Width="20px" />
                                                </telerik:GridClientSelectColumn>

                                                <telerik:GridTemplateColumn Display="true" Groupable="false" HeaderText="Resource Key" SortExpression="MetaResourceKey"
                                                    UniqueName="TemplateColumn">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblKey" runat="server" Text='<%# Container.DataItem("MetaResourceKey") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="220px" />
                                                    <ItemStyle HorizontalAlign="Left" Width="220px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="DefaultValue" HeaderText="Default Value" SortExpression="DefaultValue"
                                                    UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <div style="overflow: auto; width: 200px; display: inline; height: 30px">
                                                            <asp:Label ID="lblDefaultValue" runat="server" Text='<%# Container.DataItem("DefaultValue") %>'></asp:Label>&nbsp;
                                                        </div>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="250px" />
                                                    <ItemStyle HorizontalAlign="Left" Width="250px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Value" SortExpression="Value"
                                                    UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Container.DataItem("Value") %>'
                                                            Wrap="true" Width="300px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="350px" />
                                                    <ItemStyle HorizontalAlign="Left" Width="350px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="System Comments" SortExpression="Comment"
                                                    UniqueName="Comment">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblComment" runat="server" Text='<%# Container.DataItem("Comment") %>'></asp:Label>&nbsp;
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="200px" />
                                                    <ItemStyle HorizontalAlign="Left" Width="200px" Font-Italic="true" />
                                                </telerik:GridTemplateColumn>

                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                                    UpdateImageUrl="Update.gif">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td style="padding-left: 20px;">
                                                                <asp:LinkButton ID="btnTranslate" runat="server" CausesValidation="False" ClientIDMode="Static"
                                                                    CommandName="Translate" CssClass="GridCmdReset">
                                                                    <%--<img alt="" src="Images/Global/google.png" style="border: 0px; vertical-align: middle;" />--%>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblTranslate" runat="server" Text="Google Translate Selected Lines"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                &nbsp;&nbsp;
                                                                <asp:LinkButton ID="btnGetDefaultValues" runat="server" CausesValidation="False" OnClientClick="return GetDefaultValuesSelected('rdgResource');" ClientIDMode="Static"
                                                                    CommandName="Translate" CssClass="GridCmdTranslate">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="Label1" runat="server" Text="Reset to default value(s)"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <%-- <td>
                                                            <asp:LinkButton ID="btnRestoreDefault" runat="server" CausesValidation="False" CommandName="RestoreDefault">
                                                                <asp:Label ID="lblRestoreDefault" runat="server" Text="Restore default values"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                        </td>--%>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                        <FilterMenu Skin="Office2007" EnableTheming="True" EnableEmbeddedSkins="False">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                        <ClientSettings EnableRowHoverStyle="True" AllowColumnHide="True" AllowColumnsReorder="False"
                                            AllowDragToGroup="False" Resizing-AllowColumnResize="True">
                                            <Selecting EnableDragToSelectRows="False" AllowRowSelect="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu EnableEmbeddedSkins="False">
                                        </HeaderContextMenu>
                                    </telerik:RadGrid>
                                </asp:Panel>
                            </telerik:RadAjaxPanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" OnClientClick="Javascript:return ConfirmOnResourceFiles()" Style="display: none;" />
    <telerik:RadAjaxLoadingPanel ID="ldpLanguage" runat="server" Skin="Office2007" />
</asp:Content>
