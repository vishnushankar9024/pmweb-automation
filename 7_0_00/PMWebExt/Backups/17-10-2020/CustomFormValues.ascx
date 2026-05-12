<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormValues.ascx.vb" Inherits="Website.CustomFormValues" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<table cellpadding="0" cellspacing="0" width="100%" id="tblValues" runat="server" style="border-width:0px">
    <tr>
        <td id="tdDataTypes" runat="server" style="border-width:0px">
          <telerik:RadComboBox ID="ddlDataTypes" runat="server" Width="100px" AutoPostBack="true"
            Skin="Default" style="font-size:11px" CausesValidation="false">
            <Items>
                <telerik:RadComboBoxItem Text="String" Value="String" />
                <telerik:RadComboBoxItem Text="Integer" Value="Integer" />
                <telerik:RadComboBoxItem Text="Double" Value="Double" />
                <telerik:RadComboBoxItem Text="Currency" Value="Currency" />
                <telerik:RadComboBoxItem Text="Date" Value="Date" />
                <telerik:RadComboBoxItem Text="Cost Code" Value="CostCode" />
                <telerik:RadComboBoxItem Text="List" Value="List" />
                <telerik:RadComboBoxItem Text="Boolean" Value="Boolean" />
            </Items>
            <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
        </td>
        <td id="tdOptions" runat="server" style="border-width:0px">
            <telerik:RadComboBox ID="ddlTextMode" runat="server" Width="80px" 
                Skin="Default" style="font-size:11px" AutoPostBack="true"  CausesValidation="false">
                <Items>
                    <telerik:RadComboBoxItem Text="Single Line" Value="SingleLine" />
                    <telerik:RadComboBoxItem Text="Multi Line" Value="MultiLine" />
                </Items>
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>&nbsp;&nbsp;
             <telerik:RadNumericTextBox 
                                EmptyMessage="Height..." 
                                Type="Number"
                                width="50px"
                                ID="rnbHeight"
                                runat="server" Skin="Default">
                            </telerik:RadNumericTextBox>&nbsp;&nbsp;
              <telerik:radtextbox Width="250px" id="txtLists" runat="server" EmptyMessage="Enter a list of values separated with a ' ; '" Skin="Default"> 
              </telerik:radtextbox>&nbsp;&nbsp;
              <telerik:RadComboBox ID="ddlDateMode" runat="server" Width="80px" 
                Skin="Default" style="font-size:11px" AutoPostBack="true"  CausesValidation="false">
                 <Items>
                    <telerik:RadComboBoxItem Text="Fix Date" Value="FixDate" />
                    <telerik:RadComboBoxItem Text="Today" Value="Today" />
                </Items>
                <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>&nbsp;&nbsp;
            <telerik:RadDatePicker id="calDefaultDate" Runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>'
                            Width="100px" Skin="Default">                                                    
                        <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                        <Calendar   Skin="Default"></Calendar>
              </telerik:RadDatePicker>
            <telerik:RadNumericTextBox 
                EmptyMessage="Days offset ..." 
                ShowSpinButtons="True"
                Type="Number"
                width="50px"
                ID="rnbDaysOffset"
                runat="server" Skin="Default">
            </telerik:RadNumericTextBox>


        </td>
         <td id="tdValues" runat="server" style="border-width:0px">
            <asp:TextBox ID="txtValues" runat="server" Width="300px"></asp:TextBox>
            <asp:CheckBox ID="chkValue" runat="server" CssClass="mobile-switch"/>
            <span runat="server" id="rmd_calValue" style="display:block">
            <telerik:RadDatePicker id="calValue" Runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                            Width="204px" Skin="Default">                                                    
                        <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                        <Calendar   Skin="Default"></Calendar>
              </telerik:RadDatePicker></span>
              <telerik:RadComboBox ID="ddlValues" Filter="Contains" DropDownType=""  DropDownValue=""  MarkFirstMatch="true"  runat="server" Width="300px"
            Skin="Default" style="font-size:11px" NoWrap="true" Height="450px" AutoPostBack="False"  AllowCustomText="True" CausesValidation="False" 
           EnableLoadOnDemand="True" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddlCustomFields_ItemsRequested">
            <CollapseAnimation Duration="200" Type="OutQuint" />
            </telerik:RadComboBox>
            <asp:RequiredFieldValidator ID="rfvField" runat="server" ValidationGroup="Save"
            CssClass="Validator" ErrorMessage='<%#CStr(HttpContext.GetLocalResourceObject("~/CustomForms.aspx", "RfvRequiredMsg")) %>' Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
        </td>
    </tr>
</table>