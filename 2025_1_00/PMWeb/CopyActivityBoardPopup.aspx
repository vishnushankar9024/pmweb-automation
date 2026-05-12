<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CopyActivityBoardPopup.aspx.vb" Inherits="Website.CopyActivityBoardPopup" 
     Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
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

                function SendIdToParent(newId) {
                    CloseRadWnd();
                    window.parent.location = 'ActivityBoards.aspx?Id=' + newId + '&ModuleId=8&PageId=365';
                }

                function toggleRCP() {
                    if ($("[id$='rcpBoardBackgroundColor']").hasClass("Hide")) {
                        $("[id$='rcpBoardBackgroundColor']").removeClass("Hide");
                    }
                    else {
                        $("[id$='rcpBoardBackgroundColor']").addClass("Hide");
                    }
                }
                function ChangeBoardBackgroundColor(sender, eventArgs) {
                    color = sender.get_selectedColor();
                    $("[id$='divBoardBackgroundColor']").css("background-color", color);
                    $("[id$='rcpBoardBackgroundColor']").addClass("Hide");
                }
                function toggleColumnRCP() {
                    if ($("[id$='rcpBoardColumnColor']").hasClass("Hide"))
                        $("[id$='rcpBoardColumnColor']").removeClass("Hide");
                    else
                        $("[id$='rcpBoardColumnColor']").addClass("Hide");
                }
                function ChangeBoardColumnColor(sender, eventArgs) {
                    color = sender.get_selectedColor();
                    $("[id$='divBoardColumnColor']").css("background-color", color);
                    $("[id$='rcpBoardColumnColor']").addClass("Hide");
                }

                function ToggleCopyTasks() {
                    $('[id$=btnCopyTasks]')[0].click();
                }

                function ToggleCopyMembers() {
                    $('[id$=btnCopyMembers]')[0].click();
                }
            </script>
        </telerik:RadCodeBlock>
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
                    <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" AutoPostBack="true" CssClass="small-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndExit" AccessKey="e" Value="SaveAndExit" ValidationGroup="Save" Style="margin-right: -8px !important;">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage TitleToolbarTop" style="margin-bottom: 0 !important;">
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
                                    <asp:LinkButton runat="server" ID="imgDescription" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgDescription','txtDescription'))">
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
                                    EnableVirtualScrolling="true" Height="250px" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBoardBackgroundColor" meta:resourcekey="lblBoardBackgroundColor" runat="server" Text="Background Color"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <div id="divBoardBackgroundColor" class="BoardBackgroundColor" onclick="toggleRCP();" runat="server">
                                    <%-- Testing it out --%>
                                    <%--<svg>
                                        <polygon points="0,0 240,0 240,18 234,24 0,24" style="fill:#c9c9c9;stroke:#ffffff;stroke-width:1;" />
                                    </svg>--%>
                                </div>
                                <telerik:RadColorPicker ID="rcpBoardBackgroundColor" runat="server" OnClientColorChange="ChangeBoardBackgroundColor"
                                    CssClass="Hide NewColorPicker" Columns="18" Width="240px" PaletteModes="WebPalette" PreviewColor="false" ShowEmptyColor="false" />
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
                                    CssClass="Hide NewColorPicker" Columns="18" Width="240px" PaletteModes="WebPalette" PreviewColor="false" ShowEmptyColor="false" />
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="col-4 col-4-right">
					<table class="colTable">
						<tr>
							<td class="labelWidth" style="width: 160px !important;">
								<asp:Label runat="server" ID="lblCopyMembers" Text="Copy Members" meta:Resourcekey="lblCopyMembers"></asp:Label>
							</td>
							<td class="controlWidth">
								<label class="switch" id="lblCopyMembersSwitch" runat="server">
										<input id="chkCopyMembers" runat="server" type="checkbox" checked="checked" onclick="ToggleCopyMembers()" />
										<span class="slider round"></span>
									</label>
                                <asp:Button ID="btnCopyMembers" runat="server" CssClass="Hide"></asp:Button>
							</td>
						</tr>
						<tr>
							<td class="labelWidth" style="width: 160px !important;">
								<asp:Label runat="server" ID="lblCopyTasks" Text="Copy Tasks" meta:Resourcekey="lblCopyTasks"></asp:Label>
							</td>
							<td class="controlWidth">
								<label class="switch" id="lblCopyTasksSwitch" runat="server">
										<input id="chkCopyTasks" runat="server" type="checkbox" checked="checked" onclick="ToggleCopyTasks()"  />
										<span class="slider round"></span>
									</label>
                                <asp:Button ID="btnCopyTasks" runat="server" CssClass="Hide"></asp:Button>
							</td>
						</tr>
						<tr>
							<td class="labelWidth" style="width: 160px !important;">
								<asp:Label runat="server" ID="lblCopySubtasks" Text="Copy Subtasks" meta:Resourcekey="lblCopySubtasks"></asp:Label>
							</td>
							<td class="controlWidth">
								<label class="switch" id="lblCopySubtasksSwitch" runat="server">
										<input id="chkCopySubtasks" runat="server" type="checkbox" checked="checked" />
										<span class="slider round"></span>
									</label>
							</td>

						</tr>
						<tr>
							<td class="labelWidth" style="width: 160px !important;">
								<asp:Label runat="server" ID="lblCopyAssignments" Text="Copy Assignments" meta:Resourcekey="lblCopyAssignments"></asp:Label>
							</td>
							<td class="controlWidth">
								 <label class="switch" id="lblCopyAssignmentsSwitch" runat="server">
										<input id="chkCopyAssignments" runat="server" type="checkbox" checked="checked" />
										<span class="slider round"></span>
									</label>
							</td>
						</tr>
						<tr>
							<td class="labelWidth" style="width: 160px !important;">
								<asp:Label runat="server" ID="lblCopyAttachments" Text="Copy Attachments" meta:Resourcekey="lblCopyAttachments"></asp:Label>
							</td>
							<td class="controlWidth">
								 <label class="switch" id="lblCopyAttachmentsSwitch" runat="server">
										<input id="chkCopyAttachments" runat="server" type="checkbox" checked="checked" />
										<span class="slider round"></span>
									</label>
							</td>
						</tr>
					</table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
