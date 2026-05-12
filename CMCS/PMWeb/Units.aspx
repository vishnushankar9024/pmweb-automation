<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master" CodeBehind="Units.aspx.vb" Inherits="Website.Units" 
    %>
     <%@ Register src="UnitDetails.ascx" tagname="UnitDetails" tagprefix="uc1" %>
     <%@ Register Src="ngDocNotes.ascx" tagname="DocumentNotes" tagprefix="uc4" %>
     <%@ Register Src="ngDocAttachments.ascx" tagname="DocumentAttachments" tagprefix="uc5" %>
     <%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
     <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
 <%@ Register src="AssetTypeEquipments.ascx" tagname="AssetTypeEquipments" tagprefix="uc8" %>
  <%@ Register src="AssetTypeWorkOrder.ascx" tagname="AssetTypeWorkOrder" tagprefix="uc9" %>
    <%@ Register src="UnitSpaces.ascx" tagname="UnitSpaces" tagprefix="uc10" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ACPH1" runat="server">

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
<script type ="text/javascript">
    function AssetEquipmentRowClick(sender, eventArgs) {
        window.location = "Equipments.aspx?Id=" + eventArgs.getDataKeyValue("Id");
    }
    function AssetWorkOrderRowClick(sender, eventArgs) {
        window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
    }
    function rdvOwnerNodeClicking(sender, args) {
        var comboBox = $find($("[id$=ddlOwnerContacts]")[0].id);
        var node = args.get_node();

        var strText = "";
        var strValue = "";
        strValue = node.get_value();
        if (strValue.indexOf("P") < 0) {
            comboBox.set_text("");
            comboBox.trackChanges();
            comboBox.get_items().getItem(0).set_value(0);
            comboBox.commitChanges();
            comboBox.hideDropDown();
            return;
        }
        while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
            strText = "/" + node.get_text() + strText;
            node = node.get_parent();
        }
        strText = strText.substr(1, strText.toString().length - 1);

        comboBox.set_text(strText);
        comboBox.trackChanges();
        comboBox.get_items().getItem(0).set_value(strValue);
        comboBox.commitChanges();
        comboBox.hideDropDown();
    }

</script>           

</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="tbsDocument">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpUnits" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="mlpUnits">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpUnits" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
          <telerik:AjaxSetting AjaxControlID="ddlProperties">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlProperties" />
                     <telerik:AjaxUpdatedControl ControlID="txtCode" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr valign="top">
        <td valign="top">
           <table style="width: 100%;" cellpadding="0" cellspacing="0" >
            <tr class="ToolBar">
               <td style="width: 290px;"> &nbsp;                  
                <telerik:RadComboBox ID="ddlUnits" Runat="server" Filter="Contains" 
                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"  CheckForDirt="True"
                        EmptyMessage="Select Unit..." Width="280px" AutoPostBack="True" NoWrap ="true" 
                        CausesValidation="False" DropDownWidth="350px" >                                                               
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default"  AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" Tooltip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" Tooltip="Save (Alt+s)"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" Tooltip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" Enabled="false" CommandName ="Print"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Cut.gif" ToolTip="Cut" Enabled="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Copy.gif" ToolTip="Copy" Enabled="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Paste.gif" ToolTip="Paste" Enabled="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/EmailMessage.gif" ToolTip="Send Email" Enabled="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/toolbar/Excel.png" ToolTip="Export to Excel" Enabled="false"></telerik:RadToolBarButton>
                    </Items>
                    </telerik:RadToolBar>
                </td>  
             </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height:8px"></td>
    </tr>
   
    
     </table>
 
<table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr>
        <td>
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                <table >
                   <tr>
                        <td width="50px">  &nbsp;&nbsp;</td>
                        <td width="360px"> &nbsp;&nbsp;</td> 
                        <td width="125px"> &nbsp;&nbsp;</td>  
               <%--         <td align="center" width="150px"> <b>Market</b></td>
                        <td align="center" width="150px"> <b>Current</b></td>--%>
                       
                    </tr>
                    <tr>
                        <td style="width:20px">
                            <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location"></asp:Label>
                         </td>
                        <td>
                            <telerik:RadComboBox ID="ddlProperties" Runat="server" Filter="Contains" 
                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" 
                                 Width="260px" NoWrap ="true" 
                                CausesValidation="False" AutoPostBack="true" >                                                               
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                            <asp:CompareValidator ID="rfvLocation"  meta:resourcekey="rfvLocation" runat="server" 
                                ControlToValidate="ddlProperties" CssClass="Validator" ValidationGroup="Save" 
                                ErrorMessage="<br/>Enter the Location" Display="Dynamic" ValueToCompare="0" Operator="GreaterThan" ForeColor=""></asp:CompareValidator>
                        </td> 
                <%--        <td>Rent/Month</td>  
                        <td>
                           <telerik:RadNumericTextBox id="txtMonthlyRentMarket" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>
                        <td>
                           <telerik:RadNumericTextBox id="txtMonthlyRentCurrent" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>--%>
                        <td> 
                        </td>
                    
                    </tr>
                    <tr>
                        <td> <asp:Label ID="lblUnitID" meta:resourcekey="lblUnitID" runat="server" Text="Unit ID"></asp:Label> </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtCode" Width="250px"  ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvID" meta:resourcekey="rfvID" runat="server" 
                                ControlToValidate="txtCode" CssClass="Validator" ValidationGroup="Save" 
                                ErrorMessage="<br/>Enter the ID" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                          <asp:Label ID="lblIDUnique" meta:resourcekey="lblIDUnique" Text="<br/> Unit ID should be unique by location." CssClass="Validator" runat="server" Visible="false" ></asp:Label>
                        </td> 
                        <%--<td>Rent/Year</td>  --%>
                     <%--   <td>
                            <telerik:RadNumericTextBox id="txtYearlyRentMarket" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        <td>
                            <telerik:RadNumericTextBox id="txtYearlyRentCurrent" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>--%>
                    
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td> <asp:Label ID="lblName" meta:resourcekey="lblName" runat="server" Text="Name"></asp:Label>  </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtName" Width="250px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" meta:resourcekey="rfvName" runat="server" 
                                ControlToValidate="txtName" CssClass="Validator" ValidationGroup="Save" 
                                ErrorMessage="<br/>Enter the Name" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                        </td> 
                        <td></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblUnitType" meta:resourcekey="lblUnitType" runat="server" Text="Unit Type"></asp:Label></td>
                        <td>
                            <telerik:RadComboBox ID="ddlUnitTypes" Runat="server" Filter="Contains" 
                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" 
                                Width="155px" NoWrap ="true" 
                                CausesValidation="False">                                                               
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td> 
                        <td></td>
                    </tr>
                    <tr>
                           <td><asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="Status"></asp:Label></td>
                        <td>
                           <telerik:RadComboBox ID="ddlStatus" Runat="server" Filter="Contains" 
                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" 
                                EmptyMessage="Select Status..." Width="155px" NoWrap ="true" 
                                CausesValidation="False">                                                               
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td> 
                     
                   <%--     <td>Rent/UOM/Month</td>  
                        <td>
                           <telerik:RadNumericTextBox id="txtMonthlyUOMRentMarket" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>
                        <td>
                            <telerik:RadNumericTextBox id="txtMonthlyUOMRentCurrent" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>--%>
                        <td></td>
                    </tr>
                    <tr>
                     <%--   <td class="NoWrap">Calculated Sqft </td>--%>
                        <td>
              <%--              <telerik:RadNumericTextBox id="txtCalculatedSqft" CssClass="Right" runat="server" Type="Number"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>--%>
                        </td> 
                      <%--  <td>Rent/UOM/Year</td>  
                        <td>
                            <telerik:RadNumericTextBox id="txtYearlyUOMRentMarket" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>
                        <td>
                             <telerik:RadNumericTextBox id="txtYearlyUOMRentCurrent" CssClass="Right" runat="server" Type="Currency"  Width="150px" MinValue="0">
                                <NumberFormat DecimalDigits="3" />
                           </telerik:RadNumericTextBox>
                        </td>--%>
                        <td></td>
                    </tr>
                    <tr>
                  
                        <td></td>  
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                      
                        <td></td>  
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </telerik:RadAjaxPanel>
        </td>
    </tr>
       
    <tr>
        <td>
            
        </td>
    </tr>
    <tr>
        <td style="height:8px"></td>
    </tr>
   
    <tr id="trTbsDetails" runat="server">
        <td >                         
            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" 
                runat="server" MultiPageID="mlpUnits" Skin="Default" 
                    OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="False">
                <Tabs>
                    <telerik:RadTab Text="Details" Value="Details"/>                   
                    <telerik:RadTab Text="Assets" Value="Assets" />
                    <%-- <telerik:RadTab Text="Rent" Value="Rent"/>
                     <telerik:RadTab Text="Tenants" Value="Tenants"/>
                     <telerik:RadTab Text="Projects" Value="Projects"/>--%>
                     <telerik:RadTab Text="Work Orders" Value="WorkOrders"/>
                     <telerik:RadTab Text="Equipment" Value="Equipment"/>
                     <telerik:RadTab Text="Notes" Value="Notes"/>
                     <telerik:RadTab Text="Attachments" Value="Attachments"/>
                     <telerik:RadTab Text="Workflow" Value="Workflow" />
                </Tabs>
            </telerik:RadTabStrip>
        </td>
    </tr>
    <tr id="trMplDetails" runat="server" >
          <td >
              <telerik:RadMultiPage ID="mlpUnits" runat="server" SelectedIndex="0"  
                    Width="100%" RenderSelectedPageOnly="true" BorderColor="LightBlue" BorderWidth="1">
                    <telerik:RadPageView ID="pvDetails" runat="server">
                        <uc1:UnitDetails ID="UnitDetails" runat="server" />
                    </telerik:RadPageView>
                 <telerik:RadPageView ID="pvAssets" runat="server">
                  <uc10:UnitSpaces ID="UnitSpaces" runat="server" />
                    </telerik:RadPageView>
                   <%--    <telerik:RadPageView ID="pvRent" runat="server">
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvTenants" runat="server">
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvProjects" runat="server">
                    </telerik:RadPageView>--%>
                    <telerik:RadPageView ID="pvWorkOrders" runat="server">
                     <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvEquipment" runat="server">
                    <uc8:AssetTypeEquipments ID="AssetTypeEquipments" runat="server" />  
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server">
                        <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAttachments" runat="server">
                        <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvWorkflow" runat="server">
                        <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
        </td>
    </tr>
    
    </table>
   <telerik:RadAjaxLoadingPanel ID="ldpUnits" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
</asp:Content>