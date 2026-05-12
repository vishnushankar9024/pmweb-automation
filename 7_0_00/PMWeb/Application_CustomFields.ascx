<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Application_CustomFields.ascx.vb" Inherits="Website.Application_CustomFields" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadCodeBlock ID="CodeBlockCustomFields1" runat="server">
    <script language="javascript" type="text/javascript" >
        function OpenApplicationNoteDetailPopup(txtNoteId) {
            var left = (screen.width - 620) / 2;
            var top = (screen.height - 320) / 2;
            var win = window.open('ApplicationCustomFieldsNotesPopup.aspx?txtNotesId=' + txtNoteId, '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=620,height=320,top=' + top + ',left=' + left);
            return false;
        }
    </script>
    <style type="text/css">
         .ProjectCenterSepcs .RadTabStrip .rtsLink.rtsSelected:after {background-color: #fff !important;}
          .ProjectCenterSepcs .rtsLevel.rtsLevel1 {width:100% !important;}
          .RadTabStrip .rtsLI {
            position: relative !important;
        }
        .ProjectCenterSepcs .RadTabStrip .rtsLink:after {
            content: "" !important;
            clear: both !important;
            display: block !important;
            WIDTH: 139PX !important;
            position: absolute !important;
            height: 1px !important;
            background-color: transparent !important;
            top: 29px !important;
            z-index: 0 !important;
            left: 1px;
        }
        .ProjectCenterSepcs .RadTabStrip:after {
            content: "" !important;
            clear: both !important;
            display: block !important;
            position: absolute !important;
            width: 100% !important;
            background-color: #4c4c4c !important;
            top: 29px !important;
            height: 1px !important;
            left: 0px !important;
            z-index: -1 !important;
        }
        .ProjectCenterSepcs .RadTabStrip .rtsLevel1 .rtsTxt {
            padding: 0 !important;
            display: block !important;
            text-transform: uppercase !important;
            width: 130px !important;
            text-overflow: ellipsis !important;
            overflow: hidden !important;
        }
        .ProjectCenterSepcs .rgCommandCell {
            background-color: #fff;
        }
        .ProjectCenterSepcs .RadTabStrip {
            border-bottom: 0px solid !important;
            position: relative !important;
        }
        .ProjectCenterSepcs .RadGrid.RadGrid_Default {
            border-top: none !important;
        }
        .ProjectCenterSepcs .rtsLink {
            line-height: 30px !important;
            padding-left: 0px !important;
            width: 144px;
        }
        .ProjectCenterSepcs .rtsTxt {
            color: #fff;
        }
        .ProjectCenterSepcs .rtsSelected .rtsTxt {
            color: rgb(102,102,102);
        }
          .tbshorizantaltabs {visibility:visible !important}
           .tbsDocSpec {display:none !important;}
        .ProjectCenterSepcs .rtsLink.rtsSelected:before {
            background: #fff !important;
            z-index: -1;
        }
        .ProjectCenterSepcs .rtsLI:not(:first-child) {
            margin-left: -10px;
        }
        .ProjectCenterSepcs .rtsLink:before {
            display: block;
            content: " ";
            background-color: #fff;
            position: absolute;
            right: 1px;
            top: -4px;
            bottom: -4px;
            left: 0px;
            z-index: -2;
            border: 1px solid rgb(102,102,102);
            border-bottom: none;
            background: rgb(102,102,102);
            -webkit-transform: perspective(8px) rotateX(2deg);
            -webkit-transform-origin: bottom left;
            transform: perspective(8px) rotateX(2deg);
            transform-origin: bottom left;
            -moz-transform: perspective(8px) rotateX(2deg);
            -moz-transform-origin: bottom left;
        }
         .ProjectCenterSepcs .RadTabStrip_Default .rtsLevel .rtsSelected .rtsOut {
            border: 0px !important;
            color: #000 !important;
        }
         .rgRow span,.rgRow div,.rgRow td,.rgAltRow td,.rgAltRow span,.rgAltRow div,.rgAltRow td{
             white-space:normal;
         }
    </style>
</telerik:RadCodeBlock>

 <telerik:RadAjaxManagerProxy ID="PmAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        
        <telerik:AjaxSetting AjaxControlID="fldSpecs">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldSpecs" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting> 

    </AjaxSettings> 
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

      <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default" >
            <Calendar Width="200px"></Calendar>
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
        <div style="clear:both">&nbsp;</div>
      <div id="divSpecs">
      <fieldset style="width:100%;" class="ProjectCenterSepcs" runat="server" id="fldSpecs">
        <legend><asp:Label runat="server" ID="lblCustomFields" meta:ResourceKey="lblCustomFields" Text="Custom Fields"></asp:Label> </legend>
        
        <telerik:RadTabStrip  ID="tbsSpecs"  ScrollChildren="true" ScrollButtonsPosition="Left" runat="server"  Skin="Default" 
                    Width="100%" EnableViewState="True" CausesValidation="False" CssClass="SpecsTabs">
        </telerik:RadTabStrip>
        <telerik:RadGrid ID="rdgSpecifications" ShowGroupPanel="false" runat="server"   HeaderStyle-Font-Size="8"  SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                            Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true"  ShowStatusBar="true">
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="SpecificationId,Id" CommandItemDisplay="Top" EditMode="InPlace">
                    <Columns>                                    
                        <telerik:GridTemplateColumn  HeaderStyle-Width="140px" HeaderText="Specification" SortExpression="Specification" UniqueName="Specification"  >
                            <ItemTemplate>
                               <%#IIf(Container.DataItem("Specification") = String.Empty, "&nbsp;", IIf(Container.DataItem("Required") = False, Container.DataItem("Specification"), Container.DataItem("Specification") & "*"))%>
                            </ItemTemplate>
                       </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" >
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                            </ItemTemplate>
                       </telerik:GridTemplateColumn>
                       <telerik:GridTemplateColumn UniqueName="Measure" HeaderText="Measure"  HeaderStyle-Width="200px"  SortExpression="Measure">
                           <ItemTemplate>
                                <asp:PlaceHolder ID="plcLabel"  runat="server"></asp:PlaceHolder>
                            </ItemTemplate>
                            <EditItemTemplate>
                            <div style="width:100%; text-align:right;">
                                <asp:TextBox ID="txtMeasure" Visible="false"   MaxLength="4000"   Width="100%" runat="server"></asp:TextBox>
                                <asp:CheckBox ID="chkMeasure" Visible="false" runat="server" />
                                 <asp:TextBox ID="txtDate" MaxLength="100"  style="text-align:right"  Visible="false" Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                <telerik:RadComboBox  MarkFirstMatch="False" Filter="Contains"  AllowCustomText="True" ID="ddlMeasure" runat="server" Width="100%" Height="400px"  Visible="false" Skin="Default"></telerik:RadComboBox> 
                            <asp:TextBox runat="server"   visible="false" Width="80%" TextMode="MultiLine" Height="14px" ID="txtMemo"></asp:TextBox>
                     
                           <asp:LinkButton runat="server" ID="imgMemo" CssClass="SearchButton" OnClientClick="return OpenApplicationNoteDetailPopup(this.id.replace('imgMemo','txtMemo'))">
                               <span class="Icon"></span>
                           </asp:LinkButton>
                                
                                 <asp:RequiredFieldValidator ID="rfvMeasure" runat="server" ControlToValidate=""
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor="" ></asp:RequiredFieldValidator>
                            </div>  
                            </EditItemTemplate>
                       </telerik:GridTemplateColumn>                         
                       <telerik:GridTemplateColumn UniqueName="Notes" HeaderText="Notes" HeaderStyle-Width="200px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC">
                           <ItemTemplate>
                               <div><%# IIF(Container.DataItem("Notes") = String.empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                           </ItemTemplate>
                           <EditItemTemplate>
                                <asp:TextBox runat="server" Style="white-space:normal !important"  MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" ID="txtNotes"  Text='<%#Container.DataItem("Notes") %>'></asp:TextBox>
                           
                              
                                 <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenApplicationNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
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
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows" 
                                                                    CommandName="EditRows" Visible='<%# rdgSpecifications.EditIndexes.Count = 0 AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>'>
                                                     <span class="Icon"></span>
                                                    <asp:Label ID="lbledit" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnCustomFieldUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CssClass="GridCmdUpdateEdited" 
                                                                CommandName="UpdateEdited" Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll" 
                                                                CommandName="CancelAll" Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                                                  <span class="Icon"></span>
                                                    <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                            </tr>
                        </table>
                    </CommandItemTemplate>
                </MasterTableView>
             <ItemStyle Wrap="true"></ItemStyle>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="false">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
             </telerik:RadGrid>
          
     </fieldset>
</div>
     <div style="clear:both">&nbsp;</div>
<div id="S_9">
    <table cellpadding="0" cellspacing="0" runat="server">
        <tr>
            <td>
                <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton">
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
            </td>
        </tr>
    </table>
</div>