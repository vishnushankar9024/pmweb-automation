//$(document).ready(function () {
//    $("input[id$='txtMarketRentMonth']").attr("onBlur", " CalculateSnapShot('MarketRentMonth')");
//    $("input[id$='txtGrossArea']").attr("onBlur", " CalculateSnapShot('GrossArea')");
//});


function CalculateSnapShot() {

    var txtMarketRentMonth = $('input[id$=txtMarketRentMonth]');
    var txtCurrentRentMonth = $('input[id$=txtCurrentRentMonth]');
    var txtMarketRentYear = $('input[id$=txtMarketRentYear]');
    var txtCurrentRentYear = $('input[id$=txtCurrentRentYear]');

    var txtGrossArea = $('input[id$=txtGrossArea]');
    var txtMarketRentAreaMonth = $('input[id$=txtMarketRentAreaMonth]');
    var txtCurrentRentAreaMonth = $('input[id$=txtCurrentRentAreaMonth]');
    var txtMarketRentAreaYear = $('input[id$=txtMarketRentAreaYear]');
    var txtCurrentRentAreaYear = $('input[id$=txtCurrentRentAreaYear]');

    var MarketRentMonthVal = txtMarketRentMonth.val();
    //txtCurrentRentMonth.val(CCur(CDbl(MarketRentMonthVal)));
    var CurrentRentMonthVal = txtCurrentRentMonth.val();
    txtMarketRentYear.val(CCur(CDbl(MarketRentMonthVal) * 12));
    txtCurrentRentYear.val(CCur(CDbl(CurrentRentMonthVal) * 12));

    var GrossAreaVal = txtGrossArea.val();
    if (CDbl(GrossAreaVal) > 0) {

        txtMarketRentAreaMonth.val(CCur(CDbl(MarketRentMonthVal) / CDbl(GrossAreaVal)));
        txtCurrentRentAreaMonth.val(CCur(CDbl(CurrentRentMonthVal) / CDbl(GrossAreaVal)));
        txtMarketRentAreaYear.val(CCur(CDbl(MarketRentMonthVal) * 12 / CDbl(GrossAreaVal)));
        txtCurrentRentAreaYear.val(CCur(CDbl(CurrentRentMonthVal) * 12 / CDbl(GrossAreaVal)));
        

    }
    else {

        txtMarketRentAreaMonth.val(CCur(CDbl(0)));
        txtCurrentRentAreaMonth.val(CCur(CDbl(0)));
        txtMarketRentAreaYear.val(CCur(CDbl(0)));
        txtCurrentRentAreaYear.val(CCur(CDbl(0)));
    }

}
