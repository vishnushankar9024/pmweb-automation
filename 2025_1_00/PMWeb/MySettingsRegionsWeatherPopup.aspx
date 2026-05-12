<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MySettingsRegionsWeatherPopup.aspx.vb" Inherits="Website.MySettingsRegionsWeatherPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">

        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgActions = $("div[id$='rdgRegionsWeather']");
            var j = 0;
            var k = 0;
            rdgActions.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });
            rdgActions.find("input[type='checkbox']").each(function () {
                chkActionChange(this)
            });


            var Value = 0
            if (iObj.checked) {
                Value = Value + j;
            }
            else {
                if ((Value - k) >= 0)
                    Value = Value - k;
            }
        }


        function chkActionChange(sender) {

            var rdgActions = $("div[id$='rdgRegionsWeather']");
            var chkPArent = rdgActions.find("input[type='checkbox']")[0];
            var i = 0;
            var isChecked = true;
            rdgActions.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (sender.checked) {
                        if (!this.disabled && !this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                    }
                }
                i++;
            });


            if (!sender.checked) {
                chkPArent.checked = false;
            } else {
                chkPArent.checked = isChecked;

            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />




        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton Value="Save" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton Value="SaveAndClose" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rdgRegionsWeather" AllowMultiRowSelection="true" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                HeaderStyle-Font-Size="8" Width="99%" Height="190px" AutoGenerateColumns="False"
                                                AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" UseEditFormInMobile ="true">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="IsSelected" DataType="System.Boolean" DataField="IsSelected" AllowSorting="false">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" Checked="true" runat="server" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# CBool(Eval("IsSelected"))%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                &nbsp;
                                                            </EditItemTemplate>
                                                            <ItemStyle Wrap="False" />
                                                            <HeaderStyle Width="50px"></HeaderStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Region" UniqueName="Region" SortExpression="Region">
                                                            <ItemTemplate>
                                                                <span>
                                                                    <%#IIf(Container.DataItem("Region").ToString = String.Empty, "&nbsp;", Container.DataItem("Region").ToString)%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtRegionName" runat="server" Width="150px">
                                                                </asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvRegionName" ControlToValidate="txtRegionName" ValidationGroup="Save"
                                                                    runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                                </asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="System" UniqueName="Metric" SortExpression="Metric" AllowSorting="false">
                                                            <ItemTemplate>
                                                                <telerik:RadComboBox ID="ddlSystem" runat="server" Width="100%">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Imperial" Value="False" />
                                                                        <telerik:RadComboBoxItem Text="Metric"  Value="True" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                &nbsp;
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <FooterStyle CssClass="GridFooter" />
                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">
                                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" securitybuttontype="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                                                CommandName="PerformInsert" Visible='<%# rdgRegionsWeather.MasterTableView.IsItemInserted%>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" securitybuttontype="AddEditMode" CssClass="GridCmdCancelAll"
                                                                CommandName="CancelAll" Visible='<%# rdgRegionsWeather.EditIndexes.Count > 0 Or rdgRegionsWeather.MasterTableView.IsItemInserted%>'
                                                                meta:resourcekey="btnCancelResource1">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" securitybuttontype="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                                                CommandName="InitNewRow" Visible='<%# rdgRegionsWeather.EditIndexes.Count = 0 And (Not rdgRegionsWeather.MasterTableView.IsItemInserted)%>'
                                                                meta:resourcekey="btnAddResource1">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                                securitybuttontype="ItemMode_Delete" Visible='<%# rdgRegionsWeather.EditIndexes.Count = 0 And (Not rdgRegionsWeather.MasterTableView.IsItemInserted)%>'
                                                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" securitybuttontype="ItemMode" CssClass="GridCmdRebindGrid"
                                                                CommandName="RebindGrid" Visible='<%# rdgRegionsWeather.EditIndexes.Count = 0 And (Not rdgRegionsWeather.MasterTableView.IsItemInserted)%>'
                                                                meta:resourcekey="btnRefreshResource1">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1">
                                                                </asp:Label>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false"
                                                    Resizing-AllowColumnResize="False" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                                        AllowColumnResize="True" />
                                                </ClientSettings>
                                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert" />
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>


    </form>
</body>
</html>
