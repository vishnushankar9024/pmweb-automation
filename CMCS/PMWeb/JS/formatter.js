
	if(!Math.roundToPrecision)
	{	    Math.roundToPrecision = function(value, precision) {	        
                                       // Guard.NotNull(value, 'value');
                                        b = Math.pow(10, precision);
                                        return Math.round(value * b) / b;	    
            }
	}
function NumberFormatter() {
  
    var decRegExp = new RegExp(/[^\d\.-]/g);
    var posDecRegExp = new RegExp(/[^\d\.]/g);
    var USSep = ";";
    var USDecRegExp = new RegExp(/[^\d\.;-]/g);

    this.RemoveChars = function (nStr, decimalCharacter, separator) {
      
        decimalCharacter = decimalCharacter || Global_DecimalCharacter;
        separator = separator || Global_DecimalSeparator;
        nStr = nStr.replace(Global_CurrencySymbol, '');
        for (i = 0; i < Global_AllCurrencySymbols.length; i++) {
            nStr = nStr.replace(Global_AllCurrencySymbols[i], "")
        }
        var USNumber = this.GetUSNumber(nStr, decimalCharacter, separator);
        return USNumber.replace('.', decimalCharacter);
    }

    this.GetUSNumber = function (nStr, decimalCharacter, separator) {
    decimalCharacter = decimalCharacter || Global_DecimalCharacter;
    separator = separator || Global_DecimalSeparator;
        if (nStr == "") { return "0"; }
        else if (!this.IsUSNumber(nStr, decimalCharacter, separator)) {
            nStr = ReplaceAllString(nStr, separator, '');
            var USNumber = nStr.replace(decimalCharacter, USSep);
            nStr = USNumber.replace(USDecRegExp, '').replace(USSep, '.');
        }
        return nStr;
    }

    this.IsUSNumber = function (amount, decimalCharacter, separator) {
    decimalCharacter = decimalCharacter || Global_DecimalCharacter;
    separator = separator || Global_DecimalSeparator;
        if (isNaN(amount)) return false;
        return !(amount.indexOf(".") < 0 && amount.indexOf(decimalCharacter) > -1)
            || (amount.indexOf(".") > 0 && amount.indexOf(".") < amount.indexOf(decimalCharacter));
    }
    
    this.FormatInteger = function(nStr) {
        nStr = +nStr.replace(/[^\d-]/g, '');
        return isNaN(parseInt(nStr)) ? 0 : parseInt(nStr); 
    }

    this.FormatPositiveInteger = function(nStr) {
        nStr = +nStr.replace(/[^\d]/g, ''); 
        return isNaN(parseInt(nStr)) ? 0 : parseInt(nStr); 
    }

    this.FormatDouble = function (nStr, decimalCharacter, separator, decimalPrecision) {
        decimalCharacter = decimalCharacter || Global_DecimalCharacter;
        separator = separator || Global_DecimalSeparator;
        if (separator == '&nbsp;' || separator == " ") {
            nStr = ReplaceAllString(nStr, '&nbsp;', '');
            nStr = ReplaceAllString(nStr, " ", '');
        }
        nStr = nStr.replace(Global_CurrencySymbol, '');
        for (i = 0; i < Global_AllCurrencySymbols.length; i++) {
            nStr = nStr.replace(Global_AllCurrencySymbols[i], "")
        }
        nStr = this.GetUSNumber(nStr, decimalCharacter, separator);
        decimalPrecision = decimalPrecision || Global_DecimalPrecision;
        return isNaN(parseFloat(nStr)) ? 0 : parseFloat(Math.round(nStr * Math.pow(10, decimalPrecision)) / (Math.pow(10, decimalPrecision))).toFixed(decimalPrecision);
    }

    this.FormatPositiveDouble = function (nStr, decimalCharacter, separator, decimalPrecision) {
    decimalCharacter = decimalCharacter || Global_DecimalCharacter;
    separator = separator || Global_DecimalSeparator;
    if (separator == '&nbsp;' || separator == " ") {
        nStr = ReplaceAllString(nStr, '&nbsp;', '');
        nStr = ReplaceAllString(nStr, " ", '');
    }
    nStr = nStr.replace(Global_CurrencySymbol, '');
    for (i = 0; i < Global_AllCurrencySymbols.length; i++) {
        nStr = nStr.replace(Global_AllCurrencySymbols[i], "")
    }
    nStr = this.GetUSNumber(nStr, decimalCharacter, separator);
    decimalPrecision = decimalPrecision || Global_DecimalPrecision;
    return isNaN(parseFloat(nStr)) ? 0 : parseFloat(parseFloat(Math.round(nStr * Math.pow(10, decimalPrecision)) / (Math.pow(10, decimalPrecision))).toFixed(decimalPrecision));
    }

    this.FormatDays = function (nStr, decimalCharacter, separator, decimalPrecision) {
        decimalCharacter = decimalCharacter || Global_DecimalCharacter;
        separator = separator || Global_DecimalSeparator;
        if (separator == '&nbsp;' || separator == " ") {
            nStr = ReplaceAllString(nStr, '&nbsp;', '');
            nStr = ReplaceAllString(nStr, " ", '');
        }        
        nStr = this.GetUSNumber(nStr, decimalCharacter, separator);
        decimalPrecision = decimalPrecision || Global_DecimalPrecision;
        return isNaN(parseFloat(nStr)) ? 0 : parseFloat(parseFloat(Math.round(nStr * Math.pow(10, decimalPrecision)) / (Math.pow(10, decimalPrecision))).toFixed(decimalPrecision));
    }



    this.FormatMinMax = function(val, min, max) {
        if (max && (CDbl(val) > CDbl(max))) return max;
        else if (min && (CDbl(val) < CDbl(min))) return min;
        else return val;
    }

    this.FormatPrecision = function (amount, precision, decimalCharacter, separator,Iscurrency) {
        decimalCharacter = decimalCharacter || Global_DecimalCharacter;
        precision = precision || Global_DecimalPrecision;
        separator = separator || Global_DecimalSeparator;
        if (separator == '&nbsp;' || separator == " ") {
            amount = ReplaceAllString(amount, '&nbsp;', '');
            amount = ReplaceAllString(amount, " ", '');
        }
        amount = amount.replace(Global_CurrencySymbol, '');
        for (i = 0; i < Global_AllCurrencySymbols.length; i++) {
            amount = amount.replace(Global_AllCurrencySymbols[i], "")
        }
        amount = (amount == "") ? "0" : amount;
        if ((Math.floor(amount) == amount && $.isNumeric(amount)) && !Iscurrency) {
            precision=0
        }
        strAmount = this.GetUSNumber(amount.toString(), decimalCharacter, separator);
        strAmount = parseFloat(Math.round(strAmount * Math.pow(10, precision)) / (Math.pow(10, precision))).toFixed(precision).replace(/\./g, decimalCharacter);
        return this.AddSeparator(strAmount, decimalCharacter, separator);
    }
    
    this.AddSeparator = function(strAmount, decimalCharacter, separator) {
        var a = strAmount.split(decimalCharacter, 2)
        var d = a[1] || "";
        var i = parseInt(a[0]);
        if (isNaN(i)) { return ''; }
        var minus = '';
        if (strAmount.substr(0, 1) == '-' ) { minus = '-'; }
        i = Math.abs(i);
        var n = new String(i);
        var a = [];
        while (n.length > 3) {
            var nn = n.substr(n.length - 3);
            a.unshift(nn);
            n = n.substr(0, n.length - 3);
        }
        if (n.length > 0) { a.unshift(n); }
        n = a.join(separator);
        if (d.length < 1) { strAmount = n; }
        else { strAmount = n + decimalCharacter + d; }
        strAmount = minus + strAmount;
        return strAmount;
    }

}
var numberFormatter = new NumberFormatter();

function CurrencyFormatter(CurrencySymbol, SymbolPosition) {

    this.FormatCurrency = function (amount, ctrl) {
        if (ctrl) {
            this.SymbolPosition = $(ctrl).attr("symbolposition");
            this.CurrencySymbol = $(ctrl).attr("currencysymbol");
            var PrecisionAttr = $(ctrl).attr("precision");
            var DecimalCharAttr = $(ctrl).attr("decimalChar");
            var SeparatorAttr = $(ctrl).attr("separator");
           
        }
        this.SymbolPosition = this.SymbolPosition || Global_CurrencySymbolPosition;
        this.CurrencySymbol = this.CurrencySymbol || Global_CurrencySymbol;
    
        if (Line_CurrencySymbolPosition != null && Line_CurrencySymbol != null) {
            this.SymbolPosition = Line_CurrencySymbolPosition;
            this.CurrencySymbol = Line_CurrencySymbol;
        }

        this.DecimalCharacter = this.DecimalCharacter || Global_DecimalCharacter;
        var strAmount = numberFormatter.FormatPrecision(amount.toString(), PrecisionAttr, DecimalCharAttr, SeparatorAttr,true);
        if (this.SymbolPosition == 'LEFT') return "\u202D" + this.CurrencySymbol + strAmount;
        else return strAmount + " " + this.CurrencySymbol;
    }

    this.FormatCurrencyWithSymbol = function (amount, ctrl, symbol, symbolpos) {

        if (ctrl) {
        
                this.SymbolPosition = $(ctrl).attr("symbolposition");
                this.CurrencySymbol = $(ctrl).attr("currencysymbol");
          
            var PrecisionAttr = $(ctrl).attr("precision");
            var DecimalCharAttr = $(ctrl).attr("decimalChar");
            var SeparatorAttr = $(ctrl).attr("separator");

        }
        this.SymbolPosition = symbolpos;
        this.CurrencySymbol = symbol 
        this.DecimalCharacter = this.DecimalCharacter || Global_DecimalCharacter;
        var strAmount = numberFormatter.FormatPrecision(amount.toString(), PrecisionAttr, DecimalCharAttr, SeparatorAttr);
        if (this.SymbolPosition == 'LEFT') return "\u202D" + this.CurrencySymbol + strAmount;
        else return strAmount + " " + this.CurrencySymbol;
    }

}
var currencyFormatter = new CurrencyFormatter();

function PercentFormatter(Percent) {
    
    this.FormatPercent = function(amount, ctrl) {
    if (ctrl) {
        var PrecisionAttr = $(ctrl).attr("precision");
        var DecimalCharAttr = $(ctrl).attr("decimalChar");
        var SeparatorAttr = $(ctrl).attr("separator");
        this.Percent = $(ctrl).attr("percent");
    }
    this.Percent = this.Percent || Global_PercentCharacter;
    var strAmount = numberFormatter.FormatPrecision(amount.toString(), PrecisionAttr, DecimalCharAttr, SeparatorAttr);
    return strAmount + this.Percent;
    }
}
var percentFormatter = new PercentFormatter();

var CDbl = function (val, decimalCharacter, separator, decimalPrecision) {
    val = val.toString();
    decimalPrecision = decimalPrecision || Global_DecimalPrecision;
    return parseFloat(numberFormatter.FormatDouble(val, decimalCharacter, separator, decimalPrecision));
}
var CPDbl = function(val, decimalCharacter, separator, decimalPrecision) { val = val.toString(); return numberFormatter.FormatPositiveDouble(val, decimalCharacter, separator, decimalPrecision); }
var CDays = function (val, decimalCharacter, separator, decimalPrecision) { val = val.toString(); return numberFormatter.FormatDays(val, decimalCharacter, separator, decimalPrecision); }
var FMM = function(val, min, max) { val = val.toString(); return numberFormatter.FormatMinMax(val, min, max); }

this.FPrec = function (val, decimalCharacter, precision, separator) { val = val.toString(); return numberFormatter.FormatPrecision(val, decimalCharacter, precision, separator); }

var CInt = function(val) { val = val.toString(); return numberFormatter.FormatInteger(val); }
var CPInt = function(val) { val = val.toString(); return numberFormatter.FormatPositiveInteger(val); }


var CCur = function (val, ctrl) { val = val.toString(); return currencyFormatter.FormatCurrency(val, ctrl); }
var CCCur = function (val,  symbol, symbolpos,ctrl) {
    val = val.toString();
    return currencyFormatter.FormatCurrencyWithSymbol(val, ctrl, symbol, symbolpos);
}
var CPrct = function (val, ctrl) { val = val.toString(); return percentFormatter.FormatPercent(val, ctrl); }
