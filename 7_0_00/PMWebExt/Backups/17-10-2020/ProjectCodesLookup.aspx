<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCodesLookup.aspx.vb" Inherits="Website.ProjectCodesLookup" Title="Select a Project" meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row">
                <div class="col-4">
                    <telerik:RadGrid ID="rdgProjects" runat="server" Skin="Default" HeaderStyle-Font-Size="8"
                        Width="100%" AutoGenerateColumns="False" ShowHeader="true" FitPageHeightOffset="24" SetWidth="true">
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Projects" UniqueName="Projects">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtProject" runat="server" Text='<%# Bind("ProjectName") %>' CommandName="ProjectClick" CommandArgument='<%# Bind("Id")%>'></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="true">
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
