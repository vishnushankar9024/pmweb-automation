<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default12.aspx.vb" Inherits="Website._Default12" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="Message.ascx" tagname="Message" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>PMWeb</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
   <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
   <script src="JS/jquery.min.js" type="text/javascript"></script>
   <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
<script src="JS/PMJS.js" type="text/javascript">
    Sys.Application.add_init(function() {
        $create(Telerik.Web.UI.RadToolBar, { "_cssClass": "", "_rawPostBackReference": "WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(\u0027ctl00$CPH1$mainToolBar\u0027, \u0027{0}\u0027, true, \u0027{1}\u0027, \u0027\u0027, false, true))", "_skin": "Default", "attributes": {}, "clientStateFieldID": "ctl00_CPH1_mainToolBar_ClientState", "collapseAnimation": "{\"duration\":450}", "expandAnimation": "{\"duration\":450}", "itemData": [{ "attributes": { "SecurityButtonType": "Read" }, "value": "Search", "commandName": "Search", "causesValidation": false, "toolTip": "Search", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/lookup.png" }, { "attributes": { "SecurityButtonType": "Add" }, "commandName": "New", "causesValidation": false, "toolTip": "New (Alt+n)", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/NewDoc.png" }, { "attributes": { "SecurityButtonType": "Edit" }, "commandName": "Save", "toolTip": "Save (Alt+s)", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/Save.png" }, { "attributes": { "SecurityButtonType": "Delete" }, "value": "Delete", "commandName": "Delete", "toolTip": "Delete (Alt+d)", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/DeleteDoc.png" }, { "isSeparator": true, "cssClass": " rtbSeparator" }, { "attributes": { "SecurityButtonType": "Edit" }, "commandName": "Notification", "causesValidation": false, "postback": false, "toolTip": "Notification", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/EmailMessage.gif" }, { "attributes": { "SecurityButtonType": "Read" }, "items": [{ "commandName": "ViewTemplates", "postback": false, "toolTip": "Templates", "cssClass": " rtbWrap"}], "commandName": "WordMerge", "postback": false, "enableDefaultButton": false, "type": 2, "toolTip": "Merge to MS Office", "cssClass": " rtbWrap rtbExpandDown", "imageUrl": "Images/ToolBar/Office-icon.png" }, { "attributes": { "SecurityButtonType": "Read" }, "items": [{ "commandName": "ViewReports", "postback": false, "toolTip": "BI Reporting", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/PMWebW.gif" }, { "commandName": "ViewPMWebReports", "postback": false, "toolTip": "PMWeb Reporting", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/PMWebW.gif"}], "commandName": "Print", "postback": false, "enableDefaultButton": false, "type": 2, "toolTip": "Print", "cssClass": " rtbWrap rtbExpandDown", "imageUrl": "Images/ToolBar/Printer.png" }, { "attributes": { "SecurityButtonType": "CreateRevision" }, "commandName": "CreateRevision", "enabled": false, "toolTip": "Create Revision", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/Revision.png" }, { "isSeparator": true, "cssClass": " rtbSeparator" }, { "attributes": { "SecurityButtonType": "Read" }, "commandName": "ExportToExcel", "toolTip": "Export to Excel", "cssClass": " rtbWrap", "imageUrl": "Images/toolbar/Excel.png" }, { "isSeparator": true, "cssClass": " rtbSeparator" }, { "attributes": { "SecurityButtonType": "Edit" }, "items": [{ "commandName": "AutoCAD", "postback": false, "toolTip": "AutoCAD", "cssClass": " rtbWrap" }, { "commandName": "Navisworks", "postback": false, "toolTip": "Navisworks", "cssClass": " rtbWrap" }, { "commandName": "Revit", "postback": false, "toolTip": "Revit", "cssClass": " rtbWrap"}], "commandName": "BIM", "postback": false, "enableDefaultButton": false, "type": 2, "toolTip": "BIM", "cssClass": " rtbWrap rtbExpandDown", "imageUrl": "Images/ToolBar/Revit.png" }, { "attributes": { "SecurityButtonType": "Edit" }, "items": [{ "commandName": "Estimate", "postback": false, "toolTip": "Estimate", "cssClass": " rtbWrap" }, { "commandName": "EstimatesDetail", "postback": false, "toolTip": "Estimates Detail", "cssClass": " rtbWrap" }, { "commandName": "Templates", "postback": false, "toolTip": "Templates", "cssClass": " rtbWrap"}], "commandName": "Import", "postback": false, "enableDefaultButton": false, "type": 2, "toolTip": "Import", "cssClass": " rtbWrap rtbExpandDown", "imageUrl": "Images/ToolBar/Import.png" }, { "items": [{ "commandName": "GeneratePMBudgets", "postback": false, "toolTip": "Generate Budgets", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/PMWebW.gif" }, { "commandName": "GeneratePMContracts", "postback": false, "toolTip": "Generate Commitments", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/PMWebW.gif" }, { "commandName": "GeneratePMProcurements", "postback": false, "toolTip": "Generate Procurements", "cssClass": " rtbWrap", "imageUrl": "Images/ToolBar/PMWebW.gif"}], "commandName": "Generate", "postback": false, "enableDefaultButton": false, "type": 2, "toolTip": "Generate...", "cssClass": " rtbWrap rtbExpandDown", "imageUrl": "Images/ToolBar/Generate.png" }, { "causesValidation": false, "toolTip": "Help", "cssClass": " rtbWrap", "imageUrl": "Images/Toolbar/Help.png"}] }, { "buttonClicked": click_handler, "buttonClicking": OnClientButtonClicking }, null, $get("ctl00_CPH1_mainToolBar"));
    });
    Sys.Application.add_init(function() {
        $create(Telerik.Web.UI.RadComboBox, { "_dropDownWidth": 320, "_height": 390, "_isAspNet35": true, "_showMoreResultsBox": true, "_skin": "Default", "_text": "BCC", "_uniqueId": "ctl00$CPH1$ddlProjects", "_value": "666", "_virtualScroll": true, "allowCustomText": true, "attributes": { "UseProjectFilter": "1" }, "clientStateFieldID": "ctl00_CPH1_ddlProjects_ClientState", "collapseAnimation": "{\"type\":12,\"duration\":200}", "emptyMessage": "Select Project.", "enableLoadOnDemand": true, "enabled": false, "expandAnimation": "{\"duration\":450}", "itemData": [], "localization": "{\"AllItemsCheckedString\":\"All items checked\",\"ItemsCheckedString\":\"items checked\",\"CheckAllString\":\"Check All\"}" }, { "itemsRequesting": OnClientItemsRequesting, "selectedIndexChanged": setdirty2 }, null, $get("ctl00_CPH1_ddlProjects"));
    }); 

</script>
</head>
<body >
    <form id="form1" runat="server">
    <div style="text-align:left">
   <div class="Header">
		</div>
		<telerik:RadScriptManager ID="ScriptManager1" runat="server" />
		<img src="images/login/toplogo.jpg" width="33" height="30" hspace="15" vspace="15">
        <br>
		<table width="650" border="0" cellpadding="0" cellspacing="0" background="images/login/stripes.gif">
			<tr>
				<td width="380" height="199">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="519">
								<img src="images/login/welcome.jpg" width="153" height="26" hspace="80" vspace="8"></td>
						</tr>
						<tr>
							<td valign="top" background="images/login/welcome_line.gif">
								<img src="images/login/bgdot.gif" width="80" height="4"><img src="images/login/welcome_corner.gif" width="4" height="4"></td>
						</tr>
						<tr>
							<td>
								<img src="images/login/graydot.gif" width="1" height="45" hspace="80">
							</td>
						</tr>
						<tr>
							<td>
								<table width="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
									<tr>
										<td height="5" colspan="2" background="images/login/login_border_top.gif">
											<img src="images/login/cleardot.gif" width="1" height="5"></td>
										<td width="5" height="5">
											<img src="images/login/login_corner.gif" width="5" height="5"></td>
									</tr>
									<tr>
										<td width="15" height="180" align="right" class="login_field">
											&nbsp;</td>
										<td height="150" valign="top">
											<br>
												<table border="0" cellspacing="0" cellpadding="0">
												    <tr>
														<td width="50" align="left">
															<asp:Label ID="lblDatabase" meta:resourcekey="lblDatabase" runat="server" CssClass="login_field" Text="Database"></asp:Label>
														</td>
														<td style="padding-left:7px;">
															<telerik:RadComboBox ID="cboDatabases" runat="server" AutoPostBack="true" CausesValidation="false"
															     Skin="Default" CloseDropDownOnBlur="true" Height="150px" Width="190px">       
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td  style="height:0px"></td>
                                                        <td style="padding-left:7px;height:0px">
                                                            <asp:RequiredFieldValidator runat="server" ID="rfvDatabases" ControlToValidate="cboDatabases" CssClass="Validator" ForeColor="" 
                                                                Display="Dynamic" meta:Resourcekey="rfvDatabases"></asp:RequiredFieldValidator>
                                                        </td>
													</tr>
													<tr>
														<td width="50" align="left">
															<asp:Label ID="lblUser" meta:resourcekey="lblUser" runat="server" CssClass="login_field" Text="User"></asp:Label>
														</td>
														<td style="padding-left:7px;">
															<telerik:RadComboBox ID="cboUsers" runat="server" 
															    Filter="Contains" MarkFirstMatch="true" Width="190"
                                                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" Height="300px">       
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td  style="height:0px"></td>
                                                        <td style="padding-left:7px;height:0px">
                                                            <asp:RequiredFieldValidator runat="server" ID="rfvUsers" ControlToValidate="cboUsers" CssClass="Validator" ForeColor="" 
                                                                Display="Dynamic" meta:Resourcekey="rfvUsers"></asp:RequiredFieldValidator>
                                                        </td>
													</tr>
													<tr>
														<td width="50" align="left">
															<asp:Label ID="lblPassword" meta:resourcekey="lblPassword" runat="server" CssClass="login_field"></asp:Label>
														</td>
														<td style="padding-left:7px;">
															<telerik:RadTextBox ID="txtPassword" Runat="server" CausesValidation="True" Width="185px"
                                                                Skin="Default" TextMode="Password">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:0px"></td>
                                                        <td style="padding-left:7px;height:0px">
                                                            <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="txtPassword" CssClass="Validator" ForeColor="" 
                                                                Display="Dynamic" meta:Resourcekey="rfvPassword"></asp:RequiredFieldValidator>
                                                        </td>
													</tr>
													<tr>
														<td width="50" align="right">
															&nbsp;</td>
														<td align="right">
														    <asp:ImageButton ID="ibtLogin" runat="server" ImageUrl="~/Images/Login/Button_login.jpg"/>
														</td>
													</tr>
													<tr>
														<td >
														</td>
														<td>
															    <uc1:Message ID="Message1" runat="server" />
														</td>
													</tr>
													<tr>
														<td colspan="2">
															
														</td>
													</tr>
												</table>
										</td>
										<td width="5" height="180" background="images/login/login_border.gif">
											<img src="images/login/cleardot.gif" width="1" height="150"></td>
									</tr>
									<tr>
										<td height="5" colspan="2" background="images/login/login_border_bot.gif">
											<img src="images/login/cleardot.gif" width="1" height="5"></td>
										<td width="5" height="5">
											<img src="images/login/login_corner_bot.gif" width="5" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td width="270" valign="top">
					<img src="images/login/login_image.jpg" width="147" height="219"><br>
					<img src="images/login/cleardot.gif" width="1" height="25"><br>
					<div class="copyright" style="position:relative;">PMWeb Version <asp:Label runat="server" ID="lblVersionNumber"/></div><br />
					<span class="copyright">© 2008 PMWeb Inc. <asp:Label ID="lblCopyRight" meta:resourcekey="lblCopyRight" runat="server" CssClass="copyright"></asp:Label></span>
					</td>
			</tr>
		</table>
    </div>
    </form>
</body>
</html>
