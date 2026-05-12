<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Profile.aspx.vb" Inherits="Website.Profile" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
        
@media screen and (min-width: 320px) and (max-width: 843px) {
    .divContentHolder {
        margin-top: 60px;
    }

}

.profileNgFrame {
	height: calc(100vh - 147px); 
	width: calc(100% - 4px); 
	padding: 0px; 
	margin: 0px;
    border: none !important;
  
}

        @media (max-width: 768px) {
            .changePwdOpen {
                position: fixed;
                top: 0px;
                z-index: 9999;
                height: Calc(100vh) !important;
                width: 101%;
            }
        }

    @media screen and (min-width: 320px) and (max-width: 843px) {
        .ngFrame {
            margin-top: 58px !important;
            height: Calc(100vh - 60px) !important;
        }
    }
        
    </style>
    <script type="text/javascript">
        window.addEventListener('message', function (event) {
            var frame = document.getElementById('ctl00_CPH1_ngFrame')

                if (event.data.event_id == "OpenLayoutPopup") {
                    frame.classList.add("changePwdOpen");

                }
     
            });
    </script>

    <iframe runat="server" id="ngFrame" class="profileNgFrame" style="z-index:7000; position:relative; background-color: white"></iframe>


</asp:Content>

