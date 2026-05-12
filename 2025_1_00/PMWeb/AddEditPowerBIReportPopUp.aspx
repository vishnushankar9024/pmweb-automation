<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddEditPowerBIReportPopUp.aspx.vb" Inherits="Website.AddEditPowerBIReportPopUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <style type="text/css">
        @media only screen and (min-width: 1281px) {
            .RadScheduler .rsYearView .rsYearMonthWrap {
                width: 16.66667%;
            }
        }

        @media only screen and (min-width: 1025px) and (max-width: 1280px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }

        @media only screen and (min-width: 769px) and (max-width: 1024px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }

        @media only screen and (min-width: 361px) and (max-width: 768px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }

          .ProfileTitle {
                color: #a5a5a5 !important;
                position: fixed;
                top: 10px !important;
                width: 100%;
                font-size: 15px !important;
                padding: 20px 0px 5px 16px;
                background-color: white;
                z-index: 1000;
            }
          /*
            .closepopup div {
                background-image: url('CSS/Images/ResponsiveIcons/CloseButton.png') !important;
                background-repeat: no-repeat;
                background-position: 0 0 !important;
                display: inline-block;
                position: absolute;
                right: 16px !important;
                bottom: 1px;
            }*/
            .CloseProfilePopup{
                margin-left:0px !important;
            }

          
              .RadToolBar .rtbOuter {
                background-color: white !important;
            }

            .documentSinglePage {
                margin-top: 100px !important;
            }
            
            .ToolBar {
                border-bottom: 1px solid RGB(237,237,237);
            }


    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">

            function detailClick_handler(sender, args) {
                var value = args.get_item().get_commandName();
                if (value == "Delete") {
                    result = confirm(Msg_ConfirmDeleteReport);
                    if (!result) {
                        args.set_cancel(true)
                    }
                    
                }
            }

            function Upload() {

                var upload = document.querySelector('.Upload');
                upload.click();
                return false;
            }

            function LoadImage(FileUpload) {
                if (FileUpload.files) {
                    var btnlogo = document.querySelector(".UploadImage");
                    btnlogo.style.visibility = 'visible';
                    var btnclearimage = document.querySelector(".btnclearimage");
                    btnclearimage.style.visibility = 'visible';
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var result = e.target.result;
                        document.querySelector('.UploadImage').src = result;
                    }
                    reader.readAsDataURL(FileUpload.files[0]);

                }


                return false;
            }
         
        </script>
            <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpReportManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <div class="ProfileTitle">
            <asp:Label runat="server" ID="BITitle" meta:ResourceKey="PBITitle"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar"  style="width: 100%; margin-top: 50px; background-color: transparent !important" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%"  EnableViewState="true" OnClientButtonClicking="detailClick_handler"  >
                          <Items>
                            <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" CssClass="ToolbarSave"></telerik:RadToolBarButton>
                        </Items>
                        <Items>
                            <telerik:RadToolBarButton CommandName="SaveExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"></telerik:RadToolBarButton>
                        </Items>
                        <Items>
                            <telerik:RadToolBarButton CommandName="Delete" EnableImageSprite="true" CssClass="ToolbarDelete" Enabled="false" ></telerik:RadToolBarButton>
                        </Items>
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr> 
        </table>
        <div class="PMMainPage documentSinglePage" id="test">
            <div class="row ">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUrl" runat="server"  meta:ResourceKey="lbUrl" ></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtURL" Text="http://app.powerbi.com/MyMicrosoftPowerBI ReportURL" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                             <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" runat="server"  meta:Resourcekey="lblName" ></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:50px!important">
                                <asp:TextBox ID="txtName" Text="Power BI Report" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                          <tr>
                                        <td style="vertical-align: top;" class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server" Text="Image"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton CssClass="SearchButton" Style="cursor: pointer" runat="server" ID="btnUpload" OnClientClick="return Upload();">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>

                                            <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right;">
                                                <asp:Button ID="btnClearImage" runat="server" Style="background-color: unset !important" CssClass="btnclearimage" />
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div>
                                                <asp:Image ID="imglogo" ImageUrl="Images/Global/WhiteDot.gif" runat="server" CssClass="UploadImage" Style="height: 80px; width: 240px" />
                                            </div>
                                            <div style="display: none">
                                                <asp:FileUpload ID="FileToUpload" ClientIDMode="Static" onchange="LoadImage(this)" runat="server" Width="240px" CssClass="Upload" />
                                            </div>
                                        </td>
                                    </tr>
                      
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>