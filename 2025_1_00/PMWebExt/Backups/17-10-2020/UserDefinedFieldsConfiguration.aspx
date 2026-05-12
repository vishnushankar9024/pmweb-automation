<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="UserDefinedFieldsConfiguration.aspx.vb" Inherits="Website.UserDefinedFieldsConfiguration" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssetUserDefinedFieldsConfiguration.ascx" TagName="AssetUserDefinedFields" TagPrefix="uc1" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script type="text/javascript">
        function rdvOccupantNodeClicking(sender, args) {
            var comboBox = $find(sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlTypes')) + '_ddlTypes');
            var node = args.get_node();
            var strText = "";
            var strValue = "";
            strValue = node.get_value();
            if (strValue.indexOf("D") > 0) return;
            while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                strText = "/" + node.get_text() + strText;
                node = node.get_parent();
            }
            strText = strText.substr(1, strText.toString().length - 1);
            comboBox.set_text(strText);
            comboBox.trackChanges();
            comboBox.get_items().getItem(0).set_value(strValue);
            comboBox.commitChanges();
            comboBox.hideDropDown();
        }
        function openCalculationPopup(FieldId, SenderId) {
            OpenPOPUp('UDFCalcutionHelper.aspx?Sender=UDF&FieldId=' + FieldId + '&SenderId=' + SenderId.id, 745, 563, true, 'rdgUserDefinedFields');
            return false;
        }

        function openAssetCalculationPopup(FieldId, SenderId) {
            OpenPOPUp('UDFCalcutionHelper.aspx?Sender=AssetUDF&FieldId=' + FieldId + '&SenderId=' + SenderId.id, 745, 563, true, 'rdgUserDefinedFields');
            return false;
        }

        //    function ShowHideCalculation(ComboBoxClientId,FieldTypeId) {
        //      
        //        var ClientId = ComboBoxClientId.substring(0, ComboBoxClientId.indexOf('_ddlTypes'));


        //        if (FieldTypeId <= 3) {
        //          
        //            var ImgControlStr = ClientId + '_imgCalculation';
        //            var txtControlStr = ClientId + '_txtCalculation';
        //          
        //            $("#" + ImgControlStr).css({ 'display': 'block' });
        //            $("#" + txtControlStr).css({ 'display': 'block' });

        //        }
        //        else {
        //            var ImgControlStr = ClientId + '_imgCalculation';
        //            var txtControlStr = ClientId + '_txtCalculation';
        //            $("#" + ImgControlStr).css({ 'display': 'none' });
        //            $("#" + txtControlStr).css({ 'display': 'none' });
        //        }

        //                 
        //    }
    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
<%--            <telerik:AjaxSetting AjaxControlID="rdgUserDefinedFields">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
           <%-- <telerik:AjaxSetting AjaxControlID="ddlEntities">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEntities" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <%--<telerik:AjaxSetting AjaxControlID="ddlObjectTypes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEntities" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpUserDefinedFields" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpUserDefinedFields">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpUserDefinedFields" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadAjaxLoadingPanel ID="ldpPeriods" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
                    runat="server" MultiPageID="mlpUserDefinedFields" Skin="Default" CssClass="documentTabWithoutToolbar EmailSetupTabs"
                    OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
                    <Tabs>
                        <telerik:RadTab Text="Projects" Value="Projects" Selected="True" />
                        <telerik:RadTab Text="Locations" Value="Locations" />
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="mlpUserDefinedFields" runat="server" SelectedIndex="0" CssClass="documentMultiPagesWithoutToolbar"
                    Width="100%" RenderSelectedPageOnly="true">
                    <telerik:RadPageView ID="pvProjects" runat="server">

                        <div class="PMMainPage documentSinglePage">
                            <div class="row">
                                <div class="col-4">
                                    <table class="colTable" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblTitle" meta:Resourcekey="lblProjectInitiative" runat="server" Text="Entities"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                                    EmptyMessage="Select Entity..." Width="100%" AutoPostBack="True" AllowCustomText="true"
                                                    CausesValidation="False" Height="400px" NoWrap="true"
                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:Resourcekey="ddlEntities"
                                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblRecordType" meta:Resourcekey="lblRecordType" runat="server" Text="Record Type"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlObjectTypes" runat="server" Height="400px"
                                                    Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                    CausesValidation="False" Filter="StartsWith">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="PMHeader">
                                <div class="row">
                                    <div class="col-12">
                                        <telerik:RadGrid ID="rdgUserDefinedFields" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true"
                                            AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" UseEditFormInMobile="true" CssClass="ResponsiveMargin"
                                            AllowMultiRowEdit="True" AllowMultiRowSelection="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                                <Columns>

                                                    <telerik:GridTemplateColumn HeaderText="Key Name" UniqueName="KeyName">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("KeyName") = String.Empty, "&nbsp;", Container.DataItem("KeyName"))%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <span><%#Eval("KeyName")%></span>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="150px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Visible"
                                                        UniqueName="Visible" HeaderStyle-Width="50px" ItemStyle-Wrap="false"
                                                        ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Visible")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                                alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chbVisible" Checked='<%# CBool(IIf(Eval("Visible") Is System.DBNull.Value, 0, Eval("Visible")))%>'
                                                                runat="server" class="mobile-switch" />
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Header" UniqueName="Header">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("Header") = String.Empty, "&nbsp;", Container.DataItem("Header"))%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtHeader" MaxLength="100" runat="server" Text='<%# Eval("Header") %>' Width="100%"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvHeader" runat="server" ControlToValidate="txtHeader"
                                                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic"
                                                                ForeColor="" ValidationGroup="Equipment" meta:resourcekey="rfvHeader"></asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="150px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type"
                                                        HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px" SortExpression="Type">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlTypes" AllowCustomText="false" runat="server" Skin="Default"
                                                                CloseDropDownOnBlur="true" Width="100%" NoWrap="true"
                                                                ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="" />
                                                                </Items>
                                                                <ItemTemplate>
                                                                    <telerik:RadTreeView ID="rdvTypes" Skin="Default" runat="server" Height="250px" Width="100%"
                                                                        MultipleSelect="false" ShowLineImages="false" OnNodeClick="ddlTypeNodeClicked" OnClientNodeClicking="rdvOccupantNodeClicking"
                                                                        OnNodeDataBound="rdvTypes_NodeDataBound" OnNodeExpand="rdvTypes_NodeExpand">
                                                                    </telerik:RadTreeView>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Calculation1" UniqueName="Calculation" HeaderStyle-Width="500px"
                                                        Groupable="false">
                                                        <ItemTemplate>
                                                            <%#IIf(Container.DataItem("Calculation") = String.Empty, "&nbsp;", RestoreCalculationFromUS(Container.DataItem("Calculation")))%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <div style="float: left; width: 90%">
                                                                <asp:TextBox ID="txtCalculation" MaxLength="500" runat="server" Text='<%# RestoreCalculationFromUS(IIf(Eval("Calculation") Is System.DBNull.Value, "", Eval("Calculation"))) %>'
                                                                    Width="90%"></asp:TextBox>
                                                            </div>
                                                            <div style="float: right; width: 10%">
                                                                <asp:LinkButton ID="imgCalculation" runat="server" CssClass="FormulaButton"
                                                                    OnClientClick='<%# "return openCalculationPopup(" & Eval("Id") & ",this);" %>'>
                                                                     <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="170px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <SortExpressions>
                                                </SortExpressions>
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">

                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode_Edit"
                                                            CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgUserDefinedFields.EditIndexes.Count = 0 And (Not rdgUserDefinedFields.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"
                                                            SecurityButtonType="AddEditMode_Edit"
                                                            CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgUserDefinedFields.EditIndexes.Count > 0 %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>


                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                                            SecurityButtonType="AddEditMode"
                                                            CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgUserDefinedFields.EditIndexes.Count > 0 Or rdgUserDefinedFields.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgUserDefinedFields.EditIndexes.Count = 0 And (Not rdgUserDefinedFields.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="true">
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            </ClientSettings>
                                            <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="UpdateEdited" />
                                        </telerik:RadGrid>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvLocations" runat="server">
                        <uc1:AssetUserDefinedFields ID="AssetUserDefinedFields" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
</asp:Content>
