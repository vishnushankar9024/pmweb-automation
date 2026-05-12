<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CompaniesListPopup.aspx.vb" meta:resourcekey="Page"
    Inherits="Website.CompaniesListPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Companies</title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css"> 
    html, body, form 
    { 
        height: 100%; 
        margin: 0px; 
        padding: 0px; 
    } 
    .TSearchButton
{
	background:#FFFFFF url(../Images/Toolbar/lookup1.png) no-repeat 236px 0px !important;
	padding:4px 4px 4px 27px;
	border:1px solid #CCCCCC;
	width:255px !important;
	height:10px;
}
 
input[type="button"], input[type="submit"]
{
	
	width: 60px;
	 border-left:none;
	font-size: 10px;
	cursor: pointer;
}

	input[type="button"].middle, input[type="submit"].middle
{
	 border-left:none !important;
	 width: 60px;
	font-size: 10px;
	cursor: pointer;
}

		
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            function rdgCompanies_onNodeDropping(sender, args) {
                var IsDroppingOnGrid = $(args._htmlElement).parents().filter("[id$=rdgCompanies]").length > 0 ;
                      if (!IsDroppingOnGrid){
                          args.set_cancel(true);
                    }else{
                      droppedOnGrid(args);
                    }
                }

                function droppedOnGrid(args) {
                    var gridId = "<%= rdgCompanies.ClientID %>";
                    var target = args.get_htmlElement();
                    while (target) {
                        if (target.id == gridId) {
                            args.set_htmlElement(target);
                            return;
                        }

                        target = target.parentNode;
                    }
                    args.set_cancel(true);
                }

        $(document).ready(function() {
            $("a[id$=btnClose]").click(function() { CloseRadWnd(); return false; });
        });

        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxLoadingPanel ID="ldpPopup" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center"/>
    <telerik:RadAjaxManager ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="trvCompanies">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCompanies" LoadingPanelID="ldpPopup" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlGroupBy">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvCompanies" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManager><table width="100%" class="NormalWhiteBack" cellpadding="0" cellspacing="0">
        <tr class="ToolBar" >
                    <td>
                    <asp:Label runat="server" ID="lblGroupBy" Text="Group By" meta:ResourceKey="lblGroupBy" />&nbsp;
                        <asp:DropDownList runat="server" ID="ddlGroupBy" Width="216px" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
        
        </table>
    <telerik:RadSplitter ID="rsCompanies" runat="server" Orientation="Vertical" Height="100%"  
        Width="100%">
        <telerik:RadPane ID="rdCompaniesTree" runat="server" Width="300px"  Height="100%" MinWidth="285">
        
            <table width="100%" class="NormalWhiteBack" cellpadding="1 cellspacing="1" border="0">
                
                <tr>
                
                <td>
                   <asp:Panel style="padding-left:4px" ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                            <telerik:RadTextBox ID="txtSearch" EmptyMessage="<%$Resources: txtSearchEmptyMessage %>"  EmptyMessageStyle-Font-Italic="true" Maxlength="100" CssClass="TSearchButton" runat="server" ></telerik:RadTextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Hide" />
              
          
                    </asp:Panel> 
                   
                    <table>
                    <tr>
                    <td>
                    <telerik:RadButton ID="btnTType" AutoPostBack="false"  meta:ResourceKey="btnTType"   Text="Type" GroupName="G"   runat="server" ToggleType="Radio" ButtonType="StandardButton" >
              
              </telerik:RadButton>
                    
                    </td>
                    <td>
                       <telerik:RadButton ID="btnName"  AutoPostBack="false" meta:ResourceKey="btnName"   Text="Company" GroupName="G"   runat="server" ToggleType="Radio" ButtonType="StandardButton" >
              
              </telerik:RadButton> 
                    </td>
                    <td>
                       <telerik:RadButton ID="btnState"  meta:ResourceKey="btnState"  AutoPostBack="false"  Text="State" GroupName="G"   runat="server" ToggleType="Radio" ButtonType="StandardButton" >
              
              </telerik:RadButton> 
                    </td>
                    <td>
                       <telerik:RadButton ID="btnAll"  AutoPostBack="false" meta:ResourceKey="btnAll"  Text="All" GroupName="G"   runat="server" ToggleType="Radio" ButtonType="StandardButton" >
              
              </telerik:RadButton> 
                    </td>
                    </tr>
                    
                    </table>
                          
            
                </td>
                </tr>
                <tr>
                    <td class="Padding7">
                        <telerik:RadTreeView ID="trvCompanies" runat="server" EnableDragAndDrop="True"
                            OnNodeDrop="trvCompanies_NodeDrop" MultipleSelect="true" OnClientNodeDropping="rdgCompanies_onNodeDropping">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                        </telerik:RadTreeView>
                    </td>
                </tr>
            </table>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="rsbar1" runat="server"  />
        <telerik:RadPane ID="rpCompaniesSelected" runat="server">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="Top" style="width:100%">
                        <telerik:RadGrid ID="rdgCompanies" runat="server" AllowMultiRowSelection="true" 
                            AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                            Width="100%">
                            <HeaderStyle Font-Size="8pt" />
                            <ClientSettings Selecting-AllowRowSelect="true"  >
                                <Selecting AllowRowSelect="True"  />
                            </ClientSettings>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                CommandItemDisplay="Top">
                                <CommandItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                        SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" >
                                       <span class="Icon"></span>
                                        <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                </CommandItemTemplate>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Company" UniqueName="ComanyName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblComanyName" runat="server" Visible="true" Text='<%#Eval("Value")%>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView></telerik:RadGrid>
                    </td>
                </tr>
                <tr>
                    <td class="Right">
                        <asp:LinkButton runat="server" ID="btnSave" Text="<%$Resources:PMWeb, SaveClose %>" />
                        &nbsp;&nbsp;
                        <asp:LinkButton runat="server" ID="btnClose" Text="<%$Resources:PMWeb, Close %>" />
                    </td>
                </tr>
            </table>
        </telerik:RadPane>
    </telerik:RadSplitter>
    </form>
</body>
</html>
