<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UpdateAssetsPopup.aspx.vb" Inherits="Website.UpdateAssetsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>

<body>
    <style type="text/css">
        
        .documentSinglePage {
            margin-top:0px !important;
        }

        body {
            font-family: 'Work Sans';
            margin: 0;
            font-size: 12px;
        }
        .Updated{

            right:24px !important;

        }
    </style>
    <script type="text/javascript">
        function ShowsuccedMessage() {
            var btnOK = document.getElementById("btnOK");            
            if (btnOK.classList.contains('Updated'))
            {              
                this.close();
                return;
            }
            var ldp = $find("<%= ldpLoading.ClientID %>")
            ldp.show('form1');
            var ConfirmUpdateMessage = document.getElementById("lblConfirmupdatemsg");
            var UpdateSucceeded = document.getElementById("lblUpdateSucceeded");
            var UpdatingData = document.getElementById("lblUpdatingData");
            ConfirmUpdateMessage.classList.add("Hide");
            btnOK.classList.add("Hide");
            UpdatingData.classList.remove("Hide");
        }
        function UpdateFinished() {
            var btnCancel = document.getElementById("btnCancel");
            var UpdateSucceeded = document.getElementById("lblUpdateSucceeded");
            var UpdatingData = document.getElementById("lblUpdatingData");
            UpdatingData.classList.add("Hide");
            btnCancel.classList.add("Hide");
            UpdateSucceeded.classList.remove("Hide");
            var ldp = $find("<%= ldpLoading.ClientID %>")
            ldp.hide('form1');
            btnOK.classList.add("Updated");
        }
    </script>
   
    <form id="form1" runat="server">
         <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
    <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true" >
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnOK">
                    <UpdatedControls>
                       <telerik:AjaxUpdatedControl ControlID="btnOK"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
                               <telerik:RadAjaxLoadingPanel ID="ldpLoading"  runat="server" Skin="Default" text="Updating Your Data" BackgroundTransparency="0" Transparency="0" style="margin-top:35px"></telerik:RadAjaxLoadingPanel>

         
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <asp:Label runat="server" ID="lblConfirmupdatemsg" meta:resourcekey="lblConfirmupdatemsg"  Text="If you continue condition data from this record will be copied to all linked assets. This process cannot be undone.</br></br>Do you wish to continue?"></asp:Label>
                    <asp:Label runat="server" ID="lblUpdateSucceeded" meta:resourcekey="lblUpdateSucceeded" Text="Update Succeeded" Class="Hide" style="position: fixed; padding-top: 74px;padding-left: 193px;" ></asp:Label>
                    <asp:Label runat="server" ID="lblUpdatingData" meta:resourcekey="lblUpdatingData" Text="Updating Your Data" Class="Hide" style="position: fixed; padding-top: 100px;padding-left: 210px;" ></asp:Label>

            
            
        </div>

             <div id="divResults" style="text-align: center">
                 <table>
                     <tr>
                         <td>
                          <asp:Button runat="server" ID="btnOK" CssClass="ButtonOK" OnClientClick="ShowsuccedMessage()" meta:resourcekey="btnOK" Style="position: fixed; width: 100px; bottom: 24px; right: 165px" Text="OK" />

                         </td>
                         <td>
           <asp:Button runat="server" ID="btnCancel" CssClass="ButtonCancel" OnClientClick="return CloseRadWnd();" meta:resourcekey="btncancel" style="position:fixed;width:100px;bottom:24px;right:24px" Text="Cancel"/>

                         </td>
                     </tr>
                 </table>
                    </div>
                </div>
            </div>
       
    </form>
</body>
</html>

    <%--     <div style="text-align: center">
           <asp:Button runat="server" ID="btnCancel" CssClass="ButtonCancel" OnClientClick="CloseResultsPopup();return false;" meta:resourcekey="btnOK" style="position:fixed;width:100px;bottom:24px;right:24px"/>

                </div>--%>
                    <%--            <asp:Label runat="server" ID="lblResult"  Style=" font-size: 16px;color: #999999;font-family: 'Work Sans';top: 50%;position: absolute;left: calc(50% - 100px);width: 200px;"></asp:Label>--%>


