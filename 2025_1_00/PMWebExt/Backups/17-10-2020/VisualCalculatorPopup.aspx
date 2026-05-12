<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="VisualCalculatorPopup.aspx.vb" Inherits="Website.VisualCalculatorPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <link href="CSS/Ribbon.css" rel="stylesheet" type="text/css" />
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgMeasures">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgMeasures" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <script src="JS/Redlining/wz_jsgraphics.js" type="text/javascript"></script>
        <script src="JS/Redlining/Redlining.js" type="text/javascript"></script>
        <script src="JS/raphael-min.js" type="text/javascript"></script>
        <script src="JS/Redlining/raphael.free_transform.js" type="text/javascript"></script>
        <script src="JS/Redlining/Raphael.inlineTextEditing.js"></script>
        <script type="text/javascript">
            function replaceChar() {
                for (var i = 0; i < arrMeasures.length; i++) {
                    var arrText = arrMeasures[i].CENTROID.split('@!~');
                    var ObjText = arrText[0];
                    for (var j = 1; j < arrText.length; j++) {
                        ObjText = ObjText + String.fromCharCode(10) + arrText[j];
                    }
                    for (var q = 0; q < ObjText.split('@~#').length; q++) {
                        ObjText = ObjText.replace("@~#", "'");
                    }
                    arrMeasures[i].CENTROID = ObjText.replace("@~#", "'");
                }
            }

            function CloseCalculationPopup() {
                var Gross = CDbl($("input[id$=txtCross]").val());
                var Rentable = CDbl($("input[id$=txtRentable]").val());
                var Usable = CDbl($("input[id$=txtUsable]").val());
                if (Usable < 0)
                    Usable = 0;
                if (Rentable < 0)
                    Rentable = 0;
                if (Gross < 0)
                    Gross = 0;
                window.parent.VisualCalculator(Gross, Rentable, Usable);
                CloseRadWnd();
            }
            function pageLoad() {
                $('input[id$=txtCross]').change(function (sender) {
                    CalculateText();

                });
                $('input[id$=txtShaft]').change(function (sender) {

                    CalculateText();
                });
                $('input[id$=txtCommonAreas]').change(function (sender) {
                    $("input[id$=txtUsable]").val(FPrec(CDbl($("input[id$=txtRentable]").val()) - CDbl($("input[id$=txtCommonAreas]").val())));
                });
                $('input[id$=txtRentable]').change(function (sender) {
                    $("input[id$=txtUsable]").val(FPrec(CDbl($("input[id$=txtRentable]").val()) - CDbl($("input[id$=txtCommonAreas]").val())));
                });
            }
            function CalculateText() {
                var Gross = CDbl($("input[id$=txtCross]").val());
                var Shaft = CDbl($("input[id$=txtShaft]").val());
                var CommonArea = CDbl($("input[id$=txtCommonAreas]").val());
                var Rentable = Gross - Shaft;
                $("input[id$=txtRentable]").val(FPrec(Rentable));
                $("input[id$=txtUsable]").val(FPrec(CDbl(Rentable) - CDbl(CommonArea)));

            }
            function Main_GetValueToReturn(combobox, eventArgs) {
                if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
                    eventArgs.set_cancel(true);
                } else {
                    eventArgs.set_cancel(false);
                }
                var SelectedValue;
                var ddlProjects = $find('ddlLocations');
                SelectedValue = 0;
                if (ddlProjects.get_value() != "") { SelectedValue = ddlProjects.get_value(); }
                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;
            }

            function Main_ResetCombos(combobox, eventArgs) {
                var ddlAnnotations = $find('ddlAnnotations');
                ddlAnnotations.clearItems();
                ddlAnnotations.set_text("");
                ddlAnnotations.set_value("0");
            }


            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }

            function ClientDroped(sender, args) {
                var Tag = args.get_htmlElement();
                while (Tag) {
                    if (Tag.id == 'rlbGross' || Tag.id == 'rlbShaft' || Tag.id == 'rlbCommonAreas') {
                        var itemValue = Tag.id;
                        for (var i = 0; i < args.get_sourceItems().length; i++)
                            itemValue = itemValue + ',' + args.get_sourceItems()[i].get_value();

                        var updatePanel = $find('pnlCalculator')
                        updatePanel.ajaxRequest(itemValue);
                        return;
                    }
                    Tag = Tag.parentNode;


                }
                args.set_cancel(true);
            }

            function mainToolBar_clicked(sender, args) {
                debugger;
                var value = args.get_item().get_commandName();
                if (value === 'Close') {
                    var window = GetRadWnd();
                    window.close();
                }

            }
                
        </script>

        <style type="text/css">
            svg {
                position: absolute !important;
                top: 0 !important;
                left: 0 !important;
            }

            #Canvas > div {
                position: absolute !important;
                z-index: 10;
            }
            @media screen and (max-width:900px){
                .ddlMobile{
                    width:100% !important;
                }
                .paddingLeftMobile{
                    padding-left:10px !important;
                    width:27%;
                }
                .paddingRightMobile{
                    padding-right:10px !important;
                }
                .MobileWidth{
                    width:100%;
                }
                
            }
            @media screen and (max-width:900px) and (min-width:452px){
                .MobileTableWidth{
                    width:calc(100vw - 67px) !important;
                }
            }
            @media screen and (max-width:452px){
                 .MobileTableWidth{
                    width:400px !important;
                }
            }
        </style>

        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="mainToolBar_clicked">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td class="ToolbarTd MobileWidth HideOnMobileToolbar" style="padding-left: 0 !important;width:100%">
                    <table style="min-width: 320px; max-width: 700px;" cellpadding="5" cellspacing="0" class="MobileWidth">
                        <tr class="Toolbar">
                            <td style="padding-right: 111px;" class="paddingRightMobile">
                                <asp:Label ID="lblProject" runat="server" Text="Location" meta:resourcekey="lblProject"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlLocations" runat="server" Width="200px" Skin="Vista" EmptyMessage="Select Location..."
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="200px" CssClass="ddlMobile"
                                    NoWrap="True" EnableLoadOnDemand="True" AllowCustomText="true" OnClientSelectedIndexChanged="Main_ResetCombos"
                                    ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" meta:resourcekey="ddlLocations">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                            <td style="padding-left: 20px;">
                                <asp:Label ID="lblDrawing" runat="server" Text="Drawing" meta:resourcekey="lblDrawing"></asp:Label>
                            </td>
                            <td style="padding-left: 111px;" class="paddingLeftMobile">
                                <telerik:RadComboBox ID="ddlAnnotations" runat="server"
                                    Skin="Vista" CloseDropDownOnBlur="true"
                                    EmptyMessage="Choose a Drawing..." Width="200px" AutoPostBack="True" NoWrap="true" CssClass="ddlMobile"
                                    CausesValidation="False" Height="200px" meta:resourcekey="ddlAnnotations" EnableItemCaching="false"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" AllowCustomText="False" EnableVirtualScrolling="True"
                                    OnClientItemsRequesting="Main_GetValueToReturn" OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMMainPage ">
                        <div class="row documentSinglePage row-8-4">
                            <div class="col-4 ">

                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblMeasurments" runat="server" Text="Measurments (Drag to Visual Calculator)" meta:resourcekey="lblMeasurments"></asp:Label></legend>
                                    <div style="width: 100%; overflow: auto;">
                                        <telerik:RadListBox ID="rblMeasurment" OnClientDropping="ClientDroped"
                                            runat="server" Width="100%" Height="483px" Skin="Default"
                                            SelectionMode="Multiple" AllowTransfer="false"
                                            AllowReorder="False" EnableDragAndDrop="True" DataKeyField="Id">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <div style="width: 7px; background-color: <%#Eval("Color")%>">&nbsp;&nbsp;</div>
                                                        </td>
                                                        <td>
                                                            <img alt="" src='<%#GetMeasureImagePath(Eval("Type"))%>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblName"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadListBox>
                                    </div>
                                </fieldset>
                            </div>

                            <div class="col-8" >
                                <table class="TableNoSpacingNoBorder MobileTableWidth" style="width:100%" >
                                    <tr>
                                        <td colspan="2">
                                            <fieldset>
                                                <legend>
                                                    <asp:Label ID="lblVisualCalculator" runat="server" Text="Visual Calculator" meta:resourcekey="lblVisualCalculator"></asp:Label>
                                                </legend>
                                                <div style="width: 100%; overflow: auto; " class="MobileTableWidth">
                                                <telerik:RadAjaxPanel runat="server" ID="pnlCalculator">
                                                    <table>
                                                        <tr>
                                                            <td colspan="9" align="right">
                                                                <div class="VisualCalculatorButton"><span class="Icon"></span></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGross"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td>
                                                                <asp:Label ID="lblShaftsGlazing" runat="server" Text="Shafts & Glazing" meta:resourcekey="lblShaftsGlazing"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td>
                                                                <asp:Label ID="lblCommonAreas" runat="server" Text="Common Areas" meta:resourcekey="lblCommonAreas"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>

                                                        <tr>
                                                            <td style="padding-left: 3px; vertical-align: bottom">
                                                                <telerik:RadListBox ID="rlbGross"
                                                                    runat="server" Width="100px" Height="100px" Skin="Default"
                                                                    SelectionMode="Multiple" AllowTransfer="false"
                                                                    AllowReorder="False" EnableDragAndDrop="true">
                                                                    <ItemTemplate>

                                                                        <asp:Label runat="server" ID="lblName"></asp:Label>

                                                                    </ItemTemplate>
                                                                </telerik:RadListBox>

                                                            </td>
                                                            <td></td>
                                                            <td style="padding-left: 3px; vertical-align: bottom">
                                                                <telerik:RadListBox ID="rlbShaft"
                                                                    runat="server" Width="100px" Height="100px" Skin="Default"
                                                                    SelectionMode="Multiple" AllowTransfer="false"
                                                                    AllowReorder="False" EnableDragAndDrop="true">
                                                                    <ItemTemplate>


                                                                        <asp:Label runat="server" ID="lblName"></asp:Label>


                                                                    </ItemTemplate>
                                                                </telerik:RadListBox>
                                                            </td>
                                                            <td></td>
                                                            <td style="vertical-align: bottom">
                                                                <asp:Label ID="lblRentable" runat="server" Text="Rentable" meta:resourcekey="lblRentable"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td style="padding-left: 3px; vertical-align: bottom">
                                                                <telerik:RadListBox ID="rlbCommonAreas"
                                                                    runat="server" Width="100px" Height="100px" Skin="Default"
                                                                    SelectionMode="Multiple" AllowTransfer="false"
                                                                    AllowReorder="False" EnableDragAndDrop="true">
                                                                    <ItemTemplate>


                                                                        <asp:Label runat="server" ID="lblName"></asp:Label>

                                                                    </ItemTemplate>
                                                                </telerik:RadListBox>
                                                            </td>
                                                            <td></td>
                                                            <td style="vertical-align: bottom">
                                                                <asp:Label ID="lblUsable" runat="server" Text="Usable" meta:resourcekey="lblUsable"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtCross" CssClass="PositiveDouble"></asp:TextBox>
                                                            </td>
                                                            <td>-</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtShaft" CssClass="PositiveDouble"></asp:TextBox>
                                                            </td>
                                                            <td>=</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtRentable" Width="140px" CssClass="Double"></asp:TextBox>
                                                            </td>
                                                            <td>-</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtCommonAreas" CssClass="PositiveDouble"></asp:TextBox></td>
                                                            <td>=</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtUsable" Width="140px" CssClass="Double"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </telerik:RadAjaxPanel>
                                            </div>
                                            </fieldset>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top; background-color: #eeeeee;" id="tdZoomer" class="disableSelection" valign="top" align="left">
                                            <div style="width: 100%; overflow: auto; max-width: calc(100vw - 40px);">
                                                <div id="divZoomer" style="position: relative; height: 328px; width: auto; overflow: auto;">
                                                    <div id="Canvas" style="cursor: default; position: absolute; top: 0px; left: 0px;" onclick="CanvasClicked();">
                                                        <div id="divImage">
                                                        </div>
                                                        <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" />
                                                    </div>
                                                    <asp:HiddenField ID="hnDrawings" runat="server" />
                                                    <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>                  
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="ValueToReturn" />

    </form>
</body>
</html>
