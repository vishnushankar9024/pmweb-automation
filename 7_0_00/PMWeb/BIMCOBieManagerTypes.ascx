<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIMCOBieManagerTypes.ascx.vb" Inherits="Website.BIMCOBieManagerTypes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamFloor" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgType">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgType" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpType" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgType" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true"
                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" CssClass="WithoutTopBorder"
                AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Right"
                            HeaderStyle-Width="5%" SortExpression="Id">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("SortOrder").ToString = String.Empty, "&nbsp;", Container.DataItem("SortOrder").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#IIf(Eval("SortOrder") Is DBNull.Value, String.Empty, Eval("SortOrder").ToString)%>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name"
                            DataField="Name" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" SortExpression="Name">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Name")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy" DataField="CreatedBy"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" SortExpression="CreatedBy">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CreatedBy").ToString = String.Empty, "&nbsp;", Container.DataItem("CreatedBy").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCreatedBy" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("CreatedBy")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Created On" UniqueName="CreatedOn" DataField="CreatedOn"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" SortExpression="CreatedOn">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("CreatedOn")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("CreatedOn")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpCreatedOn" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default"
                                    EnableTyping="True">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category"
                            DataField="Category" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="Category">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCategory" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("Category")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                            DataField="Description" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" SortExpression="Description">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset Type" UniqueName="AssetType"
                            DataField="AssetType" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="AssetType">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssetType").ToString = String.Empty, "&nbsp;", Container.DataItem("AssetType").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssetType" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("AssetType")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manufacture" UniqueName="Manufacture" DataField="Manufacture" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Manufacture">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Manufacture").ToString = String.Empty, "&nbsp;", Container.DataItem("Manufacture").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtManufacture" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Manufacture")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Model Number" UniqueName="ModelNumber" HeaderStyle-Width="120px"
                            DataField="ModelNumber" HeaderStyle-HorizontalAlign="Center" SortExpression="ModelNumber">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ModelNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("ModelNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModelNumber" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ModelNumber")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Guarrantor Parts" UniqueName="WarrantyGuarrantorParts" HeaderStyle-Width="120px"
                            DataField="WarrantyGuarrantorParts" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyGuarrantorParts">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyGuarrantorParts").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyGuarrantorParts").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyGuarrantorParts" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyGuarrantorParts")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Duration Parts" UniqueName="WarrantyDurationParts" HeaderStyle-Width="120px"
                            DataField="WarrantyDurationParts" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDurationParts">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDurationParts").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDurationParts").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDurationParts" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyDurationParts")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Guarantor Labor" UniqueName="WarrantyGuarantorLabor" DataField="WarrantyGuarantorLabor" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyGuarantorLabor">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyGuarantorLabor").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyGuarantorLabor").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyGuarantorLabor" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WarrantyGuarantorLabor")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Duaration Labor" UniqueName="WarrantyDuarationLabor" DataField="WarrantyDuarationLabor" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDuarationLabor">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDuarationLabor").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDuarationLabor").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDuarationLabor" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WarrantyDuarationLabor")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Duration Unit" UniqueName="WarrantyDurationUnit" DataField="WarrantyDurationUnit" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDurationUnit">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDurationUnit").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDurationUnit").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDurationUnit" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WarrantyDurationUnit")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. System" UniqueName="ExtSystem" DataField="ExtSystem" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtSystem">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtSystem").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtSystem").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtSystem" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtSystem")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Object" UniqueName="ExtObject" DataField="ExtObject" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtObject">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtObject").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtObject").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtObject" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtObject")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Identifier" UniqueName="ExtIdentifier" DataField="ExtIdentifier" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExtIdentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExtIdentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("ExtIdentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtIdentifier" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExtIdentifier")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Replacement Cost" UniqueName="ReplacementCost" DataField="ReplacementCost" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ReplacementCost">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ReplacementCost").ToString = String.Empty, "&nbsp;", Container.DataItem("ReplacementCost").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReplacementCost" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ReplacementCost")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Expected Life" UniqueName="ExpectedLife" DataField="ExpectedLife" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExpectedLife">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExpectedLife").ToString = String.Empty, "&nbsp;", Container.DataItem("ExpectedLife").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExpectedLife" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExpectedLife") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Duration Unit" UniqueName="DurationUnit" DataField="DurationUnit" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="DurationUnit">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("DurationUnit").ToString = String.Empty, "&nbsp;", Container.DataItem("DurationUnit").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDurationUnit" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("DurationUnit")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Warranty Description" UniqueName="WarrantyDescription" HeaderStyle-Width="120px"
                            DataField="WarrantyDescription" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDescription">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDescription").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDescription" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WarrantyDescription")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Nominal Length" UniqueName="NominalLength" DataField="NominalLength" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NominalLength">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalLength").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalLength").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalLength" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalLength")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Nominal Width" UniqueName="NominalWidth" DataField="NominalWidth" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NominalWidth">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalWidth").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalWidth").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalWidth" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalWidth")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Nominal Height" UniqueName="NominalHeight" DataField="NominalHeight" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NominalHeight">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalHeight").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalHeight").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalHeight" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalHeight")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Model Reference" UniqueName="ModelReference" HeaderStyle-Width="120px"
                            DataField="ModelReference" HeaderStyle-HorizontalAlign="Center" SortExpression="ModelReference">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ModelReference").ToString = String.Empty, "&nbsp;", Container.DataItem("ModelReference").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModelReference" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ModelReference")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Shape" UniqueName="Shape" DataField="Shape" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Shape">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Shape").ToString = String.Empty, "&nbsp;", Container.DataItem("Shape").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtShape" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Shape")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" DataField="Size" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Size">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Size").ToString = String.Empty, "&nbsp;", Container.DataItem("Size").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSize" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Size")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="120px"
                            DataField="Color" HeaderStyle-HorizontalAlign="Center" SortExpression="Color">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Color").ToString = String.Empty, "&nbsp;", Container.DataItem("Color").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtColor" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Color")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="Finish" DataField="Finish" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Finish">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Finish").ToString = String.Empty, "&nbsp;", Container.DataItem("Finish").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFinish" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Finish") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Grade" UniqueName="Grade" DataField="Grade" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Grade">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Grade").ToString = String.Empty, "&nbsp;", Container.DataItem("Grade").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtGrade" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Grade") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Material" UniqueName="Material" HeaderStyle-Width="120px"
                            DataField="Material" HeaderStyle-HorizontalAlign="Center" SortExpression="Material">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Material").ToString = String.Empty, "&nbsp;", Container.DataItem("Material").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMaterial" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("Material")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Constituents" UniqueName="Constituents" DataField="Constituents" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Constituents">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Constituents").ToString = String.Empty, "&nbsp;", Container.DataItem("Constituents").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtConstituents" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Constituents")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Features" UniqueName="Features" DataField="Features" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Features">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Features").ToString = String.Empty, "&nbsp;", Container.DataItem("Features").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFeatures" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Features") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Accessibility" UniqueName="Accessibility" HeaderStyle-Width="120px"
                            DataField="Accessibility" HeaderStyle-HorizontalAlign="Center" SortExpression="Accessibility">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Accessibility").ToString = String.Empty, "&nbsp;", Container.DataItem("Accessibility").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAccessibility" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("Accessibility")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Code Performance" UniqueName="CodePerformance" HeaderStyle-Width="120px"
                            DataField="CodePerformance" HeaderStyle-HorizontalAlign="Center" SortExpression="CodePerformance">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CodePerformance").ToString = String.Empty, "&nbsp;", Container.DataItem("CodePerformance").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCodePerformance" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("CodePerformance")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Sustainability Performance" UniqueName="SustainabilityPerformance" HeaderStyle-Width="120px"
                            DataField="SustainabilityPerformance" HeaderStyle-HorizontalAlign="Center" SortExpression="SustainabilityPerformance">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("SustainabilityPerformance").ToString = String.Empty, "&nbsp;", Container.DataItem("SustainabilityPerformance").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSustainabilityPerformance" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("SustainabilityPerformance") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgType.EditIndexes.Count = 0 And (Not rdgType.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="LocationGroup" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgType.EditIndexes.Count > 0%>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup" SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgType.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgType.EditIndexes.Count > 0 Or rdgType.MasterTableView.IsItemInserted%>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgType.EditIndexes.Count = 0 And (Not rdgType.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgType.EditIndexes.Count = 0 And (Not rdgType.MasterTableView.IsItemInserted)%>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgType.EditIndexes.Count = 0 And (Not rdgType.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true"
                    Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
