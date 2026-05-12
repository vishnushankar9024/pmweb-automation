<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="PeriodProjectsLookup.aspx.vb" Inherits="Website.PeriodProjectsLookup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <asp:Label ID="lblProjects" meta:Resourcekey="lblProjects" runat="server" Text="Projects"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="row documentSinglePage">
                        <telerik:RadGrid ID="rdgProjects" runat="server" HeaderStyle-Font-Size="8"
                            Width="99%" AutoGenerateColumns="False" ShowHeader="false">
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id">
                                <Columns>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtProject" runat="server" Text='<%# Eval("ProjectName") %>' CommandName="ProjectClick" CommandArgument='<%# Eval("Id")%>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true">
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>

                </td>
            </tr>
        </table>

        <%--<table style="width: 100%; background-color:White" >
        <tr>
            <td colspan="4"><b><asp:Label ID="lblProperties"  runat="server" Text="Properties"></asp:Label></b></td>
        </tr>
        <tr>
            <td colspan="4"><hr /></td>
        </tr>        
        <tr>
            <td colspan="4">
                <telerik:RadGrid ID="rdgProperties"  runat="server"   HeaderStyle-Font-Size="8"
                    Width="99%" AutoGenerateColumns="False" ShowHeader="false">
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id">
                         <Columns>                                    
                           <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                 <asp:LinkButton ID="lbtProperty" runat="server" Text='<%# Bind("PropertyName") %>' CommandName="PropertyClick" CommandArgument='<%# Eval("Id")%>' ></asp:LinkButton>
                            </ItemTemplate>
                           </telerik:GridTemplateColumn>           
                        </Columns>
                        </MasterTableView>
                    <ClientSettings EnableRowHoverStyle="true">
                    </ClientSettings>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>--%>
    </form>
</body>
</html>
