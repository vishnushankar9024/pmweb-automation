<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BoardSettingsDialogPopup.aspx.vb" Inherits="Website.BoardSettingsDialogPopup" 
     Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        html{
            height:100%;
        }
        body{
            display:inline-block;
            height:100%;
            width:100%;
        }
        span.Right {
            display: block;
        }

         .rwWindowContent > iframe{
                border-radius:10px;
            }
            .rwWindowContent{
               background: transparent !important;
            }

        .BoardBackgroundColor {
            position: relative;
            width: 100%;
            height: 24px;
            line-height: 24px;
            border: 1px solid #666666;
            background-color: #c9c9c9;
            box-sizing: border-box;
            cursor: pointer;
            box-shadow: inset 0 0 0 1px white;
        }

            .BoardBackgroundColor:before {
                content: '';
                position: absolute;
                height: 0;
                width: 0;
                border-width: 0 0 6px 6px;
                border-style: solid;
                border-color: transparent transparent #666666 transparent;
                right: 0;
                bottom: 0;
                z-index: 1;
            }

            .BoardBackgroundColor:after {
                content: '';
                position: absolute;
                height: 0;
                width: 0;
                border-width: 0 0 7px 7px;
                border-style: solid;
                border-color: transparent transparent #FFFFFF transparent;
                right: 0;
                bottom: 0;
            }
        .NewColorPicker {
            margin: 0 auto;
        }
        .AddMembersIcon {
            background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
            width: 16px;
            display: inline-block;
            height: 16px;
            vertical-align: middle;
            background-repeat: no-repeat;
            background-position: -496px 0px;
        }
        .AddMembersIcon_disabled .AddMembersIcon {
            background-image: url('CSS/Images/ResponsiveIcons/16Disabled.png') !Important;
            cursor:auto;
        }

        .DisabledSwitch .slider{
            cursor:auto;
        }

        #rdgActivityBoardMembers {
            border: 0 !important;
            outline: none;
        }

            #rdgActivityBoardMembers .rgHeader {
                color: #666666 !important;
                border: 0 !important;
                background-color: transparent !important;
                font-size: 0.8em !important;
            }

            #rdgActivityBoardMembers .rgRow td,
            #rdgActivityBoardMembers .rgAltRow td {
                border: 0 !important;
                color: #666666;
            }

        .avatar {
            height: 28px;
            width: 28px;
            line-height: 30px;
            text-align: center;
            text-transform: uppercase;
            border: 1px solid #666666;
            border-radius: 50%;
        }

        .rcpRoundedBottomRight,.rcpRoundedBottomLeft,.rcpRoundedRight,.rcpEmptyHeader{
            display:none;
        }

         div.RadColorPicker  div.rcpPalette{
             margin:0;
             padding: 1px;
         }

         .RadGrid .rgHeaderWrapper{
             border-bottom:0 !important;
             background-color:transparent !important
         }

        .RadMenu .rmGroup a.rmLink{
            border:1px white solid !important;
         }

         .RadMenu .rmGroup a.rmLink:hover, .RadMenu .rmGroup a.rmFocused, .RadMenu .rmGroup a.rmSelected, .RadMenu .rmGroup a.rmExpanded {
           color: #455A64;
           background: #ECEFF1 !important;
           border:1px #b0b0b0 solid !important;
           }

         .RadMenu .rmSeparator{
             margin-top:2px;
         }

         .RadMenu .rmGroup a.rmLink:hover .rmText, .RadMenu .rmGroup a.rmFocused .rmText, .RadMenu .rmGroup a.rmSelected .rmText, .RadMenu .rmGroup a.rmExpanded .rmText {
             background: none !important;
         }  
         .RadMenu .rmLink{
             height:20px;
         }
       
        .RadMenu{
            margin-top:10px;
        }

        .RadMenu .rmItem,.RadMenu .rmItem .rmLink{
            width: inherit !important;
        }
        .RadMenu .rmVertical .rmText{
            padding:0 20px 0 20px !important;
            margin:0 !important
        }

       .RadMenu .rmVertical .rmSeparator .rmText{
            padding:0 !important;
            margin:0 !important
        }

       .RadToolBar {
           background-color: white !important;
       }
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>  
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                $(document).ready(function () {
                    $('body').click(function (e) {
                        var q = e.target;
                        var s = $(q);
                        var targetid = e.target.id;
                        if (targetid.indexOf('divBoardBackgroundColor') < 0)
                            $("[id$='rcpBoardBackgroundColor']").addClass("Hide");
                        if (targetid.indexOf('divBoardColumnColor') < 0)
                            $("[id$='rcpBoardColumnColor']").addClass("Hide");
                    })
                })
                function ValidateCombo(source, args) {
                    var combo = $find(source.controltovalidate);
                    var comboValue = combo.get_value();
                    var combotext = combo.get_text();

                    if (comboValue == '0') {
                        args.IsValid = true;
                        return args.IsValid = true;
                    }

                    if (comboValue == '-1') {
                        args.IsValid = false;
                        return;
                    }

                    if (comboValue != '0' && comboValue != '') {
                        args.IsValid = true;
                    } else {

                        if (combotext == '' && combotext == null) {
                            args.IsValid = false;
                        }

                        else {

                            var node = combo.findItemByText(combotext);

                            if (node) {
                                //var value = node.get_value();
                                if (node.get_value().length > 0) {
                                    args.IsValid = true;
                                } else {
                                    args.IsValid = false;
                                }

                            }
                            else {

                                args.IsValid = false;
                            }
                        }
                    }
                }

                function toggleRCP() {
                    if ($("[id$='rcpBoardBackgroundColor']").hasClass("Hide")) {
                        $("[id$='rcpBoardBackgroundColor']").removeClass("Hide");
                    }
                    else {
                        $("[id$='rcpBoardBackgroundColor']").addClass("Hide");
                    }
                    FloatDivs();
                }
                function ChangeBoardBackgroundColor(sender, eventArgs) {
                    color = sender.get_selectedColor();
                    $("[id$='divBoardBackgroundColor']").css("background-color", color);
                    $("[id$='rcpBoardBackgroundColor']").addClass("Hide");
                    FloatDivs();
                }

                function toggleColumnRCP() {
                    if ($("[id$='rcpBoardColumnColor']").hasClass("Hide"))
                        $("[id$='rcpBoardColumnColor']").removeClass("Hide");
                    else 
                        $("[id$='rcpBoardColumnColor']").addClass("Hide");
                    FloatDivs();
                }
                function ChangeBoardColumnColor(sender, eventArgs) {
                    color = sender.get_selectedColor();
                    $("[id$='divBoardColumnColor']").css("background-color", color);
                    $("[id$='rcpBoardColumnColor']").addClass("Hide");
                    FloatDivs();
                }


                function RowContextMenu(sender, eventArgs) {
                    var evt = eventArgs.get_domEvent();
                    if (evt.target.tagName == "INPUT" || evt.target.tagName == "A") {
                        return;
                    }
                    console.log(evt);
                    var index = eventArgs.get_itemIndexHierarchical();
                    document.getElementById("radGridClickedRowIndex").value = index;
                    //console.log(document.getElementById("radGridClickedRowIndex").value);
                    var masterTable = sender.get_masterTableView();
                    isCanEditNotVisible = masterTable.get_dataItems()[index].get_element().childNodes[3].childNodes.length < 3
                    if (index === "0" || isCanEditNotVisible) return;                    
                    masterTable.selectItem(masterTable.get_dataItems()[index].get_element(), true);
                    menu = $find($("[id$=rcmRemoveMember]")[0].id)

                    menu.show(evt);
                    $telerik.cancelRawEvent(evt)
                }

                function ClientRemoveMember(sender, args) {
                    var CurrEle = $($find($('[id$=rdgActivityBoardMembers]')[0].id).get_masterTableView().get_dataItems()[document.getElementById("radGridClickedRowIndex").value].get_element());
                    CurrEle.addClass("Hide");
                    CurrEle.find("[id$=hdnIsRemoved]").val("1");
                    $find($("[id$=rcmRemoveMember]")[0].id).hide();
                    args.set_cancel(true);
                }

                function setparentPageurl(url) {
                    GetRadWindow().BrowserWindow.seturl(url);
                }

                function CheckAllCanEdit(chkAll) {
                    $(".chkCanEdit").each(function () {
                        $(this).prop("checked", chkAll.checked);
                    })
                }
                function CheckAllSubscribe(chkAll) {
                    $(".chkSubscribe").each(function () {
                        $(this).prop("checked", chkAll.checked);
                    })
                }

                function CheckMemberCanEdit(chk) {
                    var isAll = true;
                    $(".chkCanEdit").each(function () {
                        if (this.checked === false) {
                            isAll = false;
                            return false;
                        }
                    })
                    $(".chkCanEditAll")[0].checked = isAll;
                }
                function CheckMemberSubscribe(chk) {
                    var isAll = true;
                    $(".chkSubscribe").each(function () {
                        if (this.checked === false) {
                            isAll = false;
                            return false;
                        }
                    })
                    $(".chkSubscribeAll")[0].checked = isAll;
                }

                function PopupMainButtonClicked(sender,args){
                    if (args.get_item().get_commandName() == "Close")
                        CloseRadWnd();
                }
                function OpenNoteDetailPopupNewStyle(txtNoteId,Source) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&Source=' + Source );
                    wnd.set_visibleTitlebar(false);
                    wnd._topResizer.parentElement.className = "";
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    return false;
                }
            </script>
        </telerik:RadCodeBlock>
       <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
         <telerik:RadAjaxManager ID="AjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlProjects">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlProjects" />
                         <telerik:AjaxUpdatedControl ControlID="txtActivityBoardNumber" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ABLP" runat="server" />

        <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" AutoPostBack="true" CssClass="small-toolbar" OnClientButtonClicking="PopupMainButtonClicked">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave"
                                CommandName="Save" AccessKey="s" Value="Save" ValidationGroup="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndExit" AccessKey="e" Value="SaveAndExit" ValidationGroup="Save" Style="margin-right: -8px !important;">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel" PostBack="false">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage" style="margin-bottom: 0 !important;">
            <div class="row JustifyContent R3Cols">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server"
                                    Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                    OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvProject" runat="server" ControlToValidate="ddlProjects"
                                    CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                    Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="csvProject" runat="server" ControlToValidate="ddlProjects"
                                    ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                    CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblActivityBoardNumber" meta:resourcekey="lblActivityBoardNumber" runat="server" Text="ID*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtActivityBoardNumber" runat="server" MaxLength="13"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvActivityBoardNumber" runat="server" ControlToValidate="txtActivityBoardNumber"
                                    CssClass="Validator" ErrorMessage="Required" Display="Dynamic"
                                    ValidationGroup="Save" Operator="NotEqual" meta:resourcekey="rfvActivityBoardNumber"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblActivityBoardNumberUnique" meta:resourcekey="lblActivityBoardNumberUnique" Text="<br/>Activity Board ID should be unique." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblActivityBoardName" meta:resourcekey="lblName" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtActivityBoardName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" valign="top">
                                <div style="float: left;">
                                    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton runat="server" ID="imgDescription" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopupNewStyle(this.id.replace('imgDescription','txtDescription'), 'ACTIVITYBOARDS')">
                                        <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" TextMode="MultiLine" runat="server" MaxLength="4000" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDueDate" meta:resourcekey="lblDueDate" runat="server" Text="Due"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <span runat="server" id="rmd_dtpDueDate" style="display: block">
                                    <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                        SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)"
                                        EnableTyping="True" AutoPostBack="false">
                                        <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                            runat="server">
                                        </DateInput>
                                        <Calendar ID="Calendar3" Skin="Default" runat="server">
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server"
                                    Skin="Default" Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                    Skin="Default" Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblOwner" meta:resourcekey="lblOwner" runat="server" Text="Owner"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlOwner" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                    meta:Resourcekey="ddlOwner" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBoardBackgroundColor" meta:resourcekey="lblBoardBackgroundColor" runat="server" Text="Background Color"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divBoardBackgroundColor" class="BoardBackgroundColor" onclick="toggleRCP();" runat="server">
                                </div>
                                <telerik:RadColorPicker ID="rcpBoardBackgroundColor" runat="server" OnClientColorChange="ChangeBoardBackgroundColor"
                                    CssClass="Hide NewColorPicker" Columns="18" Width="240px" PaletteModes="WebPalette" KeepInScreenBounds="true" EnableCustomColor="true" PreviewColor="true" ShowEmptyColor="false" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBoardColumnColor" meta:resourcekey="lblBoardColumnColor" runat="server" Text="Column Name Color"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divBoardColumnColor" class="BoardBackgroundColor" onclick="toggleColumnRCP();" runat="server">
                                </div>
                                <telerik:RadColorPicker ID="rcpBoardColumnColor" runat="server" OnClientColorChange="ChangeBoardColumnColor"
                                    CssClass="Hide NewColorPicker" Columns="18" Width="240px" KeepInScreenBounds="true" EnableCustomColor="true" PaletteModes="WebPalette" PreviewColor="true" ShowEmptyColor="false" />
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="col-4 col-4-right">
                <telerik:RadAjaxPanel id="MembersColumn" runat="server" EnableAJAX="true">
                        <div>
                            <fieldset style="width: 375px !important; float: left;">
                                <legend class="legend" style="padding-right: 5px !important;">
                                    <asp:Label runat="server" ID="lblActivityBoardMembers"></asp:Label>
                                </legend>
                            </fieldset>
                            <div style="margin-top: 4px; float: right;">
                                <asp:LinkButton ID="btnAddMembers" src="Images/Workflow/wMinus.png" runat="server" OnClientClick='return OpenPOPUpNewStyle("AddMembersPopup.aspx", null, null, true);'>
                            <span class="AddMembersIcon"></span>
                                </asp:LinkButton>
                            </div>
                            <div style="clear:both"></div>
                        </div>
                        <div>
                            <asp:LinkButton runat="server" ID="btnRefresh" CssClass="Hide" />
                            <telerik:RadGrid ID="rdgActivityBoardMembers" runat="server" AutoGenerateColumns="False" Width="100%" SetWidth="true" FitPageHeightOffset="10"> 
                                <MasterTableView Width="100%" TableLayout="Fixed" CommandItemDisplay="None" DataKeyNames="Id">
                                    <Columns>
                                        <telerik:GridTemplateColumn UniqueName="ProfilePicture" AllowFiltering="false" Groupable="false">
                                            <ItemTemplate>
                                                <asp:Image ID="imgProfilePicture" runat="server" Height="30px" Width="30px" Style="border-radius: 50%;" />
                                                <div id="DivAvatar" class="avatar" runat="server">
                                                    <asp:Label ID="lblProfileInitials" runat="server" />
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle Width="45px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn SortExpression="FirstName" UniqueName="MemberName" DataField="MemberName"
                                            DataType="System.String">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMemberName" runat="server" />
                                                <asp:HiddenField ID="hdnIsRemoved" runat="server" Value="0" EnableViewState="false"/>
                                                <%--<span ID="" runat="server"><%#Container.DataItem("FirstName")(0).ToUpper() + Container.DataItem("LastName")(0).ToUpper() + " - " + Container.DataItem("FirstName") + " " + Container.DataItem("LastName")%></span>--%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <%--<HeaderStyle Width="250px" HorizontalAlign="Center" />--%>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="CanEdit" AllowFiltering="false" Groupable="false">
                                            <ItemTemplate>
                                                <%--<asp:CheckBox Checked='<%#CBool(Container.DataItem("CanEdit"))%>' runat="server" />--%>
                                                <label runat="server" class="switch" id="lblCanEditSwitch">
                                                    <input id="chkCanEdit" runat="server" type="checkbox" />
                                                    <span class="slider round"></span>
                                                </label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Subscribe" UniqueName="Subscribe" AllowFiltering="false" Groupable="false">
                                            <ItemTemplate>
                                                <%--                                            <input type="checkbox" checked='<%#CBool(Container.DataItem("Subscribe"))%>' runat="server"/>--%>
                                                <%--<asp:CheckBox Checked='<%#CBool(Container.DataItem("Subscribe"))%>' runat="server" />--%>
                                                <label runat="server" class="switch" id="lblSubscribeSwitch">
                                                    <input id="chkSubscribe" runat="server" type="checkbox" />
                                                    <span class="slider round"></span>
                                                </label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Height="30px" />
                                            <HeaderStyle Width="70" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <%--<SortExpressions>
                                    <telerik:GridSortExpression FieldName="FirstName" SortOrder="Ascending" />
                                </SortExpressions>--%>
                                </MasterTableView>
                                <ClientSettings Resizing-AllowColumnResize="false" Selecting-AllowRowSelect="true" ClientEvents-OnRowContextMenu="RowContextMenu"></ClientSettings>
                            </telerik:RadGrid>
                            <input type="hidden" id="radGridClickedRowIndex" name="radGridClickedRowIndex" />
                            <telerik:RadContextMenu ID="rcmRemoveMember"  runat="server" OnClientItemClicking="ClientRemoveMember">
                                <Items>
                                    <telerik:RadMenuItem Text="Remove" PostBack="false"/>
                                </Items>
                            </telerik:RadContextMenu>

                        </div>
                    </telerik:RadAjaxPanel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
