<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostControlOnlineInvoices.aspx.vb" Inherits="Website.CostControlOnlineInvoices" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="CostControlOnlineinvoiceDetails.ascx" tagname="CostControlOnlineinvoiceDetails" tagprefix="uc1" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<script src="JS/Costs/OnlineInvoice.js" type="text/javascript"></script>
<table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar" valign="top">
            <td valign="top">
                <table style="width: 1050px !important;" cellpadding="0" cellspacing="0" >
                    <tr>
                        <td style="padding-left:5px;">
                            <telerik:RadComboBox ID="ddlOnlineInvoices" Runat="server" Filter="Contains" MarkFirstMatch="true"
                                Skin="Default" CloseDropDownOnBlur="true" Width="300px" DropDownWidth="490px" AutoPostBack="True" NoWrap="true"
                                height="250px" CausesValidation="False" CheckForDirt="True">           
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="padding-left:5px;">
                            <telerik:RadToolBar ID="mainToolBar" 
                                runat="server" Skin="Default" AutoPostBack="true">
                                <items>
                                    <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" Tooltip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" Tooltip="Save (Alt+s)" Value="Save"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" Tooltip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>                     
                                </items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width:100%" align="right">                   
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
    </table>
<table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">
                    <table width="1050px">
                        <tr>
                            <td valign="top"  >
                                <table >
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProject"  runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                        </td>
                                        <td>                                            
                                            <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True"
                                                Skin="Default" DropDownWidth="400px" 
                                                Filter="Contains" MarkFirstMatch="true" 
                                                NoWrap="true" Width="250px" Height="300px">
                                            </telerik:RadComboBox>
                                            <asp:CompareValidator ID="cmvProjects" runat="server" 
                                                ControlToValidate="ddlProjects" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:CostManagement, WarningMsg_RequiredProject %>"
                                                ForeColor="" Operator="GreaterThan" ValidationGroup="Save" ValueToCompare="0"></asp:CompareValidator>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap">
                                            <asp:Label ID="lblCommitment" runat="server" Text="<%$Resources:CostManagement, Label_Commitment %>"></asp:Label>
                                        </td>
                                        <td style="width:255px">
                                            <telerik:RadComboBox ID="ddlCommitments" runat="server" Skin="Default" CloseDropDownOnBlur="true" Width="250px"
                                                DropDownWidth="400px" Height="400px" AutoPostBack="True" NoWrap="true" CausesValidation="False">
                                            </telerik:RadComboBox>                                            
                                                                                        
                                            <asp:CompareValidator ID="cmvCommitments" runat="server" ControlToValidate="ddlCommitments"
                                                CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:CostManagement, WarningMsg_SelectCommitments %>"
                                                ForeColor="" Operator="GreaterThan" ValidationGroup="Save" ValueToCompare="0"></asp:CompareValidator>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCompany" runat="server" Text="Subcontractor"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" Width="245px" ID="txtCompany" Text="" ReadOnly="true"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblInvoicenumber" runat="server"  Text="Online Invoice #"></asp:Label>
                                        </td>
                                        <td class="NoWrap" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" Width="30px" ID="txtOnlineInvoiceNumber" CssClass="Right" ReadOnly="true" Text=""></asp:TextBox>
                                                    </td>
                                                    <td align="right">
                                                        <asp:LinkButton ID="btnCreateNext" OnClientClick="DisablePanelAjax()" runat="server" Text="Create Next"  ></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_Status %>"></asp:Label>
                                        </td>
                                        <td>
                                           <asp:TextBox ID="txtStatus" Enabled="false" runat="server" ></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRevision" runat="server" Text="<%$Resources:CostManagement, Label_Revision %>"></asp:Label>
                                        </td>
                                        <td class="NoWrap">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger" Width="30px" Text=""></asp:TextBox>
                                                    </td>
                                                    <td align="right" style="padding-right:10px">
                                                        <asp:Label ID="lblDate"  runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                                    </td>
                                                    <td align="right" style="width:70px">      
                                                        <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01" 
                                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                            Width="70px" Skin="Default" Culture="English (United States)" 
                                                            EnableTyping="False" DatePopupButton-Visible="false">                                                    
                                                            <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProgressinvoicenumber"  runat="server" Text="Progress Invoice #"></asp:Label>
                                        </td>
                                        <td>
                                           <asp:TextBox ID="txtProgressInvoiceNumber" runat="server" Enabled="false" ></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" align="right">
                                <fieldset style="width:500px; text-align:left;">
                                    <legend>
                                        <asp:Label ID="lblContractSnapshot"  runat="server" Text="Submitter Details"></asp:Label>
                                    </legend>
                                    <table style="width: 100%;" cellpadding="2" cellspacing="1">
                                        <tr>
                                            <td class="NoWrap">
                                                <asp:Label ID="lblInvoiceDate" runat="server" Text="Invoice Date" Width="140px"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtpInvoiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Width="120px" Skin="Default" EnableTyping="True">
                                                    <DateInput ID="DateInput2"  Skin="Default"
                                                        runat="server">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblInvoiceDue"  Width="140px" runat="server" Text="Invoice Due"></asp:Label>
                                            </td>
                                            <td>
                                               <telerik:RadDatePicker ID="dtpInvoiceDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Width="120px" Skin="Default" EnableTyping="True">
                                                    <DateInput ID="DateInput3"  Skin="Default"
                                                        runat="server">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblInvoiceType" Width="140px" runat="server" Text="Invoice Type"></asp:Label>
                                            </td>
                                            <td>            
                                            <asp:DropDownList ID="ddlInvoiceType" Width="120px" runat="server">
                                            </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblContact" Width="140px" runat="server" Text="Contact"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContact"  Width="200px"  runat="server"></asp:TextBox>
                                                     <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact"
                                CssClass="Validator" ErrorMessage="<br/>Enter the contact" Display="Dynamic" ForeColor=""
                                ValidationGroup="Save" ></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblComment" runat="server" Text="Comment" Width="140px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtComment" TextMode="MultiLine" Width="350px" Height="40px"  runat="server" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="Width:140px">   
                                            </td>
                                            <td>
                                                <asp:Button
                                                    ID="btnPrint" runat="server" Text="Print Lien Waiver" />
                                                <asp:CheckBox ID="chkSigned" runat="server" Text=" Signed Lien Waiver attached" CssClass="mobile-switch"/>  
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="Width:140px">
                                               
                                            </td>
                                            <td align="right">
                                               <asp:Button
                                                    ID="btnSubmit" runat="server" OnClientClick="DisablePanelAjax()" Text="Submit" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
        <tr id="trTbsDetails" runat="server">
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpContactInvoices"
                                Skin="Default" Width="100%" EnableViewState="false">
                                <tabs>
                            <telerik:RadTab Text="Details" PageViewID="pvDetails"  Value="Details" 
                                Selected="True"/>
                            <telerik:RadTab Text="Notes" Value="Notes" />
                            <telerik:RadTab Text="Attachments" Value="Attachments"  /> 
                            <telerik:RadTab Text="Workflow" Value="Workflow" />       
                        </tabs>
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="mlpContactInvoices" runat="server" SelectedIndex="0" Width="100%"
                                RenderSelectedPageOnly="true" BorderColor="LightBlue" BorderWidth="1">
                                <telerik:RadPageView ID="pvDetails" runat="server">
                                   
                                    <uc1:CostControlOnlineinvoiceDetails ID="CostControlOnlineinvoiceDetails1" 
                                        runat="server" />
                                   
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
                                   
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvAttachments" runat="server">

                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvWorkflow" runat="server">
                                    
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trMplDetails" runat="server" style="padding: 2px 4px 2px 2px">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
