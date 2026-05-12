<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="CustomFormTableDesigner.aspx.vb" Inherits="Website.CustomFormTableDesigner" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CustomFormTableDesigner.ascx" TagName="CustomFormTableDesigner" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>


    <script language="javascript" type="text/javascript">
        function Showdiv(divId) {
            $("#" + divId).show();

        }

        function OnClientSelectedIndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            var divId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_divColumnLists'
            var div = $("#" + divId)
            if (item.get_index() == 4) {
                div.show();
                // document.getElementById(divId).style.display = 'inline';
            } else {
                div.hide();
                //  document.getElementById(divId).style.display = 'none';
            }

        }
        function ColumnListsIndexChanging(sender, eventArgs) {
            var item = eventArgs.get_item();
            if (document.getElementById('divColumnLists')) {
                if (item.get_index() == 4) {
                    document.getElementById('divColumnLists').style.display = '';
                } else {
                    document.getElementById('divColumnLists').style.display = 'none';
                }
            }
        }
        function openCalculationPopup2(FieldId, SenderId) {

            OpenPOPUp('UDFCalcutionHelper.aspx?Sender=CUSTOMCOLUMNS&FieldId=' + FieldId + '&SenderId=' + SenderId.id, 745, 563);
            return false;
        }
        function maintoolbarClick(sender, args) {
            var value = args.get_item().get_commandName();
            switch (value) {
                case 'OpenHeadDiv':
                    var popup = $('#headpopup')[0];
                    popup.style.display = 'block';
                    break;
            }
        }
        function headToolbarClick(sender, args) {
            if (args.get_item().get_commandName() == 'closeHead') {
                var popup = $('#headpopup')[0];
                popup.style.display = 'none';
            }
        }
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgCustomTable">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCustomTable" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgDefineColumns">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDefineColumns" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="CustomFormTableDesigner1" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarHeader ShowOnMobile" PostBack="false" CommandName="OpenHeadDiv"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div id="headpopup" class="SplitterPanePopup popupDiv">
            <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick">
                <Items>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead"></telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
            <div class="PMMainPage PMPopupMainPage" style="margin-top:50px;"">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblID" runat="server" Text="ID*" meta:Resourcekey="lblID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtID" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="txtID"
                                        CssClass="Validator" ErrorMessage="Required" 
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblName" runat="server" Text="Name*" meta:Resourcekey="lblName"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                        CssClass="Validator" ErrorMessage="Required" 
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblTableIsUsedInTemplate" Style="color: red;" runat="server" Text="Table is used in Template"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblWidth" runat="server" Text="Width"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtWidth" runat="server" CssClass="Integer"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDisplay" runat="server" Text="Display" meta:resourcekey="chkDisplay"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkDisplay" runat="server" AutoPostBack="True" CssClass="mobile-switch" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="PMMainPage PMPopupMainPage documentSinglePage" style=" margin-top:0px !important;">
            <div class="row">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td id="tdDefineColumns">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblDefineColumns" runat="server" meta:resourcekey="lblDefineColumns" Text="Define Columns"></asp:Label>
                                    </legend>
                                    <telerik:RadGrid ID="rdgDefineColumns" runat="server" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AutoGenerateColumns="False"
                                        GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True" Skin="Default"
                                        Width="100%" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" FitParentContainer="true" AppendMenus="true" UseEditFormInMobile="true">
                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace"
                                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                            NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                            <Columns>

                                                <telerik:GridTemplateColumn Groupable="false" HeaderStyle-Wrap="false" HeaderText="Column </br> Order" UniqueName="ColumnNumber" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("ColumnNumber").ToString()%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("ColumnNumber").ToString()%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="70px" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Column Title*" UniqueName="ColumnTitle" ItemStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("ColumnTitle")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtColumnTitle" MaxLength="50" runat="server" Width="99%" Text='<%# Eval("ColumnTitle") %>'></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvColumnTitle" runat="server"
                                                            ControlToValidate="txtColumnTitle" CssClass="Validator" Display="Dynamic"
                                                            ErrorMessage="&lt;br&gt;Enter the Column Title" ForeColor=""
                                                            meta:resourcekey="rfvColumnTitle" ValidationGroup="UserDefinedGrid"></asp:RequiredFieldValidator>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                    <ItemStyle VerticalAlign="Top" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="300px" HeaderText="Column Type" UniqueName="ColumnType" ItemStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblColumnType" runat="server" meta:resourcekey="lblColumnType"
                                                            Text='<%#IIf(Container.DataItem("ColumnType") = "String", "Text", Container.DataItem("ColumnType"))%> '></asp:Label>
                                                        <telerik:RadComboBox ID="ddlValues" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" NoWrap="True" Skin="Default"
                                                            Style="font-size: 11px">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table cellpadding="0" cellspacing="0" style="border-width: 0px" width="350px">
                                                            <tr>
                                                                <td style="width: 100px; text-align: left">
                                                                    <telerik:RadComboBox ID="ddlColumnTypes" runat="server"
                                                                        CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                        OnClientSelectedIndexChanging="ColumnListsIndexChanging" Skin="Default"
                                                                        Style="font-size: 11px" Width="100px">
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem1"
                                                                                Text="Text" Value="String" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem3"
                                                                                Text="Numeric" Value="Numeric" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem4"
                                                                                Text="Currency" Value="Currency" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem5"
                                                                                Text="Date" Value="Date" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem6"
                                                                                Text="List" Value="List" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem7"
                                                                                Text="Boolean" Value="Boolean" />
                                                                            <telerik:RadComboBoxItem runat="server" meta:resourcekey="RadComboBoxItem8"
                                                                                Text="Cost Code" Value="CostCode" />
                                                                        </Items>
                                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td style="width: 250px">
                                                                    <div id="divColumnLists" runat="server" style="display: none">
                                                                        <telerik:RadTextBox ID="txtLists" Visible="false" runat="server" LabelCssClass=""
                                                                            meta:resourcekey="txtLists" Skin="Default" Width="250px">
                                                                        </telerik:RadTextBox>
                                                                        <telerik:RadComboBox ID="ddlLists" AllowCustomText="false" runat="server"
                                                                            Skin="Default" CloseDropDownOnBlur="true" Height="350px" Width="150px" DropDownWidth="200px"
                                                                            Filter="Contains" MarkFirstMatch="true" NoWrap="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" ShowToggleImage="true">
                                                                        </telerik:RadComboBox>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="270px" />
                                                    <ItemStyle VerticalAlign="Top" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Width (px)" UniqueName="ColumnWidth" ItemStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <%#Container.DataItem("ColumnWidth")%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtColumnWidth" MaxLength="5" runat="server" Width="99%" Text='<%# Eval("ColumnWidth") %>' CssClass="Integer"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="80px" />
                                                    <ItemStyle VerticalAlign="Top" HorizontalAlign="Right"/>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Locked" UniqueName="IsLockeded">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsLocked"), "checked.png", "unchecked.png")) %>' />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkLocked" OnCheckedChanged="chkLocked_CheckedChanged" AutoPostBack="true" Checked='<%# CBool(IIf(Eval("IsLocked") Is System.DBNull.Value, 0, Eval("IsLocked")))%>' runat="server" CssClass="mobile-switch" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="80px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Required" UniqueName="IsRequired">
                                                    <ItemTemplate>
                                                        <img src='Images/Global/<%# CStr(IIf(Eval("IsRequired"), "checked.png", "unchecked.png")) %>' />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkRequired" Checked='<%# CBool(IIf(Eval("IsRequired") Is System.DBNull.Value, 0, Eval("IsRequired")))%>' runat="server" CssClass="mobile-switch" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="80px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Calculation1" UniqueName="Calculation" HeaderStyle-Width="500px" Groupable="false">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("Calculation") = String.Empty, "&nbsp;", RestoreCalculationFromUS(Container.DataItem("Calculation")))%>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <div style="float: left; width: 90%">
                                                            <asp:TextBox ID="txtCalculation" MaxLength="500" runat="server" Width="90%"
                                                                Text='<%# RestoreCalculationFromUS(IIf(Eval("Calculation") Is System.DBNull.Value, "", Eval("Calculation"))) %>'>
                                                            </asp:TextBox>
                                                        </div>
                                                        <div style="float: right; width: 10%">
                                                            <asp:LinkButton ID="imgCalculation" runat="server" CssClass="FormulaButton"
                                                                OnClientClick='<%# "return openCalculationPopup2(" & Eval("Id") & ",this);" %>'><span class="Icon"></span></asp:LinkButton>
                                                        </div>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="200px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                            </Columns>

                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    &nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                                        CommandName="EditRows" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count = 0 And (Not rdgDefineColumns.MasterTableView.IsItemInserted) %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                        SecurityButtonType="AddEditMode_Edit" ValidationGroup="UserDefinedGrid"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count > 0 %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                        SecurityButtonType="AddEditMode_Add" ValidationGroup="UserDefinedGrid"
                                                        Visible="<%# rdgDefineColumns.MasterTableView.IsItemInserted %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblSave" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"
                                                        CommandName="CancelAll" CssClass="GridCmdCancelAll" SecurityButtonType="AddEditMode"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count > 0 Or rdgDefineColumns.MasterTableView.IsItemInserted %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"
                                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count = 0 And (Not rdgDefineColumns.MasterTableView.IsItemInserted) %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False"
                                                        CommandName="DeleteRows" CssClass="GridCmdDeleteRows" OnClientClick="return ConfirmDelete()"
                                                        SecurityButtonType="ItemMode_Delete"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count = 0 And (Not rdgDefineColumns.MasterTableView.IsItemInserted) %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"
                                                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                                        Visible="<%# rdgDefineColumns.EditIndexes.Count = 0 And (Not rdgDefineColumns.MasterTableView.IsItemInserted) %>">
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <HeaderStyle Font-Size="8pt" />
                                        <ClientSettings EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                                        </ClientSettings>
                                        <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true" ValidationGroup="UserDefinedGrid" />
                                    </telerik:RadGrid>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="Col-12">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblLockedValues" runat="server" meta:resourcekey="lblLockedValues" Text="Enter Locked Values"></asp:Label>
                        </legend>
                        <uc1:CustomFormTableDesigner ID="CustomFormTableDesigner1" runat="server" />
                    </fieldset>
                </div>
            </div>
        </div>


        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" Behaviors="Close,Move"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
