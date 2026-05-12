<%@ Page Language="vb" AutoEventWireup="false"  meta:resourcekey="Page" CodeBehind="CopyFrommergeTemplates.aspx.vb" Inherits="Website.CopyFrommergeTemplates" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
    <div>

    <table class="colTable" >
        <tr>
            <td colspan="4">
            <telerik:radgrid id="rdgTemplates" runat="server"   ShowFooter="false" GroupingEnabled ="false"
             autogeneratecolumns="False" showstatusbar="True" font-size="8px" pagesize="9" Setwidth="true"
            allowpaging="True" allowmultirowedit="True" allowmultirowselection="false"
            allowsorting="True" gridlines="None" width="99%" >
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom">
    </PagerStyle>
    
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
        TableLayout="Fixed">
        <Columns>
                 <telerik:GridTemplateColumn HeaderText="Template" ItemStyle-Wrap="false" SortExpression="Template"
                 UniqueName="Template">
            <ItemTemplate>
                   <asp:LinkButton ID="lbtSchedule" runat="server" Text='<%# Container.DataItem("Template") %>' CommandArgument='<%# Container.DataItem("Id")%>' CommandName="TemplateClick"  ></asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" SortExpression="Description"
                 UniqueName="Description">
              <ItemTemplate>
                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                </ItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                            SortExpression="IsDefault" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsDefault"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings  Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true">
       
        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
    </ClientSettings>
</telerik:radgrid>
    
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
