<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Transmittals.ascx.vb"
    Inherits="Website.Transmittals" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
 
<telerik:RadGrid ID="rdgTrasnmittals" runat="server"  SetWidth="true" AppendMenus = "true" FitParentContainer="true" CssClass="LightWeight" Skin="Default" EnableEmbeddedSkins="true"
     AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
    AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False"
    AllowSorting="False" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
    <HeaderContextMenu   EnableViewState="false">
    </HeaderContextMenu>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id,Url" ClientDataKeyNames="Id,Url" CommandItemDisplay="None" InsertItemDisplay="Top"
        UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
        EnableHeaderContextMenu="False" TableLayout="Fixed">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-HorizontalAlign="Right"
                UniqueName="TransmittalDate" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                <ItemTemplate>
                 <span><%#FormatDate(Eval("TransmittalDate"))%>&nbsp;</span>
                   
                </ItemTemplate>
                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="To" UniqueName="To">
                <ItemTemplate>
                     <span><%#IIf(Container.DataItem("ContactName") = String.Empty, "&nbsp;", Container.DataItem("ContactName"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Via" ItemStyle-HorizontalAlign="Right"
                UniqueName="TransmittalVia">
                <ItemTemplate>
                   <span>  <%#IIf(Container.DataItem("TransmittalVia") = String.Empty, "&nbsp;", Container.DataItem("TransmittalVia"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="150px" ></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
    <ClientSettings >
    <ClientEvents  OnRowClick="GoToTransmittalPage1"  />
    </ClientSettings>
</telerik:RadGrid>


