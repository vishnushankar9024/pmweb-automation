<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EquipmentSearch.aspx.vb" Inherits="Website.EquipmentSearch" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
 <script type="text/javascript">
        function GoToDocument(sender, eventArgs) {
            window.location = eventArgs.getDataKeyValue("PostBackUrl");
        }

    </script>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEquipments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquipments" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadGrid ID="rdgEquipments" runat="server"  AllowFilteringByColumn="false"   
     AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250" ShowFooter="False"
    AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
    AllowSorting="True" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true">
    </PagerStyle>
    <HeaderContextMenu  >
    </HeaderContextMenu>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="false"  FooterStyle-HorizontalAlign="Right"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true" AllowCustomPaging="true"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
        TableLayout="Fixed" AllowCustomSorting="true" ClientDataKeyNames="Id,PostBackUrl">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="RecordNumber" HeaderStyle-Wrap="false" SortExpression="RecordNumber"
                Groupable="false" Reorderable="false" DataField="RecordNumber" allowfiltering="false">
                <ItemTemplate>
                <asp:HyperLink ID="hliDocNumber" runat="server" CssClass="NoWrap" Text='<%#IIf(Container.DataItem("RecordNumber") = "", "&nbsp;", IIf(IsNumeric(Container.DataItem("RecordNumber")), Container.DataItem("RecordNumber").ToString, Container.DataItem("RecordNumber")))%>'
                            NavigateUrl='<%#CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                </ItemTemplate>
                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description"
                UniqueName="Description" >
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                </ItemTemplate>
                <HeaderStyle Width="230px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type"
                GroupByExpression="Type [GridColumn_Type] Group By Type ASC" DataField="Type"
                UniqueName="Type">
                <ItemTemplate>
                   <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Ownership" SortExpression="Ownership"
                GroupByExpression="Ownership [GridColumn_Ownership] Group By Ownership ASC" 
                UniqueName="Ownership" DataField="Ownership">
                <ItemTemplate>
                   <%#IIf(Container.DataItem("Ownership") = String.Empty, "&nbsp;", Container.DataItem("Ownership"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>
     <telerik:GridTemplateColumn HeaderText="Function Status" GroupByExpression="FunctionStatus [GridColumn_FunctionStatus] Group By FunctionStatus ASC"
                SortExpression="FunctionStatus"  UniqueName="FunctionStatus" DataField="FunctionStatus">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("FunctionStatus") = String.Empty, "&nbsp;", Container.DataItem("FunctionStatus"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Location" ItemStyle-Wrap="false" GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                SortExpression="Location" UniqueName="Location" DataField="Location">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Building" ItemStyle-Wrap="false" GroupByExpression="Building [GridColumn_Building] Group By Building ASC"
                SortExpression="Building" UniqueName="Building" DataField="Building">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Floor" ItemStyle-Wrap="false" GroupByExpression="Floor [GridColumn_Floor] Group By Floor ASC"
                SortExpression="Floor" UniqueName="Floor" DataField="Floor">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Space" ItemStyle-Wrap="false" GroupByExpression="Space [GridColumn_Space] Group By Space ASC"
                SortExpression="Space" UniqueName="Space" DataField="Space">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
                           <telerik:GridTemplateColumn HeaderText="Current Location" ItemStyle-Wrap="false" GroupByExpression="CurrentLocation [GridColumn_CurrentLocation] Group By CurrentLocation ASC"
                UniqueName="CurrentLocation" DataField="CurrentLocation">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("CurrentLocation") = String.Empty, "&nbsp;", Container.DataItem("CurrentLocation"))%>
                </ItemTemplate>
                <HeaderStyle Width="270px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Location ID" ItemStyle-Wrap="false" GroupByExpression="LocationId [GridColumn_LocationId] Group By LocationId ASC"
                UniqueName="LocationId" DataField="LocationId">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("LocationId") = String.Empty, "&nbsp;", Container.DataItem("LocationId"))%>
                </ItemTemplate>
                <HeaderStyle Width="270px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Begin" ItemStyle-Wrap="false" GroupByExpression="Begin [GridColumn_Begin] Group By Begin ASC"
                UniqueName="Begin" SortExpression="Begin" DataField="Begin">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("Begin") = String.Empty, "&nbsp;", Container.DataItem("Begin"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="End" ItemStyle-Wrap="false" GroupByExpression="End [GridColumn_End] Group By End ASC"
                UniqueName="End" SortExpression="End" DataField="End">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("End") = String.Empty, "&nbsp;", Container.DataItem("End"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Length" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" GroupByExpression="Length [GridColumn_Length] Group By Length ASC"
                UniqueName="Length" SortExpression="Length" DataField="Length">
                <ItemTemplate>
                    <%# FormatNumber(Container.DataItem("Length"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Length UOM" ItemStyle-Wrap="false" GroupByExpression="LengthUOM [GridColumn_LengthUOM] Group By LengthUOM ASC"
                UniqueName="LengthUOM" SortExpression="LengthUOM" DataField="LengthUOM">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("LengthUOM") = String.Empty, "&nbsp;", Container.DataItem("LengthUOM"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Begin Direction" ItemStyle-Wrap="false" GroupByExpression="BeginDirection [GridColumn_BeginDirection] Group By BeginDirection ASC"
                UniqueName="BeginDirection" SortExpression="BeginDirection" DataField="BeginDirection">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("BeginDirection") = String.Empty, "&nbsp;", Container.DataItem("BeginDirection"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="End Direction" ItemStyle-Wrap="false" GroupByExpression="EndDirection [GridColumn_EndDirection] Group By EndDirection ASC"
                UniqueName="EndDirection" SortExpression="EndDirection"  DataField="EndDirection">
                <ItemTemplate>
                    <%# IIf(Container.DataItem("EndDirection") = String.Empty, "&nbsp;", Container.DataItem("EndDirection"))%>
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Condition" ItemStyle-Wrap="false" GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC"
                SortExpression="Condition" UniqueName="Condition" DataField="Condition">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Condition") = String.Empty, "&nbsp;", Container.DataItem("Condition"))%>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
                <ItemStyle Wrap="False" ></ItemStyle>
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="ConditionDates" ItemStyle-Wrap="false" DataField="ConditionDate" GroupByExpression="ConditionDate [GridColumn_ConditionDates] Group By ConditionDate ASC"
                SortExpression="ConditionDates" UniqueName="ConditionDates">
                <ItemTemplate>
                    <%#IIf(FormatDate(Container.DataItem("ConditionDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("ConditionDate")))%>
                </ItemTemplate>
                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
                   </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Inactive" ItemStyle-Wrap="false" GroupByExpression="IsActive [GridColumn_IsActive] Group By IsActive ASC"
                UniqueName="IsActive" SortExpression="IsActive" DataField="IsActive">
                <ItemTemplate>
                    <asp:Image ID="imgIsActive" runat="server" ImageUrl='<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"Images/Global/checked.png" , "Images/Global/unchecked.png"))%>' />
                        <asp:Label ID="lbIsActive" runat="server" CssClass="Hide" Text='<%#CStr(Eval("IsActive"))%>' />
                </ItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <ItemStyle Wrap="False"></ItemStyle>
            </telerik:GridTemplateColumn>
            
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                <table id="tblGridStates" runat="server" style="display: inline; padding: 0px; border: 0px transparent none;height: 15px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td id="tblAddNewRecord" runat="server">
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRecord" CssClass="GridCmdInitNewRecord" 
                                                securitybuttontype="ItemMode_Add">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddRecords" meta:resourcekey="lblAddRecords" 
                                                    runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRecords" 
                                                securitybuttontype="ItemMode_Delete" runat="server" CommandName="DeleteRecords">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteRecords" meta:resourcekey="lblDeleteRecords"
                                                    runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                    SecurityButtonType="ItemMode">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                                        </td>
                                          <td style="border:solid 1px blue">
                                   
                                    <telerik:RadComboBox ID="ddlFilter" runat="server" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged"
                                        Width="250px" AutoPostBack="true"   Style="font-size: 11px;float:left"
                                        DropDownWidth="280px">
                                    </telerik:RadComboBox>
                                     <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return OpenPOPUp('FilterPopup.aspx',550, 450,true);" CssClass="GridCmdShowFilter" 
                                             CausesValidation="False" ToolTip="<%$Resources: lblShowFilter.Text %>" CommandName="ShowFilter">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                </td>
                                           
                                         <td style="width:20px">
                                          &nbsp;
                                         </td>
                                        <td class="NoWrap">
                                        <telerik:RadContextMenu ID="cmAddFirstNode" OnItemClick="cmAddFirstNode_ItemClick" ClickToOpen="true" runat="server" >
            <Items>
      
                <telerik:RadMenuItem Text="<%$ Resources:PMWeb, SaveState %>"  PostBack="True" CssClass="MenuUserButton"  Value="SaveState" EnableImageSprite="true">
               </telerik:RadMenuItem>
                 <telerik:RadMenuItem Text="<%$ Resources:PMWeb, LoadDefaultState %>"  PostBack="True"  CssClass="MenuUserGroup" Value="LoadDefaultState"  EnableImageSprite="true"/>
            </Items>
        </telerik:RadContextMenu>
                                         
                                                <asp:LinkButton ID="btnSaveLayout" runat="server" CssClass="SaveLayoutButton" >
                                                <span class="Icon"></span>
                                                      <asp:Label ID="Label3" Text="<%$ Resources:PMWeb, Layout %>" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                      
                                        <img style="border: 0px; vertical-align: middle;Cursor:Pointer;"  id="imgLayout" onclick="showMenu(event)" src="Images/Global/dropdown.PNG" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnSearchDocumentExportExcel" runat="server" CausesValidation="False" CommandName="ExportToExcel" CssClass="GridCmdExpToExcel"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label1" Text="Export To Exel" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings  AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
        AllowDragToGroup="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
       <ClientEvents OnRowDblClick="GoToDocument" />    
       <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
    </ClientSettings>
    <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true">
            <Csv EnableBomHeader="true" />
            <Pdf PaperSize="A4"></Pdf>
            <Word Format="Docx" />
            <Excel  Format="Xlsx" />
        </ExportSettings>
</telerik:RadGrid>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">

<script type="text/javascript">

    function showMenu(e) {
        var contextMenu = $find($("[id$=cmAddFirstNode]")[0].id);

        if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
            contextMenu.show(e);
        }

        $telerik.cancelRawEvent(e);
    }


</script>
</telerik:RadCodeBlock>


</asp:Content>
