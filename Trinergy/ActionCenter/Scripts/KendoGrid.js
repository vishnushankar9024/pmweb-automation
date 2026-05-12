function ApplyFilter(e, _grid) {
    var grid = $('#' + _grid).data('kendoGrid');
    var columns = grid.columns;

    var filter = { logic: 'or', filters: [] };
    columns.forEach(function (x) {
        if (x.field) {
            var type = grid.dataSource.options.schema.model.fields[x.field].type;
            if (type == 'string') {
                filter.filters.push({
                    field: x.field,
                    operator: 'contains',
                    value: e.target.value
                })
            }
            else if (type == 'number') {
                if (isNumeric(e.target.value)) {
                    filter.filters.push({
                        field: x.field,
                        operator: 'eq',
                        value: e.target.value
                    });
                }

            } else if (type == 'date') {
                var data = grid.dataSource.data();
                for (var i = 0; i < data.length ; i++) {
                    var dateStr = kendo.format(x.format, data[i][x.field]);
                    // change to includes() if you wish to filter that way https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes
                    if (dateStr.startsWith(e.target.value)) {
                        filter.filters.push({
                            field: x.field,
                            operator: 'eq',
                            value: data[i][x.field]
                        })
                    }
                }
            } else if (type == 'boolean' && getBoolean(e.target.value) !== null) {
                var bool = getBoolean(e.target.value);
                filter.filters.push({
                    field: x.field,
                    operator: 'eq',
                    value: bool
                });
            }
        }
    });
    if (e.target.value == "") {
        filter = { logic: 'or', filters: [] };
    }
    grid.dataSource.filter(filter);
    $('.k-header-column-menu').removeClass('k-state-active');
}