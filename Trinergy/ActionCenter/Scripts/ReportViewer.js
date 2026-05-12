Sys.Application.add_load(function () {
    $("#pleaseWaitDialog").show();
    $find("rptViewer1").add_propertyChanged(viewerPropertyChanged);
});

function viewerPropertyChanged(sender, e) {
    debugger;
    if (e.get_propertyName() == "isLoading") {
        if ($find("rptViewer1").get_isLoading()) {
            // Do something when loading starts
            debugger;
        }
        else {
            // Do something when loading stops
            debugger;
        }
    }
};