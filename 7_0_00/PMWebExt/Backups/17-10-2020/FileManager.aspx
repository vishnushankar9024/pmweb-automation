<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"  CodeBehind="FileManager.aspx.vb" Inherits="Website.WorkflowFileManager" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
<script type="text/javascript">
        function OnClientItemSelected(sender,args)
        {
            var pvwImage = $get("pvwImage");
            var imageSrc = args.get_path();

            if(imageSrc.match(/\.(gif|jpg|jpeg|bmp)$/gi))
            {
                pvwImage.src = imageSrc;
                pvwImage.style.display = "";
            }
            else
            {
                pvwImage.src = imageSrc;
                pvwImage.style.display = "none";
            }
        }
</script>

<table style="height:99%;width: 99%;" cellpadding="0" cellspacing="0" >
            <tr>
                <td width="80%" height="100%"  style="vertical-align: top;">
                    <telerik:RadFileExplorer runat="server" ID="fleFileExplorer"  Width="100%" Height="650px" DisplayUpFolderItem="true" 
                        OnClientItemSelected="OnClientItemSelected" EnableOpenFile="true"  Skin="Default">
                        <Configuration SearchPatterns="*.*"  ></Configuration>
                    </telerik:RadFileExplorer>
                </td>
                <td width="20%"  class="Center Padding7 Top">
                    <fieldset style="width: 270px; height: 270px">
                        <legend>Preview</legend>
                        <img id="pvwImage" src="" alt="" style="display: none; margin: 10px; width: 250px;
                            height: 225px;" />
                    </fieldset>
                </td>
            </tr>
        </table>
</asp:Content>