<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BlueBeamLoginPopup.aspx.vb" Inherits="Website.BlueBeamLoginPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <%--<script type="text/javascript">

            $(document).ready(function () {

                var strToken = window.location.hash.substr(1);
                $.ajax({
                    type: "POST",
                    url: "BlueBeamLoginPopup.aspx/GetBlueBeamToken",
                    contentType: "application/json; charset=utf-8",
                    data: "{'strToken':'" + strToken + "'}",
                    dataType: "json",
                    async: false,
                    success: function (response) {
                        if (response.d.length > 0) {
                            if (response.d.indexOf('BluebeamMarkups') > 0) {
                                window.document.location.href = '<%= PM.BluebeamMarkupsInfo.TokenReceivedRedirect%>';;
                            }
                            else {
                            window.location.href = response.d;
                            }
                            // redirect = true;
                        } else {
                            //redirect = false;
                        }
                    }

                   
                });

                //window.onbeforeunload = function () {
                //    if (window.opener.location.href.indexOf('BluebeamMarkups.aspx') > -1)
                //    {
                //        window.opener.location.href = window.opener.location.href;
                //    }
                //}

            });
            </script>--%>

    </telerik:RadCodeBlock>
    </form>
</body>
</html>
