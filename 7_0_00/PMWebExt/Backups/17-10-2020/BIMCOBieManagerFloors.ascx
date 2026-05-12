<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIMCOBieManagerFloors.ascx.vb"
    Inherits="Website.BIMCOBieManagerFloors" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamFloor" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgFloor">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgFloor" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
        </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpFloor" runat="server" Skin="Default" />
<table cellpadding="0" cellspacing="0"> 
    <tr>
        <td>
            <telerik:RadGrid ID="rdgFloor" AllowMultiRowSelection="true" runat="server"  SetWidth="true" AppendMenus = "true"
                 HeaderStyle-Font-Size="8" AutoGenerateColumns="False"
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
                        <telerik:GridTemplateColumn HeaderText="AccessibilityPerformance" UniqueName="AccessibilityPerformance"
                            DataField="AccessibilityPerformance" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="AccessibilityPerformance">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AccessibilityPerformance").ToString = String.Empty, "&nbsp;", Container.DataItem("AccessibilityPerformance").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAccessibilityPerformance" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("AccessibilityPerformance") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Area" UniqueName="Area" DataField="Area"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" SortExpression="Area">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Area").ToString = String.Empty, "&nbsp;", Container.DataItem("Area").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtArea" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Area") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assembly Code" UniqueName="AssemblyCode" DataField="AssemblyCode"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" SortExpression="AssemblyCode">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssemblyCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AssemblyCode").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssemblyCode" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("AssemblyCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assembly Description" UniqueName="AssemblyDescription"
                            DataField="AssemblyDescription" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="AssemblyDescription">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssemblyDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("AssemblyDescription").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssemblyDescription" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("AssemblyDescription") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="AssetAccountingType" UniqueName="AssetAccountingType"
                            DataField="AssetAccountingType" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="AssetAccountingType">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssetAccountingType").ToString = String.Empty, "&nbsp;", Container.DataItem("AssetAccountingType").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssetAccountingType" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("AssetAccountingType") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="AssetIdentifier" UniqueName="AssetIdentifier"
                            DataField="AssetIdentifier" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" SortExpression="AssetIdentifier">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("AssetIdentifier").ToString = String.Empty, "&nbsp;", Container.DataItem("AssetIdentifier").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssetIdentifier" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("AssetIdentifier") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="BarCode" UniqueName="BarCode" DataField="BarCode" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="BarCode">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("BarCode").ToString = String.Empty, "&nbsp;", Container.DataItem("BarCode").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBarCode" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("BarCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Classification Code" UniqueName="ClassificationCode" HeaderStyle-Width="120px"
                            DataField="ClassificationCode" HeaderStyle-HorizontalAlign="Center" SortExpression="ClassificationCode">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ClassificationCode").ToString = String.Empty, "&nbsp;", Container.DataItem("ClassificationCode").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtClassificationCode" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ClassificationCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Classification Description" UniqueName="ClassificationDescription" HeaderStyle-Width="120px"
                            DataField="ClassificationDescription" HeaderStyle-HorizontalAlign="Center" SortExpression="ClassificationDescription">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ClassificationDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("ClassificationDescription").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtClassificationDescription" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ClassificationDescription") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CodePerformance" UniqueName="CodePerformance" HeaderStyle-Width="120px"
                            DataField="CodePerformance" HeaderStyle-HorizontalAlign="Center" SortExpression="CodePerformance">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CodePerformance").ToString = String.Empty, "&nbsp;", Container.DataItem("CodePerformance").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCodePerformance" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("CodePerformance") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" DataField="Color" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Color">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Color").ToString = String.Empty, "&nbsp;", Container.DataItem("Color").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtColor" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Color") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Comments" UniqueName="Comments" DataField="Comments" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Comments">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Comments").ToString = String.Empty, "&nbsp;", Container.DataItem("Comments").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtComments" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Comments") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Constituents" UniqueName="Constituents" DataField="Constituents" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Constituents">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Constituents").ToString = String.Empty, "&nbsp;", Container.DataItem("Constituents").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtConstituents" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Constituents") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost" UniqueName="Cost" DataField="Cost" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Cost">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Cost").ToString = String.Empty, "&nbsp;", Container.DataItem("Cost").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCost" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Cost") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Description">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ExpectedLife" UniqueName="ExpectedLife" DataField="ExpectedLife" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ExpectedLife">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ExpectedLife").ToString = String.Empty, "&nbsp;", Container.DataItem("ExpectedLife").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExpectedLife" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ExpectedLife") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Family" UniqueName="Family" DataField="Family" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Family">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Family").ToString = String.Empty, "&nbsp;", Container.DataItem("Family").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFamily" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Family") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Family And Type" UniqueName="FamilyAndType" HeaderStyle-Width="120px"
                            DataField="FamilyAndType" HeaderStyle-HorizontalAlign="Center" SortExpression="FamilyAndType">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("FamilyAndType").ToString = String.Empty, "&nbsp;", Container.DataItem("FamilyAndType").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFamilyAndType" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("FamilyAndType") %>'></asp:TextBox>
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
                        <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="Finish" DataField="Finish" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Finish">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Finish").ToString = String.Empty, "&nbsp;", Container.DataItem("Finish").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFinish" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Finish") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="Function" UniqueName="Function" DataField="Function" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Function">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Function").ToString = String.Empty, "&nbsp;", Container.DataItem("Function").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFunction" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Function") %>'></asp:TextBox>
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
                        <telerik:GridTemplateColumn HeaderText="Height Offset From level" UniqueName="HeightOffsetFromlevel" HeaderStyle-Width="120px"
                            DataField="HeightOffsetFromlevel" HeaderStyle-HorizontalAlign="Center" SortExpression="HeightOffsetFromlevel">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("HeightOffsetFromlevel").ToString = String.Empty, "&nbsp;", Container.DataItem("HeightOffsetFromlevel").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtHeightOffsetFromlevel" MaxLength="500" Width="100%" runat="server" 
                                    Text='<%# Eval("HeightOffsetFromlevel") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="IfcExportAs" UniqueName="IfcExportAs" DataField="IfcExportAs" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="IfcExportAs">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("IfcExportAs").ToString = String.Empty, "&nbsp;", Container.DataItem("IfcExportAs").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtIfcExportAs" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("IfcExportAs") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="IfcExportType" UniqueName="IfcExportType" HeaderStyle-Width="120px"
                            DataField="IfcExportType" HeaderStyle-HorizontalAlign="Center" SortExpression="IfcExportType">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("IfcExportType").ToString = String.Empty, "&nbsp;", Container.DataItem("IfcExportType").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtIfcExportType" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("IfcExportType") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="InstallationDate" UniqueName="InstallationDate" HeaderStyle-Width="120px"
                            DataField="InstallationDate" HeaderStyle-HorizontalAlign="Center" SortExpression="InstallationDate">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("InstallationDate").ToString = String.Empty, "&nbsp;", Container.DataItem("InstallationDate").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtInstallationDate" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("InstallationDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Keynote" UniqueName="Keynote" DataField="Keynote" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Keynote">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Keynote").ToString = String.Empty, "&nbsp;", Container.DataItem("Keynote").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtKeynote" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Keynote") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Level" UniqueName="Level" DataField="Level" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Level">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Level").ToString = String.Empty, "&nbsp;", Container.DataItem("Level").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLevel" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Level") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" DataField="Manufacturer" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Manufacturer">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Manufacturer").ToString = String.Empty, "&nbsp;", Container.DataItem("Manufacturer").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtManufacturer" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Manufacturer") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mark" UniqueName="Mark" DataField="Mark" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Mark"> 
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Mark").ToString = String.Empty, "&nbsp;", Container.DataItem("Mark").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMark" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Mark") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Material" UniqueName="Material" DataField="Material" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Material">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Material").ToString = String.Empty, "&nbsp;", Container.DataItem("Material").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMaterial" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Material") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Model" UniqueName="Model" DataField="Model" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Model">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Model").ToString = String.Empty, "&nbsp;", Container.DataItem("Model").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModel" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Model") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ModelLabel" UniqueName="ModelLabel" DataField="ModelLabel" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="ModelLabel">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ModelLabel").ToString = String.Empty, "&nbsp;", Container.DataItem("ModelLabel").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModelLabel" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ModelLabel") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ModelReference" UniqueName="ModelReference" HeaderStyle-Width="120px"
                            DataField="ModelReference" HeaderStyle-HorizontalAlign="Center" SortExpression="ModelReference">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ModelReference").ToString = String.Empty, "&nbsp;", Container.DataItem("ModelReference").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModelReference" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ModelReference") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="NominalHeight" UniqueName="NominalHeight" HeaderStyle-Width="120px"
                            DataField="NominalHeight" HeaderStyle-HorizontalAlign="Center" SortExpression="NominalHeight">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalHeight").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalHeight").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalHeight" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalHeight") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="NominalLength" UniqueName="NominalLength" HeaderStyle-Width="120px"
                            DataField="NominalLength" HeaderStyle-HorizontalAlign="Center" SortExpression="NominalLength">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalLength").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalLength").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalLength" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalLength") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="NominalWidth" UniqueName="NominalWidth" DataField="NominalWidth" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="NominalWidth">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("NominalWidth").ToString = String.Empty, "&nbsp;", Container.DataItem("NominalWidth").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNominalWidth" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("NominalWidth") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Perimeter" UniqueName="Perimeter" DataField="Perimeter" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Perimeter">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Perimeter").ToString = String.Empty, "&nbsp;", Container.DataItem("Perimeter").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPerimeter" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Perimeter") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ProductionYear" UniqueName="ProductionYear" HeaderStyle-Width="120px"
                            DataField="ProductionYear" HeaderStyle-HorizontalAlign="Center" SortExpression="ProductionYear">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ProductionYear").ToString = String.Empty, "&nbsp;", Container.DataItem("ProductionYear").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProductionYear" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("ProductionYear") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Reference" UniqueName="Reference" DataField="Reference" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Reference">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Reference").ToString = String.Empty, "&nbsp;", Container.DataItem("Reference").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReference" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Reference") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="ReplacementCost" UniqueName="ReplacementCost" HeaderStyle-Width="120px"
                            DataField="ReplacementCost" HeaderStyle-HorizontalAlign="Center" SortExpression="ReplacementCost">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("ReplacementCost").ToString = String.Empty, "&nbsp;", Container.DataItem("ReplacementCost").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReplacementCost" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("ReplacementCost") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SerialNumber" UniqueName="SerialNumber" DataField="SerialNumber" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="SerialNumber">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("SerialNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("SerialNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSerialNumber" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("SerialNumber") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Shape" UniqueName="Shape" DataField="Shape" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Shape">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Shape").ToString = String.Empty, "&nbsp;", Container.DataItem("Shape").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtShape" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Shape") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Structural" UniqueName="Structural" DataField="Structural" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Structural">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Structural").ToString = String.Empty, "&nbsp;", Container.DataItem("Structural").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStructural" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Structural") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Structural Usage" UniqueName="StructuralUsage" HeaderStyle-Width="120px"
                            DataField="StructuralUsage" HeaderStyle-HorizontalAlign="Center" SortExpression="StructuralUsage">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("StructuralUsage").ToString = String.Empty, "&nbsp;", Container.DataItem("StructuralUsage").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStructuralUsage" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("StructuralUsage") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SustainabilityPerformance" UniqueName="SustainabilityPerformance" HeaderStyle-Width="120px"
                            DataField="SustainabilityPerformance" HeaderStyle-HorizontalAlign="Center" SortExpression="SustainabilityPerformance">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("SustainabilityPerformance").ToString = String.Empty, "&nbsp;", Container.DataItem("SustainabilityPerformance").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSustainabilityPerformance" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("SustainabilityPerformance") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="TagNumber" UniqueName="TagNumber" DataField="TagNumber" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="TagNumber">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("TagNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("TagNumber").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTagNumber" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TagNumber") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" DataField="Type" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Type">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtType" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Type") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type Comments" UniqueName="TypeComments" DataField="TypeComments" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="TypeComments">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("TypeComments").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeComments").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTypeComments" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TypeComments") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type Mark" UniqueName="TypeMark" DataField="TypeMark" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="TypeMark">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("TypeMark").ToString = String.Empty, "&nbsp;", Container.DataItem("TypeMark").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTypeMark" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TypeMark") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="URL" UniqueName="URL" DataField="URL" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px"
                            SortExpression="URL">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("URL").ToString = String.Empty, "&nbsp;", Container.DataItem("URL").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtURL" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("URL") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Vertical Projection" UniqueName="VerticalProjection" HeaderStyle-Width="120px"
                            DataField="VerticalProjection" HeaderStyle-HorizontalAlign="Center" SortExpression="VerticalProjection">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("VerticalProjection").ToString = String.Empty, "&nbsp;", Container.DataItem("VerticalProjection").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtVerticalProjection" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("VerticalProjection") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Volume" UniqueName="Volume" DataField="Volume" HeaderStyle-Width="120px"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="Volume">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("Volume").ToString = String.Empty, "&nbsp;", Container.DataItem("Volume").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtVolume" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Volume") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyDescription" UniqueName="WarrantyDescription" HeaderStyle-Width="120px"
                            DataField="WarrantyDescription" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDescription">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDescription").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDescription").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDescription" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyDescription") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyDurationLabor" UniqueName="WarrantyDurationLabor" HeaderStyle-Width="120px"
                            DataField="WarrantyDurationLabor" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDurationLabor">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDurationLabor").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDurationLabor").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDurationLabor" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyDurationLabor") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyDurationParts" UniqueName="WarrantyDurationParts" HeaderStyle-Width="120px"
                            DataField="WarrantyDurationParts" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyDurationParts">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyDurationParts").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyDurationParts").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyDurationParts" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyDurationParts") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyGuarantorLabor" UniqueName="WarrantyGuarantorLabor" HeaderStyle-Width="120px"
                            DataField="WarrantyGuarantorLabor" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyGuarantorLabor">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyGuarantorLabor").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyGuarantorLabor").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyGuarantorLabor" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyGuarantorLabor") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyGuarantorParts" UniqueName="WarrantyGuarantorParts" HeaderStyle-Width="120px"
                            DataField="WarrantyGuarantorParts" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyGuarantorParts">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyGuarantorParts").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyGuarantorParts").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyGuarantorParts" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyGuarantorParts") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="WarrantyStartDate" UniqueName="WarrantyStartDate" HeaderStyle-Width="120px"
                            DataField="WarrantyStartDate" HeaderStyle-HorizontalAlign="Center" SortExpression="WarrantyStartDate">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("WarrantyStartDate").ToString = String.Empty, "&nbsp;", Container.DataItem("WarrantyStartDate").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWarrantyStartDate" MaxLength="500" Width="100%" runat="server"
                                    Text='<%# Eval("WarrantyStartDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows"  Visible='<%# rdgFloor.EditIndexes.Count = 0 AND (Not rdgFloor.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="LocationGroup" CssClass="GridCmdUpdateEdited" CommandName="UpdateEdited" Visible='<%# rdgFloor.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                              <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                CommandName="PerformInsert" Visible='<%# rdgFloor.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll"  CssClass="GridCmdCancelAll" Visible='<%# rdgFloor.EditIndexes.Count > 0 Or rdgFloor.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow"  Visible='<%# rdgFloor.EditIndexes.Count = 0 AND (Not rdgFloor.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                             <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgFloor.EditIndexes.Count = 0 AND (Not rdgFloor.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                            <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" Visible='<%# rdgFloor.EditIndexes.Count = 0 AND (Not rdgFloor.MasterTableView.IsItemInserted) %>'
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
                    Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
