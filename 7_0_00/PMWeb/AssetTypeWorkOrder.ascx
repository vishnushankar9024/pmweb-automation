<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetTypeWorkOrder.ascx.vb" Inherits="Website.AssetTypeWorkOrder" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAssetTypeWorkOrder">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssetTypeWorkOrder" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgAssetTypeWorkOrder" runat="server"   HeaderStyle-Font-Size="8"  CssClass="WithoutTopBorder"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false" ShowGroupPanel="true" AllowPaging="true" PageSize="50" SetWidth="true" AppendMenus = "true" ClientSettings-Scrolling-AllowScroll="true" >
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None">
                    <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                    <Columns>                                    
                 <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="RecordNumber" SortExpression="RecordNumber"
                    GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC"
                   DataField="RecordNumber" AutoPostBackOnFilter="true" >
                    <ItemTemplate>
                    <asp:HyperLink ID="hliDocNumber" runat="server" CssClass="NoWrap" Text='<%#IIf(Container.DataItem("RecordNumber") = "", "&nbsp;", IIf(IsNumeric(Container.DataItem("RecordNumber")), Container.DataItem("RecordNumber").ToString, Container.DataItem("RecordNumber")))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                </telerik:GridTemplateColumn>           
                         <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                    UniqueName="Description" DataField="Description" AutoPostBackOnFilter="true"
                     GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Description") = "", "&nbsp;", Container.DataItem("Description"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="180px"></HeaderStyle>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="65px" ItemStyle-Wrap="false"
                    SortExpression="Date" DataType="System.DateTime" DataField="Date" AutoPostBackOnFilter="true"
                    UniqueName="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("Date"))%>&nbsp;
                        </span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status" SortExpression="Status"
                    GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                    DataField="Status" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("Status") = "", "&nbsp;", Container.DataItem("Status"))%>
                    </ItemTemplate>
                    <HeaderStyle Width="135px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Progress" SortExpression="Progress"
                    UniqueName="Progress" DataField="Progress" AutoPostBackOnFilter="true"
                     GroupByExpression="Progress [GridColumn_Progress] Group By Progress ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Progress") = "", "&nbsp;", Container.DataItem("Progress"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>       
                <telerik:GridTemplateColumn HeaderText="Location" SortExpression="Location"
                    UniqueName="Location" DataField="Location" AutoPostBackOnFilter="true"
                     GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Location") = "", "&nbsp;", Container.DataItem("Location"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="190px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>   
                  <telerik:GridTemplateColumn HeaderText="Project" SortExpression="Project"
                    UniqueName="Project" DataField="Project" AutoPostBackOnFilter="true"
                     GroupByExpression="Project [GridColumn_Project] Group By Project ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Project") = "", "&nbsp;", Container.DataItem("Project"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="190px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>          
                                   
                    </Columns>
                       <CommandItemTemplate>
                  <div style="padding: 2px">
                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid"
                    Visible="true">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                  </div>
                  </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true" >
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
                    <ClientEvents />
                </ClientSettings>
            </telerik:RadGrid>
            
</div>
        </div>
    </div>