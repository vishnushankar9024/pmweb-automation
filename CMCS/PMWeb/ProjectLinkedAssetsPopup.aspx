<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProjectLinkedAssetsPopup.aspx.vb" Inherits="Website.ProjectLinkedAssetsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>


        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rdgAssets" runat="server" HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                            AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11" AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                            <MasterTableView DataKeyNames="Id" CommandItemDisplay="None" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" Groupable="false" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="140px" SortExpression="Suite">
                                                                        <ItemTemplate>
                                                                            <span><%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-Width="140px" SortExpression="Property">
                                                                        <ItemTemplate>
                                                                            <span><%# IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Building" HeaderStyle-Width="140px" SortExpression="Building">
                                                                        <ItemTemplate>
                                                                            <span><%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Floor" SortExpression="Floor">
                                                                        <ItemTemplate>
                                                                            <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Space" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Space" SortExpression="Space">
                                                                        <ItemTemplate>
                                                                            <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Equipment" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-Width="140px" SortExpression="Equipment">
                                                                        <ItemTemplate>
                                                                            <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>&nbsp;  
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                            <ClientSettings Resizing-AllowColumnResize="true">
                                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                            </table>
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
