<%@ Page Language="vb" meta:resourcekey="PageTitle" Title="Close Collaborate" AutoEventWireup="false" CodeBehind="DocumentTeamClosePopup.aspx.vb" Inherits="Website.DocumentTeamClosePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:160px !important;">
                                <asp:Label ID="lblSubmitter" runat="server" Text="Submitter" meta:resourcekey="lblSubmitter"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:240px !important;">
                                <asp:TextBox ID="txtSubmitter" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSendEmail" runat="server" Text="Send Email" meta:resourcekey="lblSendEmail"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkSendEmail" runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessage"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="80px" InputType="Text"></telerik:RadTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="2" style="width:100%;">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblTeamProgress" runat="server" Text="Team Progress" meta:resourcekey="lblTeamProgress"></asp:Label>
                                    </legend>
                                    <telerik:RadGrid ID="rdgTeamProgress" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                                    Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False" FitParentContainer="true"
                                    AllowSorting="False" GridLines="None" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="None" TableLayout="Fixed"
                                        Width="300px" UseAllDataFields="true" EnableHeaderContextMenu="False">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%#Eval("TeamMemberName").ToString%>&nbsp;
                                                </ItemTemplate>
                                                <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProgress" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                <HeaderStyle Wrap="false" Width="198px" HorizontalAlign="Left" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                            AllowColumnResize="False" />
                                        <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
