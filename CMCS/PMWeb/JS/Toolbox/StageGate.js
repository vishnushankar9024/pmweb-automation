function AdjustScoreCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Score
    $("input[id*=" + gridId + "][id$=txtScore]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Score");
    }
    ).focus(function() {
        OldUnitCostVal = $(this).val();
    }
    );

    // On change Points
    $("input[id*=" + gridId + "][id$=txtPointsAvailable]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "PointAvailable");
    }
    ).focus(function() {
        OldQuantityVal = $(this).val();
    }
    );

    // On change Weight
    $("input[id*=" + gridId + "][id$=txtWeight]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Weight");
    }
    ).focus(function() {
        OldTotalCostVal = $(this).val();
    }
    );


}


function CalculateWeightedScore(row, sender) {
    var txtScore = row.find("input[id$='txtScore']");
    var ScoreVal = txtScore.val();

    var txtPointsAvailable = row.find("input[id$='txtPointsAvailable']");
    var PointsVal = txtPointsAvailable.val();
    
    var txtWeight = row.find("input[id$='txtWeight']");
    var WeightVal = txtWeight.val();
    if( CDbl(WeightVal)>CDbl(100)){
    WeightVal=CDbl(100);
    }
    var txtWeightedScore=row.find("input[id$='txtWeightedScore']");
    
    if(PointsVal ==0)
    {
     txtWeightedScore.val(FPrec(0));
    
    }
    else {
    
     txtWeightedScore.val(FPrec((CDbl(ScoreVal)/CDbl(PointsVal))*CDbl(WeightVal)));
    }


    
}

function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $(this).parents("tr:first");
    var txtLeadTime = tr.find("input[id$='txtLeadTime']");
    var hdnStart = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnStart');
    var dtpdueDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_dtpDueDate');
     var dtpStartDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_dtpStartDate');
    hdnStart.value = item.get_attributes().getAttribute("StartMilsc");
    if (hdnStart.value != "") {
        var myDate = new Date(parseFloat(hdnStart.value));
        dtpStartDate.set_selectedDate(myDate);
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

function AdjustLeadTimeCalculation(gridId) {
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