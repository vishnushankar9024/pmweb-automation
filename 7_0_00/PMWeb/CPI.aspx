<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CPI.aspx.vb" Inherits="Website.CPI" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                } 
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgCPI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCPI" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" >
        <tr class="ToolBar SmallToolbar" valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <%--<td class="ToolbarTd">
                            <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=204">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                            </asp:HyperLink>
                        </td>--%>
                        <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                            <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td style="width: 240px" class="ToolbarTd showOnIpad">
                            <telerik:RadComboBox ID="ddlCPI" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" CloseDropDownOnBlur="true" meta:ResourceKey="ddlCPI"
                                EmptyMessage="Select a CPI..." Width="240px" Style="min-width: 105px"
                                AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="400px"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                            </telerik:RadComboBox>
                        </td>
                        <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="false">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"
                                        meta:resourcekey="RadToolBarButtonResource1">
                                    </telerik:RadToolBarButton>--%>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true" CommandName="Save"
                                        AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                                        <Buttons>
                                            <telerik:RadToolBarButton ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton ImageUrl="Images/Global/AddLine.png"
                                                CommandName="Copy" ValidationGroup="Save">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)"
                                        Value="Delete" CausesValidation="False">
                                    </telerik:RadToolBarButton>
                                    <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>--%>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif" Style="margin: 20px !important">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Active" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="InActive" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('CPI');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CausesValidation="false" Value="Activate"
                                         OuterCssClass="HideOnMobileToolbar" CommandName="Activation" ToolTip="Activate"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="PMMainPage documentSinglePage">
        <div class="row">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblID" meta:ResourceKey="lblID" runat="server" Text="ID*"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtID" MaxLength="50" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvId" ControlToValidate="txtID"
                                runat="server" CssClass="Validator" Display="Dynamic"
                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblCPIIdUnique" runat="server" meta:Resourcekey="lblCPIIdUnique" Visible="False" Class="Validator"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblName" meta:ResourceKey="lblName" runat="server" Text="Name"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtName" MaxLength="50" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                    <textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />
                    <telerik:RadGrid ID="rdgCPI" runat="server" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" FilterType="HeaderContext" CssClass="ResponsiveMargin"
                        EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        AutoGenerateColumns="False" ShowStatusBar="false" PageSize="10" HasPasteFromExcel="true"
                        AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="true" UseEditFormInMobile="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <ValidationSettings CommandsToValidate="UpdateEdited,PerformInsert" ValidationGroup="CPI" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" AllowSorting="true" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Year*" SortExpression="Year" UniqueName="Year" DataField="Year">
                                    <ItemTemplate>
                                        <span>
                                            <%#Eval("Year")%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadNumericTextBox ID="rntYear" ShowSpinButtons="true"
                                            IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                            Label="" runat="server" Width="75px" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>"
                                            MaxValue="2100" MinValue="1899">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="rntYear"
                                            CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ValidationGroup="CPI"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Jan" SortExpression="Jan" UniqueName="Jan" DataField="Jan">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Jan"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtJan" MaxLength="100" runat="server" Text='<%# FormatNumber(Eval("Jan"), 3)%>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Feb" SortExpression="Feb" UniqueName="Feb" DataField="Feb">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Feb"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFeb" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Feb"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Mar" SortExpression="Mar" UniqueName="Mar" DataField="Mar">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Mar"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMar" MaxLength="100" runat="server" Text='<%# FormatNumber(Eval("Mar"), 3)%>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Apr" SortExpression="Apr" UniqueName="Apr" DataField="Apr">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Apr"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtApr" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Apr"), 3)%>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="May" SortExpression="May" UniqueName="May" DataField="May">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("May"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMay" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("May"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Jun" SortExpression="Jun" UniqueName="Jun" DataField="Jun">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Jun"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtJun" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Jun"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Jul" SortExpression="Jul" UniqueName="Jul" DataField="Jul">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Jul"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtJul" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Jul"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Aug" SortExpression="Aug" UniqueName="Aug" DataField="Aug">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Aug"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAug" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Aug"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Sep" SortExpression="Sep" UniqueName="Sep" DataField="Sep">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Sep"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSep" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Sep"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Oct" SortExpression="Oct" UniqueName="Oct" DataField="Oct">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Oct"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtOct" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Oct"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Nov" SortExpression="Nov" UniqueName="Nov" DataField="Nov">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Nov"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNov" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Nov"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Dec" SortExpression="Dec" UniqueName="Dec" DataField="Dec">
                                    <ItemTemplate>
                                        <%# FormatNumber(Eval("Dec"), 3)%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDec" MaxLength="100" runat="server" Text='<%#FormatNumber(Eval("Dec"), 3) %>' Width="100%" Precision="3" CssClass="Double"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgCPI.EditIndexes.Count = 0 And (Not rdgCPI.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCPI.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true"
                                        SecurityButtonType="AddEditMode_Add"
                                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgCPI.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgCPI.EditIndexes.Count > 0 Or rdgCPI.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Add"
                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgCPI.EditIndexes.Count = 0 And (Not rdgCPI.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                        SecurityButtonType="ItemMode_Delete"
                                        Visible='<%# rdgCPI.EditIndexes.Count = 0 And (Not rdgCPI.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgCPI.EditIndexes.Count = 0 And (Not rdgCPI.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnExportExcel" runat="server"
                                        SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                        Visible='<%# rdgCPI.EditIndexes.Count = 0 And (Not rdgCPI.MasterTableView.IsItemInserted)%>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label12" Text="Export To Exel" runat="server"></asp:Label>
                                        &nbsp;&nbsp
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                        SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                        EnableShadows="true" CausesValidation="false"
                                        Visible="true">
                                    </telerik:RadMenu>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowColumnsReorder="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                    <input type="button" id="btnClipborad" class="Hide" runat="server" />
                    <input type="hidden" id="hdClipboard" runat="server" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>
