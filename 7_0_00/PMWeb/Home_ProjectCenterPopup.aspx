<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="Home_ProjectCenterPopup.aspx.vb" Inherits="Website.WebForm2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <script type="text/javascript">
        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
            var j = 0;
            var k = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });


            var Value = 0
            if (iObj.checked) {
                Value = Value + j;
            }
            else {
                if ((Value - k) >= 0)
                    Value = Value - k;
            }
        }

        function SelectParent(chk) {
            var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
            if (rdgRights.find("input[type='checkbox']")[0] == null) return;
            var chkPArent = rdgRights.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (chk.checked) {
                        if (!this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                    }
                }
                i++;
            });

            var Value = 0;
            if (!chk.checked) {
                chkPArent.checked = false;
                if (Value > 0)
                    Value = Value - 1;


            } else {
                chkPArent.checked = isChecked;
                Value = Value + 1;
            }

            return false;
        }

        function CheckParentBox() {
            var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
            var ParentIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkSelect") > 0)
                            ParentIsNotChecked = false;
                    }
                }
                i++;
            });

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;

            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }
            }
        }


        function pageLoad() {
            CheckParentBox();
        }
    </script>
    <style>
        .rgRow td {
            text-align: center;
        }

        .rgAltRow td {
            text-align: center;
        }
    </style>
    <form id="form1" runat="server">
        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td style="width: 100%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <telerik:RadGrid ID="rdgConfigureProjectCenter" runat="server" FitPageHeightOffset="5" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
            HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True" Style="margin-top: 50px;"
            AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="False">
            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Show" HeaderStyle-Width="50px">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" TextAlign="Left" runat="server" />

                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)"
                                Checked='<%# CBool(IIf(Eval("Show") Is System.DBNull.Value, 0, Eval("Show")))%>'
                                runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Navigator" UniqueName="Navigator" HeaderStyle-Width="180px">
                        <ItemTemplate>
                            <asp:Label ID="lblNavigator" runat="server" CssClass='<%#IIf(Eval("ModuleLevel"), "Bold", "NoWrap")%>' Text='<%#IIf(Eval("Controls") = String.Empty, "&nbsp;", Eval("Controls"))%>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle Font-Size="8pt"></HeaderStyle>
            <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
            </ClientSettings>
        </telerik:RadGrid>

    </form>
</body>
</html>
