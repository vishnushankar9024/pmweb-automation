<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderResults.ascx.vb" Inherits="Website.QueryBuilderResults" %>


<style>
    .RadForm_Office2007.rfdCheckbox input[type="checkbox"], .RadForm_Office2007.rfdCheckbox input[type="checkbox"][disable], .RadForm_Office2007.rfdCheckbox input[type="checkbox"]:hover {
        background-image: url("Images/Global/unchecked.png") !important;
        background-position-y: 0px !important;
    }

        .RadForm_Office2007.rfdCheckbox input[type="checkbox"]:checked, .RadForm_Office2007.rfdCheckbox input[type="checkbox"][disable]:checked {
            background-image: url("Images/Global/checked.png") !important;
            background-position-y: 0px !important;
        }
    /*RadForm_Office2007 .rfdCheckboxUnchecked, .RadForm_Office2007 .rfdCheckboxChecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxUnchecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxChecked*/

    .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxUnchecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxUnchecked:hover {
        background-image: url("Images/Global/unchecked.png") !important;
        background-position: 0px !important;
    }

    .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxChecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxChecked:hover {
        background-image: url("Images/Global/checked.png") !important;
        background-position: 0px !important;
    }

    .RadForm_Metro.rfdCheckbox input[type="checkbox"], .RadForm_Metro.rfdCheckbox input[type="checkbox"][disable], .RadForm_Metro.rfdCheckbox input[type="checkbox"]:hover {
        background-image: url("Images/Global/unchecked.png") !important;
        background-position-y: 0px !important;
    }

        .RadForm_Metro.rfdCheckbox input[type="checkbox"]:checked, .RadForm_Metro.rfdCheckbox input[type="checkbox"][disable]:checked {
            background-image: url("Images/Global/checked.png") !important;
            background-position-y: 0px !important;
        }
    /*RadForm_Office2007 .rfdCheckboxUnchecked, .RadForm_Office2007 .rfdCheckboxChecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxUnchecked, .RadForm_Office2007 .rfdInputDisabled.rfdCheckboxChecked*/

    .RadForm_Metro .rfdInputDisabled.rfdCheckboxUnchecked, .RadForm_Metro .rfdInputDisabled.rfdCheckboxUnchecked:hover {
        background-image: url("Images/Global/unchecked.png") !important;
        background-position: 0px !important;
    }

    .RadForm_Metro .rfdInputDisabled.rfdCheckboxChecked, .RadForm_Metro .rfdInputDisabled.rfdCheckboxChecked:hover {
        background-image: url("Images/Global/checked.png") !important;
        background-position: 0px !important;
    }
</style>
<telerik:RadAjaxManagerProxy ID="rajMgn1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RDG">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RC">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RC" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<asp:Panel ID="pnlChartMessage" runat="server" Width="100%">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblChartErrorOccured" runat="server" Text="Chart Error" CssClass="Validator"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblChartErrorDetails" runat="server" CssClass="Validator"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>
<telerik:RadChart ID="RC" runat="server" AutoLayout="true" Visible="false">
</telerik:RadChart>
<asp:Panel ID="pnlMessage" runat="server" Width="100%">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblErrorOccured" runat="server" Text="Query processing error, please check the query, the calculated fields and the filters." CssClass="Validator"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblErrorDetails" runat="server" CssClass="Validator"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top">
            <telerik:RadGrid ID="RDG" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" PageSize="20" AllowPaging="True" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                ShowGroupPanel="True" AllowMultiRowSelection="True" 
                AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"  FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right"
                    CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true" HeaderStyle-Width="200px" ShowGroupFooter="true"
                    EnableHeaderContextMenu="true" TableLayout="fixed" FilterItemStyle-Width="100px">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="$Bound1$" Display="False" AllowFiltering="True" DataType="System.String">
                        </telerik:GridTemplateColumn>
                        <telerik:GridDateTimeColumn UniqueName="$Date1$" Display="False" AllowFiltering="True" DataType="System.DateTime">
                        </telerik:GridDateTimeColumn>
                        <telerik:GridCheckBoxColumn UniqueName="$Boolean1$" Display="False" AllowFiltering="True" DataType="System.boolean">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridNumericColumn UniqueName="$Numeric1$" Display="False" AllowFiltering="True" DataType="System.Decimal">
                        </telerik:GridNumericColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                CommandName="SaveState">
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                CausesValidation="False" CommandName="LoadDefaultState">
                                &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ItemStyle Wrap="false" />
                <HeaderStyle Wrap="false" Width="200px" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
