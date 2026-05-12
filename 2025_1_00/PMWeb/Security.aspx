<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Security.aspx.vb" Inherits="Website.Security" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
        <script language="javascript" type="text/javascript">

            function GetOnlineUsersList() {

                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/GetOnlineUsers",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) { 
                        const data = response.d;
                        $("[id$=ngFrame]")[0].contentWindow.postMessage({
                            event_id: "listDataFetched",
                            detail: data
                        }, '*');
                    },
                    error: function (err) {
                        console.error("Error fetching data:", err);
                    }
                });
            }

            function EndSessions(sessionIds) {
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/EndOnlineUsersSession",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ sessionIds: sessionIds }),
                    dataType: "json",
                    success: function (response) {
                        $("[id$=ngFrame]")[0].contentWindow.postMessage({
                            event_id: "EndedSessions",
                        }, '*');
                    },
                    error: function (err) {
                        console.error("Error Ending Sessions:", err);
                    }
                });
            }

            function ActivityMonitorCount() {
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/CountOnlineUsers",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("[id$=ngFrame]")[0].contentWindow.postMessage({
                            event_id: "CountOnlineUsers",
                            detail: response.d
                        }, '*');
                    },
                    error: function (err) {
                        console.error("Error Ending Sessions:", err);
                    }
                });
            }


            window.addEventListener("message", event => {
                if (event.data.event_id == "OpenActivityMonitorTab") {
                    GetOnlineUsersList();
                }
                if (event.data.event_id == "EndSessions") {
                    var sessionIds = event.data.sessionIds;
                    EndSessions(sessionIds);
                }
                if (event.data.event_id == "CountUsers") {
                    ActivityMonitorCount();
                }
               
            })

        </script>
    
   <iframe runat="server" id="ngFrame"  width="100%" style="width:calc(100%); height:100%;z-index:7000; position:relative; background-color: white;border:0;" frameborder="0"></iframe>

</asp:Content>
