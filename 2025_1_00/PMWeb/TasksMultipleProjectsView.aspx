<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TasksMultipleProjectsView.aspx.vb" Inherits="Website.TasksMultipleProjectsView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Multiple Projects View</title>
    <script src="Utilities/TreeGrid/GridE.js" type="text/javascript"> </script>
    <link href="Utilities/TreeGrid/Modern/Grid.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    
    // --- Chooses Gantt chart according to Zoom settings ---
    function DoZoom(idx) {
        var G = Grids[0], C = G.Cols.G; // G = actual grid, C = actual Gantt column

        // --- Attribute names to change ---
        var H = ["GanttUnits", "GanttRound", "GanttChartRound", "GanttWidth", "GanttMin", "GanttMax", "GanttBackground", "GanttBackgroundRepeat", "GanttHeaderOptions",
   "GanttHeader1", "GanttFormat1", "GanttHeader2", "GanttFormat2", "GanttHeader3", "GanttFormat3", "GanttHeader4", "GanttFormat4", "GanttHeader5", "GanttFormat5"];

        // --- Attribute values for individual zooms ---   
        var T = [
   ['M6', 'M3', 'y', 18, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M6', 'MMMMMM'],
   ['M3', 'M', 'y', 24, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';y', 0, 'y', 'yyyy', 'M3', 'MMMMM'],
   ['M', 'M', 'y', 18, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M6', 0, 'M6', 'MMMMMM. yyyy', 'M', 'MM'],
   ['M', 'w', 'M3', 28, '1/1/1990', '1/1/2040', ';1/1/2008~1/1/2008 1:00', ';M3', 0, 'M3', 'MMMMM. yyyy', 'M', 'MMM'],
   ['w', 'd', 'M', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMM yyyy', 'w', 'd.'],
   ['d', 'd', 'M', 6, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMMM yyyy', 'd', '.'],
   ['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'w', '"<span style=\'color:red;font-size:8px;\'>"ddddddd"</span>" dddddd MMMM yyyy', 'd', 'ddddd'],
   ['h6', 'h6', 'w', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/6/2008~1/6/2008 0:01', 'd,,w,w', 0, 'd', 'ddd dd MMM', 'h6', 'HH'],
   ['h', 'h', 'd', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/1/2008~1/1/2008 0:01', 'd,,w,d', 0, 'd', 'ddd dd MMM', 'h', 'HH'],
   ['m15', 'm5', 'd', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/1/2008~1/1/2008 0:01', 'd,,w,d', 0, 'h', 'ddd M/d, "<span style=\'color:red;\'>"HH"</span>"', 'm15', 'mm'],
   [], // Separator here
   ['d', 'd', 'w', 18, '1/1/1990', '1/1/2040', '1/5/2008~1/7/2008;1/1/2008~1/1/2008 1:00', 'w,M', 0, 'M', 'MMMM yyyy', 'd', '%d', 'w', 'Week ddddddd', 'd', 'ddddd'],
   ['h6', 'h6', 'w', 18, '1/1/1990', '1/1/2040', '1/1/2008 17:00 ~ 1/2/2008 8:00;;1/5/2008~1/7/2008;1/6/2008~1/6/2008 0:01', 'd,,w,w', 0, 'w', 'Week ddddddd - MMMM d, yyyy', 'd', 'dddd', 'd', 'dddddd MMMM', 'h6', 'HH'],
   ];

        // --- Changes the attributes and refreshes Gantt ---   
        if (!T[idx]) return;
        for (var i = 0; i < H.length; i++) C[H[i]] = T[idx][i];
        G.ShowMessage("Recalculating Gantt chart");
        setTimeout(function() { G.RefreshGantt(1); G.HideMessage(); G.SetScrollBars(); }, 10);
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
        G.PageLength = G.Grouped && Cols && Cols.length ? 1 : 8;
    }
    Grids.OnClickPanelGrouped = function(G) {
        G.PageLength = !G.Grouped && G.GroupCols && G.GroupCols.length ? 1 : 8;
    }

    // --- Updates length of page for collapsed rows ---
    Grids.OnClickButtonCollapseAll = function(G) {
        G.PageLength = 8;
        G.CreatePages();
        for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 0;
        G.Render();
        return "";
    }

    // --- Updates length of page for expanded rows ---
    Grids.OnClickButtonExpandAll = function(G) {
        G.PageLength = 1;
        G.CreatePages();
        for (var b = G.XB.firstChild; b; b = b.nextSibling) for (var r = b.firstChild; r; r = r.nextSibling) r.Expanded = 1;
        G.Render();
        return "";
    }

      </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="WIDTH:100%;HEIGHT:600px;">
        <treegrid Debug="0"
             Data_Url="TasksMultipleProjectsView.aspx?Req=Data" 
                           
             Export_Url="Utilities/TreeGrid/Export.aspx"
             Export_Data="TGData"
             Export_Param_File="Table.xls">
         </treegrid>
    </div>
    </form>
</body>
</html>
