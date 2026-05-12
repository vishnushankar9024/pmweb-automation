<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="TasksMultipleProjects.aspx.vb" Inherits="Website.TasksMultipleProjects"  meta:resourcekey="Page"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<script src="Utilities/TreeGrid/GridE.js" type="text/javascript"> </script>
    <script type="text/javascript">
    
        delete Number.prototype._toFormattedString;
        delete Number.prototype.format;
        delete Number.prototype.localeFormat;
    // --- Chooses Gantt chart according to Zoom settings ---
        // --- Chooses Gantt chart according to Zoom settings ---
   //     function DoZoom(idx) {
   //         if (!parseInt(idx)) { idx = 0; }
   //         var G = Grids[0], C = G.Cols.G; // G = actual grid, C = actual Gantt column
   //         // --- Attribute names to change ---
   //         var H = ["GanttUnits", "GanttRound", "GanttChartRound", "GanttWidth", "GanttMin", "GanttMax", "GanttBackground", "GanttBackgroundRepeat", "GanttHeaderOptions",
   //"GanttHeader1", "GanttFormat1", "GanttHeader2", "GanttFormat2", "GanttHeader3", "GanttFormat3", "GanttHeader4", "GanttFormat4", "GanttHeader5", "GanttFormat5"];

   //         // --- Attribute values for individual zooms ---
   //      var T = [
   //['M6', 'd', 'M6', 75, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M6', 'MMMMMM'],
   //['M3', 'd', 'M6', 75, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M3', 'MMMMM'],
   //['M', 'd', 'M6', 35, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M6', 0, 'M6', 'MMMMMM. yyyy', 'M', 'MM'],
   //['M', 'd', 'M3', 50, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M3', 0, 'M3', 'MMMMM. yyyy', 'M', 'MMM'],
   //['w', 'd', 'M', 20, '1/1/1990', '1/1/2040', '1/1/2008~1/1/2008 1:00', 'M', 0, 'M', 'MMM yyyy', 'w', 'd.'],
   //['d', 'd', 'M', 6, '1/1/1990', '1/1/2040', '1/1/2008~1/1/2008 1:00', 'M', 0, 'M', 'MMMM yyyy', 'd', '.'],
   //['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/1/2008~1/1/2008 1:00', 'M', 0, 'w', '"<span style=\'color:red;font-size:8px;\'>"ddddddd"</span>" dddddd MMMM yyyy', 'd', 'ddddd'],
   // [], // Separator here
   //['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMMM yyyy', 'd', '%d', 'w', 'Week ddddddd', 'd', 'ddddd'],
   //];

   //         // --- Changes the attributes and refreshes Gantt ---   
   //         if (!T[idx]) return;
   //         for (var i = 0; i < H.length; i++) C[H[i]] = T[idx][i];
   //         G.ShowMessage("Recalculating Gantt chart");
   //         setTimeout(function() { G.RefreshGantt(1); G.HideMessage(); G.SetScrollBars(); }, 10);
   //     }

        // --- Called when grid is loaded and before is rendered to choose the Gantt chart according to zoom settings ---
        // -- Nem Layout should be different to load cookies
        Grids.OnGanttStart = function(G) {
            //G.DoAction(G.GetRowById('Group'), "Resources");   // Sets Resource filter stored in cookies
            //G.DoAction(G.GetRowById('Group'), "Zoom");        // Sets Zoom level stored in cookies and recalculates Gantt
            //G.DoAction(G.Rows.Group, "Zoom", G.Rows.Group.ZoomOnChange);
            // return true;
            G.PageLength = G.Grouped && G.Group && G.Group.length ? 1 : 10;
            G.CreatePages();
            G.Render();
        }
    // --- To ensure Start <= End ---
    Grids.OnValueChanged = function(G, row, col, val) {
        if (val && (col == 'E' && Get(row, 'S') && val < Get(row, 'S') || col == 'S' && Get(row, 'E') && val > Get(row, 'E'))) {
            alert('Wrong date!');
            return Get(row, col);
        }
        return val;
    }


    // --- Informational message when printing ---
    Grids.OnClickButtonPrint = function() {
        alert("To successfully print the chart you should have chosen 'Printing of background colors and images' in your browser.\nIn IE in Internet options -> Advanced -> Print.\nIn FF in Page setup -> Format and options");
    }

    // --- Updates length of page for tree, for tree is used 1, for plain table 8 ---
    Grids.OnGroup = function(G, Cols) {
        G.PageLength = G.Grouped && Cols && Cols.length ? 1 : 10;
    }
    Grids.OnClickPanelGrouped = function(G) {
        G.PageLength = !G.Grouped && G.GroupCols && G.GroupCols.length ? 1 : 10;
    }

    // --- Updates length of page for collapsed rows ---
    Grids.OnClickButtonCollapseAll = function(G) {
        //G.PageLength = 8;
        //G.CreatePages();
        for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 0;
        G.Render();
        return "";
    }

    // --- Updates length of page for expanded rows ---
    Grids.OnClickButtonExpandAll = function(G) {
        //G.PageLength = 1;
        //G.CreatePages();
        for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 1;
        G.Render();
        return "";
    }

   
      </script>

      <div style="WIDTH:100%;HEIGHT:590px;">
        <treegrid Debug="0"
             Data_Url="TasksMultipleProjects.aspx?Req=Data" 
             Text_Url='<%= IIF(IO.File.Exists(PM.Parameters.PM_WEBSITE_PHYSICAL_PATH + "\Utilities\TreeGrid\Text." & PM.UserInfo.Language & ".xml"),"Utilities/TreeGrid/Text." & PM.UserInfo.Language & ".xml","Utilities/TreeGrid/Text.xml") %>'
                            
             Export_Url="Utilities/TreeGrid/Export.aspx"
             Export_Data="TGData"
             Export_Param_File="Table.xls">
         </treegrid>
    </div>
</asp:Content>
