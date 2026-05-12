<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="WorkOrdersSearch.aspx.vb" Inherits="Website.WorkOrdersSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RDG1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hfIsClearCommand"  />   
                </UpdatedControls>
            </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="btnSaveAsLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnSaveAsLayout" />
                <telerik:AjaxUpdatedControl ControlID="RDG1" LoadingPanelID="ldpPM2" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    
    <script type="text/javascript">
        function GoToDocument(sender, eventArgs) {
            window.location = eventArgs.getDataKeyValue("PostBackUrl");
        }

        function OnCommand(sender, args) {


        }
        var Grid;
        var btnDelete;
        function GridCreated(sender, args) {
            Grid = $find($("[id$=RDG1]")[0].id);
            btnDelete = $($("a[id$=btnDelete]")[0]);
        }

        function SearchDocument_OnRowSelecting(sender, eventArgs) {
            var IsUseWorkFlow = $("#" + eventArgs.get_id())[0].getAttribute("IsUseWorkFlow")
            var IsLatestRevision = $("#" + eventArgs.get_id())[0].getAttribute("IsLatestRevision")
            var IsUseDocumentTeam = $("#" + eventArgs.get_id())[0].getAttribute("IsUseDocumentTeam")


            if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
                return;

            if (Grid.get_masterTableView().get_selectedItems().length > 0) {
                if (btnDelete.is(":visible") == true) {
                    if (IsUseWorkFlow == "true" || IsLatestRevision == 0) { btnDelete.hide(); }
                    if (IsUseDocumentTeam == "true") { btnDelete.hide(); }

                }
            }
            else {
                if (IsUseWorkFlow == "true" || IsLatestRevision == 0 || IsUseDocumentTeam == "true") {
                    //eventArgs.set_cancel(true);
                    btnDelete.hide();
                } else {
                    btnDelete.show();
                }
            }

        }

        function openSaveCustomLayoutPopup(sender, eventArgs) {


            var item = eventArgs.get_item().get_value();
            if (item == -7) {

                var wnd = window.radopen('SaveCustomLayoutPopup.aspx?SourceId=SearchDocument');
                wnd.setSize(350, 110);
                wnd.add_close(ClickHiddenButton);
                wnd.Center();
                var iframe = $(document).find('iframe')[0];

                iframe.onload = function () {
                    var pageName = $(document).find('iframe').contents().find("form").attr('action');
                    if (pageName.indexOf('SaveCustomLayoutPopup') > -1) {
                        $(document).find('iframe').css('height', 110);

                    }
                }
                sender.close();
                eventArgs.set_cancel(true);


                return false;

            }
            if (item == -8) {
                var result;
                result = confirm(Msg_ConfirmDeleteLayout);
                eventArgs.set_cancel(!result);
                return false;
            }
            eventArgs.set_cancel(false);
            return true;
        }

        function ClickHiddenButton(Opener) {

            var btnHiddenButton = $("[id$=btnSaveAsLayout]");
            var hfSaveAsLayout = $("[id$=hfSaveAsLayout]")[0];

            if (hfSaveAsLayout.value == "1") {
                $(window.document).find("[id$=hfSaveAsLayout]").val(0);
                btnHiddenButton.click();
            }
        }

        function pageLoad() {
            var tFind = $telerik.$;
            tFind("[id$=HCFMClearFilterButton]").on("click", function (e) {
                var hfIsClearCommand = tFind("[id$=hfIsClearCommand]")[0];
                hfIsClearCommand.value = 1;
            });
        };

    </script>
    <table style="width: 100%"  cellspacing="0" cellpadding="0" border="0">
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <telerik:RadGrid ID="RDG1" CssClass="TopMarginWhenMobileMenuShown SearchDocumentGrid" runat="server"
        ShowGroupPanel="true"  HeaderStyle-Font-Size="8" AllowPaging="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        PageSize="30" AutoGenerateColumns="false" ShowStatusBar="True" AllowMultiRowEdit="True" OnFilterCheckListItemsRequested="CheckListItemsRequested" SetWidth="true" AppendMenus="true" IsWorkOrderSearch="true"
        AllowSorting="true" AllowMultiRowSelection="true" GridLines="None" AllowFilteringByColumn="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            ShowGroupFooter="true" DataKeyNames="Id,PostBackUrl" ClientDataKeyNames="Id,PostBackUrl"
            CommandItemDisplay="Top" UseAllDataFields="true" InsertItemDisplay="Top" EnableHeaderContextMenu="true" 
            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" TableLayout="Fixed"
            Width="100%">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Location" SortExpression="Location" UniqueName="Location" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                    DataField="Location" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <asp:HyperLink ID="hliLocationtName" runat="server" CssClass="NoWrap" Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                            NavigateUrl='<%# "~/Properties.aspx?Id=" & CStr(Container.DataItem("PropertyId"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Location ID" SortExpression="LocationId" UniqueName="LocationId" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="LocationId [GridColumn_LocationId] Group By LocationId ASC"
                    DataField="LocationId" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# IIf(Container.DataItem("LocationId") = "", "&nbsp;", Container.DataItem("LocationId"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Project" SortExpression="ProjectName" UniqueName="ProjectName" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC"
                    DataField="ProjectName" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# IIf(Container.DataItem("ProjectName") = "", "&nbsp;", Container.DataItem("ProjectName"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Project #" SortExpression="ProjectNumber" UniqueName="ProjectNumber" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="ProjectNumber [GridColumn_ProjectNumber] Group By ProjectNumber ASC"
                    DataField="ProjectNumber" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# IIf(Container.DataItem("ProjectNumber") = "", "&nbsp;", Container.DataItem("ProjectNumber"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Program" SortExpression="LocationProgramName" UniqueName="LocationProgramName" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="LocationProgramName [GridColumn_LocationProgramName] Group By LocationProgramName ASC"
                    DataField="LocationProgramName" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# IIf(Container.DataItem("LocationProgramName") = "", "&nbsp;", Container.DataItem("LocationProgramName"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Location Type" SortExpression="LocationType" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="LocationType" DataField="LocationType" AutoPostBackOnFilter="true"
                     GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("LocationType") = "", "&nbsp;", Container.DataItem("LocationType"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Property Manager" SortExpression="PropertyManager" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="PropertyManager" DataField="PropertyManager" AutoPostBackOnFilter="true"
                     GroupByExpression="PropertyManager [GridColumn_PropertyManager] Group By PropertyManager ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("PropertyManager") = "", "&nbsp;", Container.DataItem("PropertyManager"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Country" DataField="Country" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                UniqueName="Country" SortExpression="Country"
                    GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Country") = "", "&nbsp;", Container.DataItem("Country"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="City"  FilterCheckListEnableLoadOnDemand="true"
                UniqueName="City" SortExpression="City" DataField="City" AutoPostBackOnFilter="true"
                    GroupByExpression="City [GridColumn_City] Group By City ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("City") = "", "&nbsp;", Container.DataItem("City"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="State" DataField="StateKey" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                UniqueName="StateKey" SortExpression="StateKey"
                    GroupByExpression="StateKey [GridColumn_StateKey] Group By StateKey ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("StateKey") = "", "&nbsp;", Container.DataItem("StateKey"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="40px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Document #" UniqueName="DocumentNumber" SortExpression="DocumentNumber" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="DocumentNumber [GridColumn_DocumentNumber] Group By DocumentNumber ASC"
                   DataField="DocumentNumber" AutoPostBackOnFilter="true" >
                    <ItemTemplate>
                    <asp:HyperLink ID="hliDocNumber" runat="server" CssClass="NoWrap" Text='<%#IIf(Container.DataItem("DocumentNumber") = "", "&nbsp;", IIf(IsNumeric(Container.DataItem("DocumentNumber")), Container.DataItem("DocumentNumber").ToString, Container.DataItem("DocumentNumber")))%>'
                            NavigateUrl='<%#CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                        <span>
                        
                            </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Workflow Status" UniqueName="Status" SortExpression="Status" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                    DataField="Status" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblWorkflow"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="135px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Request ID" SortExpression="Request" UniqueName="Request" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Request [GridColumn_Request] Group By Request ASC"
                    DataField="Request" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <asp:HyperLink ID="RequestID" runat="server" CssClass="NoWrap" Text='<%#IIf(Container.DataItem("Request") = String.Empty, "&nbsp;", Container.DataItem("Request"))%>'
                            NavigateUrl='<%# "~/TenantRequests.aspx?Id=" & CStr(Container.DataItem("RequestID"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="Description" DataField="Description" AutoPostBackOnFilter="true"
                     GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Description") = "", "&nbsp;", Container.DataItem("Description"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="180px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Progress" SortExpression="WorkOrderProgress" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="Progress" DataField="WorkOrderProgress" AutoPostBackOnFilter="true"
                     GroupByExpression="WorkOrderProgress [GridColumn_Progress] Group By WorkOrderProgress ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("WorkOrderProgress") = "", "&nbsp;", Container.DataItem("WorkOrderProgress"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Currency" SortExpression="Currency" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="Currency" DataField="Currency" AutoPostBackOnFilter="true"
                     GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Currency") = "", "&nbsp;", Container.DataItem("Currency"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="Type" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Type [GridColumn_Type] Group By Type ASC"
                    DataField="Type" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Type") = "", "&nbsp;", Container.DataItem("Type"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Submitted By" SortExpression="SubmittedBy" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="SubmittedBy" DataField="SubmittedBy" AutoPostBackOnFilter="true"
                     GroupByExpression="SubmittedBy [GridColumn_SubmittedBy] Group By SubmittedBy ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("SubmittedBy") = "", "&nbsp;", Container.DataItem("SubmittedBy"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Contact Name" SortExpression="ContactName" FilterCheckListEnableLoadOnDemand="true"
                    UniqueName="ContactName" DataField="ContactName" AutoPostBackOnFilter="true"
                    GroupByExpression="ContactName [GridColumn_ContactName] Group By ContactName ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("ContactName") = "", "&nbsp;", Container.DataItem("ContactName"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Phone"  DataField="ContactPhone" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="ContactPhone" UniqueName="ContactPhone"
                    GroupByExpression="ContactPhone [GridColumn_ContactPhone] Group By ContactPhone ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("ContactPhone") = "", "&nbsp;", Container.DataItem("ContactPhone"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Ext" DataField="ContactExt" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                 SortExpression="ContactExt" UniqueName="ContactExt"
                    GroupByExpression="ContactExt [GridColumn_ContactExt] Group By ContactExt ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("ContactExt") = "", "&nbsp;", Container.DataItem("ContactExt"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="70px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" UniqueName="Priority" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC"
                    DataField="Priority" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Priority") = "", "&nbsp;", Container.DataItem("Priority"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Labor Cost" SortExpression="LaborCost" GroupByExpression="LaborCost [GridColumn_LaborCost] Group By LaborCost ASC"
                    UniqueName="LaborCost"  DataType="System.Decimal" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                     DataField="LaborCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                        <asp:Label ID="lblLaborCost" runat="server" Style="text-align: right;"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Equipment Cost" SortExpression="EquipmentCost" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="EquipmentCost [GridColumn_EquipmentCost] Group By EquipmentCost ASC"
                    UniqueName="EquipmentCost" DataType="System.Decimal" AutoPostBackOnFilter="True"
                    DataField="EquipmentCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                        <asp:Label ID="lblEquipmentCost" runat="server" Style="text-align: right;"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterTemplate>
                        <asp:Label ID="lblEquipmentTotal" runat="server"></asp:Label>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Material Cost" SortExpression="MaterialCost" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="MaterialCost [GridColumn_MaterialCost] Group By MaterialCost ASC"
                    UniqueName="MaterialCost" DataType="System.Decimal" AutoPostBackOnFilter="true"
                    DataField="MaterialCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                        <asp:Label ID="lblMaterialCost" runat="server" Style="text-align: right;"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Total Cost" SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC"
                    UniqueName="TotalCost" DataType="System.Decimal" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                    DataField="TotalCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                        <asp:Label ID="lblTotalCost" runat="server" Style="text-align: right;"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="90px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Closed" HeaderStyle-Width="55px" ItemStyle-Wrap="false" FilterCheckListEnableLoadOnDemand="true"
                    SortExpression="Closed" DataType="System.Boolean" DataField="Closed" AutoPostBackOnFilter="true"
                    UniqueName="Closed" GroupByExpression="Closed [GridColumn_Closed] Group By Closed ASC">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Closed"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>





                     <telerik:GridTemplateColumn HeaderText="Category"  DataField="Category" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="Category" UniqueName="Category"
                    GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Category") = "", "&nbsp;", Container.DataItem("Category"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="WBS"  DataField="WBS" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="WBS" UniqueName="WBS"
                    GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("WBS") = "", "&nbsp;", Container.DataItem("WBS"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>



                               <telerik:GridTemplateColumn HeaderText="Maintenance Contract"  DataField="MaintenanceContract" AutoPostBackOnFilter="true"
                SortExpression="MaintenanceContract" UniqueName="MaintenanceContract" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="MaintenanceContract [GridColumn_MaintenanceContract] Group By MaintenanceContract ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("MaintenanceContract") = "", "&nbsp;", Container.DataItem("MaintenanceContract"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn HeaderText="Cell"  DataField="Cell" AutoPostBackOnFilter="true"
                SortExpression="Cell" UniqueName="Cell" FilterCheckListEnableLoadOnDemand="true"
                    GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Cell") = "", "&nbsp;", Container.DataItem("Cell"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                      <telerik:GridTemplateColumn HeaderText="Revision" SortExpression="RevisionNumber" GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC"
                    UniqueName="RevisionNumber" DataType="System.Int64" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                    DataField="RevisionNumber" >
                    <ItemTemplate>
                     <%# Container.DataItem("RevisionNumber")%>
                    </ItemTemplate>
                    <HeaderStyle Width="90px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>

                          <telerik:GridTemplateColumn HeaderText="Reported Date" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                    SortExpression="ReportedDate" DataType="System.DateTime" DataField="ReportedDate" AutoPostBackOnFilter="true"
                    UniqueName="ReportedDate" GroupByExpression="ReportedDate [GridColumn_ReportedDate] Group By ReportedDate ASC">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("ReportedDate"))%>
                        </span>
                    </ItemTemplate>
                              <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>

                  <telerik:GridTemplateColumn HeaderText="Estimated Start Date" HeaderStyle-Width="55px" ItemStyle-Wrap="false" 
                    SortExpression="EstimatedStartDate" DataType="System.DateTime" DataField="EstimatedStartDate" AutoPostBackOnFilter="true"
                    UniqueName="EstimatedStartDate" GroupByExpression="EstimatedStartDate [GridColumn_EstimatedStartDate] Group By EstimatedStartDate ASC">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("EstimatedStartDate"))%>
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Estimated Finish Date" HeaderStyle-Width="55px" ItemStyle-Wrap="false" 
                    SortExpression="EstimatedFinishDate" DataType="System.DateTime" DataField="EstimatedFinishDate" AutoPostBackOnFilter="true"
                    UniqueName="EstimatedFinishDate" GroupByExpression="EstimatedFinishDate [GridColumn_EstimatedFinishDate] Group By EstimatedFinishDate ASC">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("EstimatedFinishDate"))%>
                        </span>
                    </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>


                    <telerik:GridTemplateColumn HeaderText="Aproximate Duration" SortExpression="ApproximateDuration" GroupByExpression="ApproximateDuration [GridColumn_ApproximateDuration] Group By ApproximateDuration ASC"
                    UniqueName="ApproximateDuration" DataType="System.Int64" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                    DataField="ApproximateDuration" >
                    <ItemTemplate>
                          <span>
                            <%# Container.DataItem("ApproximateDuration")%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px" />
                    <ItemStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>


                   <telerik:GridTemplateColumn HeaderText="Email"  DataField="Email" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="Email" UniqueName="Email"
                    GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Email") = "", "&nbsp;", Container.DataItem("Email"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

              
              
              
              
              
              <telerik:GridTemplateColumn HeaderText="Phone (Night)"  DataField="NightPhone" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="NightPhone" UniqueName="NightPhone"
                    GroupByExpression="NightPhone [GridColumn_NightPhone] Group By NightPhone ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("NightPhone") = "", "&nbsp;", Container.DataItem("NightPhone"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                         
        <telerik:GridTemplateColumn HeaderText="Phone (Night) Ext."  DataField="NightPhoneExt" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true"
                SortExpression="NightPhoneExt" UniqueName="NightPhoneExt"
                    GroupByExpression="NightPhoneExt [GridColumn_NightPhoneExt] Group By NightPhoneExt ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("NightPhoneExt") = "", "&nbsp;", Container.DataItem("NightPhoneExt"))%>
                        </span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                         

                <telerik:GridTemplateColumn HeaderText="Created By" HeaderStyle-Width="55px" ItemStyle-Wrap="false" FilterCheckListEnableLoadOnDemand="true"
                    SortExpression="CreatedBy" DataType="System.String" DataField="CreatedBy" AutoPostBackOnFilter="true"
                    UniqueName="CreatedBy" GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy ASC">
                    <ItemTemplate>
                        <span>
                            <%# IIf(Container.DataItem("CreatedBy") = "", "&nbsp;", Container.DataItem("CreatedBy"))%>
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn HeaderText="Created Date" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                    SortExpression="CreateDate" DataType="System.DateTime" DataField="CreateDate" AutoPostBackOnFilter="true"
                    UniqueName="CreateDate" GroupByExpression="CreateDate [GridColumn_CreateDate] Group By CreateDate ASC">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("CreateDate"))%>
                        </span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn Aggregate="SUM" DataField="EquipmentCost" Visible="False" />
            </Columns>
            <CommandItemTemplate>
                <div style="padding: 2px" style="width: 100%">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            
                            <td id="tblDropDownLists" runat="server" class="NoWrap">
                                <table style="display: inline; padding: 0px; border: 0px transparent none;"
                                    cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblLocationTypes" meta:resourcekey="lblLocationTypes" runat="server"
                                                    Text="Location Types">
                                                </asp:Label></b> &nbsp;&nbsp;
                                              <telerik:RadComboBox ID="ddlLocationTypes" OnSelectedIndexChanged="ddlLocationTypes_SelectedIndexChanged"
                                                runat="server" AutoPostBack="true" Filter="Contains" AllowCustomText="true" 
                                                 Style="font-size: 11px" Height="180px">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblLocations" meta:resourcekey="lblLocations" runat="server" Text="Locations">
                                                </asp:Label></b> &nbsp;&nbsp;
                                              <telerik:RadComboBox ID="ddlLocations" runat="server" OnSelectedIndexChanged="ddlLocations_SelectedIndexChanged"
                                                Width="180px" AutoPostBack="true" AllowCustomText="true" 
                                                 Style="font-size: 11px"  EnableLoadOnDemand="true" Height="400px"
                                                ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblProgress" meta:resourcekey="lblProgress" runat="server" Text="Progress">
                                                </asp:Label></b> &nbsp;&nbsp;
                                             <telerik:RadComboBox ID="ddlProgress" runat="server" OnSelectedIndexChanged="ddlProgress_SelectedIndexChanged"
                                                Width="150px" AutoPostBack="true" Filter="Contains" AllowCustomText="true" 
                                                 Style="font-size: 11px" Height="180px">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlWorKorderStatus" runat="server" OnSelectedIndexChanged="ddlWorKorderStatus_SelectedIndexChanged"
                                                Width="90px" AutoPostBack="true"   Style="font-size: 11px">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <b>
                                                <asp:Label ID="lblCurrency" meta:resourcekey="lblCurrency" Text="Currency" runat="server"></asp:Label></b>
                                            &nbsp;&nbsp;
                                           <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100px" AutoPostBack="true" Height="300px"
                                                EmptyMessage="Select Currency" Style="font-size: 11px" 
                                                OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                                </td>
                            </tr>
                        <tr>
                            <td>
                                <table id="tblGridStates" runat="server" style="display: inline; padding: 0px; border: 0px transparent none;
                                    height: 15px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="NoWrap SearchDoctdRecent">
                                            <asp:LinkButton ID="btnSearchDocRecent" CausesValidation="False" OnClientClick=""
                                                SecurityButtonType="ItemMode" runat="server" CommandName="RecentRecords" CssClass="GridCmdRecentRecords">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRecentRecords" meta:resourcekey="lblRecentRecords" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <telerik:RadToolBar ID="RadToolBar1" runat="server" Style="z-index: 0; border: 0px transparent none; position: static">
                                                <Items>
                                                    <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                                </Items>
                                            </telerik:RadToolBar>
                                        </td>
                                        <td id="tblAddNewRecord" runat="server" class="NoWrap SearchDoctdAdd">
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRecord" CssClass="SearchDocGridCmdInitNewRecord"
                                                securitybuttontype="ItemMode_Add">
                                                <span class="Icon"></span>
                                                <%--<asp:Label ID="lblAddRecords" meta:resourcekey="lblAddRecords" Text="Add Record"
                                                    runat="server">--%></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRecords"
                                                securitybuttontype="ItemMode_Delete" runat="server" CommandName="DeleteRecords">
                                                <span class="Icon"></span>
                                                <%--<asp:Label ID="lblDeleteRecords" meta:resourcekey="lblDeleteRecords" Text="Delete selected records"
                                                    runat="server"></asp:Label>--%>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                        <td class="NoWrap SearchDoctdLayout">
                                            <telerik:RadMenu ID="rdmLayouts" EnableRoundedCorners="true" EnableAutoScroll="true" Style="z-index: 1;"
                                                CollapseAnimation-Type="None" CssClass="trvContextMenu"
                                                runat="server" EnableSelection="true"
                                                EnableShadows="true"
                                                OnItemClick="rdmLayouts_ItemClick"
                                                OnClientItemClicking="openSaveCustomLayoutPopup" Visible="true">
                                            </telerik:RadMenu>
                                        </td>
                                       <%-- <td class="NoWrap">
                                            <asp:LinkButton ID="btnSaveState" runat="server" securitybuttontype="ItemMode" CausesValidation="False"
                                                CommandName="SaveState">
                                                <asp:Label ID="Label3" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" securitybuttontype="ItemMode"
                                                CausesValidation="False" CommandName="LoadDefaultState">
                                                &nbsp;&nbsp;|&nbsp;&nbsp;
                                                <asp:Label ID="label4" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                        </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <HeaderStyle Font-Size="8pt"></HeaderStyle>
        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="True">
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                AllowColumnResize="True"></Resizing>
            <ClientEvents OnRowDblClick="GoToDocument" OnCommand="OnCommand" OnRowSelecting="SearchDocument_OnRowSelecting" OnGridCreated="GridCreated"/>
            <Scrolling UseStaticHeaders="true" />
            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
        </ClientSettings>
    </telerik:RadGrid>

    <asp:Button ID="btnSaveAsLayout" runat="server" CssClass="Hide" />
     <asp:HiddenField ID="hfSaveAsLayout" runat="server" Value="0" />
     <asp:HiddenField ID="hfIsClearCommand" runat="server" Value="0" />
</asp:Content>
