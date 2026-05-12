function SubmittalddlTasksSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents("tr:first");
    var lblTaskDate = tr.find("span[id$='lblTaskDate']");
    var lblTaskFinishDate = tr.find("span[id$='lblTaskFinishDate']");
    var txtLeadTime = tr.find("input[id$='txtLeadTime']");
    lblTaskDate.html(item.get_attributes().getAttribute("Start"));
    lblTaskFinishDate.html(item.get_attributes().getAttribute("Finish"));
    var hdnStart = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnStart');
    var dtpdueDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_dtpDueDate');
    hdnStart.value = item.get_attributes().getAttribute("StartMilsc");
    if (hdnStart.value != "") {
        var myDate = new Date(parseFloat(hdnStart.value));
        var LeadTime = txtLeadTime.val();
        var i = 0;
        if (LeadTime > 0) {
            while (i < LeadTime) {
                myDate.setDate(myDate.getDate() - 1);
                i = i + 1;
            }
        }
        if (LeadTime < 0) {
            LeadTime = LeadTime * -1;
            while (i < LeadTime) {
                myDate.setDate(myDate.getDate() + 1);
                i = i + 1;
            }
        }
        dtpdueDate.set_selectedDate(myDate);
    }


}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtLeadTime]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = $(this).parents("tr:first");
        var txtLeadTime = tr.find("input[id$='txtLeadTime']");
        var hdnStart = tr.find("input[id$='hdnStart']");
        var duedateId = txtLeadTime.context.id;
        duedateId = duedateId.substring(duedateId.lastIndexOf('_'), duedateId.lenght - 1) + '_dtpDueDate';
        var dtpdueDate = $find(duedateId);
        if (hdnStart.val() != "") {

            var myDate = new Date(parseFloat(hdnStart.val()));
            var LeadTime = txtLeadTime.val();
            var i = 0;
            if (LeadTime > 0) {
                while (i < LeadTime) {
                    myDate.setDate(myDate.getDate() - 1);
                    i = i + 1;
                }
            }
            if (LeadTime < 0) {
                LeadTime = LeadTime * -1;
                while (i < LeadTime) {
                    myDate.setDate(myDate.getDate() + 1);
                    i = i + 1;
                }
            }
            dtpdueDate.set_selectedDate(myDate);





        }


    });


};
