<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="AddInitiativeFromTemplatePopup.aspx.vb" Inherits="Website.AddInitiativeFromTemplatePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
        function OnSavingWindowClosed() {
            var Type;
            Type = window.location.href.split('=')[1].split('&')[0];

            var btnReLoadLinkedRecords;
            btnReLoadLinkedRecords = $(window.parent.document).find("input[id$='btnReLoadLinkedRecords']");
            if (btnReLoadLinkedRecords) {
                btnReLoadLinkedRecords.click();
            }

            CloseRadWnd();

            if (Type == "TenantRequestInitiative") {
                alert(Msg_GeneratingInitiativeCompleted);
            } else {
                alert(Msg_GeneratingProjectCompleted);
            }

        }
        function SaveInitiative(sender, args) {
            var value = args.get_item().get_commandName();
            if (value == 'Save') {
                args.get_item().set_enabled(false)
            }
        }
    </script>
</telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgProjects">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgProjects" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="180px" CssClass="popup-toolbar" OnClientButtonClicking="SaveInitiative">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" ValidationGroup="Save" CssClass="ToolbarCheck"
                                CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator" Style="margin: 5px"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage">
            <div class="row documentSinglePage">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgProjects" runat="server" AutoGenerateColumns="False" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        ShowStatusBar="True" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" AllowPaging="true" PageSize="10" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" FitPageHeightOffset="24" AppendMenus="true"
                        ShowGroupPanel="true" AllowMultiRowEdit="false" AllowMultiRowSelection="false" AllowSorting="true" ItemStyle-Height="20px" GridLines="None">

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                            TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">

                            <Columns>

                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Full Name" HeaderStyle-Width="110px" DataField="ProjectName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="ProjectFullName" SortExpression="ProjectName" GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("ProjectFullName").ToString = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Record #" HeaderStyle-Width="110px" DataField="RecordNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="RecordNumber" SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("RecordNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("RecordNumber").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Status" HeaderStyle-Width="110px" DataField="ProjectStatus" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="ProjectStatus" SortExpression="ProjectStatus" GroupByExpression="ProjectStatus [GridColumn_ProjectStatus] Group By ProjectStatus ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("ProjectStatus").ToString = String.Empty, "&nbsp;", Container.DataItem("ProjectStatus").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Workflow Status" HeaderStyle-Width="110px" DataField="WorkflowStatus" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="WorkflowStatus" SortExpression="WorkflowStatus" GroupByExpression="WorkflowStatus [GridColumn_WorkflowStatus] Group By WorkflowStatus ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("WorkflowStatus").ToString = String.Empty, "&nbsp;", Container.DataItem("WorkflowStatus").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Program" HeaderStyle-Width="110px" DataField="Program" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Program" SortExpression="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Program").ToString = String.Empty, "&nbsp;", Container.DataItem("Program").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="110px" DataField="Type" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Type" SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Category" HeaderStyle-Width="110px" DataField="Category" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Category" SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="PBS" HeaderStyle-Width="110px" DataField="PBS" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="PBS" SortExpression="PBS" GroupByExpression="PBS [GridColumn_PBS] Group By PBS ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PBS").ToString = String.Empty, "&nbsp;", Container.DataItem("PBS").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="WBS" HeaderStyle-Width="110px" DataField="WBS" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="WBS" SortExpression="WBS" GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("WBS").ToString = String.Empty, "&nbsp;", Container.DataItem("WBS").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-Width="110px" DataField="Location" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Location" SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Address1" HeaderStyle-Width="110px" DataField="Address1" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Address1" SortExpression="Address1" GroupByExpression="Address1 [GridColumn_Address1] Group By Address1 ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Address2" HeaderStyle-Width="110px" DataField="Address2" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Address2" SortExpression="Address2" GroupByExpression="Address2 [GridColumn_Address2] Group By Address2 ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Client" HeaderStyle-Width="110px" DataField="Client" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Client" SortExpression="Client" GroupByExpression="Client [GridColumn_Client] Group By Client ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Client").ToString = String.Empty, "&nbsp;", Container.DataItem("Client").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="GC" HeaderStyle-Width="110px" DataField="GC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="GC" SortExpression="GC" GroupByExpression="GC [GridColumn_GC] Group By GC ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("GC").ToString = String.Empty, "&nbsp;", Container.DataItem("GC").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Architect" HeaderStyle-Width="110px" DataField="Architect" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Architect" SortExpression="Architect" GroupByExpression="Architect [GridColumn_Architect] Group By Architect ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Architect").ToString = String.Empty, "&nbsp;", Container.DataItem("Architect").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Executive" HeaderStyle-Width="110px" DataField="Executive" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Executive" SortExpression="Executive" GroupByExpression="Executive [GridColumn_Executive] Group By Executive ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Executive").ToString = String.Empty, "&nbsp;", Container.DataItem("Executive").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Manager" HeaderStyle-Width="110px" DataField="Manager" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Manager" SortExpression="Manager" GroupByExpression="Manager [GridColumn_Manager] Group By Manager ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Manager").ToString = String.Empty, "&nbsp;", Container.DataItem("Manager").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Superintendents" HeaderStyle-Width="110px" DataField="Superintendents" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Superintendents" SortExpression="Superintendents" GroupByExpression="Superintendents [GridColumn_Superintendents] Group By Superintendents ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Superintendents").ToString = String.Empty, "&nbsp;", Container.DataItem("Superintendents").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Country" HeaderStyle-Width="110px" DataField="Country" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Country" SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Country").ToString = String.Empty, "&nbsp;", Container.DataItem("Country").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="City" HeaderStyle-Width="110px" DataField="City" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="City" SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="State" HeaderStyle-Width="110px" DataField="State" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="State" SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("State").ToString = String.Empty, "&nbsp;", Container.DataItem("State").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Phone" HeaderStyle-Width="110px" DataField="Phone" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Phone" SortExpression="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Zip" HeaderStyle-Width="110px" DataField="Zip" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Zip" SortExpression="Zip" GroupByExpression="Zip [GridColumn_Zip] Group By Zip ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Fax" HeaderStyle-Width="110px" DataField="Fax" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Fax" SortExpression="Fax" GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Revision #" HeaderStyle-Width="110px" DataField="RevisionNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="RevisionNumber" SortExpression="RevisionNumber" GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("RevisionNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("RevisionNumber").ToString)%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Revision Date" HeaderStyle-Width="110px" DataField="RevisionDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="RevisionDate" SortExpression="RevisionDate" GroupByExpression="RevisionDate [GridColumn_RevisionDate] Group By RevisionDate ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("RevisionDate") = New Date(1900, 1, 1), "&nbsp;", FormatDate(CDate(Container.DataItem("RevisionDate"))))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Target Budget" HeaderStyle-Width="110px" DataField="TargetBudget" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="TargetBudget" SortExpression="TargetBudget" GroupByExpression="TargetBudget [GridColumn_TargetBudget] Group By TargetBudget ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("TargetBudget").ToString = String.Empty, "&nbsp;", FormatCurrency(Container.DataItem("TargetBudget").ToString))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Target Revenue" HeaderStyle-Width="110px" DataField="TargetRevenue" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="TargetRevenue" SortExpression="TargetRevenue" GroupByExpression="TargetRevenue [GridColumn_TargetRevenue] Group By TargetRevenue ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("TargetRevenue").ToString = String.Empty, "&nbsp;", FormatCurrency(Container.DataItem("TargetRevenue").ToString))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Target Duration" HeaderStyle-Width="110px" DataField="TargetDuration" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="TargetDuration" SortExpression="TargetDuration" GroupByExpression="TargetDuration [GridColumn_TargetDuration] Group By TargetDuration ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("TargetDuration").ToString = String.Empty, "&nbsp;", FormatNumber(Container.DataItem("TargetDuration").ToString))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />                                    
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Target Start" HeaderStyle-Width="110px" DataField="TargetStart" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="TargetStart" SortExpression="TargetStart" GroupByExpression="TargetStart [GridColumn_TargetStart] Group By TargetStart ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("TargetStart") = New Date(1900, 1, 1), "&nbsp;", FormatDate(CDate(Container.DataItem("TargetStart"))))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />                                    
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Target Finish" HeaderStyle-Width="110px" DataField="TargetFinish" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="TargetFinish" SortExpression="TargetFinish" GroupByExpression="TargetFinish [GridColumn_TargetFinish] Group By TargetFinish ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("TargetFinish") = New Date(1900, 1, 1), "&nbsp;", FormatDate(CDate(Container.DataItem("TargetFinish"))))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="UOM" HeaderStyle-Width="110px" DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("UOM").ToString = String.Empty, "&nbsp;", Container.DataItem("UOM").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Percent Complete" HeaderStyle-Width="110px" DataField="PercentComplete" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="PercentComplete" SortExpression="PercentComplete" GroupByExpression="PercentComplete [GridColumn_PercentComplete] Group By PercentComplete ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PercentComplete").ToString = String.Empty, "&nbsp;", FormatPercent(Container.DataItem("PercentComplete").ToString))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />                                    
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Scope" HeaderStyle-Width="110px" DataField="Scope" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Scope" SortExpression="Scope" GroupByExpression="Scope [GridColumn_Scope] Group By Scope ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Scope").ToString = String.Empty, "&nbsp;", Container.DataItem("Scope").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>

                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        |&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>

                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                        </ClientSettings>
                    </telerik:RadGrid>

                </div>
                </div>
        </div>

    </form>
</body>
</html>
