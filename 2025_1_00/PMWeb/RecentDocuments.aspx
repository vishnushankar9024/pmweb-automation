<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RecentDocuments.aspx.vb" Inherits="Website.RecentDocuments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Recent Documents</title>
    <style type="text/css">
        /*.RecentGrid {
            min-width: 100%;
        }*/

            .RecentGrid .rgRow > td, .RecentGrid .rgAltRow > td,
            .RecentGrid .rgEditRow > td, .RecentGrid .rgFooter > td {
                border-right: none !important;
                border-left: none !important;
            }

        .RadGrid_Default.RecentGrid th.rgHeader,
        .RadGrid_Default.RecentGrid th.rgResizeCol {
            background: #F2F2F2 !important;
            color: #333333 !important;
            text-align: left !important;
            height: 50px !important;
            border-width: 1px !important;
            border-style: solid !important;
            border-color: rgba(204, 204, 204, 1) !important;
            border-right: 0px !important;
            border-radius: 0px !important;
            border-top-right-radius: 0px !important;
            border-bottom-right-radius: 0px !important;
            text-transform: none !important;
            font-weight: 400;
            font-style: normal;
            font-size: 12px !important;
        }

        .RadGrid .rgRow.rgHoveredRow,
        .RadGrid .rgAltRow.rgHoveredRow {
            background: #ededed !important;
            cursor: pointer;
        }

        .RadGrid_Default .rgHeaderWrapper {
            background: #F2F2F2 !important;
        }

        .RadGrid .rgRow, .RadGrid .rgAltRow {
            background: #FFFFFF !important;
        }

        .RadGrid_Default.RecentGrid .rgHeader.AlignRight, .RadGrid_Default.RecentGrid th.rgResizeCol.AlignRight {
            text-align: right !important;
        }


        .RecentGrid.RadGrid_Default {
            border: 1px solid #cccccc !important;
        }

        .RecentGrid.RadGrid_Default,
        .topBar tbody {
            display: inline-table;
            width: 90% !important;
            margin: 0 0 0 20px;
        }

            .RecentGrid.RadGrid_Default .rgRow a, .RecentGrid.RadGrid_Default .rgAltRow a, .RecentGrid.RadGrid_Default .rgEditRow a {
                /* color: #666666; */
                color: #316888 !important;
                font-size: 13px !important;
                margin-top: -20px;
                display: block;
            }

        .RecentGrid span {
            font-weight: 400;
            font-style: normal;
            font-size: 12px !important;
            color: #555555;
        }

        .CloseButton .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png) !important;
            background-position: -208px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
            margin-right: 8px !important;
            position: absolute;
            right: 0px;
            top: 8px;
            cursor: pointer;
        }

        .RecentGrid .rgDataDiv {
            overflow: auto !important;
            height: auto !important;
        }

        .tdLogo {
            padding-bottom:15px;
        }

        .tdProgramprojectLogin span {
            font-size: 16px !important;
            font-weight: 400 !important;
            font-style: normal;
            color: black !important;
        }

        /*span#lblRecentRecordType:hover {
            font-weight: bold !important;
        }*/

        .topBar {
            width: 100%;
            padding-top: 20px;
            box-sizing: border-box;
            table-layout: fixed;
            margin-bottom: 30px;
            background-color: #fafafa;
            box-shadow: 0px 5px 10px #00000059;
        }

        .rgHeaderDiv {
            margin-right: 0 !important;
        }

        /*.RecentGrid .rgHeader, .RecentGrid th.rgResizeCol, .RecentGrid .rgHeaderWrapper{border-bottom:none !important;}*/
    </style>
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script type="text/javascript">
        function CloseWindow(sender, args) {
            self.close();
        }
        var windowOpener = null;
        $(document).ready(function () {
            $(".lnkPage").click(function () {
                $(parent.document).find("[id=DisableAllControlsOnPostback]").removeClass("Hide");
            })

            window.parent.addEventListener("message", event => {           
                
                if (event.data.event_id == "GoToURL")
                {
                    if (windowOpener == null)
                        windowOpener = window.opener.parent;
                
                    windowOpener.location.href = event.data.recordurl;
                    window.close();
                }
                   
            })
        })

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--<asp:LinkButton runat="server" ID="btnClose" OnClientClick="CloseWindow(); return false;" CssClass="CloseButton">
                <span class="Icon"></span>
            </asp:LinkButton>--%>
    <iframe runat="server" id="ngFrame" style="height: 100vh; width: 100%; padding: 0px; margin: 0px; box-sizing:border-box; border:0;float:left"></iframe>

        </div>
    </form>
</body>
</html>
