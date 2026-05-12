<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderMarkup.ascx.vb" Inherits="Website.WorkOrderMarkup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 


<div style="overflow:auto; width:100%;" id="MarkupDiv">
     <telerik:RadGrid ID="rdgMarkupDetails" runat="server"   
            AutoGenerateColumns="False" HeaderStyle-Font-Size="8" ShowStatusBar="True" CssClass="WithoutTopBorder"
         GridLines="None" >
      
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="None" InsertItemPageIndexAction="ShowItemOnFirstPage">
             <Columns>       
                     <telerik:GridTemplateColumn HeaderText="Labor Total" UniqueName="LaborTotal" ItemStyle-Wrap="false" 
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" >
                    <ItemTemplate>
                           <asp:Label ID="lblLaborTotal" runat="server" Style="text-align: right;" ReadOnly="true"
                               Text='<%#FormatCurrency(ParseDouble(Eval("LaborTotal"))) %>'></asp:Label>                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Equipment Total" ItemStyle-Wrap="false" UniqueName="EquipmentTotal" 
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                          <asp:Label ID="lblEquipmentTotal" Text='<%#FormatCurrency(ParseDouble(Eval("EquipmentTotal"))) %>'
                              runat="server" Style="text-align: right;" ReadOnly="true"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Center" />
               </telerik:GridTemplateColumn> 
                    <telerik:GridTemplateColumn HeaderText="Other Total" UniqueName="OtherTotal" ItemStyle-Wrap="false" 
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" >
                    <ItemTemplate>
                           <asp:Label ID="lblOther" runat="server" Style="text-align: right;" ReadOnly="true"
                               Text='<%#FormatCurrency(Eval("OtherTotal")) %>'></asp:Label>                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total" ItemStyle-Wrap="false" 
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" >
                    <ItemTemplate>
                           <asp:Label ID="lblTotal" runat="server" Style="text-align: right;" ReadOnly="true"
                               Text='<%#FormatCurrency(Eval("Total")) %>'></asp:Label>                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>
            </Columns>
            <FooterStyle CssClass="GridFooter" />        
        </MasterTableView>
<HeaderStyle Font-Size="8pt"></HeaderStyle>   
    </telerik:RadGrid>

</div>