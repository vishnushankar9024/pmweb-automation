<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="LinkedAssetChargesPopup.aspx.vb" Inherits="Website.LinkedAssetChargesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server">






        <script language="javascript" type="text/javascript">

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

            function pageLoad() {
                //            var IsEditMode = querySt('IsEditMode') || 0;
                //            var ParentPagehdnSelectedValues = $(window.parent.document).find("input[id$=" + querySt('hdnLinkedAssetIds') + "]").val() || '';
                //          var hdnLinkedAssetChargesIds = $("#hdnLinkedAssetChargesIds")
                //          var hdnLinkedAssetChargesIds = hdnLinkedAssetChargesIds.val() || ''
                //          var ValuesToCheck = ""
                //          if (IsEditMode == 1 && ParentPagehdnSelectedValues != "")
                //              ValuesToCheck = ParentPagehdnSelectedValues
                //          else
                //              ValuesToCheck = hdnLinkedAssetChargesIds
                //          
                //          
                //              var masterTable = $find("rdgAssets").get_masterTableView();

                //              if (ValuesToCheck != "") {
                //                  for (var i = 0; i < masterTable.get_dataItems().length; i++) {

                //                      var Id = masterTable.get_dataItems()[i].getDataKeyValue("Id")

                //                      if (("," + ValuesToCheck + ",").indexOf("," + Id + ",") > -1) {

                //                          var chkIsIncluded = masterTable.get_dataItems()[i].findElement("chkIsIncluded")
                //                          chkIsIncluded.checked = true;
                //                      }
                //                      else {
                //                          var chkIsIncluded = masterTable.get_dataItems()[i].findElement("chkIsIncluded")
                //                          chkIsIncluded.checked = false;
                //                      }

                //                  }

                //              }

                var chkPArent = $("#rdgAssets").find("input[type='checkbox']")[0];
                var i = 0;
                var isChecked = true;
                $("#rdgAssets").find("input[type='checkbox']").each(function () {
                    if (i != 0) {
                        if (!this.checked) isChecked = false;
                    }
                    i++;
                });
                chkPArent.checked = isChecked;

            }
            function SelectAll(chk) {
                var totalContracts = 0;
                var totalPurchaseOrders = 0;
                $("#rdgAssets").find("input[type='checkbox']").each(function () {
                    this.checked = chk.checked;

                });


            }


            function ReturnValue(values, Text) {
                ParentPagehdnSelectedValues = $(window.parent.document).find("input[id$=" + querySt('hdnLinkedAsset') + "]");
                ParentPagelblLinkedAssets = querySt('hdnLinkedAsset').substring(querySt('hdnLinkedAsset').lastIndexOf('_'), querySt('hdnLinkedAsset').lenght - 1) + '_lblLinkedAssets';
                ParentPageImgLinkedAssets = querySt('hdnLinkedAsset').substring(querySt('hdnLinkedAsset').lastIndexOf('_'), querySt('hdnLinkedAsset').lenght - 1) + '_imgLinkAsset';
                var ObjImg = $(window.parent.document).find("[id$=" + ParentPageImgLinkedAssets + "]")
                if (values != "" && values != "-1")
                    ObjImg[0].className = "FilledDetails";
                else
                    ObjImg[0].className = "EmptyDetails";

                ParentPagehdnSelectedValues.val(values)

                $(window.parent.document).find("[id$=" + ParentPagelblLinkedAssets + "]").html(Text);

            }

            function ReturnValueToPopup(values, Text) {
                ParentPagehdnSelectedValues = $(window.parent.document).find("input[id$=" + querySt('hdnLinkedAsset') + "]");
                ParentPagelblLinkedAssets = querySt('hdnLinkedAsset').substring(querySt('hdnLinkedAsset').lastIndexOf('_'), querySt('hdnLinkedAsset').lenght - 1) + '_lblLinkedAssets';
                ParentPageNameHiddenfield = querySt('hdnLinkedAsset').substring(querySt('hdnLinkedAsset').lastIndexOf('_'), querySt('hdnLinkedAsset').lenght - 1) + '_hdnLinkedAssetNames';

                ParentPageImgLinkedAssets = querySt('hdnLinkedAsset').substring(querySt('hdnLinkedAsset').lastIndexOf('_'), querySt('hdnLinkedAsset').lenght - 1) + '_imgLinkAsset';
                var ObjImg = $(window.parent.document).find("[id$=" + ParentPageImgLinkedAssets + "]")
                if (values != "" && values != "-1")
                    ObjImg[0].className = "FilledDetails";
                else
                    ObjImg[0].className = "EmptyDetails";


                if (values == "-1") {
                    ParentPagehdnSelectedValues.val('');
                }
                else {
                    ParentPagehdnSelectedValues.val(values);

                }

                $(window.parent.document).find("[id$=" + ParentPagelblLinkedAssets + "]").html(Text);
                $(window.parent.document).find("[id$=" + ParentPageNameHiddenfield + "]").val(Text);
                window.close();
            }

            function SelectParent(chk) {
                var chkPArent = $("#rdgAssets").find("input[type='checkbox']")[0];
                var i = 0;
                var isChecked = true;
                $("#rdgAssets").find("input[type='checkbox']").each(function () {
                    if (i != 0) {
                        if (chk.checked) {
                            if (!this.checked) isChecked = false;
                        }
                    }
                    i++;
                });

                if (!chk.checked) {
                    chkPArent.checked = false;
                } else {
                    chkPArent.checked = isChecked;
                }
                return false;
            }


        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAssets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <asp:HiddenField runat="server" ID="hdnLinkedAssetChargesIds" />
                                            <telerik:RadGrid ID="rdgAssets" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="False"
                                                AllowMultiRowSelection="true" AllowPaging="False" PageSize="250">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="False" />
                                                <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkIsIncluded" runat="server" onclick="SelectParent(this);" />
                                                            </ItemTemplate>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkIsIncluded" runat="server" TextAlign="Left" onclick="SelectAll(this);" />
                                                            </HeaderTemplate>
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="140px" SortExpression="Suite">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-Width="140px" SortExpression="Property">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Building" HeaderStyle-Width="140px" SortExpression="Building">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Floor" SortExpression="Floor">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Space" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Space" SortExpression="Space">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>
                                                                <%--  <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span> --%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Equipment" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-Width="140px" SortExpression="Equipment">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>

                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings Resizing-AllowColumnResize="true">
                                                    <Selecting AllowRowSelect="False" EnableDragToSelectRows="true" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
