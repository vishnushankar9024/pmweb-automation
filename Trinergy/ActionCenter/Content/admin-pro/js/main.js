(function ($) {
    "use strict";
    //css menu

    $("#menu_program").hide();
    $("#menu_pm").hide();
    $("#menu_pgm").hide();
    InitCssMenu();

    $(".nav-asset .nav-link").click(function () {
        $(".nav-asset li").removeClass("active");
        $(this).closest("li").addClass("active");
    });

    $(".nav-dashboard .nav-link").click(function () {
        $(".nav-dashboard li").removeClass("active");
        $(this).closest("li").addClass("active");

        var data_tab = $(this).attr("data-tab");
        var data_url = $(this).attr("data-url");

        if (data_tab && typeof (data_tab) != "undefined") {
            $.ajax({
                url: data_url,
                dataType: "html",
                ContentType: "application/json;charset=utf-8",
                type: "POST",
                data: { tabKey: data_tab },
                cache: false,
                async: true,
                beforeSend: function () {
                    $('#content_view').html('');
                    $('#pleaseWaitDialog').modal('show');
                },
                complete: function () {
                    $('#pleaseWaitDialog').modal('hide');
                },
                success: function (data) {
                    $('#content_view').html(data);
                    GetViewInit();
                },
                failure: function (response) {
                    alert("Get Failed");
                },
            });
        }
    });
    $(".nav-dashboard .nav-link:eq(0)").click();

    $("#btnClearAll").click(function () {

        $("#cssmenu li").removeClass("active");
        $('.projectLinks').removeClass("selectedProject");

        $("#txtSearchMenu").val('');
        SearchMenu($("#GroupBy").val());

        $("#pleaseWaitDialog").show();
        iframe = $("#" + globalParams.frameId);
        var parent = iframe.parent();
        var iframe_Id = iframe.attr('id');
        var iframe_height = iframe.height();
        var url = globalParams.dashBoardReport + "?tabKey=" + globalParams.target + "&pid=" + globalParams.GetProjectIds() + "&width=" + $(document).width() + "&_=" + Math.random();
        iframe.remove();
        $('<iframe>', {
            src: url,
            id: iframe_Id,
            frameborder: 0,
            scrolling: true,
            css: {
                width: '100%',
                height: iframe_height,
            }
        }).load(function () {
            $("#pleaseWaitDialog").hide();
        }).appendTo(parent);
    });
    $("#btnSearchMenu").click(function (e) {
        SearchMenu($("#GroupBy").val());
        e.preventDefault();
    });
    $('#txtSearchMenu').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            SearchMenu($("#GroupBy").val());
        }

    });
})(jQuery);

var globalParams = {
    target: '',
    frameId: '',
    dashBoardReport: '',
    GetProjectIds: function () {
        var pids = $(".selectedProject").attr("data-pid");
        if (typeof (pids) == 'undefined') {
            pids = '';
            $(".projectLinks").each(function () {
                pids = pids + "," + $(this).attr("data-pid");
            });
        }
        //pids = '0,' + pids;
        return pids;
    }
};
function SearchMenu(groupBy) {
    console.log(groupBy);
    var data_url = $("#btnSearchMenu").attr("href");
    var searchString = $("#txtSearchMenu").val();
    $('#cssmenu').html('');
    $.ajax({
        url: data_url,
        dataType: "html",
        ContentType: "application/json;charset=utf-8",
        type: "GET",
        data: { searchString: searchString, menuColumn: groupBy },
        cache: false,
        async: true,
        success: function (data) {
            $('#cssmenu').html(data);
            InitCssMenu();
        },
        failure: function (response) {
            alert("Get Failed");
        },
    });
}
function InitCssMenu() {
    //$("#cssmenu > ul > li ul").each(function (index, element) {
    //    var count = $(element).find("li").length;
    //    var content = "<span class='cnt'>" + count + "</span>";
    //    $(element).closest("li").children("a").append(content);
    //});

    //$("#cssmenu ul ul li:odd").addClass("odd");
    //$("#cssmenu ul ul li:even").addClass("even");
    $("#cssmenu > ul > li > a").click(function () {
        var checkElement = $(this).next();

        $("#cssmenu li").removeClass("active");
        $(this).closest("li").addClass("active");

        if (checkElement.is("ul") && checkElement.is(":visible")) {
            $(this).closest("li").removeClass("active");
            checkElement.slideUp("normal");
        }
        if (checkElement.is("ul") && !checkElement.is(":visible")) {
            $("#cssmenu ul ul:visible").slideUp("normal");
            checkElement.slideDown("normal");
        }
        $("#cssmenu > ul > li > a > ul").hide()
        if ($(this).closest("li").find("ul").children().length == 0) {
            return true;
        } else {
            return false;
        }
    });

    $("#cssmenu > ul > li > ul > li > a").click(function () {

        var checkElement = $(this).next();

        $("#cssmenu li li").removeClass("active");
        $(this).closest("li").addClass("active");

        var ul = $(this).closest('ul').find('ul');
        ul.each(function () {
            $(this).closest("li").removeClass("active");
            $(this).slideUp("normal");
        });

        if (checkElement.is("ul") && checkElement.is(":visible")) {
            $(this).closest("li").removeClass("active");
            checkElement.slideUp("normal");
        }
        if (checkElement.is("ul") && !checkElement.is(":visible")) {
            $(this).closest("li").addClass("active");
            $("#cssmenu ul ul ul:visible").slideUp("normal");
            checkElement.slideDown("normal");
        }

        if ($(this).closest("li").find("ul").children().length == 0) {
            return true;
        } else {
            return false;
        }
    });

    $("#cssmenu > ul > li > ul > li > ul > li > a").click(function () {
        var checkElement = $(this).next();

        $("#cssmenu li li li").removeClass("active");
        $(this).closest("li").addClass("active");

        if (checkElement.is("ul") && checkElement.is(":visible")) {
            $(this).closest("li").removeClass("active");
            checkElement.slideUp("normal");
        }
        if (checkElement.is("ul") && !checkElement.is(":visible")) {
            $("#cssmenu ul ul ul ul:visible").slideUp("normal");
            checkElement.slideDown("normal");
        }

        if ($(this).closest("li").find("ul").children().length == 0) {
            return true;
        } else {
            return false;
        }
    });
    $('.dashboard').click(function () {
        $("#cssmenu  ul > li > ul > li").removeClass("active");
        $(this).closest("li").addClass("active");

        $('.projectLinks').removeClass("selectedProject");
        $(this).addClass("selectedProject");

        $("#pleaseWaitDialog").show();
        debugger;
        iframe = $("#" + globalParams.frameId);
        var parent = iframe.parent();
        var iframe_Id = iframe.attr('id');
        var iframe_height = iframe.height();
        var url = globalParams.dashBoardReport + "?tabKey=" + globalParams.target + "&pid=" + globalParams.GetProjectIds() + "&width=" + $(document).width() + "&_=" + Math.random();
        iframe.remove();
        $('<iframe>', {
            src: url,
            id: iframe_Id,
            frameborder: 0,
            scrolling: true,
            css: {
                width: '100%',
                height: iframe_height,
            }
        }).load(function () {
            debugger;
            $("#pleaseWaitDialog").hide();
        }).appendTo(parent);
    });

    setTimeout(function () {
        var dropdownlist = $("#GroupBy").data("kendoDropDownList");
        ChangeMenu(dropdownlist.selectedIndex + 1);
    }, 10);

    //if ($("#myonoffswitch").is(":checked") == false) {
    //    $("#menu_properties").hide();
    //    $("#menu_program").show();
    //}
    //else {
    //    $("#menu_program").hide();
    //    $("#menu_properties").show();
    //}

    //$("#myonoffswitch").change(function () {
    //    if ($(this).is(":checked") == false) {
    //        $("#menu_properties").hide();
    //        $("#menu_program").show();
    //    }
    //    else {
    //        $("#menu_program").hide();
    //        $("#menu_properties").show();
    //    }
    //});
}
function OnGroupChange(e) {
    //ChangeMenu(parseInt(e.dataItem.Value));
    SearchMenu(e.dataItem.ColumnName);
}

function ChangeMenu(menuType) {
    switch (menuType) {
        case 1:
            $("#menu_program").show();
            break;
        case 2:
            $("#menu_properties").show();
            break;
        case 3:
            $("#menu_pm").show();
            break;
        case 4:
            $("#menu_pgm").show();
            break;
    }
}
