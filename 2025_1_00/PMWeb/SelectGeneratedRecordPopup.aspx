<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="SelectGeneratedRecordPopup.aspx.vb" Inherits="Website.SelectGeneratedRecordPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

     <script type="text/javascript">

         function RedirectPage(str) {
             window.top.location.href = str

         }

         </script>

        <table cellpadding="0" cellspacing="0" style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadGrid ID="rdgGeneratedRecords" runat="server"  HeaderStyle-Font-Size="8"
                        Width="99%" AutoGenerateColumns="False" ShowHeader="true" PageSize="250" 
                        AllowPaging="True" AllowSorting="True"  AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="PostBackURL"> 
                             <Columns>                                    
                                <telerik:GridTemplateColumn HeaderText="Record Type" UniqueName="ObjectType" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="ObjectType" AutoPostBackOnFilter="true" SortExpression="ObjectType" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblObjectType" runat="server"></asp:Label>&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>           
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="Description" AutoPostBackOnFilter="true" SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtRecord" runat="server" OnClick='<%# String.Format("RedirectPage(""{0}"")",  Eval("PostBackURL")) %>'></asp:LinkButton>&nbsp;
                                        <asp:Label ID="lblDeleted" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Project\Location" UniqueName="Object" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="Object" AutoPostBackOnFilter="true" SortExpression="Object">
                                    <ItemTemplate>
                                        <span><%# Eval("Object")%></span>&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>    
                            </Columns>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="true"></ClientSettings>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
