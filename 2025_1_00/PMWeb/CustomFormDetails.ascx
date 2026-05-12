<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormDetails.ascx.vb" Inherits="Website.CustomFormDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CustomFormValues.ascx" TagName="CustomFormValues" TagPrefix="uc1" %>
<%@ Register Src="CustomFormCustomTable.ascx" TagName="CustomFormCustomTable" TagPrefix="uc2" %>
<%@ Reference Control="CustomFormCustomTable.ascx" %>
   <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManagerProxy>
<div class="row">
    <div>
        <telerik:RadComboBox ID="ddlPHProject" runat="server" 
            Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
            CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
            ShowMoreResultsBox="True" EnableLoadOnDemand="true" Visible="false"
            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
        </telerik:RadComboBox>

        <asp:Panel ID="pnlCustomFields" runat="server" Width="100%">
            <fieldset>
                <legend>
                    <asp:Label runat="server" ID="lblCustomFormFields" Text="Custom Form Fields"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgCustomFormFields" runat="server" ShowHeader="false"
                    AutoGenerateColumns="False" ShowStatusBar="false" GridLines="None">
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Height="100%"
                        DataKeyNames="Id" CommandItemDisplay="None">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderStyle-Width="145px" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%#Container.DataItem("LabelString")%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="240px">
                                <ItemTemplate>
                                    <uc1:CustomFormValues ID="CustomFormValues" runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="FieldNumber"></telerik:GridSortExpression>
                        </SortExpressions>
                    </MasterTableView>
                </telerik:RadGrid>

            </fieldset>
        </asp:Panel>

    </div>
</div>
<div class="row UseTemplate">
       
             <asp:PlaceHolder ID="plcTemplate" runat="server"></asp:PlaceHolder>
  

</div>


<asp:Repeater runat="server" ID="rpt">
    <ItemTemplate>
        <div id='<%# "C_" & Eval("Id") %>'>         
                <uc2:CustomFormCustomTable ID="CustomFormCustomTable1" runat="server" />
        </div>
    </ItemTemplate>
</asp:Repeater>

