<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetUserDefinedFieldsConfiguration.ascx.vb" Inherits="Website.AssetUserDefinedFieldsConfiguration" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAssetUserDefinedFields">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlAssetEntities">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlAssetEntities" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlObjectTypes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlAssetEntities" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMMainPage documentSinglePage">
    <div class="row">
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTitle" meta:Resourcekey="lblTitle" runat="server" Text="Entities"></asp:Label>

                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlAssetEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
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
                        <asp:Label ID="lblRecordType" meta:Resourcekey="lblRecordType" runat="server" Text="Record Type"></asp:Label></td>
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
                <telerik:RadGrid ID="rdgAssetUserDefinedFields" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true"
                    AutoGenerateColumns="False" ShowStatusBar="true" Width="100%"
                    AllowMultiRowEdit="True" AllowMultiRowSelection="true" UseEditFormInMobile="true">
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
                                        <asp:LinkButton ID="imgCalculation" runat="server" class="FormulaButton"
                                            OnClientClick='<%# "return openAssetCalculationPopup(" & Eval("Id") & ",this);" %>'>
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
                                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgAssetUserDefinedFields.EditIndexes.Count = 0 And (Not rdgAssetUserDefinedFields.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"
                                    SecurityButtonType="AddEditMode_Edit"
                                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgAssetUserDefinedFields.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>


                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                    SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgAssetUserDefinedFields.EditIndexes.Count > 0 Or rdgAssetUserDefinedFields.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgAssetUserDefinedFields.EditIndexes.Count = 0 And (Not rdgAssetUserDefinedFields.MasterTableView.IsItemInserted) %>'>
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

