
$(document).ready(function () {
    //var s = document.createElement("script");
    //s.type = "text/javascript";
    ////s.src = "../Content/HMC_OCS.js";
    //s.src = "Custom/JS/HMC_OCS.js";

    //$("head").append(s);

    InitHMCJs();
    SetIFrameHeight();
    var queryString = [];
    var url = location.href;
    if (url.indexOf('?') > 0) {
        url = url.split('?');
        url = url[1].split('&');

        for (i = 0; i < url.length; i++) {
            var sp = url[i].split('=');
            queryString[sp[0]] = sp[1];
        }
        if (queryString["TypeId"]) {
            global.TypeId = queryString["TypeId"];
        }
    }
    var customForm = $('#ctl00_CPH1_ddlCustomForms_Input').val();
    if (customForm != 'Select Custom Form ...' && customForm != '' && typeof (customForm) != 'undefined') {
        if (customForm.indexOf('-') > 0) {
            customForm = customForm.split("-");
            global.CustomFormId = customForm[0];
        }
    }

    //if (queryString["notab"] && queryString["notab"] == "1") {
    //    $("#tblHeader").css({
    //        'position': 'absolute',
    //        'left': '-1000px'
    //    });
    //    $("#ctl00_imgLogo").unbind('click');
    //    $("#ctl00_imgLogo").attr("onclick", "");
    //    $("#ctl00_imgLogo").click(function (e) {
    //        e.preventDefault();
    //    });
    //    $("#HeaderPane td:not(#PMLogo)").each(function () {
    //        $(this).hide();
    //    });

    //    //$(".WhiteDarkBlueBack ").hide();
    //    $("#ctl00_tdMenu1").hide();
    //    setTimeout(function () {
    //        //$("#HeaderPane").hide();
    //        divContentHolder.css({
    //            'position': 'relative',
    //            'top': '0px'
    //        });
    //    }, 2500);
    //}
    if (window.self !== window.top) {
        $("#tblHeader").css({ 'opacity': '0' });
        $("#tblHeader").css({
            'position': 'absolute',
            'left': '-1000px'
        });
        $('body').animate({ 'marginTop': '-40px' }, 1000);
        $("#ctl00_imgLogo").unbind('click');
        $("#ctl00_imgLogo").attr("onclick", "");
        $("#ctl00_imgLogo").click(function (e) {
            e.preventDefault();
        });
        $("#HeaderPane td:not(#PMLogo)").each(function () {
            $(this).hide();
        });
        var divContentHolder = $('#divContentHolder');
        divContentHolder.css({
            'position': 'relative',
            'top': '-50px'
        });
        $('#FooterPane').hide();
        //$(".WhiteDarkBlueBack").hide();
        $("#ctl00_tdMenu1").hide();
        setTimeout(function () {
            //$("#HeaderPane").hide();
            divContentHolder.css({
                'position': 'relative',
                'top': '0px'
            });
        }, 100);

        if ($('#ctl00_CPH1_ddlCustomForms_Input').length > 0) {
            var div = $('#ctl00_CPH1_ddlCustomForms_Input').closest('div');
            div.css({ 'width': '600px' });
            var divTd = div.closest('td');
            divTd.css({ 'width': '630px !important' });
            //$('#ctl00_CPH1_ddlCustomForms_Input').attr('enabled', false);
        }
        $("[id$=rdbReturn]").click(function () {
            HMCSetRadWindowConfig();
        });
        $("[id$=lbtTeamInput]").click(function () {
            HMCSetRadWindowConfig();
        });
        $("[id$=rdbDelegate]").click(function () {
            HMCSetRadWindowConfig();
        });
    }
    Risk.Init(queryString);
    CustomForm();


    // For Revisions

    if (typeof ($("#btnRevision").val()) != 'undefined') {
        var customFormId = $('#ctl00_CPH1_ddlCustomForms_Input').val();
        if ((global.CustomFormId == "" || typeof (global.CustomFormId) == 'undefined') && (customFormId == 'Select Custom Form ...' || customFormId == '' || typeof (customFormId) == 'undefined')) {
            $("#btnRevision").prop('disabled', true);
            $("#ctl00_CPH1_CustomFormDetails1_10").val('0');
        }
        else {
            var submitterComments = "ctl00_CPH1_CustomFormDetails1_";
            var consultantComments = "ctl00_CPH1_CustomFormDetails1_";
            var hmcComments = "ctl00_CPH1_CustomFormDetails1_";
            $.ajax({
                url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/GetStepNumber/?customformId=' + global.CustomFormId,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                success: function (data) {
                    if (data != 0) {
                        $('#btnRevision').hide();
                    }
                },
                error: function (xhr) { }
            });
            $("#btnRevision").click(function () {
                Custom.Render();
                Custom.Confirm('Are you sure you want to create revision?', ClickRevisionHandler, '');
            });
        }
    }
    if (typeof ($("#btnRevisionNCR").val()) != 'undefined') {
        var customFormId = $('#ctl00_CPH1_ddlCustomForms_Input').val();
        if ((global.CustomFormId == "" || typeof (global.CustomFormId) == 'undefined') && customFormId == 'Select Custom Form ...' || customFormId == '' || typeof (customFormId) == 'undefined') {
            $("#btnRevisionNCR").prop('disabled', true);
            $("#ctl00_CPH1_CustomFormDetails1_10").val('0');
        }
        else {
            $.ajax({
                url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/GetStepNumber/?customformId=' + global.CustomFormId,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                success: function (data) {
                    if (data != 1) {
                        $('#btnRevisionNCR').hide();
                    }
                },
                error: function (xhr) { }
            });
            $("#btnRevisionNCR").click(function () {
                Custom.Render();
                Custom.Confirm('Are you sure you want to create revision?', ClickRevisionHandler, '');
            });
        }
    }
});
function CreateBISessionSubmit() {
    //var customForm = $('#ctl00_CPH1_ddlCustomForms_Input').val();
    //if (customForm != 'Select Custom Form ...' && customForm != '' && typeof (customForm) != 'undefined') {
    //    if (customForm.indexOf('-') > 0) {
    //        customForm = customForm.split("-");
    //        global.CustomFormId = customForm[0];
    //    }
    //}
    //
    //var url = 'https://pmweb.hamad.qa/PMWebhelper/HMC/SetBISession/?customformId=' + global.CustomFormId + '&wfaction=submit';
    //$.ajax({
    //    url: url,
    //    dataType: "html",
    //    type: "GET",
    //    contentType: 'application/json;charset=utf-8',
    //    async: false,
    //    cache: false,
    //    success: function (data) {
    //        return true;
    //    },
    //    error: function (xhr) {
    //        return true;
    //    }
    //});
}
function CreateBISessionWorkflowSave() {
    var teamInputAction = TeamInputConfirmAction();
    //if (teamInputAction != false) {
    //    var customForm = $('#ctl00_CPH1_ddlCustomForms_Input').val();
    //    if (customForm != 'Select Custom Form ...' && customForm != '' && typeof (customForm) != 'undefined') {
    //        if (customForm.indexOf('-') > 0) {
    //            customForm = customForm.split("-");
    //            global.CustomFormId = customForm[0];
    //        }
    //    }
    //    
    //    var vl = $('input[type="radio"][name="ctl00$CPH1$WorkflowDocument1$Approve"]:checked').val();
    //    var url = 'https://pmweb.hamad.qa/PMWebhelper/HMC/SetBISession/?customformId=' + global.CustomFormId + '&wfaction=' + vl;
    //    $.ajax({
    //        url: url,
    //        dataType: "html",
    //        type: "GET",
    //        contentType: 'application/json;charset=utf-8',
    //        async: false,
    //        cache: false,
    //        success: function (data) {
    //            return true;
    //        },
    //        error: function (xhr) {
    //            return true;
    //        }
    //    });
    //}
    return teamInputAction;
}
function CreateBIReport() {
    //var customForm = $('#ctl00_CPH1_ddlCustomForms_Input').val();
    //if (customForm != 'Select Custom Form ...' && customForm != '' && typeof (customForm) != 'undefined') {
    //    if (customForm.indexOf('-') > 0) {
    //        customForm = customForm.split("-");
    //        global.CustomFormId = customForm[0];
    //    }
    //}
    //var url = 'https://pmweb.hamad.qa/PMWebhelper/HMC/CustomformFinalApproval/?userId=' + global.User.Id;
    //$.ajax({
    //    url: url,
    //    dataType: "html",
    //    type: "GET",
    //    contentType: 'application/json;charset=utf-8',
    //    async: false,
    //    cache: false,
    //    success: function (data) {
    //    },
    //    error: function (xhr) {
    //    }
    //});
}
function AttachBiForAll() {
    var url = 'https://pmweb.hamad.qa/pmwebhelper/hmc/AttachAllBi';
    $.ajax({
        url: url,
        dataType: "html",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        async: true,
        cache: false,
        success: function (data) {
        },
        error: function (xhr) {
        }
    });
}
function CreateBIWorkflowSave() {
    var teamInputAction = TeamInputConfirmAction();
    //if (teamInputAction != false) {
    //    var customForm = $('#ctl00_CPH1_ddlCustomForms_Input').val();
    //    if (customForm != 'Select Custom Form ...' && customForm != '' && typeof (customForm) != 'undefined') {
    //        if (customForm.indexOf('-') > 0) {
    //            customForm = customForm.split("-");
    //            global.CustomFormId = customForm[0];
    //        }
    //    }
    //    var vl = $('input[type="radio"][name="ctl00$CPH1$WorkflowDocument1$Approve"]:checked').val();
    //    var url = 'https://pmweb.hamad.qa/PMWebhelper/HMC/CustomformFinalApproval/?customformId=' + global.CustomFormId + '&wfaction=' + vl + '&userId=' + global.User.Id;
    //    $.ajax({
    //        url: url,
    //        dataType: "html",
    //        type: "GET",
    //        contentType: 'application/json;charset=utf-8',
    //        async: true,
    //        cache: false,
    //        success: function (data) { },
    //        error: function (xhr) { }
    //    });
    //}
    return teamInputAction;
}
function CustomForm() {
    //WIR
    $("#ctl00_CPH1_CustomFormDetails1_4", "#tbl_wir").attr("maxlength", "1250");
    //$("#ctl00_CPH1_CustomFormDetails1_5", "#tbl_wir").attr("maxlength", "750");//
    // Health Facilities Development – Quarterly Report//
    $("#ctl00_CPH1_CustomFormDetails1_1", "#tbl_HFDQR").attr("maxlength", "2000");
    $("#ctl00_CPH1_CustomFormDetails1_2", "#tbl_HFDQR").attr("maxlength", "2000");
    $("#ctl00_CPH1_CustomFormDetails1_3", "#tbl_HFDQR").attr("maxlength", "1000");
    $("#ctl00_CPH1_CustomFormDetails1_4", "#tbl_HFDQR").attr("maxlength", "1000");
    $("#ctl00_CPH1_CustomFormDetails1_5", "#tbl_HFDQR").attr("maxlength", "1600");
    $("#ctl00_CPH1_CustomFormDetails1_6", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_7", "#tbl_HFDQR").attr("maxlength", "700");
    $("#ctl00_CPH1_CustomFormDetails1_8", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_9", "#tbl_HFDQR").attr("maxlength", "2000");
    $("#ctl00_CPH1_CustomFormDetails1_10", "#tbl_HFDQR").attr("maxlength", "2000");
    $("#ctl00_CPH1_CustomFormDetails1_11", "#tbl_HFDQR").attr("maxlength", "1000");
    $("#ctl00_CPH1_CustomFormDetails1_12", "#tbl_HFDQR").attr("maxlength", "1000");
    $("#ctl00_CPH1_CustomFormDetails1_13", "#tbl_HFDQR").attr("maxlength", "1600");
    $("#ctl00_CPH1_CustomFormDetails1_14", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_15", "#tbl_HFDQR").attr("maxlength", "700");
    $("#ctl00_CPH1_CustomFormDetails1_16", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_17", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_18", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_19", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_20", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_21", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_22", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_23", "#tbl_HFDQR").attr("maxlength", "500");
    $("#ctl00_CPH1_CustomFormDetails1_24", "#tbl_HFDQR").attr("maxlength", "500");

    $("#ctl00_CPH1_CustomFormDetails1_ddlPHCategory", "#tbl_riskmanagement").css({ "width": "300px" });
}

function ClickRevisionHandler() {
    var rev = $("#ctl00_CPH1_CustomFormDetails1_10").val();
    if (Number.isNaN(parseInt(rev)) || rev == '') {
        rev = 0;
    }
    $.ajax({
        url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/CustomformReVersion/?customformId=' + global.CustomFormId + '&rev=' + rev,
        dataType: "html",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        async: true,
        cache: false,
        success: function (data) {
            var rev = $("#ctl00_CPH1_CustomFormDetails1_10").val();
            if (Number.isNaN(parseInt(rev)) || rev == '') {
                rev = 0;
            }
            rev = parseInt(rev) + 1;
            $("#ctl00_CPH1_CustomFormDetails1_10").val(rev);
            $("#btnRevision").prop('disabled', true);

            alert('Please click the save icon to save the record');
            var queryStr = "";
            var urlC = location.href;
            if (urlC.toLowerCase().indexOf("id=") > 0) {
                var urlBase = urlC;
                if (urlC.indexOf('?') > 0) {
                    urlC = urlC.split('?');
                    urlBase = urlC[0];
                    urlC = urlC[1].split('&');

                    for (i = 0; i < urlC.length; i++) {
                        var sp = urlC[i].split('=');
                        queryStr[sp[0]] = sp[1];
                        var val = sp[1];
                        if (sp[0].toLowerCase() == 'id') {
                            val = global.CustomFormId;
                        }
                        if (queryStr == "") {
                            queryStr = sp[0] + '=' + val;
                        }
                        else {
                            queryStr = queryStr + '&' + sp[0] + '=' + val;
                        }
                    }
                }
                location.href = (urlBase + "?" + queryStr);
            }
            else {
                location.href = location.href;
            }
        },
        error: function (xhr) { }
    });
}
var Risk = {
    CategoryDefinition: {
        'E01 - Capital Availability - External': 'Mismanaging access to capital or capital being pulled during design stage may create funding uncertainty and threaten upcoming payments to project stakeholders.',
        'E02 - Commodity - External': 'Fluctuation in commodity prices may expose the project to delays in the delivery.',
        'E03 - Competition - External': 'A key competitor may launch a competing product or service and invalidate the project; key staff may be poached by competitors; key competitor may withdraw from the market.',
        'E04 - Customer Needs - External': 'Failure to understand and fulfill customer’s current and foreseeable needs as well as anticipate short and long term changes.',
        'E05 - Economic/Financial - External': 'Unpredicted economic slowdown and economic crisis may impact sustainability of project. Economic boom leading to shortage of labour, materials and/or increased cost of raw materials, increased tender prices due to SS/DD of contractors.',
        'E06 - Environmental - External': 'Unexpected environmental conditions may affect progress and cost, positively or negatively.',
        'E07 - External Interfaces - External': 'External parties may positively or negatively influence the progress of the project (i.e. adjacent project, public works infrastructure, Utilities etc.)',
        'E08 - Foreign Exchange - External': 'Volatility in foreign exchange rates may expose the project to delays in delivery.',
        'E09 - Legal/Regulatory - External': 'Change in legislation may impose changes in the solution; legal requirements may add unforeseen design and construction requirements/constraints; significant regular changes may occur during the project.',
        'E10 - Media - External': 'Failure to manage international and local media (i.e. press, internet, etc.) in an effective, pro-active and transparent way to convey the right message which in turn may precipitate a crisis. It is created when expectations are poorly managed, or when a company simply fails to execute.',
        'E11 - Natural Hazards/Catastrophic - External': 'Inability to plan for and recover from a major disaster (E.g. earthquake, flood, landslide and wind) interrupts the day-to-day operations/implementation phase',
        'E12 - Pressure Group - External': 'Lobby groups may influence/promote the cause of the project.',
        'E13 - Permits/Licenses - External': 'Delays in obtaining permits & licenses may lead to variances in the proposed project schedule.',
        'E14 - Regional Unrest - External': 'Rising civil unrest in the region may affect key stakeholders decision-making process.',
        'E15 - Site/Facilities - External': 'Site access may prove more difficult than expected; required facilities may not be available on site.',
        'E16 - Social/Demographic - External': 'Changing social imperatives may impose additional requirements; public perception of the project may change positively or negatively.',
        'E17 - Sovereign/ Political - External': 'Political factors may influence senior management support for the project; a change in government may result in changed priorities or legislation positively or negatively.',
        'E18 - Technological Innovation - External': 'Inability to implement technological advances in the organization’s portfolio of projects in order to remain competitive and attain superior quality, cost and time performance in project delivery.',
        'E19 - Utilities - External': 'Late provision of common utilities and telecommunication affects project delivery.',
        'E20 - Weather - External': 'Weather may be unreasonable, better or worse than expected.',
        'E21 - Widespread Diseases - External': 'Diseases and pandemics may adversely impact the workforce and supply chain.',
        'P01 - Change Response - Internal': 'The project team’s inability or desire to react in a timely fashion to change requests that affects the project ability to deliver on time within the budget.',
        'P02 - Compliance - Internal': 'Failure to act in accordance with local rules, regulations (in particular Qatar Construction Specifications), international standards, professional code of conduct, policies & procedures, resulting in a negative effect on the project and the organization.',
        'P03 - Customer Satisfaction - Internal': 'Lack of focus on the economic buyer threatens the project’s capacity to meet or exceed customer’s expectations.',
        'P04 - Health, Safety and Environment (HSE) - Internal': 'May impose additional cost; design not Construction Design Management (CDM) compliant, changes in safety regulations (including CDM regulations) may require significant redesign; safety test failures may lead to major fines; an accident or incident may occur delaying the project',
        'P05 - Information - Internal': 'Client may fail to provide required information on time; client-supplied information may be inadequate to support project.',
        'P06 - Integrated Management Systems - Internal': 'Inability to effectively integrate all the project processes that are required to accomplish project objectives within an organization’s defined procedures.',
        'P07 - Measurement - Internal': 'Use of distorted or irrelevant KPIs impact the project’s decision-making and governance processes.',
        'P08 - Organization - Internal': 'Reorganization may impact project organization negatively or positively; change in corporate structure may affect project negatively or positively.',
        'P09 - Project Communication - Internal': 'Client requirements may be misunderstood; project reporting needs are unclear or may change during project; key stakeholder interests may change positively or negatively; communication breakdown with project team. Ineffective internal communication lead to conflicting messages, poor knowledge management, unclear sense of direction within the organization',
        'P10 - Project Definition - Internal': 'Poorly defined or understood purpose, needs, objectives, costs, timelines, and deliverables. Redundant scope may be discovered.',
        'P11 - Project Governance - Internal': 'Unclear project governance arrangements, roles & responsibilities, authority and accountability.',
        'P12 - Program management - Internal': 'Project may be given inappropriate priority within the program, other projects may divert key resources or may be cancelled and release resources.',
        'P13 - Project Performance - Internal': 'Inability to perform effectively in terms of planning, cost, time and quality of deliverables and implementing efficient project controls; estimating and/or scheduling errors; project systems and processes may not be adequate to support project requirements. Inappropriately aggressive schedules, poor estimation of activity duration and resources and inadequate analysis may lead to schedule slippage. Final solution may not meet performance requirements; some performance requirements may be mutually exclusive.',
        'P14 - Project reporting - Internal': 'Submission of inaccurate and inconsistent reporting data and information internally and externally.',
        'P15 - Quality - Internal': 'Effective quality management may reduce rework; number of defects found may not match expectations.',
        'P16 - Quality Control / Assurance - Internal': 'Inability to monitor and review services provided to ensure it meets project, legal, regulatory incl. Qatar Construction Specifications (QCS) and customer requirements.',
        'P17 - Resource Management - Internal': 'Inappropriate management of internal resources and inefficient balancing resource requirements across multiple projects; key resources may be unavailable when required; specific skills may not be available when required.',
        'P18 - Risk Return - Internal': 'Failure to optimize the return on the amount, time and effort invested in the project on a risk adjusted basis.',
        'P19 - Scope Creep - Internal': 'Inability to promptly identify work falling outside original requirements in order to develop different options to address the situation.',
        'P20 - Social Responsibility - Internal': 'Inability to recognize the hidden costs of choosing projects that are or perceived to be socially irresponsible.',
        'P21 - Stakeholder Relations - Internal': 'Inability to maintain stakeholder confidence in the project management and execution in meeting project objectives; inability to effectively manage key customer and contractor relationships.',
        'T01 - Business Interruption - Internal': 'Unexpected shocks (e.g. land, capital, labor, technology) threaten to cause partial or complete cessation of the day to day operations.',
        'T02 - Commissioning - Internal': 'Failure in organizing and planning pre-commissioning, commissioning and start-up activities by system/sub-system levels, as per an approved and optimized and agreed upon start-up sequence',
        'T03 - Constructability - Internal': 'Inadequate process for transition from design to construction, inability to construct the design technically and safely.',
        'T04 - Design Intent - Internal': 'It may prove difficult to meet some requirements within design limitations, Reuse of existing design elements may be impossible.',
        'T05 - Estimates / Assumptions / Constraints - Internal': 'Basis of estimating may be wrong; planning assumptions may be invalidated during project. Imposed constraints may be relieved or removed.',
        'T06 - Inadequate or Incomplete Design - Internal': 'Mistake in design may lead to major inconsistencies during project delivery; project design does not comply with local laws, Qatar Construction Specifications in particular the Construction Design Management (CDM) regulations.',
        'T07 - IT / Date - Internal': 'Unavailability and/or vulnerability of relevant systems or incomplete/inaccurate data and information may impair the ability to conduct day to day operations.',
        'T08 - Material - Internal': 'Unavailability of raw material, goods in process or finished products at the required time and/or of desired quality/standard; purchase of wrong materials affecting the achievement of the project’s objectives.',
        'T09 - Reliability - Internal': 'Target reliability criteria may be unattainable with chosen solution; the effective use of technology may improve reliability; maintainability requirements may impose unacceptable design constraints.',
        'T10 - Scope Changes - Internal': 'Poor initial scope definition, insufficient or not clear requirements and/ or requirements understood differently by key stakeholders may lead to scope changes exposing the project to cost overruns and schedule delays. Client may introduce significant changes including budget reduction during project, negative or positive, internal inconsistencies may exist within requirements, key requirements may be missing from formal requirements specs. Scope changes may arise during project.',
        'T11 - Security - Internal': 'Security implications may be overlooked during design, redesign; government regulations and requirements may change during the project.',
        'T12 - Technical Interfaces - Internal': 'Unexpected interactions may occur at key interfaces; data inconsistencies across interfaces may require rework; key interfaces may be reduced.',
        'T13 - Technical Processes - Internal': 'Standard processes may not meet requirements of specific solution; new processes may be required; processes may be improved and made more effective.',
        'T14 - Technology Changes - Internal': 'New technology may be developed during project lifetime; new, unproven technology; technology changes may invalidate design.',
        'T15 - Test and Acceptance - Internal': 'Test protocols may reveal significant design error requiring rework; client may withhold final acceptance for reasons outside contracts.',
        'C01 - Claim Management - Internal': 'Inability to prevent project claims from arising and for the expeditious handling of claims when they occur.',
        'C02 - Claim Processing - Internal': 'Failure to effectively monitor, manages, and settles project claims, resulting in a negative impact on financial performance.',
        'C03 - Contract Strategy - Internal': 'The choice of an inefficient contract strategy can lead to delays and over budget project delivery',
        'C04 - Contract Management - Internal': 'Failure to have sufficiently skilled and experience resources to effectively manage the contract; failure to act on contractor underperformance.',
        'C05 - Contractual Commitment - Internal': 'Client standard terms may prove unacceptably onerous; contractual terms may contain internal inconsistencies; harmonized client/contractor terms may reduce exposure.',
        'C06 - Contract Variations - Internal': 'Contract changes not dealt with as contract variations; contractor not prepared to agree to contract variations; change in circumstances not managed in a timely manner.',
        'C07 - Costing Information - Internal': 'Inaccurate costing information resulting in inappropriate conclusions and decisions.',
        'C08 - Financial Management - Internal': 'Failure to acquire and manage the financial resources for the project.',
        'C09 - Planning - Internal': 'Lack of a comprehensive and accurate planning process jeopardizes the project’s ability to achieve its set objectives.',
        'C10 - Procurement Process - Internal': 'Poor or incomplete design and gaps in tender documents may lead to major changes in the contractor’s procurement process exposing the project to cost overruns and schedule delays; inadequate definition of outsourced work may lead to project inefficiencies.',
        'C11 - Stakeholder Management - Internal': 'Stakeholders not consulted and/or kept informed about contract performance; change in stakeholder requirements not communicated.',
        'C12 - Suppliers and Contractors - Internal': 'Key sub-contractors may go out of business; non-alignment of sub-contractors staff with overall project objectives; key sub-contractors may refuse to work together; failure to provide contract deliverables on time, to agreed quality standards; failure to adhere to agreed budget; failure to comply with all contract provisions e.g. privacy, security, recordkeeping. Contractor’s strategies and objectives not aligned with client objectives creating conflict; consultant or contractor delays.',
        'O01 - Accountability - Internal': 'Failure to ensure that the responsibility and ownership for management of projects, processes and objectives is understood and carried through to completion.',
        'O02 - Capacity - Internal': 'Insufficient capacity threatens the project and the organization’s ability to meet customer’s demand or excess capacity threatens the project and the organization’s ability to generate competitive profit margins.',
        'O03 - Completeness / Accuracy - Internal': 'Incorrect information relating to clients, project objectives, products & services, causes the project and the organization to fail to comply with regulations, to make relevant decisions, and to meet the needs and expectations of its clients',
        'O04 - Empowerment - Internal': 'Not providing employees with the knowledge and authority to make appropriate decisions.',
        'O05 - Hiring / Retention - Internal': 'Inability to attract and retain qualified personnel with the necessary experience, knowledge and skill set required in order achieving project and business objectives.',
        'O06 - Image / Brand - Internal': 'An event or incident that adversely impacts the image or damages the brand of the project and the organization, including mismanagement of the said event or incident and poor media communications regarding the event or the incident.',
        'O07 - Intellectual Property - Internal': 'Failure to protect intellectual capital developed within HFD and ensures that such capital is not released to third parties without prior authorization.',
        'O08 - Knowledge Transfer - Internal': 'Failure to maintain effective processes for capturing and institutionalizing learning across projects and the organization, resulting in slow response time, duplication, high costs, repeated mistakes or inconsistent skill sets.',
        'O09 - Leadership / Management Style - Internal': 'Inability of management to properly and credibly lead and instruct employees, resulting in lack of direction, focus, motivation to perform and trust',
        'O10 - Loss of Key people - Internal': 'loss of key employees by death, illness, injury, leaving through dissatisfaction, poached by alternative employers may lead to demotivation and disengagement of project’s teams and the organization as a whole',
        'O11 - Out Sourcing / Sub-Contracting - Internal': 'Mismanaged relationships with third parties may lead to inconsistencies in the provision of services and the inability to meet customer expectations.',
        'O12 - Productivity - Internal': 'Sub-standard productivity may jeopardize the expected improvements related to the project.',
        'O13 - Project Structure - Internal': 'Failure to accomplish project’s goals and objectives due to unclear or an ineffective project structure.',
        'O14 - Resources - Internal': 'Inability to avoid permanent staff loss; failure to get all the resources required to the project; important parts of the project scope were missed due to insufficient resources; and project budget could be limited to deliver the required project objectives.',
        'O15 - Skills / Competencies - Internal': 'The lack of or inability to properly allocate personnel with the appropriate skill sets may lead to gaps and limit the project and the organization capabilities.',
        'O16 - Social Responsibility - Internal': 'Inability to recognize the hidden costs of choosing projects that are or are perceived to be socially irresponsible.',
        'O17 - Succession Planning - Internal': 'Lack of a formal plan that identifies successors for key executive and operational/project positions across the organization.',
        'O18 - Sustainability - Internal': 'Failure to consider an adequate balance between economic, social and environmental factors in the project development process.',
        'O19 - Training / Development - Internal': 'Inadequate training content or deployment may lead to poor outputs and fail to deliver desired results.',
        'I01 - Conflict of Interest - Internal': 'Inability to avoid situations in which an employee or employees of an organization have a personal interest sufficient to, or to appear to influence the objective execution of a project and stakeholders’ interests.',
        'I02 - Employee Fraud - Internal': 'Failure to prevent fraudulent activities by employees (e.g. misappropriation of assets) that could expose the project and the organization to financial loss.',
        'I03 - Ethical Decision -Making - Internal': 'Inability of management to make appropriate and moral decisions resulting in non-compliance, decreased client and shareholder confidence, or a weakened competitive position.',
        'I04 - Illegal Acts - Internal': 'Illegal acts or fraudulent activities committed by employees expose the organization to criminal charges, penalties, and a loss of customers and profits.',
        'I05 - Management Fraud - Internal': 'Corporate deceit, such as the wilful filing of inaccurate financial reports, negatively impacts the organization’s reputation and decreases client and shareholder confidence.',
        'I06 - Span of Control - Internal': 'Inability to set and monitor employee levels of authority and associated behaviour',
        'I07 - Third Party Fraud - Internal': 'Fraudulent activities perpetrated by customers, suppliers, agents, contractors, or third-party administrators against the project and the organization (e.g. misappropriation of physical, financial or information assets) expose it to financial loss.',
        'I08 - Unauthorized Acts - Internal': 'Unauthorized use of the organization’s physical, financial, or information assets expose the project and the organization to an unnecessary waste of resources and financial losses.'
    },
    QueryString: [],
    Init: function (queryString) {
        Risk.QueryString = queryString;
        if ($("#tbl_riskmanagement").length > 0) {
            if (!Risk.QueryString["Id"]) {
                $('#btnRiskClose').hide();
            }
            if ($("#ctl00_CPH1_CustomFormDetails1_15_Input").length > 0) {
                if ($("#ctl00_CPH1_CustomFormDetails1_15_Input").val() == 'Closed') {
                    $('#btnRiskClose').hide();
                    $('.ToolbarSave ').hide();
                    $('.ToolbarDelete ').hide();
                }
                else {
                    $("#ctl00_CPH1_CustomFormDetails1_15_Input").val('In-progress');
                    $("#ctl00_CPH1_CustomFormDetails1_15_ClientState").val('{"logEntries":[],"value":"1","text":"In-progress","enabled":true,"checkedIndices":[],"checkedItemsTextOverflows":false}');
                }
            }
            Risk.Defination();
            $('#btnRiskClose').click(function () {
                Risk.RiskConfirm();
            });
        }
    },
    Defination: function () {
        if (Risk.CategoryDefinition[$("#ctl00_CPH1_CustomFormDetails1_ddlPHCategory_Input").val()]) {
            $("#divCategoryDefinition").html(Risk.CategoryDefinition[$("#ctl00_CPH1_CustomFormDetails1_ddlPHCategory_Input").val()]);
        }
        $("#ctl00_CPH1_CustomFormDetails1_ddlPHCategory_Input").change(function () {
            $("#divCategoryDefinition").html('');
            if (Risk.CategoryDefinition[$(this).val()]) {
                $("#divCategoryDefinition").html(Risk.CategoryDefinition[$(this).val()]);
            }
        });
    },
    RiskConfirm: function () {
        Custom.Render();
        Custom.Confirm('Please make sure you save your changes before clicking the "Close" button.<br />Click "Yes" if saved<br/>Click "No" to save the changes', function (Id) { Risk.RiskClose(Id) }, global.CustomFormId);
    },
    RiskClose: function (Id) {
        $.ajax({
            url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/RiskClose/?Id=' + Id,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            async: true,
            cache: false,
            success: function (data) {
                //alert(data);
                location.href = location.href;
            },
            error: function (xhr) { }
        });
    }
};
var Custom = {
    IsRendered: false,
    Confirm: function (dialog, call_back, args) {
        if (this.IsRendered == false) {
            this.Render();
        }
        var winW = window.innerWidth;
        var winH = window.innerHeight;
        var dialogoverlay = document.getElementById('dialogoverlay');
        var dialogbox = document.getElementById('dialogbox');
        dialogoverlay.style.display = "block";
        dialogoverlay.style.height = winH + "px";
        dialogbox.style.left = (winW / 2) - (550 * .5) + "px";
        dialogbox.style.top = "100px";
        dialogbox.style.display = "block";

        document.getElementById('dialogboxhead').innerHTML = "Action";
        document.getElementById('dialogboxbody').innerHTML = dialog;
        //document.getElementById('dialogboxfoot').innerHTML = '<button onclick="Custom.Yes(' + call_back + ', ' + args + ')">Yes</button> <button onclick="Custom.No()">No</button>';
        $('#dialogboxfoot').html('');
        $('<button />', {}).text('Yes')
            .click(function () {
                Custom.Yes(call_back, args);
            }).appendTo($('#dialogboxfoot'));

        $('<button />', {}).text('No')
           .click(function () {
               Custom.No()
           }).appendTo($('#dialogboxfoot'));
    },
    Render: function () {
        if (this.IsRendered == false) {
            var dialogoverlay = jQuery('<div/>', {
                id: 'dialogoverlay',
                css: {
                    "display": "none",
                    "opacity": ".8",
                    "position": "fixed",
                    "top": "0px",
                    "left": "0px",
                    "background": "#FFF",
                    "width": "100%",
                    "z-index": "10"
                }
            }).appendTo($('body'));
            var dialogbox = jQuery('<div/>', {
                id: 'dialogbox',
                css: {
                    "display": "none",
                    "position": "fixed",
                    "background": "#000",
                    "border-radius": "7px",
                    "width": "550px",
                    "z-index": "10"
                }
            }).appendTo($('body'));
            var div = jQuery('<div />', {
                css: {
                    "background": "#FFF",
                    "margin": "8px"
                }
            }).appendTo(dialogbox);
            jQuery('<div/>', {
                id: 'dialogboxhead',
                css: {
                    "background": "#666",
                    "font-size": "19px",
                    "padding": "10px",
                    "color": "#ccc"

                }
            }).appendTo(div);
            jQuery('<div/>', {
                id: 'dialogboxbody',
                css: {
                    "background": "#333",
                    "padding": "20px",
                    "color": "#FFF"

                }
            }).appendTo(div);
            jQuery('<div/>', {
                id: 'dialogboxfoot',
                css: {
                    "background": "#666",
                    "padding": "10px",
                    "text-align": "right"

                }
            }).appendTo(div);
        }
        this.IsRendered = true;
    },
    No: function () {
        document.getElementById('dialogbox').style.display = "none";
        document.getElementById('dialogoverlay').style.display = "none";
    },
    Yes: function (call_back, args) {
        call_back(args);
        document.getElementById('dialogbox').style.display = "none";
        document.getElementById('dialogoverlay').style.display = "none";
    }
}
var CorrespondenceReply = {
    Init: function () {
        //global.CustomFormId = 39107;
        var customFormId = $('#ctl00_CPH1_ddlCustomForms_Input').val();
        CorrespondenceReply.Render();
        if (customFormId != 'Select Custom Form ...' && customFormId != '' && typeof (customFormId) != 'undefined') {
            $.ajax({
                //url: 'http://localhost:58318/HMC/GetCorrespondenceButtons/?customformId=' + global.CustomFormId,
                url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/GetCorrespondenceButtons/?customformId=' + global.CustomFormId,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                success: function (data) {
                    CorrespondenceReply.GenerateButtons(JSON.parse(data));
                },
                error: function (xhr) { }
            });
        }
    },
    GenerateButtons: function (buttons) {
        var placeHolder = $('#letterReplyButtons');
        $.each(buttons, function (i) {
            var button = buttons[i];
            $('<br /><input type="button" value="' + button.Text + '" style="width:250px;" /><br />').click(function () {

                var winW = window.innerWidth;
                var winH = window.innerHeight;
                var dialogoverlay = document.getElementById('dialogoverlayCorrespondence');
                var dialogbox = document.getElementById('dialogboxCorrespondence');
                dialogoverlay.style.display = "block";
                dialogoverlay.style.height = winH + "px";
                dialogbox.style.left = (winW / 2) - (550 * .5) + "px";
                dialogbox.style.top = "100px";
                dialogbox.style.display = "block";

                document.getElementById('dialogboxheadCorrespondence').innerHTML = "Confirmation";
                if (button.Text != 'Generate Forward') {
                    document.getElementById('dialogboxbodyCorrespondence').innerHTML = 'Do you wish to <b>' + button.Text + '</b>?';
                }
                else if (button.Text = 'Generate Forward') {
                    document.getElementById('dialogboxbodyCorrespondence').innerHTML = 'For internal circulation of this Memo, kindly use the Team Input Option under Workflow tab.  Continue to Click on “Yes”  to  Forward this Memo to a Department of your choice by generating a new Memo.';
                }


                //                document.getElementById('dialogboxbodyCorrespondence').innerHTML = 'Do you wish to <b>' + button.Text + '</b>?';

                if (button.Button1ConfirmationText && button.Button1ConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.Button1ConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />There are <b>' + confirmationText.length + ' Memo(s) already created for this Record. Do You Still want to continue </b>?');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }

                if (button.Button2ConfirmationText && button.Button2ConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.Button2ConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />There are <b>' + confirmationText.length + ' Outgoing Letter(s) already created for this Record. Do You Still want to continue </b>?');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }


                if (button.ConsultantConfirmationText && button.ConsultantConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.ConsultantConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />There are <b>' + confirmationText.length + ' Consultant Correspondence(s) already created for this Record. Do You Still want to continue </b>?');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }

                if (button.ContractorConfirmationText && button.ContractorConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.ContractorConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />There are <b>' + confirmationText.length + ' Contractor Correspondence(s) already created for this Record. Do You Still want to continue </b>?');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }

                if (button.ConfirmationText && button.ConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.ConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />There are <b>' + confirmationText.length + ' replies already created for this Memo. Do You Still want to continue </b>?');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }

                if (button.ForwardConfirmationText && button.ForwardConfirmationText.length > 0) {
                    var confirmationText = JSON.parse(button.ForwardConfirmationText);
                    if (confirmationText.length > 0) {
                        $("#dialogboxbodyCorrespondence").append('<br /><br />This memo forwaded to the below department(s) for <b>' + confirmationText.length + ' times. Do you still want to continue?</b>');
                        var tr;
                        var table = $('<table />');
                        for (var i = 0; i < confirmationText.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td><a href='javascript: void(0)' onclick=\"" + confirmationText[i].RecordId + "\" style='color:#FFF'>" + confirmationText[i].Record + "</a></td>");
                            // tr.setAttribute('href', button.ConfirmationText.RecordId);
                            table.append(tr);
                        }
                        $("#dialogboxbodyCorrespondence").append(table);
                    }
                }




                $('#dialogboxfootCorrespondence').html('');
                $('<button />', {}).text('Yes')
                    .click(function () {
                        CorrespondenceReply.Close();
                        $.ajax({
                            //url: 'http://localhost:58318/HMC/CorrespondenceButtonAction/?customformId=' + global.CustomFormId + '&func=' + button.Func,
                            url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/CorrespondenceButtonAction/?customformId=' + global.CustomFormId + '&func=' + button.Func + '&userid=' + global.User.Id,
                            dataType: "html",
                            type: "GET",
                            contentType: 'application/json;charset=utf-8',
                            async: true,
                            cache: false,
                            success: function (data) {
                                location.href = JSON.parse(data);
                            },
                            error: function (xhr) { }
                        });
                        CorrespondenceReply.Close();
                    }).appendTo($('#dialogboxfootCorrespondence'));

                $('<button />', {}).text('No')
                   .click(function () {
                       CorrespondenceReply.Close()
                   }).appendTo($('#dialogboxfootCorrespondence'));
            }).appendTo(placeHolder);
        });
    },
    Render: function () {
        var dialogoverlay = jQuery('<div/>', {
            id: 'dialogoverlayCorrespondence',
            css: {
                "display": "none",
                "opacity": ".8",
                "position": "fixed",
                "top": "0px",
                "left": "0px",
                "background": "#FFF",
                "width": "100%",
                "z-index": "10"
            }
        }).appendTo($('body'));
        var dialogbox = jQuery('<div/>', {
            id: 'dialogboxCorrespondence',
            css: {
                "display": "none",
                "position": "fixed",
                "background": "#000",
                "border-radius": "7px",
                "width": "550px",
                "z-index": "10"
            }
        }).appendTo($('body'));
        var div = jQuery('<div />', {
            css: {
                "background": "#FFF",
                "margin": "8px"
            }
        }).appendTo(dialogbox);
        jQuery('<div/>', {
            id: 'dialogboxheadCorrespondence',
            css: {
                "background": "#666",
                "font-size": "19px",
                "padding": "10px",
                "color": "#ccc"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxbodyCorrespondence',
            css: {
                "background": "#333",
                "padding": "20px",
                "color": "#FFF"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxfootCorrespondence',
            css: {
                "background": "#666",
                "padding": "10px",
                "text-align": "right"

            }
        }).appendTo(div);
    },
    Close: function () {
        document.getElementById('dialogboxCorrespondence').style.display = "none";
        document.getElementById('dialogoverlayCorrespondence').style.display = "none";
    }
}

var PaymentApplication = {
    Init: function () {
        //global.CustomFormId = 39107;

        var customFormId = $('#ctl00_CPH1_ddlCustomForms_Input').val();
        PaymentApplication.Render();
        if (customFormId != 'Select Custom Form ...' && customFormId != '' && typeof (customFormId) != 'undefined') {
            $.ajax({
                //url: 'http://localhost:58318/HMC/GetPaymentApplicationButtons/?customformId=' + global.CustomFormId,
                url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/GetPaymentApplicationButtons/?customformId=' + global.CustomFormId,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                success: function (data) {
                    PaymentApplication.GenerateButtons(JSON.parse(data));
                },
                error: function (xhr) { }
            });
        }
    },
    GenerateButtons: function (buttons) {

        var placeHolder = $('#paymentButtons');
        $.each(buttons, function (i) {

            var button = buttons[i];
            $('<br /><input type="button" value="' + button.Text + '" style="width:250px;" /><br />').click(function () {

                var winW = window.innerWidth;
                var winH = window.innerHeight;
                var dialogoverlay = document.getElementById('dialogoverlayCorrespondence');
                var dialogbox = document.getElementById('dialogboxCorrespondence');
                dialogoverlay.style.display = "block";
                dialogoverlay.style.height = winH + "px";
                dialogbox.style.left = (winW / 2) - (550 * .5) + "px";
                dialogbox.style.top = "100px";
                dialogbox.style.display = "block";

                document.getElementById('dialogboxheadCorrespondence').innerHTML = "Confirmation";
                document.getElementById('dialogboxbodyCorrespondence').innerHTML = 'Do you wish to <b>' + button.Text + '</b>?';

                $('#dialogboxfootCorrespondence').html('');
                $('<button />', {}).text('Yes')
                    .click(function () {

                        PaymentApplication.Close();
                        $.ajax({
                            //url: 'http://localhost:58318/HMC/PaymentApplicationButtonAction/?customformId=' + global.CustomFormId,
                            url: 'https://pmweb.hamad.qa/PMWebhelper/HMC/PaymentApplicationButtonAction/?customformId=' + global.CustomFormId,
                            dataType: "html",
                            type: "GET",
                            contentType: 'application/json;charset=utf-8',
                            async: true,
                            cache: false,
                            success: function (data) {
                                location.href = JSON.parse(data);
                            },
                            error: function (xhr) { }
                        });
                        PaymentApplication.Close();
                    }).appendTo($('#dialogboxfootCorrespondence'));

                $('<button />', {}).text('No')
                   .click(function () {
                       PaymentApplication.Close()
                   }).appendTo($('#dialogboxfootCorrespondence'));
            }).appendTo(placeHolder);
        });
    },
    Render: function () {
        var dialogoverlay = jQuery('<div/>', {
            id: 'dialogoverlayCorrespondence',
            css: {
                "display": "none",
                "opacity": ".8",
                "position": "fixed",
                "top": "0px",
                "left": "0px",
                "background": "#FFF",
                "width": "100%",
                "z-index": "10"
            }
        }).appendTo($('body'));
        var dialogbox = jQuery('<div/>', {
            id: 'dialogboxCorrespondence',
            css: {
                "display": "none",
                "position": "fixed",
                "background": "#000",
                "border-radius": "7px",
                "width": "550px",
                "z-index": "10"
            }
        }).appendTo($('body'));
        var div = jQuery('<div />', {
            css: {
                "background": "#FFF",
                "margin": "8px"
            }
        }).appendTo(dialogbox);
        jQuery('<div/>', {
            id: 'dialogboxheadCorrespondence',
            css: {
                "background": "#666",
                "font-size": "19px",
                "padding": "10px",
                "color": "#ccc"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxbodyCorrespondence',
            css: {
                "background": "#333",
                "padding": "20px",
                "color": "#FFF"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxfootCorrespondence',
            css: {
                "background": "#666",
                "padding": "10px",
                "text-align": "right"

            }
        }).appendTo(div);
    },
    Close: function () {
        document.getElementById('dialogboxCorrespondence').style.display = "none";
        document.getElementById('dialogoverlayCorrespondence').style.display = "none";
    }
}

var global = {
    CustomFormId: "",
    TypeId: "",
    UserId: 0,
    User: {
        Id: 0,
        Email: ''
    }
}

$(function () {
    InitHMCJs();
    GetUser();
    //CreateBIReport();
    AttachBiForAll();
    if ($('#letterReplyButtons').length > 0) {
        CorrespondenceReply.Init();
    };
    if ($('#paymentButtons').length > 0) {
        PaymentApplication.Init();
    };
    if (typeof (WorkflowDocumentGrid) != "undefined" && $('#' + WorkflowDocumentGrid).length > 0) {
        ShowWorkflowNestedRows();
        HideWorkflowLog();
    }
    if ($("#ctl00_CPH1_CommitmentCODetails_rdgCommitmentCODetails_ctl00").length > 0) {

        $("#ctl00_CPH1_CommitmentCODetails_rdgCommitmentCODetails_ctl00 tr th:eq(3)").each(function () {

            var a = $(this);
            $(this).hide();
        });
        $("#ctl00_CPH1_CommitmentCODetails_rdgCommitmentCODetails_ctl00 tr td:eq(3)").each(function () {

            var a = $(this);
            $(this).hide();
        });
    }
    if ($("#ctl00_CPH1_CustomFormDetails1_ddlPHStatus_Input", $("#tblMemo")).length > 0 && $("#ctl00_CPH1_CustomFormDetails1_ddlPHStatus_Input", $("#tblMemo")).val() == "Draft") {
        $("#letterReplyButtons").hide();
    }
    console.log(global);
});
function GetUser() {
    $.ajax({
        url: 'https://pmweb.hamad.qa/pmweb/custom/pmwebhelper.aspx/GetUser',
        dataType: "json",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        async: false,
        cache: false,
        success: function (data) {
            console.log(JSON.parse(data.d));
        },
        error: function (xhr) { }
    });
}

function ShowWorkflowNestedRows() {
    if ($('#' + WorkflowDocumentGrid).length > 0) {
        $('tbody tr', $('#' + WorkflowDocumentGrid)).each(function () {
            debugger;
            console.log($(this).css("background-color"));
            if ($(this).css("background-color") == "green") {

            }
        });
    }
}
function HideWorkflowLog() {

    if (global.User.Email != "" && $('#' + WorkflowDocumentGrid).length > 0 && (global.User.Email.toLowerCase().indexOf("@hamad.qa") < 0 && global.User.Email.toLowerCase().indexOf("@hmc.org.qa") < 0)) {
        var stepColumnIndex = 0;
        var ramColumnIndex = 0;
        var stepChildColumnIndex = 0;
        var commentChildColumnIndex = 0;
        var HasBranching = 0;

        $("#" + WorkflowDocumentGrid + " th").each(function () {
            if ($(this).text() == '#') {
                stepColumnIndex = $("#" + WorkflowDocumentGrid + "  th").index(this);
                if ($(this).attr('colspan') == "3") {
                    HasBranching = 1;
                }
            }
            if ($(this).text() == 'RAM') {
                ramColumnIndex = $("#" + WorkflowDocumentGrid + " th").index(this);
            }
        });
        $(".rgMasterTable thead th", "#" + workflowLogGrid).each(function () {

            console.log($(this));
            var text = $(this).text();
            if ($(this).text() == 'Step') {
                stepChildColumnIndex = $(".rgMasterTable thead th", "#" + workflowLogGrid).index(this);
            }
            if ($(this).text() == 'Comments') {
                commentChildColumnIndex = $(".rgMasterTable thead th", "#" + workflowLogGrid).index(this);
            }
        });
        stepColumnIndex = stepColumnIndex + 1;
        ramColumnIndex = ramColumnIndex + 1;

        $("#" + WorkflowDocumentGrid + " tr").each(function () {
            var ramColumnIndexTmp = ramColumnIndex;
            var stepColumnIndexTmp = stepColumnIndex;
            if (HasBranching == 1 && $("td:eq(1)", $(this)).attr("colspan") && $("td:eq(1)", $(this)).attr("colspan") == 2) {
                ramColumnIndexTmp = ramColumnIndex;
                stepColumnIndexTmp = stepColumnIndex;
            }
            else if (HasBranching == 1) {
                ramColumnIndexTmp = ramColumnIndex + 1;
                stepColumnIndexTmp = stepColumnIndex + 1;
            }
            if ($("td:eq(" + ramColumnIndexTmp + ")", $(this)).text().indexOf('HMC-Workflow') >= 0) {
                var stepNumber = $.trim($("td:eq(" + stepColumnIndexTmp + ")", $(this)).text().replace(/(<([^>]+)>)/ig, ""));
                $(this).remove();

                $(".rgMasterTable tbody tr", "#" + workflowLogGrid).each(function () {
                    var stepNumberText = $.trim($("td:eq(" + stepChildColumnIndex + ")", $(this)).text().replace(/(<([^>]+)>)/ig, ""));
                    if (stepNumberText == stepNumber) {
                        $(this).remove();
                    }
                });
            }
            else if ($("td:eq(" + ramColumnIndexTmp + ")", $(this)).text().indexOf('HMC-Comments') >= 0) {
                var stepNumber = $.trim($("td:eq(" + stepColumnIndexTmp + ")", $(this)).text().replace(/(<([^>]+)>)/ig, ""));
                //$(this).hide();

                $(".rgMasterTable tbody tr", "#" + workflowLogGrid).each(function () {
                    var stepNumberText = $.trim($("td:eq(" + stepChildColumnIndex + ")", $(this)).text().replace(/(<([^>]+)>)/ig, ""));
                    if (stepNumberText == stepNumber) {
                        $("td:eq(" + commentChildColumnIndex + ")", $(this)).text('');
                    }
                });
            }
        });
        $("#" + workflowPnlImg).hide();
    }

    //if ($('#ctl00_CPH1_WorkflowDocument1_rdgWorkflowLog').length > 0 && global.User.Email.toLowerCase().indexOf("@hamad.qa")) {
    //    $("#ctl00_CPH1_WorkflowDocument1_rdgWorkflowLog td:contains('(HMC)')").each(function () {
    //        $(this).parent().find('td:last-child').text('');
    //        $(this).parent().find('td:eq(2)').text('');
    //    });
    //}
}

function BindProjectContactDropDown(objDropdown) {
    var select = objDropdown;
    if (select) {
        MultiAjaxAutoComplete("#customizedContact", 'https://pmweb.hamad.qa/pmwebhelper/hmc/GetHMCContacts');
    }
}

function MultiAjaxAutoComplete(element, url) {
    var txtCustomizedCC = $('input[type="text"]', $("#txtCustomizedCC"));
    txtCustomizedCC.hide();

    var projectId = $("input[id$='ddlPHProject_ClientState']").val();
    if (projectId == "") {
        projectId = 0;
    }
    else {
        projectId = JSON.parse(projectId);
        projectId = projectId["value"];
    }
    if (projectId == "")
        projectId = 0;

    $(element).select2({
        ajax: {
            url: url,
            delay: 250,
            dataType: 'json',
            data: function (params) {
                var query = {
                    search: params.term,
                    projectId: projectId,
                    page: params.page || 1
                }
                return query;
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data,
                    pagination: {
                        more: true
                    }
                };
            },
            cache: true
        },
        placeholder: 'Search the name',
        minimumInputLength: 3,
        //templateResult: formatRepo,
        //templateSelection: formatRepoSelection
    })
    .on('select2:select', function (e) {
        $('input[type="text"]', $("#txtCustomizedCC")).val($(this).val());
    })
    .on('select2:unselect', function (e) {
        $('input[type="text"]', $("#txtCustomizedCC")).val($(this).val());
    });

    if (txtCustomizedCC.val() != "") {
        $.ajax({
            url: 'https://pmweb.hamad.qa/pmwebhelper/hmc/GetHMCContactsByEmail?emails=' + txtCustomizedCC.val(),
            dataType: "json",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            async: false,
            cache: false,
            success: function (data) {


                $.each(data, function (i) {

                    val = data[i].id;
                    txt = data[i].text;
                    var $option = $('<option selected>' + data[i].text + '</option>').val(data[i].id);
                    $(element).append($option).trigger('change');
                });
            },
            error: function (xhr) { }
        });
    }
};

function formatRepo(repo) {
    if (repo.loading) {
        return repo.text;
    }

    var $container = $(
      "<div class='select2-result-repository clearfix'>" +
        "<div class='select2-result-repository__avatar'><img src='" + repo.owner.avatar_url + "' /></div>" +
        "<div class='select2-result-repository__meta'>" +
          "<div class='select2-result-repository__title'></div>" +
          "<div class='select2-result-repository__description'></div>" +
          "<div class='select2-result-repository__statistics'>" +
            "<div class='select2-result-repository__forks'><i class='fa fa-flash'></i> </div>" +
            "<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> </div>" +
            "<div class='select2-result-repository__watchers'><i class='fa fa-eye'></i> </div>" +
          "</div>" +
        "</div>" +
      "</div>"
    );

    $container.find(".select2-result-repository__title").text(repo.full_name);
    $container.find(".select2-result-repository__description").text(repo.description);
    $container.find(".select2-result-repository__forks").append(repo.forks_count + " Forks");
    $container.find(".select2-result-repository__stargazers").append(repo.stargazers_count + " Stars");
    $container.find(".select2-result-repository__watchers").append(repo.watchers_count + " Watchers");

    return $container;
}

function formatRepoSelection(repo) {
    return repo.full_name || repo.text;
}

function SetIFrameHeight() {
    var top = 105;
    var $height = $(window).height();
    var frame = $('iframe');
    if (frame.length > 0) {
        frame = $(frame[0]);
        if (frame.attr('src')) {
            var src = frame.attr('src').toLowerCase();
            if (src.indexOf('pmwebhelper') >= 0) {
                var $divContentHolder = $('#divContentHolder');
                var $radTabStrip = $('.RadTabStrip', $divContentHolder);

                var $radTabStripHeight = $radTabStrip.height() + top;
                var $height = ($height - $radTabStripHeight - 40);
                frame.attr('height', $height);
                frame.css({
                    'height': $height + 'px'
                });
                var divView = frame.closest('div');
                divView.css({
                    'height': $height + 'px'
                });
            }
        }
    }
}
//function GetProjectContacts(projectId, callBack)
//{
//    $.ajax({
//        url: 'https://pmweb.hamad.qa/pmwebhelper/hmc/GetProjectContacts?projectId=' + projectId,
//        //url: 'http://localhost:58318/hmc/GetProjectContacts?projectId=' + projectId,
//        dataType: "json",
//        type: "GET",
//        contentType: 'application/json;charset=utf-8',
//        async: false,
//        cache: false,
//        success: function (data) {
//            callBack(data);
//        },
//        error: function (xhr) { }
//    });
//}

//function BindProjectContactDropDown(projectId, objDropdown)
//{
//    var select = objDropdown;
//    if (select) {
//        GetProjectContacts(projectId, function (data) {
//            select.hide();
//            var selectId = select.attr("id");
//            var s = $('<select />', {
//                Id: selectId + '_select2',
//                css: { 'width': '100%' },
//                "multiple": "multiple"
//            });
//            $.each(data, function (i) {
//                
//                $('<option />', { value: data[i].Id, text: data[i].Name }).appendTo(s);
//            });
//            s.appendTo(select.parent().get(0));
//            s.select2();
//            s.on('select2:select', function (e) {
//                $('input[type="text"]', $("#txtCC")).val(s.val());
//            });
//            s.on('select2:unselect', function (e) {
//                $('input[type="text"]', $("#txtCC")).val(s.val());
//            });
//        });
//    }
//}
function HMCSetRadWindowConfig() {
    setTimeout(function () { 
        $(".RadWindow").css({ 'top': '100px' });
        $(".RadWindow").css({ 'left': '500px' });
    }, 10);
}
