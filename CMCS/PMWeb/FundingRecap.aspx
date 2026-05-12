<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="FundingRecap.aspx.vb" Inherits="Website.FundingRecap" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

 <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
          
             <telerik:AjaxSetting AjaxControlID="rdgFundingLines">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFundingLines" LoadingPanelID="ldpPM"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
       
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
 <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr class="ToolBar">  
                        <td class="Padding7" style="width:100px;">
                            <asp:Label ID="lblTitle" meta:ResourceKey="lblTitle" CssClass="Bold" runat="server"
                                Text="Funding Recap"></asp:Label><br />
                        </td>                      
                        <td colspan="5" valign="middle" >
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default"   AutoPostBack="true">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName ="Print"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/toolbar/Excel.png" ToolTip="Export to Excel"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>                         
                                    <telerik:RadToolBarButton  ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation ="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>      
                    </tr>
                </table>
            </td>
        </tr>

          <tr>
            <td valign="top" align="left">
             <fieldset style="margin-left: 10px; text-align:left;">
              <legend>
                <asp:Label ID="lblFilter" meta:resourcekey="lblFilter" runat="server" Text="Filter By"></asp:Label>
            </legend>
                <telerik:RadAjaxPanel ID="pnlFilter" runat="server" Width="100%" LoadingPanelID="ldpPM">
               
                    <table width="800px" cellpadding="0" cellspacing="3" border="0">
                       
                           
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                          <tr>
                                        <td >
                                            <asp:Label ID="lblYear" meta:ResourceKey="lblYear" runat="server" Text="Year"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadNumericTextBox ID="rntYear"  ShowSpinButtons="true" 
                                                IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true" 
                                                Label="" runat="server" Width="70px" DataType="System.Int16" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>" 
                                                MaxValue="2100" AutoPostBack ="true" MinValue="1899">
                                                <numberformat decimaldigits="0" groupseparator="" />
                                            </telerik:RadNumericTextBox>
                                        </td>
                                        <td >
                                          <asp:Label ID="lblFundingState" meta:Resourcekey="lblFundingState" runat="server" Text="Funding Line State"></asp:Label>                                  
                                        </td> 
                                         <td > 
                                         <telerik:RadComboBox ID="ddlFundingState" runat="server" Width="150px" AutoPostBack="true"
                                            Skin="Default" style="font-size:11px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" 
                                          >
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>                                                                                     
                                        </td>
                                        
                                    </tr>
                        <tr>
                            <td> 
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>                               
                            </td>
                            <td >  
                                <telerik:RadComboBox ID="ddlProjects" runat="server" Width="300px" 
                                    Skin="Default" style="font-size:11px" AutoPostBack="true" Height="400px"
                                    
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" 
                                   EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>                             
                            </td>
                             <td >
                                          <asp:Label ID="lblTransactStatus" meta:Resourcekey="lblTransactStatus" runat="server" Text="Transaction Status"></asp:Label>                                  
                                        </td> 
                             <td > 
                                 <telerik:RadComboBox ID="ddlTransactStatus"  runat="server" Width="150px" AutoPostBack="true"
                                    Skin="Default" style="font-size:11px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" 
                                   >
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>                                                                                     
                            </td>
                            
                            
                        </tr> 
                        <tr>
                            <td> 
                                <asp:Label ID="lblFundingSource" runat="server" meta:Resourcekey="lblFundingSource" Text="Funding Source"></asp:Label>                               
                            </td>
                            
                             <td> 
                                 <telerik:RadComboBox ID="ddlFundingSource" runat="server" Width="150px" AutoPostBack="true"
                                    Skin="Default" style="font-size:11px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" 
                                   >
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>                                                                                     
                            </td>
                        </tr> 
                        
                    </table> 
                  
                </telerik:RadAjaxPanel> 
                  </fieldset> 
            </td> 
            <td>
                <telerik:RadGrid Id="rdgFundingLines" AllowMultiRowSelection="false" runat="server" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                         ShowGroupPanel="true"   HeaderStyle-Font-Size="8"  
                         AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                         PageSize="250">
        

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                              
                              <telerik:GridTemplateColumn HeaderText="Funding #" UniqueName="FundingNumber" SortExpression="FundingNumber"
                                GroupByExpression="FundingNumber [GridColumn_FundingNumber] Group By FundingNumber ASC" DataField="FundingNumber">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("FundingNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("FundingNumber"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                               <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber"  DataField="LineNumber" allowfiltering="false"
                                HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("LineNumber").ToString%>
                                </ItemTemplate>
                                <HeaderStyle Width="50px" />
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                             
                            
                            <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" SortExpression="Year"
                                GroupByExpression="Year [GridColumn_Year] Group By Year ASC" DataField="Year">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Year").ToString = "0", "&nbsp;", Container.DataItem("Year"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" SortExpression="Project"
                                GroupByExpression="Project [GridColumn_Project] Group By Project ASC" DataField="Project">
                                <ItemTemplate>
                                     <%#IIf(Container.DataItem("Project") = String.Empty, PM.LanguagesInfo.GlobalResource("Portfolio"), Container.DataItem("Project"))%> 
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                              <telerik:GridTemplateColumn HeaderText="Source" SortExpression="FundingSourceText"
                                UniqueName="FundingSource"  DataField="FundingSourceText" GroupByExpression="FundingSourceText [GridColumn_FundingSource] Group By FundingSourceText ASC">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("FundingSourceText") = String.Empty, "&nbsp;", Container.DataItem("FundingSourceText"))%>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle  />
                            </telerik:GridTemplateColumn>
                            
                             <telerik:GridTemplateColumn HeaderText="Code" SortExpression="Code"
                                UniqueName="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC" DataField="Code">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle/>
                            </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Funded" UniqueName="Funded" 
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                     <asp:Label ID="lblFunded" runat="server" Style="text-align: right;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Authorized" UniqueName="Authorized"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                     <asp:Label ID="lblAuthorized" runat="server" Style="text-align: right;"></asp:Label>
                                  
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Committed" UniqueName="Committed"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                     <asp:Label ID="lblCommitted" runat="server" Style="text-align: right;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                            
                             <telerik:GridTemplateColumn HeaderText="Expended" UniqueName="Expended"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                     <asp:Label ID="lblExpended" runat="server" Style="text-align: right;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                            
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                                    SecurityButtonType="ItemMode" Visible='True'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                    CommandName="SaveState" Visible='true'>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                    CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                         </MasterTableView>
                         <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                         <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">
                             <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                             <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                 AllowColumnResize="True" />
                         </ClientSettings>
                     </telerik:RadGrid>
            
            </td>
        </tr> 
    </table> 


</asp:Content>