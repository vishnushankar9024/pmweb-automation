<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DistributionList.aspx.vb" Inherits="Website.DistributionList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            function droppedOnGroup(sender, args) {
                var dest = args.get_destNode();
                var nodes = args.get_sourceNodes();
                var target = args.get_htmlElement();
                if (dest) {
                    args.set_cancel(true);
                }
            }
            var gridId = "ctl00_CPH1_tdOnSite";
            function isMouseOverGrid(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == gridId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }

                return null;
            }


            function rowDropping(sender, args) {
                var target = args.get_destinationHtmlElement();
                if (!target) return;

                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }

                var grid = isMouseOverGrid(target);
                if (grid) {
                    grid.style.cursor = "hand";
                }
                else {
                    args.set_cancel(true);
                }
            }


            function droppedOnGrid(args) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == gridId) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }


            function onNodeDropping(sender, args) {
                if (droppedOnGrid(args)) return;
            }



            function Program_ResetCombos(combobox, eventArgs) {
                var ddlProject = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                ddlProject.clearItems();
                ddlProject.set_text("");
                ddlProject.set_value("0");



            }

            function Main_GetValueFromProgram(combobox, eventArgs) {
                var SelectedValue;
                var ddlProgram = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProgram');
                SelectedValue = ddlProgram.get_value();
                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;

            }

            function ValidateProgramCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();

                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value >= 0) {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                        if (value.length == 0)
                            args.IsValid = false;
                    }
                }
                else
                    args.IsValid = true;
            }


        </script>

    </telerik:RadCodeBlock>
    <style type="text/css">
        @media screen and (min-width:320px) and (max-width:843px) {
            .marginBottomOnMobile {
                margin-bottom: 36px;
            }
        }
        .documentSinglePage {
            margin-bottom:0 !important;
        }
    </style>

    <telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgcmp">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgcmp" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgcmp" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=180">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd  showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">

                <telerik:RadComboBox ID="ddlDistrbutionList" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" EmptyMessage="Select Distribution List..."
                    Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                    Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlDistrbutionList">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=180" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                     <%--   <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="true" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                            Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <%--   <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif" >
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('DistributionList');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <div class="PMMainPage PMPopupMainPage documentSinglePage">
        <div class="row R3Cols">
            <div class="col-4 col-4-left">
                <table class="colTable">
                    <tr>
                        <td class="NoWrap labelWidth">
                            <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlProgram" OnClientSelectedIndexChanged="Program_ResetCombos"
                                Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                Skin="Default" NoWrap="true" Width="100%" Height="200px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfv_Program" runat="server"
                                ControlToValidate="ddlProgram" CssClass="Validator" InitialValue="" 
                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                            <asp:CustomValidator meta:Resourcekey="csv_Program" ID="csvPrograms" runat="server"
                                ControlToValidate="ddlProgram" ClientValidationFunction="ValidateCombo"
                                ValidationGroup="Save" Display="Dynamic" CssClass="Validator" >
                            </asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="labelWidth">
                        <td valign="top" class="NoWrap">
                            <asp:Label ID="lblProject" runat="server" meta:Resourcekey="lblProject" Text="Project"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlProjects" meta:Resourcekey="ddlProjects" runat="server" OnClientItemsRequesting="Main_GetValueFromProgram"
                                Skin="Default" EmptyMessage="Select Project..." AutoPostBack="True"
                                NoWrap="true" Width="100%" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            </telerik:RadComboBox>

                        </td>
                    </tr>



                </table>
            </div>
            <div class="col-4 col-4-middle">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCode" runat="server" MaxLength="15"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCode" meta:Resourcekey="rfv_Code" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                CssClass="Validator" Display="Dynamic" ErrorMessage="Required."
                                ForeColor=""></asp:RequiredFieldValidator>
                            <asp:Label ID="lblCommIDUnique" meta:Resourcekey="lblCommIDUnique" runat="server" Text="ID must be unique."
                                Visible="False" Class="Validator"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td class="NoWrap labelWidth">
                            <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtDescription" runat="server" MaxLength="255"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-4 col-4-right">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlTypes" AllowCustomText="true" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                Style="font-size: 11px" Width="100%">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="PMMainPage marginBottomOnMobile">
        <div class="row row-8-4-fit4">
            <div class="col-8">
                <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" ClientSettings-Scrolling-AllowScroll="true"
                    Width="100%" AutoGenerateColumns="False" AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" SetWidth="true" AppendMenus="true" FitParentContainer="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Company" CurrentFilterFunction="Contains"
                                DataField="Company" AutoPostBackOnFilter="true"
                                GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Type" CurrentFilterFunction="Contains"
                                DataField="Type" AutoPostBackOnFilter="true"
                                GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Reference" UniqueName="Reference" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Reference" CurrentFilterFunction="Contains"
                                DataField="Reference" AutoPostBackOnFilter="true"
                                GroupByExpression="Reference [GridColumn_Reference] Group By Reference ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Reference").ToString = String.Empty, "&nbsp;", Container.DataItem("Reference").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Contact" CurrentFilterFunction="Contains"
                                DataField="Contact" AutoPostBackOnFilter="true"
                                UniqueName="Contact" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Contact"
                                GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Contact").ToString = String.Empty, "&nbsp;", Container.DataItem("Contact").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Email" CurrentFilterFunction="Contains"
                                DataField="Email" AutoPostBackOnFilter="true"
                                UniqueName="Email" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Email"
                                GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Country" CurrentFilterFunction="Contains"
                                DataField="Country" AutoPostBackOnFilter="true"
                                UniqueName="Country" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="90px" SortExpression="Country"
                                GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Country").ToString = String.Empty, "&nbsp;", Container.DataItem("Country").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="City" CurrentFilterFunction="Contains"
                                DataField="City" AutoPostBackOnFilter="true"
                                UniqueName="City" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="City"
                                GroupByExpression="City [GridColumn_City] Group By City ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="State" CurrentFilterFunction="Contains"
                                DataField="State" AutoPostBackOnFilter="true"
                                UniqueName="State" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-Width="90px" SortExpression="State"
                                GroupByExpression="State [GridColumn_State] Group By State ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("State").ToString = String.Empty, "&nbsp;", Container.DataItem("State").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Department" CurrentFilterFunction="Contains"
                                DataField="Department" AutoPostBackOnFilter="true"
                                UniqueName="Department" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Department"
                                GroupByExpression="Department [GridColumn_Department] Group By Department ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Department").ToString = String.Empty, "&nbsp;", Container.DataItem("Department").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Title" CurrentFilterFunction="Contains"
                                DataField="Title" AutoPostBackOnFilter="true"
                                UniqueName="Title" HeaderStyle-HorizontalAlign="Left"
                                HeaderStyle-Width="120px" SortExpression="Title"
                                GroupByExpression="Title [GridColumn_Title] Group By Title ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <telerik:RadComboBox ID="ddlType" runat="server" Width="100px" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlType_SelectedIndexChanged"
                                    Style="font-size: 11px" SecurityButtonType="ItemMode" DropDownWidth="200px"
                                    Visible="true">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="0" Text="Contacts" Selected="true" />
                                        <telerik:RadComboBoxItem Value="1" Text="Companies" />
                                    </Items>
                                </telerik:RadComboBox>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgContacts.EditIndexes.Count = 0 And (Not rdgContacts.MasterTableView.IsItemInserted)%>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                        AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
            <div class="col-4 AddTopPadWhenUnfit">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblrdgcmp" runat="server" Text="Drop Companies and Contacts Here"></asp:Label>
                    </legend>
                </fieldset>
                <telerik:RadGrid ID="rdgcmp" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true"
                    HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="10"
                    AllowPaging="True" ShowFooter="false" ShowGroupPanel="True">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                SortExpression="LineNumber" Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <span>
                                        <%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" Width="40px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Company" HeaderStyle-HorizontalAlign="left"
                                HeaderStyle-Width="150px" UniqueName="Company" SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Contact" HeaderStyle-HorizontalAlign="left"
                                HeaderStyle-Width="105px" UniqueName="Contact" SortExpression="Contact" GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Contact").ToString = String.Empty, "&nbsp;", Container.DataItem("Contact").ToString)%></span>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Email" HeaderStyle-HorizontalAlign="left"
                                HeaderStyle-Width="145px" UniqueName="Email" SortExpression="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">

                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgcmp.EditIndexes.Count = 0 And (Not rdgcmp.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgcmp.EditIndexes.Count = 0 And (Not rdgcmp.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                            AllowColumnResize="True"></Resizing>
                    </ClientSettings>
                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true"
                        ValidationGroup="WorkOrder" />
                </telerik:RadGrid>
            </div>
        </div>
    </div>



</asp:Content>
