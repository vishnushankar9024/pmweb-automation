<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProgramDetails.ascx.vb" Inherits="Website.ProgramDetails" %>
<table style="">
<tr>
<td valign="top" style="">
<fieldset style="height:460px;">
<legend>
<asp:Label ID="lblProgram" meta:Resourcekey="lblProgram" runat="server" Text="Program"></asp:Label>
</legend>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblDirector" meta:Resourcekey="lblDirector" runat="server" Text="Director"></asp:Label>
            </td>
            <td style="width:215px;">
                <asp:TextBox ID="txtDirector" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td >
                <asp:Label ID="lblProgramManager" meta:Resourcekey="lblProgramManager" runat="server"
                    Text="Manager"></asp:Label>
            </td>
            <td >
                <asp:TextBox ID="txtManager" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="NoWrap" >
                <asp:Label ID="lblProgramManager1" meta:Resourcekey="lblProgramManager1" runat="server"
                    Text="Program Manager"></asp:Label>
            </td>
            <td >
                  <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="205px" DropDownWidth="300px" 
                        Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select Company..." 
                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td class="NoWrap">
                <asp:Label ID="lblProgramType" meta:Resourcekey="lblProgramType"  runat="server" Text="Program Type"></asp:Label>
            </td>
            <td >
                <telerik:RadComboBox ID="ddlTypes" runat="server" Width="205px" meta:Resourcekey="ddlTypes" AllowCustomText="true"
                    EmptyMessage="Select Type..." Skin="Default" style="font-size: 11px">
                    <collapseanimation duration="200" type="OutQuint" />
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td class="NoWrap">
                <asp:Label ID="lblProgramStatus" meta:Resourcekey="lblProgramStatus" runat="server"
                    Text="Program Status"></asp:Label>
            </td>
            <td >
                <telerik:RadComboBox ID="ddlStatuses" runat="server" Width="205px" meta:Resourcekey="ddlStatuses" AllowCustomText="true"
                    EmptyMessage="Select Status..." Skin="Default" style="font-size: 11px">
                    <collapseanimation duration="200" type="OutQuint" />
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td  class="NoWrap">
                <asp:Label ID="lblEstimatedDuration" meta:Resourcekey="lblEstimatedDuration" runat="server"
                    Text="Estimated Duration"></asp:Label>
            </td>
            <td  class="NoWrap">
                <asp:TextBox ID="txtEstimatedDuration" MaxLength="255" runat="server" Width="200px"></asp:TextBox>
            </td>
      
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblEstimatedCost" meta:Resourcekey="lblEstimatedCost" runat="server"
                    Text="Estimated Cost"></asp:Label>
            </td>
            <td >
                <asp:TextBox ID="txtEstimatedCost" MaxLength="15" CssClass="Currency" runat="server"
                    Width="100px"></asp:TextBox>
                    
            </td>
        </tr>
        <tr>
            <td class="Top">
                <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server" Text="Upload Logo"></asp:Label>
            </td>
            <td>
                <div style="padding: 10px">
                    <asp:Image ID="imglogo" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Width="210px"  Height="70px" />
                </div>
                <div>
                    <asp:FileUpload ID="FileToUpload" runat="server" Width="280px" />
                </div>
            </td>
        </tr>
    </table>
</fieldset>
</td>

<td valign="top" >

<fieldset>
<legend>
<asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
</legend>
<table style="width: 100%; height: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td valign="top">
                        <table style="width: 100%;"  cellpadding="0" cellspacing="5" border="0">
                            
                            <tr>
                                <td>
                                      <asp:Label ID="lblClient" meta:resourcekey="lblClient" runat="server" Text="Client"
                                        Width="60px"></asp:Label></td>
                                <td>
                                   <%--  <asp:DropDownList ID="ddlClients" runat="server" Width="220px">
                                    </asp:DropDownList>--%>
                  <telerik:RadComboBox ID="ddlClients" runat="server" Width="205px" DropDownWidth="300px" 
                        Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select ..." 
                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlClients"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                                    
                                    </td>
                                <td>
                                    <asp:Label ID="lblCity" meta:resourcekey="lblCity" runat="server" Text="City"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Width="220px"></asp:TextBox>
                                </td>
                            
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblGC" meta:resourcekey="lblGC" runat="server" Text="GC"></asp:Label>
                                </td>
                                <td  >
                                   <%-- <asp:DropDownList ID="ddlGCs" runat="server" Width="220px">
                                    </asp:DropDownList>--%>
                                      <telerik:RadComboBox ID="ddlGCs" runat="server" Width="205px" DropDownWidth="300px" 
                        Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select ..." 
                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlGCs"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server" Text="State"></asp:Label>
                                </td>
                                <td >
                                                <telerik:RadComboBox ID="ddlStates" runat="server" Width="103px" Skin="Default" Style="font-size: 11px" 
                                                    NoWrap="true" Height="350px" AllowCustomText="true" Filter="Contains" >
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                        <td >
                                    <asp:Label ID="lblArchitect" meta:resourcekey="lblArchitect" runat="server" Text="Architect"></asp:Label>
                                </td>
                                <td  >
                                  <%--  <asp:DropDownList ID="ddlArchitects" runat="server" Width="220px">
                                    </asp:DropDownList>--%>
                                        <telerik:RadComboBox ID="ddlArchitects" runat="server" Width="205px" DropDownWidth="300px" 
                        Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select ..." 
                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlArchitects"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server" Text="Country"></asp:Label>
                                </td>
                                <td >
                                    <telerik:RadComboBox ID="ddlCountries" Width="205px" Height="350px" AllowCustomText="true" Filter="Contains" 
                                     runat="server" Skin="Default"
                                        Style="font-size: 11px">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                    
                            </tr>
                            <tr>
                              <td >
                                    <asp:Label ID="lblManager" meta:resourcekey="lblManager" runat="server" Text="Manager"></asp:Label>
                                </td>
                                <td >
                                    <asp:TextBox ID="txtProjectManager" runat="server" MaxLength="100" Width="201px"></asp:TextBox>
                                </td>
                                <td>
                                   <asp:Label ID="lblProjectType" meta:Resourcekey="lblProjectType" runat="server" Text="Project Type"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="ddlProjectTypes" runat="server" Width="205px" meta:Resourcekey="ddlTypes" AllowCustomText="true"
                                EmptyMessage="Select Type..." Skin="Default" style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox></td>
                              
                            </tr>
                            <tr>
                                <td>
                                    <asp:HyperLink runat ="server" CssClass ="Link" ID="hplCurrency" Height="16px" meta:Resourcekey="hplCurrency" Text="Currency11" ></asp:HyperLink>
                                </td>
                                <td >
                                     <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="205px" Height="250px" Skin="Default" style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox> </td>
                                <td>
                                   <asp:Label ID="lblProjectStatus" meta:Resourcekey="lblProjectStatus" runat="server"
                                Text="Project Status"></asp:Label></td>
                                <td>
                                  <telerik:RadComboBox ID="ddlProjectStatuses" runat="server" Width="205px" meta:Resourcekey="ddlStatuses" AllowCustomText="true"
                                EmptyMessage="Select Status..." Skin="Default" style="font-size: 11px">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>  </td>
                     
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTargetBudget" meta:Resourcekey="lblTargetBudget" runat="server" Text="Target Budget"></asp:Label>
                                      </td>
                                <td >
                                      <asp:TextBox ID="txtTargetBudget" MaxLength="15" CssClass="Currency" runat="server" Width="68px"></asp:TextBox>  
                                      </td>
                                <td >
                                    &nbsp;</td>
                                <td  align="right">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label  ID="lblTargetRevenue" meta:Resourcekey="lblTargetRevenue" runat="server" Text="Target Revenue"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTargetRevenue" MaxLength="15" CssClass="Currency" runat="server" Width="68px"></asp:TextBox>
                                </td>
                                <td >
                                    &nbsp;</td>
                                <td  align="right">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label  ID="lblTargetDuration" meta:Resourcekey="lblTargetDuration" runat="server" Text="Target Duration"></asp:Label>
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="width:90px;">
                                                <asp:TextBox ID="txtTargetDuration" CssClass="Double" runat="server" Width="68px"></asp:TextBox>
                                            </td>
                                            <td style="width:35px;">
                                                <asp:Label  ID="lblUOM" meta:Resourcekey="lblUOM" runat="server" Text="UOM"></asp:Label>
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="ddlUOM" Width="78px" AllowCustomText="true" runat="server"></telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td >
                                    &nbsp;</td>
                                <td  align="right">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                            <td >
                                    &nbsp;</td>
                            <td >
                                    &nbsp;</td>
                                <td  valign="top">
                                    &nbsp;</td>
                                 <td >
                                     &nbsp;</td>
                            </tr>
                            </table>
                    </td>
                </tr>
        </table>
</fieldset>


</td>
</tr>

</table>