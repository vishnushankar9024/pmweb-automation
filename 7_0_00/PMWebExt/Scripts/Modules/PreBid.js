var self = {}, ext = {};
var btnUpdate = "";
var preBidMatrixGrid = "";
function PreBid(_ext) {
    self = this;
    ext = _ext;
}
Object.assign(PreBid.prototype, {
    GetPQDetails: function (Id, element) {
        if (btnUpdate === "") {
            btnUpdate = $("a[id$='btnUpdateEdited']");
            if (btnUpdate.length > 0 && typeof (btnUpdate) !== 'undefined') {
                btnUpdate.click(self.Update);
            }
            else {
                btnUpdate = "";
            }
        }
        ext.ajx.post(ext.pmweb.getHost() + '/PreBid/GetPQDetails', { Id: Id }).then((data) => self.BindData(data, element));
    },
    BindData: function (data, element) {
        if (data) {
            data = JSON.parse(data);
            var PreBid = data.PreBid;
            var PreBidMatrixUserDefinedFields = data.PreBidMatrixUserDefinedFields;
            var tr = $(element);
            var td = $('td', tr);

            if (PreBid) {
                $('td:eq(' + (td.length - 4) + ')', tr).html(PreBid.PQStatus);
                $('td:eq(' + (td.length - 3) + ')', tr).html(PreBid.PQDateStr);
                $('td:eq(' + (td.length - 2) + ')', tr).html(PreBid.PQExpiryDateStr);
                $('td:eq(' + (td.length - 1) + ')', tr).html(PreBid.NDAReceived);
            }
            var EOIStatus = $('#ddlEOIStatus', tr);
            if (PreBidMatrixUserDefinedFields && EOIStatus.length <= 0) {
                $('td:eq(' + (td.length - 9) + ')', tr).html(PreBidMatrixUserDefinedFields.EOIStatus);
                $('td:eq(' + (td.length - 8) + ')', tr).html(PreBidMatrixUserDefinedFields.EOIRecievedDate);
                $('td:eq(' + (td.length - 7) + ')', tr).html(PreBidMatrixUserDefinedFields.Capability);
                $('td:eq(' + (td.length - 6) + ')', tr).html(PreBidMatrixUserDefinedFields.Experience);
                $('td:eq(' + (td.length - 5) + ')', tr).html(PreBidMatrixUserDefinedFields.Resources);
            }
            else if (PreBidMatrixUserDefinedFields && EOIStatus.length > 0) {
                $('#ddlEOIStatus', tr).val(PreBidMatrixUserDefinedFields.EOIStatus);
                $('input[id*="txtEOIReceivedDate"]', tr).val(PreBidMatrixUserDefinedFields.EOIRecievedDate);
                $('#ddlCapability', tr).val(PreBidMatrixUserDefinedFields.Capability);
                $('#ddlExperience', tr).val(PreBidMatrixUserDefinedFields.Experience);
                $('#ddlResources', tr).val(PreBidMatrixUserDefinedFields.Resources);
            }
        }
    },
    Update: function (e) {
        btnUpdate = "";
        var masterTableView = self.PreBidMatrixGrid.get_masterTableView();
        var editItems = masterTableView.get_editItems();
        for (var i = 0; i < editItems.length; i++) {
            var editItem = editItems[i];         
            var Id = editItem.getDataKeyValue("Id");
            var element = editItem.get_element();
            var tr = $(element);
            //var td = $('td', tr);

            //var eoiStatusTd = $('td:eq(' + (td.length - 9) + ')', tr);
            //var eoiRecievedDateTd = $('td:eq(' + (td.length - 8) + ')', tr);
            //var capabilityTd = $('td:eq(' + (td.length - 7) + ')', tr);
            //var experienceTd = $('td:eq(' + (td.length - 6) + ')', tr);
            //var resourcesTd = $('td:eq(' + (td.length - 5) + ')', tr);

            var EOIStatus = $('#ddlEOIStatus', tr).val();
            //var EOIRecievedDate = $('#txtEOIReceivedDate', tr).val();
            var EOIRecievedDate = $('input[id*="txtEOIReceivedDate"]', tr).val();
            var Capability = $('#ddlCapability', tr).val();
            var Experience = $('#ddlExperience', tr).val();
            var Resources = $('#ddlResources', tr).val();

            ext.ajx.post(ext.pmweb.getHost() + '/PreBid/UpdatePreBid', { Id: Id, EOIStatus: EOIStatus, EOIRecievedDate: EOIRecievedDate, Capability: Capability, Experience: Experience, Resources: Resources });
        }
        //alert('test');
    },
    PreBidMatrixGrid: {}
});
export { PreBid }