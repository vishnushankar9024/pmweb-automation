(function () {
    var dependency = {
        scripts: ['https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js', 'https://cdn.datatables.net/buttons/1.4.2/js/dataTables.buttons.min.js'],
        styles: ['PMWebHelper/Content/bootstrap.min.css', 'PMWebHelper/Content/jquery.dataTables.css', 'PMWebHelper/Content/buttons.dataTables.css', 'PMWebHelper/Content/datatables.min.css']
    };

    dependency.scripts.forEach(function (src) {
        var s = document.createElement("script");
        s.type = "text/javascript";
        s.src = src;
        $("head").append(s);
    });

    dependency.styles.forEach(function (src) {
        var link = document.createElement("link");
        link.type = "text/css";
        link.rel = "stylesheet";
        link.href = src;
        $("head").append(link);
    });
    

    var ocsElement = $('#ocs-data');
    Init = function()
    {
        var table = $('<table class="table table-hover table-nomargin dataTable table-bordered"></table>');
        ocsElement.append(table);

        var thead = $('<thead></thead>');

        var theadRow = $('<tr></tr>');
        theadRow.appendTo(thead);

        // Columns
        theadRow.append($('<td>Document Title</td>'));
        theadRow.append($('<td>Rev.No.</td>'));

        //Body
        var tbody = $('<tbody></tbody>');
        var tbodyRow = $('<tr></tr>');
        for(var i = 0; i<10; i++)
        {
            var tr = tbodyRow.clone();
            tr.append($('<td></td>').html('Title - ' + i));
            tr.append($('<td></td>').html('Rev - ' + i));
            tbody.append(tr)
        }


        table.append(thead);
        table.append(tbody);
    }
    this.Init();
    $(document).ready(function () { 
        $('table', ocsElement).DataTable();
    });
})();