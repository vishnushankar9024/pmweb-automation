<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ResoucesAvailability.aspx.vb" Inherits="Website.ResoucesAvailability" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="Utilities/TreeGrid/GridE.js" type="text/javascript"></script>
    <script type="text/javascript">

        delete Number.prototype._toFormattedString;
        delete Number.prototype.format;
        delete Number.prototype.localeFormat;

        //  function DoZoom(idx) {
        //      if (!parseInt(idx)) { idx = 0; }
        //      var G = Grids[0], C = G.Cols.G; // G = actual grid, C = actual Gantt column
        //      // --- Attribute names to change ---
        //      var H = ["GanttUnits", "GanttRound", "GanttChartRound", "GanttWidth", "GanttMin", "GanttMax", "GanttBackground", "GanttBackgroundRepeat", "GanttHeaderOptions",
        //"GanttHeader1", "GanttFormat1", "GanttHeader2", "GanttFormat2", "GanttHeader3", "GanttFormat3", "GanttHeader4", "GanttFormat4", "GanttHeader5", "GanttFormat5"];

        //      // --- Attribute values for individual zooms ---   
        //      var T = [
        //['M6', 'M3', 'y', 18, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M6', 'MMMMMM'],
        //['M3', 'M', 'y', 24, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M3', 'MMMMM'],
        //['M', 'M', 'y', 18, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M6', 0, 'M6', 'MMMMMM. yyyy', 'M', 'MM'],
        //['M', 'w', 'M3', 28, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M3', 0, 'M3', 'MMMMM. yyyy', 'M', 'MMM'],
        //['w', 'd', 'M', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMM yyyy', 'w', 'd.'],
        //['d', 'd', 'M', 6, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMMM yyyy', 'd', '.'],
        //['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'w', '"<span style=\'color:red;font-size:8px;\'>"ddddddd"</span>" dddddd MMMM yyyy', 'd', 'ddddd'],
        //['h6', 'h6', 'w', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/6/2008~1/6/2008 0:01', 'd,,w,w', 0, 'd', 'ddd dd MMM', 'h6', 'HH'],
        //['h', 'h', 'd', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/1/2008~1/1/2008 0:01', 'd,,w,d', 0, 'd', 'ddd dd MMM', 'h', 'HH'],
        //['m15', 'm5', 'd', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/1/2008~1/1/2008 0:01', 'd,,w,d', 0, 'h', 'ddd M/d, "<span style=\'color:red;\'>"HH"</span>"', 'm15', 'mm'],
        //[], // Separator here
        //['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMMM yyyy', 'd', '%d', 'w', 'Week ddddddd', 'd', 'ddddd'],
        //['h6', 'h6', 'w', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/6/2008~1/6/2008 0:01', 'd,,w,w', 0, 'w', 'Week ddddddd - MMMM d, yyyy', 'd', 'dddd', 'd', 'dddddd MMMM', 'h6', 'HH'],
        //];

        //      // --- Changes the attributes and refreshes Gantt ---   
        //      if (!T[idx]) return;
        //      for (var i = 0; i < H.length; i++) C[H[i]] = T[idx][i];
        //      G.ShowMessage("Recalculating Gantt chart");
        //      setTimeout(function() { G.RefreshGantt(1); G.HideMessage(); G.SetScrollBars(); }, 10);
        //  }

        // --- Called when grid is loaded and before is rendered to choose the Gantt chart according to zoom settings ---
        // -- Nem Layout should be different to load cookies
        Grids.OnGanttStart = function (G) {
            //G.DoAction(G.GetRowById('Group'), "Resources");   // Sets Resource filter stored in cookies
            //G.DoAction(G.Rows.Group, "Zoom", G.Rows.Group.ZoomOnChange);
            // return true;
            G.PageLength = G.Grouped && G.Group && G.Group.length ? 1 : 10;
            G.CreatePages();
            G.Render();
        }


        // --- Informational message when printing ---
        Grids.OnClickButtonPrint = function () {
            alert("To successfully print the chart you should have chosen 'Printing of background colors and images' in your browser.\nIn IE in Internet options -> Advanced -> Print.\nIn FF in Page setup -> Format and options");
        }

        // --- Updates length of page for tree, for tree is used 1, for plain table 8 ---
        Grids.OnGroup = function (G, Cols) {
            G.PageLength = G.Grouped && Cols && Cols.length ? 1 : 10;
        }
        Grids.OnClickPanelGrouped = function (G) {
            G.PageLength = !G.Grouped && G.GroupCols && G.GroupCols.length ? 1 : 10;
        }

        // --- Updates length of page for collapsed rows ---
        Grids.OnClickButtonCollapseAll = function (G) {
            //G.PageLength = 8;
            //G.CreatePages();
            for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 0;
            G.Render();
            return "";
        }

        // --- Updates length of page for expanded rows ---
        Grids.OnClickButtonExpandAll = function (G) {
            //G.PageLength = 1;
            //G.CreatePages();
            for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 1;
            G.Render();
            return "";
        }

        //Grids.OnRenderFinish = function(G) { $("span[title=http://www.treegrid.com/]").hide(); }
        //Grids.OnGroupFinish = function(G) { $("span[title=http://www.treegrid.com/]").hide(); }

        function onCheckBoxClick(chk, value) {
            var combo = $find("<%= ddlAllResources.ClientID %>");
            var text = "";
            var values = "";
            var items = combo.get_items();
            for (var i = 0; i < items.get_count() ; i++) {
                var item = items.getItem(i);
                var chk1 = $get(combo.get_id() + "_i" + i + "_chkResource");
                if (chk1.checked) {
                    text += item.get_text() + ";";
                    values += item.get_value() + ";";
                }
            }
            text = removeLastSemiColumn(text);
            values = removeLastSemiColumn(values);

            var hdnResourceSelectedValues = $("[id$='hdnResourceSelectedValues']")[0];
            hdnResourceSelectedValues.value = values;

            if (text.length > 0) {
                combo.set_text(text);
            }
            else {
                combo.set_text("");
            }
        }

        function removeLastSemiColumn(str) {
            if (str.lenght >= 1) {
                return str.substring(0, str.lenght - 1);
            } else {
                return str;
            }
        }

        function OnClientItemsRequested_chkResources(sender, args) {
            $("[id$='chkResource']").change(function () { setResources(this); });
        }
        function setResources(e) {
            // var hdnResourcesValues = $("[id$='hdnResourcesValues']").val("");
            $("[id$='chkResource']:checked").each(function () {
                var selectedValue = $(this).parents().find("[id$='hdnResourceValue']").val();
                onCheckBoxClick(this, selectedValue);
            });
        }

    </script>


    <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientButtonClicking="OnClientButtonClickingHandler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName="Print"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ResoucesAvailability"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="documentSinglePage">
        <tr>
            <td>
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblResources" meta:resourcekey="lblResources" Text="Resources"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:HiddenField ID="hdnResourcesValues" runat="server" />
                                        <telerik:RadComboBox ID="ddlAllResources" runat="server" Skin="Default" AllowCustomText="True" OnClientItemsRequested="OnClientItemsRequested_chkResources" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            Filter="Contains" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                                            Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Width="100%">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <table width="100%" cellpadding="1" cellspacing="0" border="0">
                                                        <tr>
                                                            <td class="Top">
                                                                <asp:CheckBox runat="server" ID="chkResource" />
                                                            </td>
                                                            <td style="width: 99%" class="NoWrap">
                                                                <asp:HiddenField ID="hdnResourceValue" runat="server" Value='<%# DataBinder.Eval(Container, "Value")%>' />
                                                                <asp:Label runat="server" ID="lblResource" AssociatedControlID="chkResource">
                                            <%#DataBinder.Eval(Container, "Text")%>
                                                                </asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblFromDate" meta:resourcekey="lblFromDate" Text="From Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDateInput runat="server" ID="rdiFromDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%" Style="text-align:right;"></telerik:RadDateInput>
                                    </td>

                                </tr>


                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblToDate" meta:resourcekey="lblToDate" Text="To Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDateInput runat="server" ID="rdiToDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%" Style="text-align:right;"></telerik:RadDateInput>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth">
                                        <asp:Button ID="btnSearch" runat="server" meta:resourcekey="btnSearch" Text="Search" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <div style="width: 100%; height: 510px; margin-top: 10px;">
                    <treegrid debug="1"
                        data_url="ResoucesAvailability.aspx?Req=Data"
                        text_url='<%= IIF(IO.File.Exists(PM.Parameters.PM_WEBSITE_PHYSICAL_PATH + "\Utilities\TreeGrid\Text." & PM.UserInfo.Language & ".xml"), "Utilities/TreeGrid/Text." & PM.UserInfo.Language & ".xml", "Utilities/TreeGrid/Text.xml") %>'
                        export_url="Utilities/TreeGrid/Export.aspx"
                        export_data="TGData"
                        export_param_file="Table.xls">
                    </treegrid>
                </div>
            </td>

        </tr>
    </table>

    <asp:HiddenField ID="hdnResourceSelectedValues" runat="server" />
</asp:Content>
