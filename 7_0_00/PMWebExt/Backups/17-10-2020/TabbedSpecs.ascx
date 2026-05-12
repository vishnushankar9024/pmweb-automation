<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TabbedSpecs.ascx.vb" Inherits="Website.TabbedSpecs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <telerik:RadAjaxManagerProxy ID="PmAjaxManager" runat="server">
    <AjaxSettings>
     <telerik:AjaxSetting AjaxControlID="rdgSpecifications">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
          <telerik:AjaxSetting AjaxControlID="tbsSpecs">
            <UpdatedControls>
             <telerik:AjaxUpdatedControl ControlID="tbsSpecs" />
                <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
    </AjaxSettings> 
    </telerik:RadAjaxManagerProxy>
       <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default" >
            <Calendar Width="200px"></Calendar>
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
        <div style="clear:both">&nbsp;</div>
      
      <fieldset style="width:785px" >
     <legend><asp:Label runat="server" ID="lblCustomFields" Text="Custom Fields"></asp:Label> </legend>
        <telerik:RadTabStrip  ID="tbsSpecs" 
                    runat="server" MultiPageID="mlpEstimates" Skin="Default" 
                    Width="782px" EnableViewState="True" CausesValidation="False">
                </telerik:RadTabStrip>
 <telerik:RadGrid ID="rdgSpecifications" ShowGroupPanel="false" runat="server"   HeaderStyle-Font-Size="8" 
 Width="780px" AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true"   AllowSorting="true" ShowStatusBar="true">
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="SpecificationId,Id" CommandItemDisplay="Top" EditMode="InPlace" Width="780px">
                    <Columns>                                    
                        <telerik:GridTemplateColumn  HeaderStyle-Width="140px"   
                        SortExpression="Specification" UniqueName="Specification"  >
                        <ItemTemplate>
                           <%#IIf(Container.DataItem("Specification") = String.Empty, "&nbsp;", Container.DataItem("Specification"))%>
                        </ItemTemplate>
                       </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" 
                        SortExpression="UOM" UniqueName="UOM" >
                        <ItemTemplate>
                             <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                        </ItemTemplate>
                       </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Measure"  HeaderStyle-Width="200px"  SortExpression="Measure">
                           <ItemTemplate>
                        <asp:PlaceHolder ID="plcLabel"  runat="server"></asp:PlaceHolder>
                       </ItemTemplate>
                            <EditItemTemplate>
                            <div style="width:100%; text-align:right;">
                                <asp:TextBox ID="txtMeasure" Visible="false"  MaxLength="100"   Width="100%" runat="server"></asp:TextBox>
                                <asp:CheckBox ID="chkMeasure" Visible="false" runat="server" class="mobile-switch"/>
                                 <asp:TextBox ID="txtDate" MaxLength="100"  style="text-align:right"  Visible="false" Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                <telerik:RadComboBox  MarkFirstMatch="False" Filter="Contains"  AllowCustomText="True" ID="ddlMeasure" runat="server" Width="100%" Height="400px"  Visible="false" Skin="Default"></telerik:RadComboBox> 
                          </div>  
                            </EditItemTemplate>
                       </telerik:GridTemplateColumn>                         
                        <telerik:GridTemplateColumn UniqueName="Notes" HeaderStyle-Width="120px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC">
                            <ItemTemplate>
                               <div><%# IIF(Container.DataItem("Notes") = String.empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" ID="txtNotes"  Text='<%#Container.DataItem("Notes") %>'></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton">
                                               <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <ItemStyle Wrap ="false" /> 
                       </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <table cellpadding="2" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit"
                                                    CommandName="EditRows" CssClass="GridCmdEditRows"  Visible='<%# rdgSpecifications.EditIndexes.Count = 0 %>'>
                              <span class="Icon"></span>
                                   <asp:Label ID="lbledit" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                              <span class="Icon"></span>
                                 <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode"
                                                    CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                              <span class="Icon"></span>
                                  <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                 &nbsp;
                                </td>
                            </tr>
                        </table>
                       
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="false">
                 <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
             </telerik:RadGrid>
  
     </fieldset>