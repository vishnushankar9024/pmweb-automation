<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderChart.ascx.vb" Inherits="Website.QueryBuilderChart" %>
<telerik:RadAjaxManagerProxy ID="rajMgn2" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblChart" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdgSeries" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgSeries">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSeries" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="PMMainPage JustifyContent" id="tblChart" runat="server">
    <div class="row paddingLeftMobile" style="padding-top:24px;">
        <div class="col-4 col-4-left">
            <fieldset>
                <legend>
                    <asp:Label ID="lblChart" runat="server" Text="Chart" meta:resourcekey="lblChart"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblWidth" runat="server" Text="Width" meta:resourcekey="lblWidth"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtWidth" MaxLength="9" runat="server" Width="100%" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTitle" runat="server" Text="Title" meta:resourcekey="lblTitle"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtTitle" MaxLength="200" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblSkin" runat="server" Text="Theme" meta:resourcekey="lblSkin"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox runat="server" ID="ddlRadSkins" Skin="Default" Width="100%" Height="280px">
                                <Items>
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Vista.gif" Text="Vista" Value="Vista" meta:resourcekey="ListItem_Vista" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Office2007.gif" Text="Office 2007" Value="Default" meta:resourcekey="ListItem_Office2007" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Outlook.gif" Text="Default" Value="Default" meta:resourcekey="ListItem_Outlook" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Wood.gif" Text="Wood" Value="Wood" meta:resourcekey="ListItem_Wood" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Marble.gif" Text="Marble" Value="Marble" meta:resourcekey="ListItem_Marble" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Inox.gif" Text="Inox" Value="Inox" meta:resourcekey="ListItem_Inox" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Metal.gif" Text="Metal" Value="Metal" meta:resourcekey="ListItem_Metal" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/BlueStripes.gif" Text="BlueStripes" Value="BlueStripes" meta:resourcekey="ListItem_BlueStripes" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/GrayStripes.gif" Text="GrayStripes" Value="GrayStripes" meta:resourcekey="ListItem_GrayStripes" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/GreenStripes.gif" Text="GreenStripes" Value="GreenStripes" meta:resourcekey="ListItem_GreenStripes" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/DeepGray.gif" Text="DeepGray" Value="DeepGray" meta:resourcekey="ListItem_DeepGray" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Gray.gif" Text="Gray" Value="Gray" meta:resourcekey="ListItem_Gray" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/DeepGreen.gif" Text="DeepGreen" Value="DeepGreen" meta:resourcekey="ListItem_DeepGreen" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/DeepRed.gif" Text="DeepRed" Value="DeepRed" meta:resourcekey="ListItem_DeepRed" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Black.gif" Text="Black" Value="Black" meta:resourcekey="ListItem_Black" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/DeepBlue.gif" Text="DeepBlue" Value="DeepBlue" meta:resourcekey="ListItem_DeepBlue" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/LightBrown.gif" Text="LightBrown" Value="LightBrown" meta:resourcekey="ListItem_LightBrown" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Default.gif" Text="Default" Value="Default" meta:resourcekey="ListItem_Default" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Hay.gif" Text="Hay" Value="Hay" meta:resourcekey="ListItem_Hay" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Sunset.gif" Text="Sunset" Value="Sunset" meta:resourcekey="ListItem_Sunset" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/Web20.gif" Text="Web20" Value="Web20" meta:resourcekey="ListItem_Web20" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/WebBlue.gif" Text="WebBlue" Value="WebBlue" meta:resourcekey="ListItem_WebBlue" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/LightGreen.gif" Text="LightGreen" Value="LightGreen" meta:resourcekey="ListItem_LightGreen" />
                                    <telerik:RadComboBoxItem ImageUrl="Images/Charts/LightBlue.gif" Text="LightBlue" Value="LightBlue" meta:resourcekey="ListItem_LightBlue" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblHeight" runat="server" Text="Height" meta:resourcekey="lblHeight"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtHeight" MaxLength="9" runat="server" Width="100%" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblMarker" runat="server" Text="Marker" meta:resourcekey="lblMarker"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlMarker" runat="server" Width="100%">
                                <Items>
                                    
                                    <telerik:RadComboBoxItem Text="Circle" Value="Circle" meta:resourcekey="ListItem_Marker_Circle" />
                                    <telerik:RadComboBoxItem Text="Diamond" Value="Diamond" meta:resourcekey="ListItem_Marker_Diamond" />
                                    <telerik:RadComboBoxItem Text="Ellipse" Value="Ellipse" meta:resourcekey="ListItem_Marker_Ellipse" />
                                    <telerik:RadComboBoxItem Text="Cross" Value="Cross" meta:resourcekey="ListItem_Marker_Cross" />
                                    <telerik:RadComboBoxItem Text="Rectangle" Value="Rectangle" meta:resourcekey="ListItem_Marker_Rectangle" />
                                    <telerik:RadComboBoxItem Text="Triangle" Value="Triangle" meta:resourcekey="ListItem_Marker_Triangle" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLegendVisible" runat="server" Text="Legend Visible"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkLegendVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblVisible" runat="server" Text="Visible" Style="float: left"></asp:Label>

                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTitleVisible" runat="server" Text="Title Visible"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkTitleVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblSeriesOrientation" runat="server" Text="Orientation" meta:resourcekey="lblSeriesOrientation"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlOrienation" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Vertical" Value="0" meta:resourcekey="ListItem_Vertical" />
                                    <telerik:RadComboBoxItem Text="Horizontal" Value="1" meta:resourcekey="ListItem_Horizontal" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTitleAlignment" runat="server" Text="Title Alignment" meta:resourcekey="lblTitleAlignment"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlTitleAlignment" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Center" Value="32" meta:resourcekey="ListItem_Alignment_Center" />
                                    <telerik:RadComboBoxItem Text="Left" Value="16" meta:resourcekey="ListItem_Alignment_Left" />
                                    <telerik:RadComboBoxItem Text="Right" Value="64" meta:resourcekey="ListItem_Alignment_Right" />
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_Alignment_None" />
                                    <telerik:RadComboBoxItem Text="Bottom" Value="512" meta:resourcekey="ListItem_Alignment_Bottom" />
                                    <telerik:RadComboBoxItem Text="Bottom Left" Value="256" meta:resourcekey="ListItem_Alignment_BottomLeft" />
                                    <telerik:RadComboBoxItem Text="Bottom Right" Value="1024" meta:resourcekey="ListItem_Alignment_BottomRight" />
                                    <telerik:RadComboBoxItem Text="Top" Value="2" meta:resourcekey="ListItem_Alignment_Top" />
                                    <telerik:RadComboBoxItem Text="Top Left" Value="1" meta:resourcekey="ListItem_Alignment_TopLeft" />
                                    <telerik:RadComboBoxItem Text="Top Right" Value="4" meta:resourcekey="ListItem_Alignment_TopRight" />
                                    <telerik:RadComboBoxItem />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLegendAlignment" runat="server" Text="Legend Alignment" meta:resourcekey="lblLegendAlignment"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlLegendAlignment" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Center" Value="32" meta:resourcekey="ListItem_Alignment_Center" />
                                    <telerik:RadComboBoxItem Text="Left" Value="16" meta:resourcekey="ListItem_Alignment_Left" />
                                    <telerik:RadComboBoxItem Text="Right" Value="64" meta:resourcekey="ListItem_Alignment_Right" />
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_Alignment_None" />
                                    <telerik:RadComboBoxItem Text="Bottom" Value="512" meta:resourcekey="ListItem_Alignment_Bottom" />
                                    <telerik:RadComboBoxItem Text="Bottom Left" Value="256" meta:resourcekey="ListItem_Alignment_BottomLeft" />
                                    <telerik:RadComboBoxItem Text="Bottom Right" Value="1024" meta:resourcekey="ListItem_Alignment_BottomRight" />
                                    <telerik:RadComboBoxItem Text="Top" Value="2" meta:resourcekey="ListItem_Alignment_Top" />
                                    <telerik:RadComboBoxItem Text="Top Left" Value="1" meta:resourcekey="ListItem_Alignment_TopLeft" />
                                    <telerik:RadComboBoxItem Text="Top Right" Value="4" meta:resourcekey="ListItem_Alignment_TopRight" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="padding-top:24px">
                <legend>
                    <asp:Label ID="lblXAxis" runat="server" Text="X Axis" meta:resourcekey="lblXAxis"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXAlignment" runat="server" Text="Alignment" meta:resourcekey="lblXAlignment"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlXAlignment" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Center" Value="32" meta:resourcekey="ListItem_Alignment_Center" />
                                    <telerik:RadComboBoxItem Text="Left" Value="16" meta:resourcekey="ListItem_Alignment_Left" />
                                    <telerik:RadComboBoxItem Text="Right" Value="64" meta:resourcekey="ListItem_Alignment_Right" />
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_Alignment_None" />
                                    <telerik:RadComboBoxItem Text="Bottom" Value="512" meta:resourcekey="ListItem_Alignment_Bottom" />
                                    <telerik:RadComboBoxItem Text="Bottom Left" Value="256" meta:resourcekey="ListItem_Alignment_BottomLeft" />
                                    <telerik:RadComboBoxItem Text="Bottom Right" Value="1024" meta:resourcekey="ListItem_Alignment_BottomRight" />
                                    <telerik:RadComboBoxItem Text="Top" Value="2" meta:resourcekey="ListItem_Alignment_Top" />
                                    <telerik:RadComboBoxItem Text="Top Left" Value="1" meta:resourcekey="ListItem_Alignment_TopLeft" />
                                    <telerik:RadComboBoxItem Text="Top Right" Value="4" meta:resourcekey="ListItem_Alignment_TopRight" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXValueFormat" runat="server" Text="Value Format" meta:resourcekey="lblXValueFormat"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlXValueFormat" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_ValueFormat_None" />
                                    <telerik:RadComboBoxItem Text="Currency" Value="1" meta:resourcekey="ListItem_ValueFormat_Currency" />
                                    <telerik:RadComboBoxItem Text="General" Value="3" meta:resourcekey="ListItem_ValueFormat_General" />
                                    <telerik:RadComboBoxItem Text="Long Date" Value="8" meta:resourcekey="ListItem_ValueFormat_LongDate" />
                                    <telerik:RadComboBoxItem Text="Long Time" Value="9" meta:resourcekey="ListItem_ValueFormat_LongTime" />
                                    <telerik:RadComboBoxItem Text="Number" Value="4" meta:resourcekey="ListItem_ValueFormat_Number" />
                                    <telerik:RadComboBoxItem Text="Percent" Value="5" meta:resourcekey="ListItem_ValueFormat_Percent" />
                                    <telerik:RadComboBoxItem Text="Scientific" Value="2" meta:resourcekey="ListItem_ValueFormat_Scientific" />
                                    <telerik:RadComboBoxItem Text="Short Date" Value="6" meta:resourcekey="ListItem_ValueFormat_ShortDate" />
                                    <telerik:RadComboBoxItem Text="Short Time" Value="7" meta:resourcekey="ListItem_ValueFormat_ShortTime" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXTitle" runat="server" Text="Title" meta:resourcekey="lblXTitle"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtXTitle" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXVisibleValues" runat="server" Text="Visible Values" meta:resourcekey="lblXVisibleValues"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlXVisibleValues" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="All" Value="0" meta:resourcekey="ListItem_VisibleValues_All" />
                                    <telerik:RadComboBoxItem Text="Positive" Value="1" meta:resourcekey="ListItem_VisibleValues_Positive" />
                                    <telerik:RadComboBoxItem Text="Negative" Value="2" meta:resourcekey="ListItem_VisibleValues_Negative" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXLabelDataColumn" runat="server" Text="Label Data Column" meta:resourcekey="lblXLabelDataColumn"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlXLabelDataColumn" runat="server" Width="100%"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblVisible2" runat="server" Text="Visible"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkXVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowTicks" runat="server" Text="Show Ticks"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkXShowTicks" runat="server" />

                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowLabels" runat="server" Text="Show Labels"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkXShowLabels" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblXRotation" runat="server" Text="Rotation" meta:resourcekey="lblXRotation"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtXRotation" MaxLength="3" runat="server" Width="100%" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <fieldset>
                <legend>
                    <asp:Label ID="lblYAxis" runat="server" Text="Y Axis" meta:resourcekey="lblYAxis"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblYAlignment" runat="server" Text="Alignment" meta:resourcekey="lblYAlignment"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlYAlignment" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Center" Value="32" meta:resourcekey="ListItem_Alignment_Center" />
                                    <telerik:RadComboBoxItem Text="Left" Value="16" meta:resourcekey="ListItem_Alignment_Left" />
                                    <telerik:RadComboBoxItem Text="Right" Value="64" meta:resourcekey="ListItem_Alignment_Right" />
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_Alignment_None" />
                                    <telerik:RadComboBoxItem Text="Bottom" Value="512" meta:resourcekey="ListItem_Alignment_Bottom" />
                                    <telerik:RadComboBoxItem Text="Bottom Left" Value="256" meta:resourcekey="ListItem_Alignment_BottomLeft" />
                                    <telerik:RadComboBoxItem Text="Bottom Right" Value="1024" meta:resourcekey="ListItem_Alignment_BottomRight" />
                                    <telerik:RadComboBoxItem Text="Top" Value="2" meta:resourcekey="ListItem_Alignment_Top" />
                                    <telerik:RadComboBoxItem Text="Top Left" Value="1" meta:resourcekey="ListItem_Alignment_TopLeft" />
                                    <telerik:RadComboBoxItem Text="Top Right" Value="4" meta:resourcekey="ListItem_Alignment_TopRight" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblYValueFormat" runat="server" Text="Value Format" meta:resourcekey="lblYValueFormat"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlYValueFormat" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_ValueFormat_None" />
                                    <telerik:RadComboBoxItem Text="Currency" Value="1" meta:resourcekey="ListItem_ValueFormat_Currency" />
                                    <telerik:RadComboBoxItem Text="General" Value="3" meta:resourcekey="ListItem_ValueFormat_General" />
                                    <telerik:RadComboBoxItem Text="Long Date" Value="8" meta:resourcekey="ListItem_ValueFormat_LongDate" />
                                    <telerik:RadComboBoxItem Text="Long Time" Value="9" meta:resourcekey="ListItem_ValueFormat_LongTime" />
                                    <telerik:RadComboBoxItem Text="Number" Value="4" meta:resourcekey="ListItem_ValueFormat_Number" />
                                    <telerik:RadComboBoxItem Text="Percent" Value="5" meta:resourcekey="ListItem_ValueFormat_Percent" />
                                    <telerik:RadComboBoxItem Text="Scientific" Value="2" meta:resourcekey="ListItem_ValueFormat_Scientific" />
                                    <telerik:RadComboBoxItem Text="Short Date" Value="6" meta:resourcekey="ListItem_ValueFormat_ShortDate" />
                                    <telerik:RadComboBoxItem Text="Short Time" Value="7" meta:resourcekey="ListItem_ValueFormat_ShortTime" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblYTitle" runat="server" Text="Title" meta:resourcekey="lblYTitle"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtYTitle" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblYVisibleValues" runat="server" Text="Visible Values" meta:resourcekey="lblYVisibleValues"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlYVisibleValues" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="All" Value="0" meta:resourcekey="ListItem_VisibleValues_All" />
                                    <telerik:RadComboBoxItem Text="Positive" Value="1" meta:resourcekey="ListItem_VisibleValues_Positive" />
                                    <telerik:RadComboBoxItem Text="Negative" Value="2" meta:resourcekey="ListItem_VisibleValues_Negative" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblYRotation" runat="server" Text="Rotation" meta:resourcekey="lblYRotation"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtYRotation" MaxLength="3" runat="server" Width="100%" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblVisible3" runat="server" Text="Visible"></asp:Label>

                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkYVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowTicks2" runat="server" Text="Show Ticks"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkYShowTicks" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowLabels2" runat="server" Text="Show Labels"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkYShowLabels" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="padding-top:24px">
                <legend>
                    <asp:Label ID="lblY2Axis" runat="server" Text="Y2 Axis" meta:resourcekey="lblY2Axis"></asp:Label>
                </legend>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblY2Alignment" runat="server" Text="Alignment" meta:resourcekey="lblY2Alignment"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlY2Alignment" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Center" Value="32" meta:resourcekey="ListItem_Alignment_Center" />
                                    <telerik:RadComboBoxItem Text="Left" Value="16" meta:resourcekey="ListItem_Alignment_Left" />
                                    <telerik:RadComboBoxItem Text="Right" Value="64" meta:resourcekey="ListItem_Alignment_Right" />
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_Alignment_None" />
                                    <telerik:RadComboBoxItem Text="Bottom" Value="512" meta:resourcekey="ListItem_Alignment_Bottom" />
                                    <telerik:RadComboBoxItem Text="Bottom Left" Value="256" meta:resourcekey="ListItem_Alignment_BottomLeft" />
                                    <telerik:RadComboBoxItem Text="Bottom Right" Value="1024" meta:resourcekey="ListItem_Alignment_BottomRight" />
                                    <telerik:RadComboBoxItem Text="Top" Value="2" meta:resourcekey="ListItem_Alignment_Top" />
                                    <telerik:RadComboBoxItem Text="Top Left" Value="1" meta:resourcekey="ListItem_Alignment_TopLeft" />
                                    <telerik:RadComboBoxItem Text="Top Right" Value="4" meta:resourcekey="ListItem_Alignment_TopRight" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblY2ValueFormat" runat="server" Text="Value Format" meta:resourcekey="lblY2ValueFormat"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlY2ValueFormat" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_ValueFormat_None" />
                                    <telerik:RadComboBoxItem Text="Currency" Value="1" meta:resourcekey="ListItem_ValueFormat_Currency" />
                                    <telerik:RadComboBoxItem Text="General" Value="3" meta:resourcekey="ListItem_ValueFormat_General" />
                                    <telerik:RadComboBoxItem Text="Long Date" Value="8" meta:resourcekey="ListItem_ValueFormat_LongDate" />
                                    <telerik:RadComboBoxItem Text="Long Time" Value="9" meta:resourcekey="ListItem_ValueFormat_LongTime" />
                                    <telerik:RadComboBoxItem Text="Number" Value="4" meta:resourcekey="ListItem_ValueFormat_Number" />
                                    <telerik:RadComboBoxItem Text="Percent" Value="5" meta:resourcekey="ListItem_ValueFormat_Percent" />
                                    <telerik:RadComboBoxItem Text="Scientific" Value="2" meta:resourcekey="ListItem_ValueFormat_Scientific" />
                                    <telerik:RadComboBoxItem Text="Short Date" Value="6" meta:resourcekey="ListItem_ValueFormat_ShortDate" />
                                    <telerik:RadComboBoxItem Text="Short Time" Value="7" meta:resourcekey="ListItem_ValueFormat_ShortTime" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblY2Title" runat="server" Text="Title" meta:resourcekey="lblY2Title"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtY2Title" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblY2VisibleValues" runat="server" Text="Visible Values" meta:resourcekey="lblY2VisibleValues"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <telerik:RadComboBox ID="ddlY2VisibleValues" runat="server" Width="100%">
                                <Items>
                                    <telerik:RadComboBoxItem Text="All" Value="0" meta:resourcekey="ListItem_VisibleValues_All" />
                                    <telerik:RadComboBoxItem Text="Positive" Value="1" meta:resourcekey="ListItem_VisibleValues_Positive" />
                                    <telerik:RadComboBoxItem Text="Negative" Value="2" meta:resourcekey="ListItem_VisibleValues_Negative" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                      <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblVisible4" runat="server" Text="Visible"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkY2Visible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowTicks3" runat="server" Text="Show Ticks"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkY2ShowTicks" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowLabels3" runat="server" Text="Show Labels"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:CheckBox ID="chkY2ShowLabels" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblY2Rotation" runat="server" Text="Rotation" meta:resourcekey="lblY2Rotation"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtY2Rotation" MaxLength="3" runat="server" Width="100%" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width:100%;text-align:center;">
                            <asp:Button ID="btnSave" runat="server" Text="Save" meta:resourcekey="btnSave" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <fieldset>
                <legend>
                    <asp:Label ID="lblSeries" runat="server" Text="Series" meta:resourcekey="lblSeries"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgSeries" runat="server" UseEditFormInMobile="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="5" ShowFooter="false" AppendMenus="True"
                    AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSeriesion="True"
                    AllowSorting="True" GridLines="None">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                                <ItemTemplate>
                                    <%#Eval("Name")%>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="ChartTypeId">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblChartType"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox runat="server" ID="ddlChartTypes" Skin="Default" DropDownWidth="220px" Width="95%" OnClientLoad="OnClientLoadHandler" OnClientSelectedIndexChanged="OnClientSelectedIndexChanged" Height="250px">
                                        <Items>
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Bar.png" Text="Bar" Value="1" meta:resourcekey="ListItem_Bar" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Line.png" Text="Line" Value="4" meta:resourcekey="ListItem_Line" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Pie.png" Text="Pie" Value="8" meta:resourcekey="ListItem_Pie" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Area.png" Text="Area" Value="5" meta:resourcekey="ListItem_Area" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/BezierLine.png" Text="Bezier" Value="10" meta:resourcekey="ListItem_Bezier" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Bubble.png" Text="Bubble" Value="12" meta:resourcekey="ListItem_Bubble" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/Gant.png" Text="Gantt" Value="9" meta:resourcekey="ListItem_Gantt" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/point.png" Text="Point" Value="13" meta:resourcekey="ListItem_Point" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/splineArea.png" Text="SplineArea" Value="14" meta:resourcekey="ListItem_SplineArea" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/splineLine.png" Text="Spline" Value="11" meta:resourcekey="ListItem_Spline" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedArea.png" Text="StackedArea" Value="6" meta:resourcekey="ListItem_StackedArea" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedArea100.png" Text="StackedArea100" Value="7" meta:resourcekey="ListItem_StackedArea100" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedBar.png" Text="StackedBar" Value="2" meta:resourcekey="ListItem_StackedBar" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedBar100.png" Text="StackedBar100" Value="3" meta:resourcekey="ListItem_StackedBar100" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedLine.png" Text="StackedLine" Value="18" meta:resourcekey="ListItem_StackedLine" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedSplineArea.png" Text="StackedSplineArea" Value="15" meta:resourcekey="ListItem_StackedSplineArea" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedSplineArea100.png" Text="StackedSplineArea100" Value="16" meta:resourcekey="ListItem_StackedSplineArea100" />
                                            <telerik:RadComboBoxItem ImageUrl="Images/Charts/StackedSplineLine.png" Text="StackedSpline" Value="20" meta:resourcekey="ListItem_StackedSpline" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="X Field" UniqueName="XField">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblXField"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlXField" runat="server" Width="100%"></telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Y Field" UniqueName="YField">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblYField"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlYField" runat="server" Width="100%" />
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="X2 Field" UniqueName="X2Field">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblX2Field"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlX2Field" runat="server" Width="95%"></telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Y2 Field" UniqueName="Y2Field">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblY2Field"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlY2Field" runat="server" Width="100%"></telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Y Axis Type" UniqueName="YAxisTypeId">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblYAxisType"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlYAxisTypes" runat="server" Width="100%">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="Primary" Value="0" meta:resourcekey="ListItem_YAxisType_Primary" />
                                            <telerik:RadComboBoxItem Text="Secondary" Value="1" meta:resourcekey="ListItem_YAxisType_Secondary" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Label Field" UniqueName="LabelsField">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblLabelsField"></asp:Label>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlLabelsField" runat="server" Width="100%"></telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Labels Rotation Angle" UniqueName="LabelRotationAngle">
                                <ItemTemplate>
                                    <%#Eval("LabelRotationAngle")%>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLabelRotationAngle" runat="server" Text='<%# Eval("LabelRotationAngle") %>' Width="100%" CssClass="Integer" MaxLength="3"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Visible Labels" UniqueName="LabelVisible">
                                <ItemTemplate>
                                    <span>
                                        <img alt="" src='<%#IIf(Container.DataItem("LabelVisible"), "Images/Global/checked.png", "Images/Global/unchecked.png")%>' /></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkLabelVisible" runat="server" Checked=' <%# IIf(Eval("LabelVisible") Is System.DBNull.Value, False, Eval("LabelVisible")) %>' />
                                </EditItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgSeries.EditIndexes.Count = 0 And (Not rdgSeries.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSeries.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add"
                                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgSeries.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSeries.EditIndexes.Count > 0 Or rdgSeries.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgSeries.EditIndexes.Count = 0 And (Not rdgSeries.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                    OnClientClick="return ConfirmDelete()" Visible='<%# rdgSeries.EditIndexes.Count = 0 And (Not rdgSeries.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgSeries.EditIndexes.Count = 0 And (Not rdgSeries.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="false" AllowColumnsReorder="false"
                        AllowDragToGroup="false" AllowRowsDragDrop="false">
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="False" />
                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                    </ClientSettings>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
</div>
