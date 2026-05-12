<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Interface.aspx.vb" Inherits="Website._Interface" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnUseDefaultColors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlColors" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUseDefaultLogo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="imgDefaultLogo" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="lblRatioError" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <asp:LinkButton runat="server" ID="btnSave" Text="Save" Style="display: none" OnClick="btnSave_Click" />


    <div class="PMMainPage">
        <div class="row">
            <div class="col-4 col-4-left" style="height:380px;">

                <fieldset style="width: 100% !important">
                    <legend>
                        <label>INTERFACE COLORS</label>
                    </legend>
                    <asp:Panel ID="pnlColors" runat="server">
                        <table class="colTable" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblColor1" Text="Color 1" runat="server"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <div id="divColor1" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                    </div>
                                        <telerik:RadColorPicker ShowIcon="true" ID="rcpColor1" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblColor2" Text="Color 2" runat="server"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <div id="divColor2" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                    </div>
                                          <telerik:RadColorPicker ShowIcon="true" ID="rcpColor2" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblColor3" Text="Color 3" runat="server"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <div id="divColor3" runat="server" class="colorDiv" onclick="OpenPalette(this);">
                                    </div>
                                     <telerik:RadColorPicker ShowIcon="true" ID="rcpColor3" runat="server" OnClientColorChange="HandleColorChanged" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" valign="top">
                                    <asp:LinkButton ID="btnUseDefaultColors" runat="server" CssClass="lnkButton" Style="width: 150px; display: block; height: 30px; line-height: 30px; padding: 0;" OnClick="btnUseDefaultColors_Click">
                                        <%-- style="display:inline-flex !important"--%>
                                        <span runat="server"></span>
                                        <asp:Label ID="lblUseDefault" Text="Use Default" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td></td>
                            </tr>

                        </table>
                    </asp:Panel>

                </fieldset>

                <fieldset style="margin-top: 30px; width: 100% !important">
                    <legend>
                        <label>DEFAULT PROJECT LOGO</label>
                    </legend>
                    <table class="colTable" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left">
                                    <asp:Label ID="lblDefaultLogo" Text="Default Logo" runat="server"></asp:Label>
                                </div>
                                <div style="float: right">
                                    <asp:LinkButton ID="lnkUpload" OnClientClick="return TriggerUpload();" runat="server" CssClass="SearchButton1">
                                                                <span class="Icon"></span>     
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                 <asp:FileUpload ID="fileImageUpload" runat="server" ClientIDMode="Static" Style="display: none;" CssClass="SearchButton1" />
                               
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtFileName" Width="238px" style="padding:0 !important" ClientIDMode="Static"></asp:TextBox>
                                <%--Style="width:236.86px; position:relative;right:1.5px;"--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="padding-top:5px" valign="top">
                                <asp:LinkButton ID="btnUseDefaultLogo" runat="server" CssClass="lnkButton" Style="width: 150px; display: block; height: 30px; line-height: 30px; padding: 0;"
                                    OnClick="btnUseDefaultLogo_Click">
                                    <%--style="display:inline-flex !important"--%>
                                    <span runat="server"></span>
                                    <asp:Label ID="Label1" Text="Use Default" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td style="padding-top:5px" class="controlWidth">
                                  <asp:HiddenField runat="server" ID="hdnLogoFileName" />
                                <asp:Image ID="imgDefaultLogo" Height="80px" ClientIDMode="Static" Width="100%" runat="server" alt="" />
                                <asp:HiddenField ID="hdnError" runat="server" />
                                <%--Style="border: 1px solid #666; height: 80px;position:relative;right:1px; min-width: 100%"--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label runat="server" CssClass="Hide Validator" ID="lblRatioError" Text="The image must be in a 3:1 ratio"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        function UseDefaultLogo() {
            debugger;
            var image = document.getElementById("imgDefaultLogo");
            image.src = "Images/PMWeb-Logo-WHite.png";
            document.getElementById("imgDefaultLogo").style.backgroundColor = currColor;
            document.getElementById("txtFileName").value = "";
            return false;
        }
        function OpenPalette(sender) {
            var id = sender.id;
            var cliendId = id.substring(0, id.lastIndexOf('_')) + "_rcpColor" + id[id.length - 1];
            var colorPicker = $find(cliendId);
            colorPicker.ShowPalette();
        }

        function HandleColorChanged(sender, eventArgs) {
            currColor = sender.get_selectedColor();
            var id = sender.get_id();
            var cliendId = id.substring(0, id.lastIndexOf('_')) + "_divColor" + id[id.length - 1];
            $("#" + cliendId).css("background", currColor);
            if (id == "ctl00_ContentPlaceHolder1_rcpColor1" && document.getElementById("imgDefaultLogo").src.indexOf("PMWeb-Logo-WHite.png") >= 0) {
                document.getElementById("imgDefaultLogo").style.backgroundColor = currColor;
            }
        }

        function TriggerUpload() {
            $("[id$=lblRatioError]")[0].className = "Hide Validator"
            $("#fileImageUpload").click();
            return false;
        }

        $(document).ready(function () {
            $("#fileImageUpload").change(function () {
                    var uploadFile = $(this);
                    $('#' + $('[id$=hdnError]')[0].id).val('');
                    $("#txtFileName").val(uploadFile.val().replace(/^.*\\/, ""));
                    var reader = new FileReader();
                    reader.onloadend = function () {
                        debugger;
                        $("#imgDefaultLogo").attr("src", reader.result);
                    }
                    var file = document.querySelector('input[type=file]').files[0]
                    if (file) {
                        reader.readAsDataURL(file);
                }
            });

        });
        //else {
        //    $("#imgLoginPageImage").attr("src", "");
        //}



    </script>
</asp:Content>
