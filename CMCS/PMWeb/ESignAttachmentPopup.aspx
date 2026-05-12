<%@ Page Language="vb" AutoEventWireup="false" Title="SELECT TO ATTACH TO EMAIL" CodeBehind="ESignAttachmentPopup.aspx.vb" Inherits="Website.ESignAttachmentPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .grid-container {
            width: 100%;
            /*height: 455px;*/
            overflow: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .eSignButton {
            box-sizing: border-box;
            display: block;
            width: 200px !important;
            flex-shrink: 0;
            text-transform: uppercase;
            text-decoration: none;
            color: #666;
            text-align: center;
            font-size: 12px;
            border: 1px solid #666;
            border-radius: 5px;
            height: 32px;
            line-height: 30px;
            background-color: transparent;
            padding: 0;
            font-family: "Work Sans";
        }
        .eSignButton:disabled,
        .eSignButton.disabled {
            pointer-events: none;
            cursor: not-allowed;
            background-color: #ECECEC;
            opacity: 0.8;
            border-color: #999;
            color: #999
        }

        .eSignText {
            display: block;
            /*padding-left: 5px;*/
            /*text-transform: uppercase;*/
        }

            .eSignText.Info {
                color: #666;
            }

            .eSignText.Error {
                color: red;
            }

        .selectHeader {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 5px;
            align-items: center;
            justify-content: center;
            margin-left: 5px;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function pageLoad() {
                //console.log("ESign Attachment Popup Loading");
                let radWindow = GetRadWindow();
                radWindow.set_visibleStatusbar(false);
                AdjustGridHeight(radWindow)
                radWindow.add_resizeEnd(function () { AdjustGridHeight(radWindow) })
                radWindow.add_close(HandleOnClose);

                // add change event to all checkboxes in the grid to disable the confirm button in case there are none checked
                let gridContent = document.querySelector("#rdgAttachToEmail");
                if (gridContent) {
                    let checkboxes = gridContent.querySelectorAll("input[type='checkbox']");
                    checkboxes.forEach(chk => chk.addEventListener("change", ToggleConfirmButton));

                    ToggleConfirmButton();
                }


            }
            function ToggleConfirmButton() {
                //debugger;
                let gridContent = document.querySelector("#rdgAttachToEmail");
                let btnConfirm = document.getElementById("<%= btnConfirm.ClientID %>")
                //console.log("gridContent: " + gridContent)
                if (gridContent && btnConfirm) {
                    let checkboxes = gridContent.querySelectorAll("input[type='checkbox']");
                    let isChecked = Array.from(checkboxes).some(chk => chk.checked);
                    btnConfirm.disabled = !isChecked;
                }
            }

            function OpenPOPUpToRefreshByHref(URL, Width, Height) {
                let left = (window.innerWidth - Width) / 2;
                let top = (window.innerHeight - Height) / 2;
                window.parent.ESignExternalPopup = window.parent.open(URL, '', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + Width + ',height=' + Height + ',top=' + top + ',left=' + left); //popup
                //console.log("parent: " + window.parent);
                //console.log("popup111: " + window.parent.ESignExternalPopup);
                return false;
            }

            function AdjustGridHeight(radWindow) {
                let gridContainer = document.querySelector(".grid-container");
                let grid = gridContainer.querySelector(".RadGrid");
                if (!gridContainer) {
                    return false;
                }
                let popupHeight = radWindow.getWindowBounds().height;
                grid.style.height = (popupHeight - 145) + "px"
                radWindow.set_keepInScreenBounds(true)
                return false;
            }

            function HandleOnClose(sender, args) {
                let argument = args.get_argument();
                // the argument will be null if the user clicks on the 'x' icon in the top right of the popup 
                if (argument === null) {
                    document.getElementById("<%= btnCloseESignPopup.ClientID %>").click();
                }
                return false;
            }

            function closeRadWindow(args) {
                let radwindow = GetRadWindow();
                radwindow.argument = args;
                radwindow.close(args);
            }

            function AllCheckClicked(iObj) {
                let i = 0;
                let rdgAttachToEmail = $("div[id$='rdgAttachToEmail']");
                let j = 0;
                let k = 0;
                rdgAttachToEmail.find("input[type='checkbox']").each(function () {
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

                let hdnCount = $("[id$=hdnCount]");
                let Value = parseFloat(hdnCount.val());
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
                hdnCount.val(Value);

            }

            function SelectParent(chk) {

                let rdgAttachToEmail = $("div[id$='rdgAttachToEmail']");
                let chkPArent = rdgAttachToEmail.find("input[type='checkbox']")[0];

                let i = 0;
                let isChecked = true;
                rdgAttachToEmail.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.disabled && !this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                        }
                    }
                    i++;
                });
                let hdnCount = $("[id$=hdnCount]");
                let Value = parseFloat(hdnCount.val());

                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;


                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }
                hdnCount.val(Value);

                return false;
            }

            function CheckParentBox() {
                let rdgAttachToEmail = $("div[id$='rdgAttachToEmail']");
                if (rdgAttachToEmail.find("input[type='checkbox']")[0] == null) return;
                let ParentIsNotChecked = true;
                let i = 0;
                let d = 1;
                let c = 1;
                rdgAttachToEmail.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && !this.checked) {
                            if (this.id.indexOf("chkSelect") > 0)
                                ParentIsNotChecked = false;
                        }
                        if (this.disabled) {
                            d = d + 1;
                        }
                        if (this.id.indexOf("chkSelect") > 0) {

                            c = c + 1;
                        }
                    }
                    i++;
                });

                if (d == c) {
                    ParentIsNotChecked = false;

                }

                if (!ParentIsNotChecked) {
                    rdgAttachToEmail.find("input[type='checkbox']")[0].checked = false;

                } else {
                    if (i > 0) {
                        rdgAttachToEmail.find("input[type='checkbox']")[0].checked = true;
                    }
                }
            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="margin: 24px">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnConfirm">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlMain" LoadingPanelID="ldpESignAttachmentPopup" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnBack">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlMain" LoadingPanelID="ldpESignAttachmentPopup" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpESignAttachmentPopup" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        <asp:Panel CssClass="container" runat="server" ID="pnlMain">
            <div class="header">
                <asp:Label runat="server" ID="lblInfoText" CssClass="eSignText Info" Text="Files Larger than 25 MB cannot be attached1" meta:resourcekey="lblInfoText"></asp:Label>
                <asp:Button runat="server" ID="btnConfirm" CssClass="eSignButton" Text="Confirm Attachments1" meta:resourcekey="btnConfirm"></asp:Button>
                <asp:Panel ID="pnlContinue" runat="server" Style="display: flex; gap: 20px;" Visible="false">
                    <asp:Button runat="server" ID="btnBack" CssClass="eSignButton" Text="Back1" meta:resourcekey="btnBack"></asp:Button>
                    <asp:Button runat="server" ID="btnContinue" CssClass="eSignButton" Text="Continue to DocuSign1"></asp:Button>
                </asp:Panel>
            </div>
            <div class="grid-container">
                <telerik:RadGrid ID="rdgAttachToEmail" BorderStyle="None" runat="server" Height="455px" PageSize="250" Width="100%"
                    AutoGenerateColumns="False" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
                    ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false" AllowPaging="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                    <ClientSettings>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id,Type" CommandItemDisplay="None" TableLayout="auto" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">

                        <Columns>

                            <telerik:GridTemplateColumn Reorderable="false" UniqueName="SelectColumn" Groupable="False" AllowFiltering="false">
                                <HeaderTemplate>
                                    <div class="selectHeader">
                                        <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" Style="justify-self: start;" />
                                        <asp:Label ID="lblSelect" runat="server" Text="Select1" meta:resourcekey="GC_Select"></asp:Label>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Height="20px" Width="90px" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn UniqueName="AttachedColumn" HeaderText="Attached1" meta:resourcekey="GC_Attached">
                                <ItemTemplate>
                                    <asp:Label ID="lblAttached" runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" Groupable="false" HeaderText="Type1" UniqueName="Type" meta:resourcekey="GC_Type">
                                <ItemTemplate>
                                    <%# Eval("TypeTranslation").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="110px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" Groupable="false" HeaderText="Description1" UniqueName="Description" meta:resourcekey="GC_Description">
                                <ItemTemplate>
                                    <%# Eval("Description").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="230px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" Groupable="false" HeaderText="Size1" UniqueName="FileSize" meta:resourcekey="GC_FileSize">
                                <ItemTemplate>
                                    
                                    <asp:Label ID="lblFileSize" runat="server" ></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="75px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" Font-Size="8" />
                    </MasterTableView>

                </telerik:RadGrid>
                <asp:Button runat="server" ID="btnCloseESignPopup" CssClass="Hide" />
            </div>
        </asp:Panel>
    </form>
</body>
</html>
