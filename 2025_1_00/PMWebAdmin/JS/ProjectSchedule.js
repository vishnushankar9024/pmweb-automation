var width = 30;
var counter = 0;
var fromDate = new Date();
var toDate = new Date();
var Splitter = '|';
var totalWidth = 0;

var TableHeader =	'<table id=tblList width=%width cellspacing=1 cellpadding=1 border=0>' +
						'<tr style="height: 20px">' +
							'%Header%Dates' +
						'</tr>';
var TableBottom = '</table>';

var BodyInfoSub = 
	'<tr  onmouseover=\"mouseover(this, \'TableBodyOver\');\" onmouseout=\"mouseout(\'tblList\', this, \'\');\">' + 
		'%Body%Dates' +
	'</tr>';
	
function RefreshTable()
{
	var arrProjectID = trimObj(document.getElementById('hdProjectID').value, Splitter).split(Splitter);
	var arrName = trimObj(document.getElementById('hdProject').value, Splitter).split(Splitter);
	var arrStartDate = trimObj(document.getElementById('hdStartDate').value, Splitter).split(Splitter);
	var arrFinishDate = trimObj(document.getElementById('hdEndDate').value, Splitter).split(Splitter);
	
	counter = 0;
	var duration = 0;
	var strHTML = ReplaceString(TableHeader, '%Header', ReplaceString(unescape(document.getElementById('hdHeader').value), '+', ' '));
	strHTML = ReplaceString(strHTML, '%Dates', GenerateDatesHeader());
	//var widthlocal = totalWidth + parseInt(document.getElementById('hdWidth').value);
	strHTML = ReplaceString(strHTML, '%width', totalWidth + parseInt(document.getElementById('hdWidth').value));
	
	BodyInfoSub = ReplaceString(BodyInfoSub, '%Body', ReplaceString(unescape(document.getElementById('hdBody').value), '+', ' '));
	
	for(var i = 0; i<arrProjectID.length; i++)
	{
		if(arrProjectID[i]!='')
		{
			strHTML += ReplaceString(BodyInfoSub, '@@01', arrProjectID[i]);
			strHTML = ReplaceString(strHTML, '@@02', arrName[i]);
			strHTML = ReplaceString(strHTML, '@@03', arrStartDate[i]);
			strHTML = ReplaceString(strHTML, '@@04', arrFinishDate[i]);
			strHTML = ReplaceString(strHTML, '%Dates', GenerateDates(arrName[i], arrStartDate[i], arrFinishDate[i]));
			
			counter++;
		}
	}
	strHTML+=TableBottom;
	document.getElementById('tdInfo').innerHTML = strHTML;
}
function RefreshHeaderTable()
{
	var lateDate = new Date();
	var diffs;
	var curDate;
	var arrEarlyFinish = trimObj(document.getElementById('hdEndDate').value, Splitter).split(Splitter);
	
	document.getElementById('hdLastDate').value = '';
	
	for(var i = 0; i<arrEarlyFinish.length; i++)
	{
		curDate = new Date(arrEarlyFinish[i]);
		
		diffs = DateDiff('M', curDate, lateDate);
		
		if(diffs>0)
		{
			document.getElementById('hdLastDate').value = arrEarlyFinish[i];
			lateDate = new Date(document.getElementById('hdLastDate').value);
		}
	}
	RefreshTable();
}
function GenerateDatesHeader()
{
	if(document.getElementById('hdLastDate').value=='')
		return '';
	var header = '';
	var firstDate = new Date(document.getElementById('hdFirstDate').value);
	var lateDate = new Date(document.getElementById('hdLastDate').value);
	
	var counter = DateDiff('M', lateDate, firstDate);
	
	var lastMonth = '';
	var lastYear = '';
	
	header='<td>';
	var tablewidth = counter * width;
	
	if(counter>0)
		totalWidth = tablewidth;
	header+='<table width=' + tablewidth + ' height=100% cellspacing=0 cellpadding=0 border=1' +
		//'border=1 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid"' +
		'>';
	header+='<tr>' + GetDaysCountFromYear(firstDate, lateDate) + '</tr>';
	header+='<tr>' + GetDaysCountFromMonth(firstDate, lateDate) + '</tr>';
	header+='</table>'
	header+='</td>';
	return header;
}
function GetDaysCountFromMonth(iFromDate, iToDate)
{
	var arrMonth = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 
		'August', 'September', 'October', 'November', 'December');
	//var arrMonth = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 
	//	'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
	var arrMonth = new Array('J', 'F', 'M', 'A', 'M', 'J', 'J', 
		'A', 'S', 'O', 'N', 'D');
	
	var counter = DateDiff('D', iToDate, iFromDate);
	
	var lastMonth = -1;
	
	var thisDate = new Date(iFromDate);
	var colspan = 0;
	var html = '';
	
	for(var i = 0; i<=counter; i++)
	{
		if(lastMonth!=thisDate.getMonth())
		{
			lastMonth=thisDate.getMonth();
			if(thisDate.getFullYear()==iToDate.getFullYear())
			{
				if(i==0)
				{
					colspan = GetDaysInMonth(thisDate.getDate(), thisDate.getMonth(), thisDate.getFullYear());
					html+='<td class="TableHeaderDays" width=' + width + 'px  colspan=' + colspan + ' align="center">' + 
					arrMonth[lastMonth] + '</td>';
				}
				else
				{
					if(lastMonth==iToDate.getMonth())
					{
						colspan = iToDate.getDate();
						html+='<td class="TableHeaderDays" width=' + width + 'px  colspan=' + colspan + ' align="center">' + 
							arrMonth[lastMonth] + '</td>';
					}
					else
					{
						colspan = GetDaysInMonth(1, thisDate.getMonth(), thisDate.getFullYear());
						html+='<td class="TableHeaderDays" width=' + width + 'px  colspan=' + colspan + ' align="center">' + 
							arrMonth[lastMonth] + '</td>';
					}
				}
			}
			else
			{
				colspan = GetDaysInMonth(1, thisDate.getMonth(), thisDate.getFullYear());
				html+='<td class="TableHeaderDays" width=' + width + 'px  colspan=' + colspan + ' align="center">' + 
					arrMonth[lastMonth] + '</td>';
			}
			
		}
		thisDate.setDate(thisDate.getDate() + 1);
	}
	return html;
}
function GetDaysCountFromYear(iFromDate, iToDate)
{
	var counter = DateDiff('D', iToDate, iFromDate);
	
	var lastYear = '';
	
	var thisDate = new Date(iFromDate);
	
	var html = '';
	var colspan = 0;
	
	for(var i = 0; i<=counter; i++)
	{
		if(lastYear!=thisDate.getFullYear())
		{
			lastYear=thisDate.getFullYear();
			if(lastYear!=iToDate.getFullYear())
			{
				colspan = DateDiff('D', new Date(thisDate.getFullYear(), 11, 31, 0, 0, 0), thisDate) + 1;
				html+='<td class="TableHeaderDays" colspan=' + colspan + ' align="center">' + lastYear + '</td>';
			}
			else
			{
				colspan = DateDiff('D', iToDate, thisDate) + 1;
				html+='<td class="TableHeaderDays" colspan=' + colspan + ' align="center">' + lastYear + '</td>';
			}
		}
		thisDate.setDate(thisDate.getDate() + 1);
	}
	
	return html;
}
function GenerateDates(iName, iFromDate, iToDate)
{
	var thisFromDate = new Date(iFromDate);
	var thisToDate = new Date(iToDate);
	
	thisFromDate.setDate(1);
	thisToDate.setDate(GetDaysInMonth(1, thisToDate.getMonth()+1, thisToDate.getFullYear()));
	
	var lateDate = new Date(document.getElementById('hdLastDate').value);
	var firstDate = new Date(document.getElementById('hdFirstDate').value);
	
	var tmpDate = new Date(firstDate);
	
	var counter = DateDiff('M', lateDate, firstDate);
	var tablewidth = counter * width;
	var indexcount = 0;
	header='<td><table cellspacing=0 width=' + tablewidth + 'px cellpadding=0 border=0><tr>';
	for(var i = 0; i<=counter; i++)
	{
		if(thisFromDate<=tmpDate && tmpDate<=thisToDate)
			header+='<td height=20px width=' + width + 'px class=TableDaysSeleted ' + 
				'title=\"' + iName + ' ' + iFromDate + ' ' + iToDate + '\" ' + 
				' style=\"CURSOR: HAND\"><img src=../Images/bar.jpg></td>';
		else
			header+='<td height=20px width=' + width + 'px class=TableDaysSeleted>&nbsp;</td>';
		tmpDate.setDate(tmpDate.getDate() + GetDaysInMonth(1, tmpDate.getMonth(), tmpDate.getFullYear()));
	}
	header+='</tr></table></td>';
	return header;	
}
function GetDaysInMonth(iLastDay, iMonth, iYear)
{
	var numMonths = 0;
	switch(iMonth)
	{
		case 0: case 2: case 4: case 6: case 7: case 9: case 11:
			numMonths = 31;
			break;
		case 3: case 5: case 8: case 10:
			numMonths = 30;
			break;
		case 1:
			if(iYear % 4 == 0)
				numMonths = 29;
			else
				numMonths = 28;
			break;
	}
	return numMonths - iLastDay + 1;
}
function DateDiff(iInterval, iDate1, iDate2)
{
	try
	{
		var Date1=new Date(iDate1);
		var Date2=new Date(iDate2);
		var difference = Date1 - Date2;
		switch(iInterval.toUpperCase())
		{
			case 'S':
				return Math.ceil(parseFloat(difference) / 1000);
				break;
			case 'MN':
				return Math.ceil(parseFloat(difference) / (60*1000));
				break;
			case 'H':
				return Math.ceil(parseFloat(difference) / (60*60*1000));
				break;
			case 'D':
				return Math.ceil(parseFloat(difference) / (24*60*60*1000));
				break;
			case 'M':
				return Math.floor(Math.floor(parseFloat(difference)) / (24*60*60*30*1000));
				break;
			case 'Y':
				return Math.floor(parseFloat(difference) / (24*60*60*30*12*1000));
				break;
		}
	}
	catch(e)
	{
		alert('DateDiff: ' + e.message);
	}
}
function trimObj(strText, sChar)
{
	try
	{
		//This will get rid of the leading spaces
		while (strText.substring(0,sChar.length)==sChar)
			strText = strText.substring(sChar.length, strText.length);
		//This will get rid of the trailing spaces
		while (strText.substring(strText.length-sChar.length,strText.length) == sChar)
			strText = strText.substring(0, strText.length-sChar.length);
						                
		return strText;
	}
	catch(e)
	{
		alert(e.message);
	}
}
function ReplaceString(iValue, iChar, iCharToReplace)
{
	while(iValue.indexOf(iChar) > -1)
	{
		iValue = iValue.replace(iChar, iCharToReplace);
	}
	return iValue;
}