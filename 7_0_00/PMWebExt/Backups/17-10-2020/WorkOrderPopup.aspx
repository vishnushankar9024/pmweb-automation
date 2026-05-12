<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderPopup.aspx.vb" Inherits="Website.WorkOrderPopup" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="WorkOrderDetails.ascx" tagname="WorkOrderDetails" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Work Order</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
     <style type="text/css">
            body
            {
                background: white none !important;
                 font-family: Arial, Helvetica, sans-serif;
                font-size: 10px; 
                color: #000000;
            }
 </style>
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        function OpenContactPOPUp(URL, Width, Height, AddClose) {
            var wnd = window.radopen(URL);
            wnd.setSize(Width, Height);
            if (AddClose == true) {
                wnd.add_close(WindowContactClosed);
            }
            wnd.Center();
            return false;
        }

        function WindowContactClosed(Opener) {
            var updatePanel = $find($("[id$=RadAjaxPanel1]")[0].id);
            if (updatePanel) { __doPostBack("WorkOrderDetails1_RadAjaxPanel1") }

        }
    </script>
     <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
    <telerik:RadToolBar ID="mainToolBar" Visible="false" runat="server" Skin="Default"  AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" Tooltip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" Tooltip="Save (Alt+s)"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" Tooltip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Cut.gif" ToolTip="Cut" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Copy.gif" ToolTip="Copy" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Paste.gif" ToolTip="Paste" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/EmailMessage.gif" ToolTip="Send Email" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/toolbar/Excel.png" ToolTip="Export to Excel" Enabled="false"></telerik:RadToolBarButton>
                        </Items>
                        </telerik:RadToolBar>
   <table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr>
        <td> 
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                <table style="width: 100%;" >
                <tr>
                <td>
                </td>
                <td></td>
                <td><asp:Label ID="lblRequestId" runat="server" Text="Request Id"></asp:Label></td>
                <td>
                <asp:LinkButton ID="lbtnRequestIdValue" Style="text-decoration: underline;cursor: hand;" Text="000" runat="server"></asp:LinkButton>
                </td>
                </tr>
                    <tr>
                        <td width="10%">&nbsp;Location</td>
                        <td width="40%">
                            <telerik:RadComboBox ID="ddlProperties" Runat="server" Filter="Contains" 
                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" 
                                EmptyMessage="Select Property..." Width="300px" NoWrap ="true" 
                                CausesValidation="False" >                                                               
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                            <asp:TextBox ID="txtProperty" Width="297px" ReadOnly="True"  runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="rfvProperties" runat="server" 
                                ControlToValidate="ddlProperties" CssClass="Validator" ValidationGroup="Save"
                                ErrorMessage="&lt;br&gt;Enter the property" Display="Dynamic" Operator="GreaterThan" ValueToCompare="0" ForeColor=""></asp:CompareValidator>
                        </td>
                        <td width="10%">Submitted By</td>
                        <td width="40%">
                            <asp:TextBox runat="server" ID="txtSubmittedBy"  ReadOnly="true" Width="300px" TabIndex="4"  Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;Description</td>
                        <td>
                            <asp:TextBox runat="server" ID="txtDescription" Width="297px" TabIndex="1" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                                ControlToValidate="txtDescription" CssClass="Validator" ValidationGroup="Save" 
                                ErrorMessage="&lt;br&gt;Enter the description" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                        </td>
                        <td>Assigned To</td>
                        <td><asp:TextBox runat="server" ID="txtAssignedTo" ReadOnly="true"  Width="300px" TabIndex="5"  Enabled="false"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>&nbsp;Status</td>
                        <td>
                        <table width="300px" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="40%">
                                    <telerik:RadComboBox ID="ddlStatus" Runat="server" Filter="Contains" 
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" 
                                        EmptyMessage="Select Status..." Width="100%"  NoWrap ="true" 
                                        CausesValidation="False" TabIndex="2" >                                                               
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </td>
                                <td width="20%">&nbsp;&nbsp;Created</td>
                                <td width="40%">
                                    <telerik:RadDatePicker id="calCreatedDate" Width="100%" Runat="server" 
                                        MinDate="1901-01-01" MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>'
                                            Skin="Default" TabIndex="3" Enabled="false">                                                    
                                        <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" 
                                            TabIndex="3" Runat="server"></DateInput>
                                        <Calendar   Skin="Default" Runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                        </table>
                            
                        </td>
                        <td>Scheduled</td>
                        <td><asp:TextBox runat="server" ID="txtScheduled" Width="300px" TabIndex="6"  Enabled="false"></asp:TextBox></td>
                    </tr>
                </table>
            </telerik:RadAjaxPanel>
        </td>
    </tr>
    <tr>
        <td style="height:8px"></td>
    </tr>
    <tr>
    <td style="width:100%">
        <uc1:WorkOrderDetails ID="WorkOrderDetails1" runat="server" />
    </td>
    
    </tr>
      <tr>
                <td colspan="2" align="right">
                    <asp:LinkButton ID="lbtSave" runat="server" Text="Save" ></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtSaveAndClose" Text="<%$ Resources:PMWeb, SaveClose %>" runat="server"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Close %>"></asp:LinkButton>&nbsp;&nbsp;
                </td>
            </tr>
    </table>
       <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
        InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>
    </form>
</body>
</html>
