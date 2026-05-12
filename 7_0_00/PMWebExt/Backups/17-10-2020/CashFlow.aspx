<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CashFlow.aspx.vb" Inherits="Website.CashFlow" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    
    
<script type="text/javascript">
        function PNCWindowPrintAlfa() {
            document.all.WebBrowser1.ExecWB(7, 2);

      
        } 
 
</script>

<style type="text/css" media="print">
        .NotForPrint{display:none;}
        .ForPrint{display:block;}
        .ChartArea{page-break-after:always;}
    </style>
 <OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" >
      </OBJECT>
         
      <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
          <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="grvItems" >
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grvItems" LoadingPanelID="ldpPM"/>
                    </UpdatedControls>                    
                </telerik:AjaxSetting> 
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
  <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
  
   <div id="CashFlow" style="vertical-align:top;" class="NormalWhiteBack">
    <table width="100%" class="NormalWhiteBack">
    <tr><td><b>Linear Cash Flow</b></td></tr>
    
    <tr>
        <td>
            <table width="800px" class="NotForPrint">
                <tr>
                    <td>Description*</td>
                    <td><asp:TextBox ID="txtDescription" runat="server" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtDescription" CssClass="Validator" ForeColor="" Display="Dynamic" ErrorMessage="<br>Enter the description"></asp:RequiredFieldValidator>
                    </td>
                    <td>Amount*</td>
                    <td><asp:TextBox ID="txtAmount" runat="server" CssClass="PositiveCurrency" MaxLength="13"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtAmount" CssClass="Validator" ForeColor="" Display="Dynamic" ErrorMessage="<br>Enter the amount"></asp:RequiredFieldValidator>
                    </td>
                    <td>Start Date*</td>
                    <td>
                        <telerik:RadDatePicker id="calFromDate" Runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" 
                                Width="100px" Skin="Default">                                                    
                            <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                        <Calendar EnableEmbeddedSkins="true" Skin="Default"></Calendar>
                        </telerik:RadDatePicker>
                    </td>
                    <td>End Date*</td>
                    <td>
                        <telerik:RadDatePicker id="calToDate" Runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                            Width="100px" Skin="Default">                                                    
                        <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default"></DateInput>
                        <Calendar EnableEmbeddedSkins="true" Skin="Default"></Calendar>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="8"><asp:Button ID="btnUpdate" runat="server" Text="Update"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CausesValidation="false"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CausesValidation="false"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" id="btnPrint" onclick="PNCWindowPrintAlfa();" 
                            value="Print" />
                    </td>
                    
                </tr>
                <tr>
                    <td colspan="6"></td>
                    <td colspan="2"><asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="calToDate" CssClass="Validator" ForeColor="" Display="Static" ErrorMessage="Ending should be greater than starting date" Type="Date" ControlToCompare="calFromDate" Operator="GreaterThanEqual"></asp:CompareValidator></td>
                </tr>
            </table>
        </td>
      </tr>
      
    <tr>
    <td style="vertical-align:top">
    <asp:GridView ID="grvCash" runat="server"  CellPadding="4" Width="100%" AutoGenerateColumns="True" ShowFooter="true">
  
               <Columns>   
               
                           <asp:TemplateField HeaderText="" ItemStyle-Wrap="false" HeaderStyle-CssClass="NotForPrint" FooterStyle-CssClass="NotForPrint" ItemStyle-CssClass="NotForPrint"> 
                            
                             <ItemTemplate>
                                
                                 <asp:LinkButton runat="server" ID="ibtEdit" AlternateText="Edit" CommandName="Edit" CausesValidation="false" CommandArgument='<%#Container.DataItem("Id")%>'  CssClass="EditButton">
    					            <span class="Icon"></span>
				                </asp:LinkButton>

                             </ItemTemplate>
                        </asp:TemplateField>                  
                          
               </Columns>
                <EmptyDataTemplate>
                    <table style="height:200px;width:100%">
                        <tr>
                            <td>Add items from the form below</td>
                        </tr>
                    </table>
               </EmptyDataTemplate>
               <EmptyDataRowStyle HorizontalAlign="Center" />
                 <AlternatingRowStyle Wrap="false" />
                <RowStyle Wrap="false" />
                <FooterStyle Wrap="false" />
               
             <HeaderStyle CssClass="td0"  Wrap="false"/>
            </asp:GridView> 
      </td>
      </tr>
     <tr>
    <td align="center" valign="top">&nbsp;
    </td>
    </tr>
   
    <tr >
    <td align="center" valign="top">


        
        <telerik:RadChart ID="chrtCashFlow1" runat="server" Width="900px"
            Skin="LightBlue" AutoLayout="True" AutoTextWrap="True" 
            CreateImageMap="False" IntelligentLabelsEnabled="True" UseSession="False">
        <Series>
            <telerik:ChartSeries Name="Cash">
                  <Appearance BarWidthPercent="30">
                    <FillStyle FillType="ComplexGradient" MainColor="243, 206, 119">
                        <FillSettings>
                            <ComplexGradient>
                                <telerik:GradientElement Color="243, 206, 119" />
                                <telerik:GradientElement Color="236, 190, 82" Position="0.5" />
                                <telerik:GradientElement Color="210, 157, 44" Position="1" />
                            </ComplexGradient>
                        </FillSettings>
                    </FillStyle>
                    <TextAppearance TextProperties-Color="112, 93, 56">
                    </TextAppearance>
                    <Border Color="223, 170, 40" />
                </Appearance>
            </telerik:ChartSeries>
        </Series>
        <PlotArea>
            <XAxis>
                <Appearance Color="153, 187, 208" MajorTick-Color="153, 187, 208">
                    <MajorGridLines Color="153, 187, 208" Width="0" />
                    <TextAppearance TextProperties-Color="72, 124, 160">
                    </TextAppearance>
                </Appearance>
                <AxisLabel>
                    <TextBlock>
                        <Appearance TextProperties-Color="72, 124, 160">
                        </Appearance>
                    </TextBlock>
                </AxisLabel>
            </XAxis>
            <YAxis>
                <Appearance Color="153, 187, 208" MajorTick-Color="153, 187, 208" 
                    MinorTick-Color="153, 187, 208">
                    <MajorGridLines Color="153, 187, 208" />
                    <MinorGridLines Color="153, 187, 208" />
                    <TextAppearance TextProperties-Color="72, 124, 160">
                    </TextAppearance>
                </Appearance>
                <AxisLabel>
                    <TextBlock>
                        <Appearance TextProperties-Color="72, 124, 160">
                        </Appearance>
                    </TextBlock>
                </AxisLabel>
            </YAxis>
            <Appearance Dimensions-Margins="18%, 23%, 12%, 10%">
                <FillStyle MainColor="255, 255, 238" SecondColor="Transparent">
                </FillStyle>
                <Border Color="153, 187, 208" />
            </Appearance>
        </PlotArea>
        <Appearance>
            <FillStyle MainColor="240, 252, 255">
            </FillStyle>
            <Border Color="182, 224, 249" />
        </Appearance>
        <ChartTitle>
            <Appearance>
                <FillStyle MainColor="">
                </FillStyle>
            </Appearance>
            <TextBlock Text="Cash Flow">
                <Appearance TextProperties-Color="8, 103, 166">
                </Appearance>
            </TextBlock>
        </ChartTitle>
        <Legend>
            <Appearance Corners="Round, Round, Round, Round, 6">
                <ItemTextAppearance TextProperties-Color="62, 117, 154">
                </ItemTextAppearance>
                <Border Color="208, 237, 255" />
            </Appearance>
        </Legend>
        </telerik:RadChart>

        
        </td>
      </tr>
      <tr>
    <td align="center" valign="top" style="height:100px">&nbsp;
    </td>
    </tr>
      </table>
    </div>
    
</asp:Content>
