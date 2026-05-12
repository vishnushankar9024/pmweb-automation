<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BimRevitPopup.aspx.vb" Inherits="Website.BimRevitPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BIM Revit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script language="javascript" type="text/javascript">

        function SelectAll(chk) {
            var total = 0;
            $("#rdgRevit").find("input[type='checkbox']").each(function () {
                this.checked = chk.checked;
            });
        }

        function SelectParent(chk) {
            var chkParent = $("#rdgRevit").find("input[type='checkbox']")[0];
            var i = 0;
            var isChecked = true;
            $("#rdgRevit").find("input[type='checkbox']").each(function () {
                if (i != 0) {
                    if (chk.checked) {
                        if (!this.checked) isChecked = false;
                    }
                }
                i++;
            });

            if (!chk.checked) {
                chkParent.checked = false;
            } else {
                chkParent.checked = isChecked;
            }
            return false;
        }

    </script>

</head>
<body>
    <style>
        .controlWidth span {
            display: inline !important;
        }

        a.rfdSkinnedButton {
            text-decoration: none;
        }
    </style>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rblUnit">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rblUnit" />
                        <telerik:AjaxUpdatedControl ControlID="rdgRevit" LoadingPanelID="ldpRevit" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <%--<telerik:AjaxSetting AjaxControlID="btnUpdate">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgRevit" LoadingPanelID="ldpRevit" />
                        <telerik:AjaxUpdatedControl ControlID="lblUpdatedDateValue" />
                        <telerik:AjaxUpdatedControl ControlID="lblUpdatedByValue" />
                        <telerik:AjaxUpdatedControl ControlID="lblFailedToInsert" />
                        <telerik:AjaxUpdatedControl ControlID="lblSucceed" />
                    </UpdatedControls>
                </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpRevit" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                        Width="220px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row R3Cols">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPMWebProject" meta:resourcekey="lblPMWebProject" runat="server" Text="PMWeb Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblPMWebProjectValue" runat="server" Width="100%"></asp:Label>
                            </td>
                        </tr>

                        <tr>

                            <td class="labelWidth">
                                <asp:Label ID="lblUpdatedDate" meta:resourcekey="lblUpdatedDate" runat="server" Text="Last Revit Update"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblUpdatedDateValue" runat="server" Width="100%"></asp:Label>

                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEstimateDescription" meta:resourcekey="lblEstimateDescription" runat="server" Text="Estimate Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblEstimateDescriptionValue" runat="server" Width="100%"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUpdatedBy" meta:resourcekey="lblUpdatedBy" runat="server" Text="Updated By"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblUpdatedByValue" runat="server" Width="100%"></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRevision" meta:resourcekey="lblRevision" runat="server" Text="Revision"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblRevisionValue" runat="server" Width="100%"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDate" meta:resourcekey="lblDate" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblDateValue" runat="server" Width="100%"></asp:Label>

                            </td>
                        </tr>


                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRevitProject" meta:resourcekey="lblRevitProject" runat="server" Text="Revit Project*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:FileUpload ID="fluRevitProject" runat="server" Width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth">
                                <asp:RequiredFieldValidator ID="rfvRevitProject" meta:resourcekey="rfvRevitProject" runat="server" ControlToValidate="fluRevitProject" ValidationGroup="Upload"
                                    CssClass="Validator" Display="Dynamic" Text="Choose a Revit project." ForeColor=""></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnRevit" runat="server" CommandName="Read" Style="text-decoration: none;"
                                    Text="Read Revit" ValidationGroup="Upload" meta:resourcekey="btnRevit"></asp:Button>
                                &nbsp;&nbsp;
                                                            <asp:Label ID="lblFileName" runat="server" CssClass="Bold"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblOptions" meta:resourcekey="lblOptions" runat="server" Text="Measurement System"></asp:Label>
                        </legend>
                        <asp:RadioButtonList ID="rblUnit" runat="server" AutoPostBack="true" CssClass="RadioCss RadioPadding">
                            <asp:ListItem Selected="True" Text="Imperial" Value="1" meta:resourcekey="rblUnit_Imperial"></asp:ListItem>
                            <asp:ListItem Text="Metric" Value="2" meta:resourcekey="rblUnit_Metric"></asp:ListItem>
                        </asp:RadioButtonList>
                    </fieldset>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td colspan="4">
                                <telerik:RadGrid ID="rdgRevit" runat="server" ShowCommandItem="false"
                                    AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0" Width="99%" setwidth="true"
                                    GridLines="None">
                                    <HeaderContextMenu EnableViewState="false">
                                    </HeaderContextMenu>
                                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="ItemId" CommandItemDisplay="None" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkUse" runat="server" Checked="True"
                                                        onclick="SelectParent(this);" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:Label ID="lblUse" runat="server" meta:resourcekey="lblUse"></asp:Label><br />
                                                    <asp:CheckBox ID="chkUse" runat="server" Checked="True" TextAlign="Left"
                                                        onclick="SelectAll(this);" />
                                                </HeaderTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                                <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="BIM ID" UniqueName="TypeID">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("TypeID")) = String.Empty, "&nbsp;", Eval("TypeID"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="250px" />
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM">
                                    <ItemTemplate>
                                        <span><%#IIf(CStr(Eval("UOM")) = String.Empty, "&nbsp;", Eval("UOM"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"/>
                                </telerik:GridTemplateColumn>--%>
                                            <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity">
                                                <ItemTemplate>
                                                    <span><%#IIf(rblUnit.SelectedIndex = 0, FormatNumber(Container.DataItem("ImperialQuantity")), FormatNumber(Container.DataItem("Quantity")))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="false">
                                        <Selecting AllowRowSelect="false" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="padding-top: 7px">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" style="padding-left: 10px">
                                <asp:Label ID="lblFailedToUpload" meta:resourcekey="ErrorMsg_FailedToUpload" Visible="false" Class="Failure" runat="server" Text="Failed to upload the revit project file."></asp:Label>
                                <asp:Label ID="lblWrongDataSouce" meta:resourcekey="ErrorMsg_WrongDataSouce" Visible="false" Class="Failure" runat="server" Text="The uploaded file does not match the desired schema."></asp:Label>
                                <asp:Label ID="lblFailedToInsert" meta:resourcekey="ErrorMsg_FailedToInsert" Visible="false" Class="Failure" runat="server" Text="Failed to insert the items."></asp:Label>
                                <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                    Visible="False" Class="Success"></asp:Label>
                            </td>
                            <td colspan="2" align="right" style="padding-right: 10px">
                                <%--         <table cellpadding="1" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUpdate" meta:resourcekey="btnUpdate" CssClass="LargeButton" Text="Save to Estimate" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnCancel" meta:resourcekey="btnCancel" CssClass="LargeButton" Text="Cancel" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>--%>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>



    </form>
</body>
</html>
