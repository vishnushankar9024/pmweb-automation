<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ItemDetails.ascx.vb"
    Inherits="Website.ItemDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rtrImages">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="imagePreview" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpItemDetail" runat="server" Skin="Default" /> 
<div class="PMMainPage JustifyContent">
    <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable">
                
            </table>
            <table class="coltable">

            </table>
        </div>
        <div class="col-4 col-4-middle">
            <table class="colTable">
       
            </table>
            <table class="coltable">
            
               
            </table>
        </div>
        <div class="col-4 col-4-right">
            <table class="colTable">
         
            </table>

            <table class="colTable">
        
            </table>
        </div>
    </div>
</div>

