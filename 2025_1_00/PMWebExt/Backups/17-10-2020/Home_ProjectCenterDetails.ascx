<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_ProjectCenterDetails.ascx.vb"
    Inherits="Website.Home_ProjectCenterDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="PMAjaxManager">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlQuickFileUpload"  />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <style>
        .PMHeader .row{display:block!important;}
        .fader img {width: 100%;max-height: 285px;}
        .ProjectCenterSepcs .fldSpecs {border-top: 0px solid #999999;}
        .ProjectCenterSepcs .SpecificationPadding{ padding-left:0px !important}
        .ProjectCenterSepcs .RadTabStrip .rtsLink.rtsSelected:after {background-color: #fff !important;}
        .ProjectCenterSepcs .RadTabStrip .rtsLink:after {
            content: "" !important;
            clear: both !important;
            display: block !important;
            WIDTH: 139PX !important;
            position: absolute !important;
            height: 1px !important;
            background-color: transparent !important;
            top: 29px !important;
            z-index: 0 !important;
            left: 1px;
        }
        .ProjectCenterSepcs .RadTabStrip:after {
            content: "" !important;
            clear: both !important;
            display: block !important;
            position: absolute !important;
            width: 100% !important;
            background-color: #4c4c4c !important;
            top: 29px !important;
            height: 1px !important;
            left: 0px !important;
            z-index: -1 !important;
        }
        .ProjectCenterSepcs .RadTabStrip .rtsLevel1 .rtsTxt {
            padding: 0 !important;
            display: block !important;
            text-transform: uppercase !important;
            width: 130px !important;
            text-overflow: ellipsis !important;
            overflow: hidden !important;
        }
        .ProjectCenterSepcs .rgCommandCell {
            background-color: #fff;
        }
        .ProjectCenterSepcs .RadTabStrip {
            border-bottom: 0px solid !important;
            position: relative !important;
        }
        .ProjectCenterSepcs .RadGrid.RadGrid_Default {
            border-top: none !important;
        }
        .ProjectCenterSepcs .rtsLink {
            line-height: 30px !important;
            padding-left: 0px !important;
            width: 144px;
        }
        .ProjectCenterSepcs .rtsTxt {
            color: #fff;
        }
        .ProjectCenterSepcs .rtsSelected .rtsTxt {
            color: rgb(102,102,102);
        }
          .tbshorizantaltabs {visibility:visible !important}
           .tbsDocSpec {display:none !important;}
        .ProjectCenterSepcs .rtsLink.rtsSelected:before {
            background: #fff !important;
            z-index: -1;
        }
        .ProjectCenterSepcs .rtsLI:not(:first-child) {
            margin-left: -10px;
        }
        .ProjectCenterSepcs .PMHeader{padding-top:24px !important;}
        .ProjectCenterSepcs .rtsLink:before {
            display: block;
            content: " ";
            background-color: #fff;
            position: absolute;
            right: 1px;
            top: -4px;
            bottom: -4px;
            left: 0px;
            z-index: -2;
            border: 1px solid rgb(102,102,102);
            border-bottom: none;
            background: rgb(102,102,102);
            -webkit-transform: perspective(8px) rotateX(2deg);
            -webkit-transform-origin: bottom left;
            transform: perspective(8px) rotateX(2deg);
            transform-origin: bottom left;
            -moz-transform: perspective(8px) rotateX(2deg);
            -moz-transform-origin: bottom left;
        }
        .RadUpload.ProjectCenterUpload{padding:0px !important;}
        .RadTabStrip .rtsLI {
            position: relative !important;
        }

        /*.ProjectCenterSepcs .rtsLI {margin-left:-15px;
        }
        .ProjectCenterSepcs .rtsLI.rtsFirst{margin-left:0px;}
      .ProjectCenterSepcs .rtsLI  a {padding:10px;
           text-decoration:none;
           color:white !important;
           font-weight:bold;
           display:inline-block;
           border-right:30px solid transparent;
           border-bottom:30px solid rgb(102,102,102);

           height:0;
           line-height:50px !important;
        }

        .ProjectCenterSepcs .rtsLI a.rtsSelected   {
         text-decoration:none !important;
           color:#000 !important;
           font-weight:bold;
           display:inline-block;
           border-right:30px solid transparent;
           border-bottom:30px solid #316888;

           height:0;
           line-height:50px !important;
        
        }*/
        .ProjectCenterSepcs .RadTabStrip_Default .rtsLevel .rtsSelected .rtsOut {
            border: 0px !important;
            color: #000 !important;
        }
        .RadUpload_Office2007 .ruDropZone, .RadUpload_Office2007_rtl .ruDropZone {
            margin-top: 0px !important;
        }
        .ProjectCenterUpload  .ruDropZone{
            padding-right: 0px !important;
            margin-top: 0px !important; }
        .RadUpload_Office2007 .ruDropZone {
            border-color: #7396AA !important;
            color: white !important;
            background-color: #316888 !important;
        }
        .rtsLevel.rtsLevel1 {
            width: calc(30vw) !important;
        }
        .fader .rrButton.rrButtonLeft {
            left: 0 !important;
            top: 50%;
            width: 24px;
            background: none !important;
            display: block;
            position: absolute;
            height: 24px;
        }
        .fader:hover .rrButton.rrButtonLeft {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -264px 0 !important;
        }
        .fader .rrButton.rrButtonLeft:hover {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -264px 0 !important;
        }
        td:empty {
    display: none !important;
}
        .rrButton.rrButtonRight {
            left: calc(100% - 24px) !important;
            top: 50%;
            height: 24px;
            width: 24px;
            background: none !important;
            display: block;
            position: absolute;
        }
        .fader:hover .rrButton.rrButtonRight {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -288px 0 !important;
        }
        .pnlStats div:first-child {
            background-color: rgb(102,102,102);
            color: white;
            text-align: center;
            font-size: 20px;
            font-weight: 400;
            padding: 5px;
            cursor: pointer;
            height: 20px;
            line-height: 20px;
        }
        .pnlStats p {
            height: 54px;
            color: white;
            text-align: center;
            /*padding: 5px;*/
            cursor: pointer;
            line-height: 54px;
        }
        .pnlStats {
            margin-left: 0px;
            width: 100%;
        }
        .PMHeader .row .col-2 {
        flex: 0 0 100% !important;
        max-width: 100% !important;
         margin-left:0px !important;
         /*float:none !important;*/
    }
        .PMHeader .row .col-10 {
        flex: 0 0 100% !important;
        max-width: 100% !important;
         margin-left:0px !important;
          /*float:none !important;*/
    }
        .marginTop{margin-top:-13px;}
        /*.ProjectCenterSepcs{padding-left:20px;    padding-bottom: 56px;}*/
        .PMProjectCenter .row {  table-layout:fixed;
     box-sizing:border-box;
     display: flex !important;
     flex-wrap:wrap;
     padding-top:24px;
     width:100%;
     padding-left:24px;
     padding-right:24px;
        }
        .PMProjectCenter .col-4 {width:400px;margin-top:24px;order:1}
          .PMProjectCenter .col-3 {width:250px;padding-left:24px;margin-top:24px;order:2}
          .PMProjectCenter textarea{box-sizing:border-box;}
          .PMProjectCenter .col-5{width:650px;height:529px !important;order:3;padding-left:24px}
        .ProjectCenterSepcs .PMHeader .row {margin-top:0px !important}
        .PMProjectCenter .ProjectCenterSepcs .row{margin-top:0px !important;padding-top:0px !important;padding-left:0px !important}
        .PMProjectCenter .ProjectCenterSepcs .tbshorizantaltabs .rtsLevel.rtsLevel1 {width: 650px !important;}
        .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:650px !important;height:527px !important}
        h2{-webkit-margin-before: 0em !important;-webkit-margin-after: 0em !important;}
        
        .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default .rgDataDiv{height:462px !important}
        .mobileLogo{display:none;}


              .rail .tblProjectCenterHeader{max-width:1548px;}
                 .tblProjectCenterHeader{max-width:1348px;}
    

        @media screen and (min-width:1582px) and (max-width:1612px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:16px !important;padding-right:16px !important;}
              .PMProjectCenter .col-3 {padding-left:16px !important;}
               .PMProjectCenter .col-5 {padding-left:16px !important;}
                .tblProjectCenterHeader{max-width:1332px !important;}
                
        }
         @media screen and (min-width:1557px) and (max-width:1581px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:16px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;}
                .PMProjectCenter .col-5 {padding-left:8px !important;}
                .tblProjectCenterHeader{max-width:1316px !important;}
              
        }
          /*@media screen and (min-width:1452px) and (max-width:1468px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:16px !important;padding-right:16px !important;}
              .PMProjectCenter .col-3 {padding-left:16px !important;}
              .PMProjectCenter .col-5 {padding-left:16px !important;}
               .tblProjectCenterHeader{max-width:1332px !important;}
        }
          @media screen and (min-width:1435px) and (max-width:1451px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:8px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;}
              .PMProjectCenter .col-5 {padding-left:8px !important;}
               .tblProjectCenterHeader{max-width:1316px !important;}
        }*/

           @media screen and (min-width:1514px) and (max-width:1556px) {
            .PMProjectCenter .col-4 {max-width:400px !important;flex:0 0 50% !important; order:1 !important}
            .PMProjectCenter .col-3 {max-width:400px !important;flex:0 0 50% !important;order:2 !important}
             .PMProjectCenter .col-5 {max-width:400px !important;min-width:400px !important;flex:0 0 50% !important;order:3 !important}
             .PMProjectCenter .col-3 {padding-left:24px !important;}
             .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
              .tblProjectCenterHeader{max-width:1248px !important;}
              
        }

         /*@media screen and (min-width:1368px) and (max-width:1434px) {
            .PMProjectCenter .col-4 {max-width:400px !important;flex:0 0 50% !important; order:1 !important}
            .PMProjectCenter .col-3 {max-width:400px !important;flex:0 0 50% !important;order:2 !important}
             .PMProjectCenter .col-5 {max-width:400px !important;min-width:400px !important;flex:0 0 50% !important;order:3 !important}
             .PMProjectCenter .col-3 {padding-left:24px !important;}
             .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
              .tblProjectCenterHeader{max-width:1248px !important;}
        }*/
           @media screen and (min-width:1481px) and (max-width:1513px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:16px !important;padding-right:16px !important;}
              .PMProjectCenter .col-5 {padding-left:16px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:16px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:1232px !important;}
               .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
        }

            @media screen and (min-width:1324px) and (max-width:1480px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:8px !important;}
              .PMProjectCenter .col-5 {padding-left:8px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:1216px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
        }
             @media screen and (min-width:961px) and (max-width:1323px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:24px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
             .PMProjectCenter .col-3 {padding-left:24px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
        }
               @media screen and (min-width:961px) and (max-width:1089px) {
                .rail .PMProjectCenter .col-3 {padding-left:24px !important;max-width:400px !important;width:400px !important}
               .PMProjectCenter .col-3 {padding-left:0px !important;max-width:400px !important;width:400px !important}
        }

               /*@media screen and (min-width:1263px) and (max-width:1295px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:16px !important;padding-right:16px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:13px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:816px !important;}
                
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
        }
                @media screen and (min-width:1232px) and (max-width:1262px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:8px !important;}
              .PMProjectCenter .col-5 {padding-left:8px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:1216px !important;}
               
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
        }

                 @media screen and (min-width:889px) and (max-width:1231px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:24px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:24px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}

                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
        }*/
                @media screen and (min-width:954px) and (max-width:960px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:16px !important;padding-right:16px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:16px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:816px !important;}
                
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
        }
                   @media screen and (min-width:937px) and (max-width:953px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:8px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:808px !important;}
                
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
        }
                   @media screen and (min-width:839px) and (max-width:936px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:24px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:0px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:816px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
        }
                     /*@media screen and (min-width:839px) and (max-width:863px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:8px !important;padding-right:8px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:8px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
        }*/

                       @media screen and (min-width:464px) and (max-width:838px) {
            .PMProjectCenter .row{padding-top:24px;padding-left:24px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:0px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
                .mobileLogo{display:block !important}
                .Logo{display:none !important}
        }
                        @media screen and (min-width:447px) and (max-width:463px) {
            .PMProjectCenter .row{padding-top:16px;padding-left:16px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:0px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:509px !important}
                .mobileLogo{display:block !important}
                .Logo{display:none !important}
        }
            @media screen  and (max-width:446px) {
            .PMProjectCenter .row{padding-top:8px;padding-left:8px !important;padding-right:24px !important;}
              .PMProjectCenter .col-5 {padding-left:0px !important;max-width:400px !important;}
              .PMProjectCenter .col-3 {padding-left:0px !important;max-width:400px !important;width:400px !important}
               .tblProjectCenterHeader{max-width:824px !important;}
                .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:400px !important;height:527px !important}
                .mobileLogo{display:block !important}
                .Logo{display:none !important}
                
        }

            
               @media screen and (max-height:799px) and (min-width:1539px) {
                 .PMProjectCenter .col-5{width:630px;height:509px !important;order:3;padding-left:24px}
        .PMProjectCenter .ProjectCenterSepcs .tbshorizantaltabs .rtsLevel.rtsLevel1 {width: 630px !important;}
        .PMProjectCenter .ProjectCenterSepcs .RadGrid.RadGrid_Default {width:630px !important;height:527px !important}
           .tblProjectCenterHeader{max-width:1328px !important;}
        }

        @media screen and (max-width:1231px) {
        .PMProjectCenter .row {padding-bottom: 60px;}
        }

        @media screen and (max-width:840px) {
            .ProjectCenterContainer {margin-top: 45px !important;}
             .mobileLogo{display:block !important}
              .Logo{display:none !important}
        }

        .ellipsis {
                width: 16px;
                height: 16px;
                background-image: url(CSS/Images/ResponsiveIcons/16White.png);
                position: absolute;
                right: 8px;
                background-position: -1280px 0;
                top:8px;
        }
        .PMProjectCenter .colTable {
            border-spacing: 0px 1px !important;
            /* padding-left: 24px; */
        }
      </style>
    <script type="text/javascript">
        /*******Drag and Drop ***********/

        var uploadsInProgress = 0;

        function onFileSelected(sender, args) {
            uploadsInProgress++;
        }

        function onFileUploaded(sender, args) {
            decrementUploadsInProgress();
            if (uploadsInProgress <= 0) {
                $find('ctl00_PMAjaxManager').ajaxRequest();
                setTimeout(function () {
                    sender.deleteAllFileInputs();
                }, 10);
            }
        }

        function onUploadFailed(sender, args) {
            decrementUploadsInProgress();
        }

        function decrementUploadsInProgress() {
            uploadsInProgress--;
        }

        function added(sender, args) {
            if (document.getElementById('lblUploadOption')) {
                if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                    $("#lblUploadOption").html(lblUploadOptionChFFText);
                } else {
                    $("#lblUploadOption").html(lblUploadOptionIEText);
                }
            }
        }

        function ClientValidationFailed(sender, args) {
            decrementUploadsInProgress();
            alert(WarningMsg_InvalidFile);
        }


        function ProgramRedirect() {
            var ddlProgramValue = $find("<%= ddlProgram.ClientID %>").get_value();
            if (parseInt(ddlProgramValue)) {
                window.top.location.href = 'Programs.aspx?ID=' + ddlProgramValue + '&ModuleId=7&PageId=214';
            }
            return false;
        }


        function ProjectRedirect() {
            var txtProjectValue = <%= PM.ProjectInfo.Id %>;
            if (parseInt(txtProjectValue)) {
                window.top.location.href = 'Projects.aspx?ID=' + txtProjectValue + '&ModuleId=7&PageId=53';
            }
            return false;
        }

        function LocationRedirect() {
            var ddlLocationValue = $find("<%= ddlLocation.ClientID %>").get_value();
            if (parseInt(ddlLocationValue)) {
                window.top.location.href = 'Properties.aspx?ID=' + ddlLocationValue + '&ModuleId=5&PageId=39';
            }
            return false;
        }
        function OnRotatorLoad(rotator,args){
            if(!rotator.autoIntervalID)
            {
                rotator.autoIntervalID = window.setInterval(function(){
                    rotator.showNext();},5000)

            }
        }

        function ControlButtonClicked(rotator,args)
        {
            window.clearInterval(rotator.autoIntervalID)
        }

        function showNavigator(){
            $('[id$=pnlNavigatorSection]')[0].classList.remove('Hide');
            $('[id$=pnlNavigatorSection]')[0].style.display="table-row";
            $('[id$=pnlCustomFields]')[0].classList.add('Hide');
            $('[id$=divDocuments]')[0].classList.add('Hide');
            $('#lbtViewSpec')[0].classList.remove('Hide')

            return false;
        }

        function showSpecifications(){
            $('[id$=pnlNavigatorSection]')[0].classList.add('Hide');
            $('[id$=pnlCustomFields]')[0].classList.remove('Hide');
            $('[id$=divDocuments]')[0].classList.remove('Hide');
            $('#lbtViewSpec')[0].classList.add('Hide')
            if($('.rtsNextArrow').length==1)$('.rtsNextArrow').show();
            if($('.rtsNextArrowDisabled').length==1)$('.rtsNextArrow').show();
            if($('.rtsPrevArrow').length==1)$('.rtsPrevArrow').show();
            if($('.rtsPrevArrowDisabled').length==1)$('.rtsPrevArrowDisabled').show();
            ResizeSpectabsInProjectCenter();
            return false;
        }
    </script>
</telerik:RadScriptBlock>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <Calendar Width="200px"></Calendar>
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<div class="PMProjectCenter" style="padding-top:0 !important">
    <div class="row">
     
        <table style="width:100%" cellpadding="0" cellspacing="0" class="tblProjectCenterHeader">
            <tr>
                <td style="width:70%"><div runat="server" id="divLocationHeader"><asp:Label runat="server" ID="lblLocationHeader" style="font-size:24px;color:#999999;"></asp:Label><br /></div>
                <div style="padding-top:10px;"  runat="server" id="divProjectHeader"><asp:Label runat="server" ID="lblProjectHeader" style="font-size:26px;color:#000000;"></asp:Label></div></td>
                <td style="width:30%;text-align:right;" class="Logo">
                       <asp:Image ID="imglogo" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="240px" Height="80px"/>
                </td>
            </tr>
            <tr class="mobileLogo">
                <td colspan="2" style="padding-top:24px;text-align:center">
                     <asp:Image ID="imglogoMobile" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="240px" Height="80px"/>
                </td>
            </tr>
        </table>
        <div class="col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:LinkButton ID="btnGoToProgram" OnClientClick="return ProgramRedirect();" CssClass="Link"
                            meta:Resourcekey="btnGoToProgram" runat="server">Program</asp:LinkButton>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlProgram" runat="server" meta:Resourcekey="ddlProgram" Width="100%" AllowCustomText="true"
                             Skin="Default" Style="font-size: 11px">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:LinkButton ID="btnGoToProject" OnClientClick="return ProjectRedirect();" CssClass="Link"
                            meta:ResourceKey="btnGoToProject" runat="server" Text="Project ID*"></asp:LinkButton>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtProjectId" runat="server" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProjectId" runat="server" CssClass="Validator"
                            Display="Dynamic" ForeColor="" ControlToValidate="txtProjectId" ValidationGroup="Save"
                            meta:resourcekey="rfvProjectId">
                        </asp:RequiredFieldValidator>
                        <asp:Label ID="lblProjectIdUnique" Visible="false" runat="server" CssClass="Validator"
                            meta:ResourceKey="lblProjectIdUnique" />
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblName" Text="Name*" runat="server" meta:resourcekey="lblName"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtName" runat="server" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProjectName" runat="server" CssClass="Validator"
                            Display="Dynamic" ForeColor="" ControlToValidate="txtName" ValidationGroup="Save"
                            meta:resourcekey="rfvProjectName">
                        </asp:RequiredFieldValidator>
                        <asp:Label ID="lblProjectNameUnique" Visible="false" CssClass="Validator" runat="server"
                            meta:ResourceKey="lblProjectNameUnique" />
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:LinkButton ID="btnLocation" OnClientClick="return LocationRedirect();" CssClass="Link"
                            Text="Location" runat="server" meta:resourcekey="btnLocation"></asp:LinkButton>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlLocation" runat="server" Width="100%" meta:Resourcekey="ddlLocation"
                            OnItemsRequested="ddl_ItemsRequested"  EnableLoadOnDemand="True" Height="200px"
                            Skin="Default" Style="font-size: 11px" EnableVirtualScrolling="true" ShowMoreResultsBox="true">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblProjectStatus" Text="Project Status" runat="server" meta:resourcekey="lblProjectStatus"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlProjectStatus" runat="server" Width="100%" meta:Resourcekey="ddlProjectStatus"
                            Skin="Default" Style="font-size: 11px" AllowCustomText="true">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblProjectType" Text="Project Type" runat="server" meta:resourcekey="lblProjectType"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlProjectType" runat="server" Width="100%" meta:Resourcekey="ddlProjectType"
                            Skin="Default" Style="font-size: 11px" AllowCustomText="true">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblCategory" Text="Category" runat="server" meta:resourcekey="lblCategory"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlCategory" runat="server" Width="100%" meta:Resourcekey="ddlCategory" AllowCustomText="true"
                            Skin="Default" Style="font-size: 11px">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblStatus" Text="Status" runat="server" meta:resourcekey="lblStatus"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlStatus" runat="server" meta:Resourcekey="ddlStatus"
                            EmptyMessage="Select Status..." Skin="Default" Style="font-size: 11px;width:182px !important">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>    
                                                            <asp:TextBox ID="txtRevision" runat="server" CssClass="Integer" Enabled="false" Width="50px" style="margin-left:3px;" ></asp:TextBox>
                   
                    </td>

                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblCurrency" Text="Currency" runat="server" meta:resourcekey="lblCurrency"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlCurrency" runat="server" Width="100%" meta:Resourcekey="ddlCurrency"
                            EmptyMessage="Select Currency..." Skin="Default" Style="font-size: 11px">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                        <asp:Label ID="lblCurrencyError" meta:resourcekey="lblCurrencyError" CssClass="Validator" runat="server" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTargetBudget" Text="Target Budget" runat="server" meta:resourcekey="lblTargetBudget"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtTargetBudget" runat="server" Width="100%" CssClass="Double"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTargetRevenue" Text="Target Revenue" runat="server" meta:resourcekey="lblTargetRevenue"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtTargetRevenue" runat="server" Width="100%" CssClass="Double"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTargetDuration" Text="Target Duration" runat="server" meta:resourcekey="lblTargetDuration"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                            <tr>
                                <td style="width: 50%;">
                                    <asp:TextBox ID="txtTargetDuration" runat="server" Width="116px" CssClass="Double"></asp:TextBox>
                                </td>
<%--                                <td style="text-align: center; padding-left: 5px;width:30px;padding-right:0px;">
                                    <asp:Label ID="lblUOM" Text="UOM" runat="server" meta:resourcekey="lblUOM"></asp:Label>
                                </td>--%>
                                <td style="width:50%;margin-right:5px;text-align:right">
                                    <telerik:RadComboBox ID="ddlUOM" runat="server" meta:Resourcekey="ddlUOM" Class="RadComboBox" AllowCustomText="true"
                                        Skin="Default" Style="font-size:11px;width:116px !important">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTargetStartFinish" Text="Target Start/Finish" runat="server" meta:resourcekey="lblTargetStartFinish"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width: 50%;">
                                   <%-- <span runat="server" id="rmd_dtpTargetStart1" style="display: block">
                                        <asp:TextBox ID="dtpTargetStart1" runat="server" Width="95%" onclick="showDatePopup(this, event);"
                                            onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"></asp:TextBox>
                                    </span>--%>
                                     <span runat="server" id="rmd_dtpTargetStart">
                                                        <telerik:RadDatePicker ID="dtpTargetStart" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                             EnableTyping="True" style="width:116px !important">
                                                            <DateInput ID="DateInput5" runat="server"></DateInput>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                </td>
                                <td style="width: 50%;text-align:right">
<%--                                    <span runat="server" id="rmd_dtpTargetFinish1" style="display: block">
                                        <asp:TextBox ID="dtpTargetFinish1" runat="server" Width="98%" onclick="showDatePopup(this, event);"
                                            onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"></asp:TextBox>
                                    </span>--%>
                                     <span runat="server" id="rmd_dtpTargetFinish">
                                                        <telerik:RadDatePicker ID="dtpTargetFinish" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                             EnableTyping="True" style="width:116px !important">
                                                            <DateInput ID="DateInput1" runat="server"></DateInput>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblActualStartFinish" Text="Actual Start/Finish" runat="server" meta:resourcekey="lblActualStartFinish"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td style="width: 50%;">
                                    <asp:TextBox ID="txtActualStart" runat="server" Width="116px" onclick="showDatePopup(this, event, true);"
                                        onfocus="showDatePopup(this, event, true);" onblur="parseDate(this, event);"></asp:TextBox>
                                </td>
                                <td></td>
                                <td style="width: 50%;text-align:right">
                                    <asp:TextBox ID="txtActualFinish" runat="server" Width="116px" onclick="showDatePopup(this, event, true);"
                                        onfocus="showDatePopup(this, event, true);" onblur="parseDate(this, event);"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblPercentComplete" Text="Percent Complete" runat="server" meta:resourcekey="lblPercentComplete"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <table cellpadding="0" cellspacing="0" style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtPercentComplete" runat="server" Width="100%" CssClass="Double"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth" style="vertical-align: top">
                        <div style="float: left">
                            <asp:Label ID="lblScope" Text="Scope" runat="server" meta:resourcekey="lblScope"></asp:Label>
                        </div>
                        <div style="float: right">
                            <asp:LinkButton runat="server" ID="imgMemo" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtScope'))" CssClass="SearchButton">
                                       <span class="Icon"></span>
                            </asp:LinkButton>
                        </div>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtScope" runat="server" Width="100%" Height="48px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Panel ID="pnlQuickFileUpload" runat="server" Width="100%">
                         <telerik:RadAsyncUpload runat="server" Width="100%"  CssClass="ProjectCenterUpload" ID="rauAttachment" Skin="Default" OnClientFileUploadFailed="onUploadFailed"
                           OnClientFileSelected="onFileSelected" OnClientFileUploaded="onFileUploaded" OnClientAdded="added" HideFileInput="true" 
                           MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed" OnFileUploaded="rauAttachment_FileUploaded">
                               <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>"/>   
                          </telerik:RadAsyncUpload>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-3" runat="server" id="divStats">
            <table class="colTable" cellpadding="0" cellspacing="0">
                <tr id="trRotator" runat="server" >
                    <td style="padding-bottom:25px">
                         <div runat="server" id="divImages" class="ImagesHeaderDiv" style="color:#fff;background-color:rgb(102,102,102);width:100%;text-align:center;height:30px">
                            <div  style="font-size:20px;font-weight:400;height:30px;line-height:30px; text-transform:uppercase">
                                <asp:Label runat="server" ID="Images" Text="Images" ></asp:Label></div>
                             </div>
                        <div id="fader" class="fader" style="position:relative;">
                            <asp:Repeater ID="rptRotator" runat="server">
                                <ItemTemplate>
                                    <asp:Image runat="server" id="img" Height="220px" Width="100%" style='<%# iif(Container.ItemIndex>0,"display:none","") %>' />
                                </ItemTemplate>
                        </asp:Repeater>
                            <div class="rrButton rrButtonRight" id="next">&nbsp;</div>
                            <div class="rrButton rrButtonLeft" id="prev" >&nbsp;</div>
                        </div> 
                       
                    </td>   
                </tr>
                <tr style="display:block;">
                    <td style="display:block;"><div runat="server" id="divBudget" class="pnlStats" ><div style="position:relative"><asp:Label runat="server" ID="lblBudgetHeader" meta:resourcekey="lblBudgetHeader"></asp:Label><i class="ellipsis"></i></div><div id="divBudgetBar" style="height:56px;color:#fff;text-align:center;"><asp:Label runat="server" ID="lblBudget" Font-Size="30px" style="line-height: 56px;"></asp:Label></div></div></td>
                </tr>
                <tr style="display:block">
                    <td style="display:block;padding-top:5px">
                        <div runat="server" id="divSchedule" class="pnlStats">
                            <div style="position:relative">
                                <asp:Label runat="server" ID="lblScheduleHeader" meta:resourcekey="lblScheduleHeader"></asp:Label><i class="ellipsis"></i></div>
                            <div id="divScheduleBar" style="height:56px;color:#fff;text-align:center;">
                                <asp:Label runat="server" ID="lblSchedule" Font-Size="30px" style="line-height: 56px;"></asp:Label>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr style="display:block">
                    <td style="display:block;z-index:9999;padding-top:5px">
                        <div runat="server" id="divDocuments" class="pnlStats" >
                            <div style="position:relative">
                                <asp:Label runat="server" ID="lblDocumentsHeader" meta:resourcekey="lblDocumentsHeader"></asp:Label><i class="ellipsis"></i></div>
                            <div id="divDocumentBar" style="height:56px;color:#fff;text-align:center;">
                                <asp:Label runat="server" ID="lblDocument" Font-Size="30px" style="line-height: 56px;"></asp:Label>
                            </div>
                        </div>
                        <div id="lbtViewSpec" style="width:100%;text-align: center;margin-top: 15px;" class="Hide">
                        <asp:LinkButton ID="lbtSpec" runat="server" meta:resourcekey="lblViewSpec" OnClientClick="return showSpecifications()" style="font-size: 15px;color: gray;text-decoration: none;" ></asp:LinkButton>
                        </div>
                            </td>
                </tr>
            </table>
        </div>
        <div class="col-5 marginTop" style="padding-bottom:10px"> 
            <table class="colTable">
                <tr runat="server" ID="pnlNavigatorSection"  >
                    <td>
                        <div style="border: 1px solid #999;margin-top:36px;height:555px;overflow:auto">
                        <telerik:RadAjaxPanel ID="pnlDetailPane"
                            runat="server" Width="100%" ClientEvents-OnResponseEnd="ResponsenavigatorEnd">
                            <asp:Repeater ID="rptModules" runat="server">

                                <ItemTemplate>
                                    <div style="margin-top: 5px;margin-left:10px">
                                        <asp:Image ID="imgToggleModule" Style="cursor: pointer;" runat="server" alt="" ImageUrl="Images/Workflow/wMinus.png" />
                                        <asp:Label runat="server" Style="color: #999999; font-size: 18px" ID="lblModuleName"></asp:Label>
                                    </div>
                                    <asp:Panel runat="server" ID="pnlModuleRecordTypes" Style="margin-left: 10px;" class="moduleToggle" moduleid='<%# CStr(Eval("ModuleId")) %>'>
                                        <asp:Repeater ID="rptModuleRecordTypes" runat="server">
                                            <HeaderTemplate>
                                                <table cellspacing="0" cellpadding="4" style="margin-top: 5px">
                                                    <tr style="color:white;background-color:#999999;font-size:14px">
                                                        <td style="width:100%; font-weight: bold;">
                                                            <asp:Label runat="server" ID="lblRecordTypeTitle" meta:resourceKey="lblRecordTypeTitle" Text="Record Type"></asp:Label></td>
                                                        <td><b>
                                                            <asp:Label runat="server" ID="lblPending"  meta:resourceKey="lblPending" Text="Pending"></asp:Label></b></td>
                                                        <td><b>
                                                            <asp:Label runat="server" ID="lblApproved"  meta:resourceKey="lblApproved" Text="Approved"></asp:Label></b></td>
                                                    </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton style="color:black;font-size:12px" SearchURL='<%# CStr(Eval("SearchURL")) %>' PageURL='<%# Cstr(Eval("PageURL")) %>' ObjectType='<%# Cstr(Eval("ObjectType")) %>' runat="server" ID="btnRecordType" Text='<%# Cstr(Eval("Title")) %>'> </asp:LinkButton></td>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="lblPendingCount" Text='<%#  CInt(Eval("PendingCount")) %>'></asp:Label></td>
                                                    <td align="right">
                                                        <asp:Label runat="server" ID="lblApprovedCount" Text='<%# CInt(Eval("ApprovedCount"))%>'></asp:Label></td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </telerik:RadAjaxPanel>
                     </div>
                        </td>
                    </tr>
                <tr runat="server" ID="pnlCustomFields">
                    <td>
                         <table cellPadding="0" cellSpacing="0"  id="tblSpecifications" style="width:100%;table-layout: fixed;">
                                <tr>
                                    <td class="ProjectCenterSepcs">
                                        <uc1:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
                                    </td>
                                </tr>
                            </table>
                    </td>
                </tr>
                    </table>
        </div>
    </div>
</div>
<asp:HiddenField runat="server" ID="hdnImgCount" />

