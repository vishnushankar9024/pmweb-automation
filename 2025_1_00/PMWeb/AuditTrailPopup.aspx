<%@ Page meta:resourcekey="Page" Title="Audit Trail Transaction Details1" Language="vb" AutoEventWireup="false" CodeBehind="AuditTrailPopup.aspx.vb" Inherits="Website.AuditTrailPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .wrapcolumn{white-space:normal !important}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager> 
       <telerik:RadAjaxManager ID="RadajaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RDG">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RDG"  LoadingPanelID="ldpAuditTrail" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>    
        <telerik:RadAjaxLoadingPanel ID="ldpAuditTrail" runat="server" Skin="Default" />




                                <div class="PMMainPage PMPopupMainPage">
                                    <div class="row JustifyContent R3Cols">
                                        <div class="col-4 col-4-left">
                                            <table class="colTable" border="0">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblUser" runat="server" Text="User1" meta:resourcekey="lblUser"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtUser" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblDate" runat="server" Text="Date1" meta:resourcekey="lblDate"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDate" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblTime" runat="server" Text="Time1" meta:resourcekey="lblTime"></asp:Label>

                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtTime" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblSystemId" runat="server" Text="System ID1" meta:resourcekey="lblSystemId"></asp:Label>

                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtSystemId" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblActionType" runat="server" Text="Action Type1" meta:resourcekey="lblActionType"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtActionType" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-4 col-4-middle">
                                            <table class="colTable" border="0">

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblProjectLocation" runat="server" Text="Project/Location1" meta:resourcekey="lblProjectLocation"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtProjectLocation" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type1" meta:resourcekey="lblRecordType"></asp:Label>

                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtRecordType" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblRecord" runat="server" Text="Record1" meta:resourcekey="lblRecord"></asp:Label>

                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtRecord" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblTab" runat="server" Text="Tab1" meta:resourcekey="lblTab"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtTab" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblGrid" runat="server" Text="Grid1" meta:resourcekey="lblGrid"></asp:Label>

                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtGrid" MaxLength="500" Width="100%" runat="server" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-4 col-4-right">
                                        <table class="colTable" border="0">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblProgramLocation" runat="server" Text="Program/Location" meta:resourcekey="lblProgramLocation"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtProgramLocation" MaxLength="500" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                       </div>
                                    </div>

                                </div>

     <div class="PMHeader" style="padding-top:24px;">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
                     <telerik:RadGrid ID="RDG" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="60" allow-scroll="true" setwidth="true"
            ShowFooter="False" AllowPaging="True" ShowGroupPanel="false" AllowSorting="True" GridLines="None" FitPageHeightOffset="5" ClientSettings-Scrolling-AllowScroll="true">
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                InsertItemPageIndexAction="ShowItemOnFirstPage" Width="200px" EditMode="InPlace"
                EnableHeaderContextMenu="false" TableLayout="Fixed" ShowGroupFooter="false" GroupLoadMode="Client">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Field" DataField="FieldName"
                        UniqueName="FieldName" SortExpression="FieldName">
                        <ItemTemplate>
                            <span><%#IIf(CStr(Container.DataItem("FieldName")) = String.Empty, "&nbsp;", CStr(Container.DataItem("FieldName")))%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="300px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Old Value" DataField="FieldOldValue" ItemStyle-CssClass="wrapcolumn"
                        UniqueName="FieldOldValue" SortExpression="FieldOldValue" ItemStyle-Wrap="true">
                        <ItemTemplate>
                            <span>
                                <asp:Label runat="server" ID="lblOldValue"  style="white-space:normal!important;"></asp:Label>
                            </span>
                        </ItemTemplate>
                        <HeaderStyle Width="300px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="New Value" DataField="FieldValue" ItemStyle-CssClass="wrapcolumn"
                        UniqueName="NewValue" SortExpression="FieldValue" ItemStyle-Wrap="true">
                        <ItemTemplate>
                            <span>
                                <asp:Label runat="server" ID="lblNewValue" style="white-space:normal!important;"></asp:Label></span>
                        </ItemTemplate>

                        <HeaderStyle Width="300px"></HeaderStyle>
                    </telerik:GridTemplateColumn>

                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                <ItemStyle Wrap="false" />
            </MasterTableView>
            <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" ColumnsReorderMethod="Reorder" AllowDragToGroup="false">
                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false"
                    AllowColumnResize="True" />
            </ClientSettings>
        </telerik:RadGrid>
   </div>
        </div>
         </div>
       
    </form>
</body>
</html>
