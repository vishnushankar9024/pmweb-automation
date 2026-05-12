<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FileManagerSpecialPermissionsPopUp.aspx.vb" Inherits="Website.FileManagerSpecialPermissionsPopUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <%--    <style>
        .k-reset {
            position: relative;
            top: 9px;
            z-index: 1;
        }

        input[type=text]{
            height:29px !important;
            width:240px !important;
        }

        .k-widget.k-multiselect.RadMultiSelect.RadMultiSelect_Default.SpecialPermissionMultiSelect{
            height:29px;
            position:relative;
            top:-7px;
        }

        .k-multiselect-wrap.k-floatwrap input {
            width: 100% !important;
            position: relative;
            top: -10px;
            height:23px;
        }

         .RadMultiSelect_Default.k-state-focused.k-multiselect input{
             /*top:0px !important;*/
        }
        .k-multiselect-wrap.k-floatwrap input.k-input.k-readonly{
            height:22px;
        }

        .RadMultiSelect_Default .k-multiselect-wrap > .k-readonly.k-input {
            position: relative;
            top: 7px;
        }

        .RadMultiSelect_Default .k-multiselect-wrap > .k-input {
            /*position: relative;
            top: 0px;*/
        }

        .RadMultiSelect_Default .k-multiselect-wrap .k-icon.k-i-loading {
            display: none;
        }
    </style>--%>

    <%--<telerik:radcodeblock id="CodeBlock" runat="server">--%>
    <style>
        .Delete .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png) !important;
            width: 16px;
            height: 16px;
            background-repeat: no-repeat;
            /*background-position: -208px 0px !important;*/
            background-position: -512px 0px;
            display: inline-block;
            vertical-align: middle;
        }

        .Delete:hover .Icon {
            background-image: url('CSS/Images/ResponsiveIcons/16Hovered.png') !important;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item.k-state-selected, .RadMultiSelectDropDown_Default .k-list-optionlabel.k-state-selected {
            color: #000 !important;
            background-color: #E4E4E4 !important;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item:hover.k-state-selected {
            color: #fff !important;
            background-color: #e4e4e4 !important;
        }

        .SpecialPermissionMultiSelect span.k-icon.k-clear-value.k-i-close.k-hidden {
            margin-left: -16px;
        }

        .SpecialPermissionMultiSelect input.k-input.k-readonly, .SpecialPermissionMultiSelect input.k-input {
            width: 156px !important;
            height: 29px;
            border: 1px solid #666;
        }

        .k-widget.k-multiselect.RadMultiSelect.RadMultiSelect_Default.SpecialPermissionMultiSelect.k-multiselect-clearable {
            height: 24px;
        }

        .SpecialPermissionMultiSelect span.k-icon.k-clear-value.k-i-close.k-hidden :focus {
            margin-left: -16px;
        }

        .k-widget.k-multiselect.RadMultiSelect.RadMultiSelect_Default.SpecialPermissionMultiSelect.k-multiselect-clearable :focus {
            height: 24px;
        }

        .k-reset {
            position: relative;
            top: 0px;
        }

        .RadMultiSelect_Default .k-multiselect-wrap li.k-button {
            border-radius: 15px;
            width: 130px !important;
            color: #333333;
            background-color: RGB(237,237,237) !important;
            background-image: none !important;
            height: 25px;
            text-align: center;
            line-height: 25px;
        }

        .SpecialPermissionMultiSelect input.k-input {
            position: relative;
            top: -25px;
        }

        .k-widget.k-multiselect.RadMultiSelect.RadMultiSelect_Default.SpecialPermissionMultiSelect {
            height: 32px;
        }

        .k-multiselect-wrap.k-floatwrap {
            height: 100%;
        }

        .RadMultiSelect_Default .k-multiselect-wrap li.k-button {
            position: relative;
            top: 4px;
            z-index: 1;
            left: 5px;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item {
            height: 20px;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item {
            height: 30px;
        }

        .k-list-scroller {
            width: 280px;
            height: 216px;
            position: relative;
            right: 122px;
            background: white;
            overflow: auto;
            white-space: nowrap;
            top: -5px;
            border: 1px black solid;
        }


        .Toolbar {
            width: 100%;
            margin-top: 40px;
            background-color: white !important;
            border-bottom: 1px solid RGB(237,237,237);
        }

        input[type="text"] {
            height: 33px !important;
            padding-left: 5px !important;
        }

        .Delete {
            position: absolute;
            right: 5px;
            bottom: 10px;
            /*display:none*/
        }

        .SpecialPermissionMultiSelect.MultiSelectEmpty input.k-input.k-readonly {
            margin-top: 25px;
        }

        .positionRelative {
            position: relative;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item {
            line-height: 30px;
        }

            .RadMultiSelectDropDown_Default .k-list .k-item.k-state-focused {
                box-shadow: none !important;
            }

        .k-item {
            padding-left: 5px;
        }

        .RadMultiSelectDropDown_Default .k-list .k-item:hover,
        .RadMultiSelectDropDown_Default .k-list .k-item.k-state-hover,
        .RadMultiSelectDropDown_Default .k-list-optionlabel:hover,
        .RadMultiSelectDropDown_Default .k-list-optionlabel.k-state-hover {
            background: #e4e4e4;
        }
    </style>
    <script type="text/javascript">

        function click_handler(sender, args) {
            switch (args.get_item().get_commandName()) {
                case 'Cancel': CloseRadWnd();
            }
        }

        function onDeselect(sender, args) {
            args.set_cancel(true);
            //return false;
            //debugger;
            //var selectedvalue = parseInt(args.get_dataItem().value);

            //var senderId = sender.get_id();
            //$(".k-input").css("top", "")
            //var hdnSender = document.querySelector("#" + senderId.substring(0, senderId.lastIndexOf('_')) + '_hfValues');
            //alert(hdnSender.value);
            //alert(selectedvalue);
            //hdnSender.value = hdnSender.value.replace(',' + selectedvalue, '')
            //alert(hdnSender.value);
            //if (hdnSender.value.length == 0) {
            //    if (hdnSender.value.length > 0 && !hdnSender.isSystem) {
            //        var deletebtn = document.querySelector("#" + senderId.substring(0, senderId.lastIndexOf('_')) + '_btnDeleteGroup');
            //        deletebtn.hidden = "true";
            //    } else {
            //        var deletebtn = document.querySelector("#" + senderId.substring(0, senderId.lastIndexOf('_')) + '_btnDeleteGroup');
            //        deletebtn.hidden = "false";
            //    }
            //}

        }

        function onSelect(sender, args) {


            var selectedvalue = parseInt(args.get_dataItem().value);
            var senderId = sender.get_id();
            $(".k-input").css("top", "")
            var multiSelects = $("div.k-widget.k-multiselect.RadMultiSelect.RadMultiSelect_Default.SpecialPermissionMultiSelect");
            multiSelects.each(function () {
                var cur = $(this);
                var currId = cur.find('select')[0].id;
                var multiSelect = $find(currId);
                var hdnSender = document.querySelector("#" + senderId.substring(0, senderId.lastIndexOf('_')) + '_hfValues');
                var hdn = document.querySelector("#" + multiSelect.get_id().substring(0, multiSelect.get_id().lastIndexOf('_')) + '_hfValues');
                //var txtBoxSender = document.querySelector("#" + senderId.substring(0, senderId.lastIndexOf('_')) + '_rmsSecurityGroup_taglist');

                if (senderId != currId) {
                    var arr = multiSelect.get_value();
                    if (arr.indexOf(selectedvalue) > -1) {
                        var removedValue = arr.splice(arr.indexOf(selectedvalue), 1)
                        multiSelect.set_value(arr);
                        hdnSender.value += ',' + removedValue;
                        hdn.value = arr.join(',');
                    }
                }
                var btnDelete = document.querySelector("#" + multiSelect.get_id().substring(0, multiSelect.get_id().lastIndexOf('_')) + '_btnDeleteGroup');
                //var txtBox = document.querySelector("#" + multiSelect.get_id().substring(0, multiSelect.get_id().lastIndexOf('_')) + '_rmsSecurityGroup_taglist');
                var txtBox = document.getElementsByClassName("k-input");
                //var i;
                //for (i = 0; i < txtBox.length; i++) {
                //   txtBox[i].style.top = "0px";
                //}
                if (hdn.getAttribute("issystem") == "False" || hdn.getAttribute("issystem") == null) {
                    if (hdn.value.length > 0) {
                        if (btnDelete)
                            btnDelete.style.display = "none";

                    }
                    else {

                        if (btnDelete) {
                            debugger;
                            var multiSelect = $find(currId);
                            var parent = document.getElementById(multiSelect.get_id()).parentElement;
                            parent.classList.add('MultiSelectEmpty')
                            btnDelete.style.display = "block";

                        }

                    }
                    if (hdn == hdnSender && selectedvalue) {
                        btnDelete.style.display = "none";

                    }
                }





            });
            //$('.PMMainPage').on('blur', '.k-input', function (e) {
            //    e.target.style.top = ""
            //});
        }
        document.onload = function () {
            var arr = Array.from(document.querySelectorAll(".k-input"));
            arr.forEach(function (el) {
                el.addEventListener("click", function (evt) {
                    if (document.documentElement.clientHeight - evt.offSetX < 216) {
                        document.querySelector(".k-list-scroller").style.top = "0px";
                    }
                });
                el.addEventListener("blur", function (e) {
                    e.target.style.top = ""
                })
            });
            //$('.PMMainPage').on('blur', '.k-input', function (e) {
            //    e.target.style.top = ""
            //});
            //$('.PMMainPage').on('focus', '.k-readonly', function (e) {
            //    e.target.style.top = "0px"
            //});

        }

        function setEvents() {
            $('.PMMainPage').on('blur', '.k-input', function (e) {
                e.target.style.top = ""
            });
            $('.PMMainPage').on('focus', '.k-readonly', function (e) {
                e.target.style.top = "0px"
            });
        }

        function OpenConfirmDelete(msg) {
            if (!confirm(msg))
                return false;
        }

    </script>

</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPerm" runat="server" Skin="Default" />

        <telerik:RadAjaxManager ID="AjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="imgAddNewEntry">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="imgAddNewEntry" />
                        <telerik:AjaxUpdatedControl ControlID="rptFolderGroups" LoadingPanelID="ldpPerm" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rptFolderGroups">
                    <UpdatedControls>
                        <%--<telerik:AjaxUpdatedControl ControlID="mainToolBar" />--%>
                        <telerik:AjaxUpdatedControl ControlID="rptFolderGroups" LoadingPanelID="ldpPerm" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>



        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text=""></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>


        <div>

            <table style="width: 100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar NewStylePopupToolbar">
                    <td valign="middle" align="left" class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientButtonClicked="click_handler" CssClass="popup-toolbar">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save" Height="50px"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save"
                                    CommandName="SaveExit" Value="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                    PostBack="false">
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>

            <div class="R24SidePadding" style="margin-top:91px;padding-top:24px">
                <div style="min-height: 150px;width:650px;">
                    <div>

                        <table style="width:100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <fieldset style="width: 100%">
                                                <legend>
                                                    <asp:Label ID="lblFolderGroups" runat="server" meta:resourcekey="lblFolderGroups" Text="Folder Groups"></asp:Label>
                                                </legend>
                                            </fieldset>
                                        </td>
                                        <td style="width:30px">
                                            <asp:LinkButton CssClass="ShowFieldsetButton" src="Images/Workflow/wMinus.png" runat="server" ID="imgAddNewEntry" OnClick="imgAddNewEntry_Click">
                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>

                        </div>
                            <div>
                                <table>
                                    <tr>
                                        <td style="width: 240px; padding-right: 5px;"></td>
                                        <td class="positionRelative" style="width: 160px;"></td>
                                        <td style="width: 235px;">
                                            <asp:Label ID="lblAdministrator" runat="server" Text="Document Manager Administrator" Style="text-transform: uppercase;" meta:resourcekey="lblAdministrator"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:Repeater ID="rptFolderGroups" runat="server" EnableViewState="true">
                                <ItemTemplate>
                                    <div style="width: 630px !important;">
                                        <table>
                                            <tr>
                                                <td style="width: 240px; padding-right: 5px;">
                                                    <asp:TextBox runat="server" ID="txtFolderGroup"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="cmpFolderGroup" runat="server" ControlToValidate="txtFolderGroup"
                                                        CssClass="Validator" Display="Dynamic" ForeColor="" ValidationGroup="Save" Operator="NotEqual"
                                                        meta:resourcekey="cmpFolderGroupNewEntry" ErrorMessage="Required and must be unique1">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblFolderGroupUnique" meta:resourcekey="cmpFolderGroupNewEntry"
                                                        Text="Required and must be unique" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                                </td>
                                                <td class="positionRelative" style="width: 160px;">
                                                    <telerik:RadMultiSelect runat="server" ID="rmsSecurityGroup" DataTextField="FolderName" EnableTheming="true" Skin="Default"
                                                        DataValueField="FolderId" Filter="Contains" TagTemplate="" TagMode="Single"
                                                        CssClass="SpecialPermissionMultiSelect" EnableEmbeddedSkins="false" EnableViewState="true" AutoBind="true"
                                                        DataKeyName="GroupFolderId" DropDownHeight="216px" DropDownWidth="240px"
                                                        ClearButton="false">
                                                        <ClientEvents OnSelect="onSelect" OnDeselect="onDeselect" />
                                                    </telerik:RadMultiSelect>

                                                    <asp:LinkButton runat="server" ID="btnDeleteGroup" CssClass="Delete" Visible="True" OnClick="btnDeleteGroup_Click">
                                                        <span class="Icon" runat="server"></span>
                                                        
                                                    </asp:LinkButton>
                                                    <input type="hidden" id="hfValues" runat="server" />
                                                </td>
                                                <td style="width:240px; text-align:center;">
                                                    <label class="switch">
                                                        <input id="chkAdministrator" runat="server" type="checkbox"/>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
            </div>
   
    </form>
</body>
</html>
