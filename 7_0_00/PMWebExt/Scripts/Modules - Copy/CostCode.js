var self = {}, ext = {}
function CostCode(_ext) {
    self = this;
    ext = _ext;
}
Object.assign(CostCode.prototype, {
    FormatData: function (data) {
        var rows = data.split('\r');
        var costCodeIdx = self.GetCostCodeIdx();
        for (var i = 0; i < rows.length; i++) {
            rows[i] = self.FormatCostCode(rows[i], costCodeIdx);
        }
        return rows.join('\r');
    },
    FormatCostCode: function (row, costCodeIdx) {
        var columns = row.split('\t');
        var costCode = columns[costCodeIdx];
        var detailNumbers = costCode.split('-');
        detailNumbers[3] = detailNumbers[2] + '.' + detailNumbers[3];
        detailNumbers[5] = detailNumbers[4] + '.' + detailNumbers[5];
        columns[costCodeIdx] = detailNumbers.join('-');
        return columns.join('\t');
    },
    GetCostCodeIdx: function () {
        if (ext.pmweb.getPage().toLowerCase() == 'costcodes.aspx') {
            return 0;
        }
    }
});
export { CostCode };