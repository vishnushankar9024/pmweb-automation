<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RedliningMeasuresPopup.aspx.vb" Inherits="Website.RedliningMeasuresPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Measured Drawings</title>
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

            function Main_GetValueToReturn(combobox, eventArgs) {
                if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
                    eventArgs.set_cancel(true);
                } else {
                    eventArgs.set_cancel(false);
                }
                var SelectedValue;
                var ddlProjects = $find('ddlProjects');
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

            function RowClick(sender, eventArgs) {
                var AreaValue = $(eventArgs.get_item().get_cell("AreaValue")).find("[id$=hdnAreaValue]").val();
                var UOMText = $(eventArgs.get_item().get_cell("UOMText")).find("[id$=hdnUOMText]").val();
                var UOMValue = $(eventArgs.get_item().get_cell("UOMValue")).find("[id$=hdnUOMValue]").val();
                var ctrlQty = window.parent.document.getElementById(querySt('QuantityControlId'));

                if (ctrlQty) {
                    ctrlQty.value = AreaValue;
                    if (ctrlQty.fireEvent) {
                        ctrlQty.fireEvent("onchange"); // for IE
                    } else if (document.createEvent && ctrlQty.dispatchEvent) {
                        var evt = document.createEvent("HTMLEvents");
                        evt.initEvent("change", true, true);
                        try {
                            ctrlQty.dispatchEvent(evt); // for DOM-compliant browsers
                        }
                        catch (ex) {

                        }
                    }
                }

                if (window.parent.document.getElementById(querySt('UOMControlId'))) {
                    if (querySt('UOMType') == 'ASP') {
                        var ddlUOM = window.parent.document.getElementById(querySt('UOMControlId'))
                        var i = 0;
                        $(ddlUOM).val(UOMValue);
                    }
                    if (querySt('UOMType') == 'TELERIK') {
                        var ddlUOM = window.parent.$find(querySt('UOMControlId'));
                        ddlUOM.findItemByValue(UOMValue).select();
                    }
                }

                window.close();
                return false;
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

            .labelWidth {
                background-color: unset !important;
            }
        </style>




        <table class="ToolBar" style="table-layout: fixed; width: auto !important;">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td class="ToolbarTd" style="width: 160px !important">
                    <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                </td>
                <td style="width: 240px" class="ToolbarTd">
                    <telerik:RadComboBox ID="ddlProjects" runat="server" Width="240px" Skin="Vista" 
                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="200px"
                        NoWrap="True" EnableLoadOnDemand="True" AllowCustomText="true" OnClientSelectedIndexChanged="Main_ResetCombos"
                        ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                        <CollapseAnimation Duration="200" Type="OutQuint" />
                    </telerik:RadComboBox>
                </td>
                <td style="width: 160px !important" class="ToolbarTd">
                    <asp:Label ID="lblDrawing" runat="server" Text="Drawing" meta:resourcekey="lblDrawing"></asp:Label>
                </td>
                <td style="width: 240px" class="ToolbarTd">
                    <telerik:RadComboBox ID="ddlAnnotations" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                        Skin="Vista" CloseDropDownOnBlur="true"
                        EmptyMessage="Choose a Drawing..." Width="240px" AutoPostBack="True" NoWrap="true"
                        CausesValidation="False" Height="200px" meta:resourcekey="ddlAnnotations"
                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" AllowCustomText="true" EnableVirtualScrolling="True"
                        OnClientItemsRequesting="Main_GetValueToReturn" OnItemsRequested="ddl_ItemsRequested">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td width="100%"></td>
            </tr>

        </table>


        <div class="PMHeader ">
            <div class="row" style="padding-top:80px">
                <div class="col-4">
                    <telerik:RadGrid ID="rdgMeasures" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="true" PageSize="9" AllowPaging="True">
                        <PagerStyle Mode="NextPrev" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" Width="100%" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn UniqueName="Color">
                                    <ItemTemplate>
                                        <div style="width: 7px; background-color: <%#Eval("Color")%>">&nbsp;&nbsp;</div>
                                    </ItemTemplate>
                                    <HeaderStyle Width="20px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="Type">
                                    <ItemTemplate>
                                        <img alt="" src='<%#GetMeasureImagePath(Eval("Type"))%>' />
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Measure" UniqueName="Name">
                                    <ItemTemplate>
                                        <%#IIf(Eval("Name") = String.Empty, "&nbsp;", Eval("Name"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="85px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Area/Length" UniqueName="Area">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAreaValue" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="AreaValue" Display="False">
                                    <ItemTemplate>
                                        <input type="hidden" id="hdnAreaValue" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="1px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="UOMText" Display="False">
                                    <ItemTemplate>
                                        <input type="hidden" id="hdnUOMText" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="1px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn UniqueName="UOMValue" Display="False">
                                    <ItemTemplate>
                                        <input type="hidden" id="hdnUOMValue" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="1px" />
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <SortExpressions>
                            </SortExpressions>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowRowsDragDrop="false">
                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                            <ClientEvents OnRowDblClick="RowClick" />
                        </ClientSettings>

                    </telerik:RadGrid>
                </div>
                <div class="col-8">
                    <table class="colTable" border="0">
                        <tr>
                            <td style="vertical-align: top; background-color: #ffffff; border: 1px solid #666666" id="tdZoomer" class="disableSelection" valign="top" align="left">
                                <div id="divZoomer" style="position: relative; height: 510px; width: auto; overflow: auto">
                                    <div id="Canvas" style="cursor: default; position: absolute; top: 0px; left: 0px;" onclick="CanvasClicked();">
                                        <div id="divImage">
                                        </div>
                                        <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" />
                                    </div>
                                </div>
                                <asp:HiddenField ID="hnDrawings" runat="server" />
                                <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>


        <input type="hidden" id="ValueToReturn" />
    </form>
</body>
</html>
