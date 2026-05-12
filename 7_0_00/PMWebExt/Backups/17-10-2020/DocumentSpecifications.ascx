<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentSpecifications.ascx.vb" Inherits="Website.DocumentSpecifications" %>
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
        <telerik:AjaxSetting AjaxControlID="tbsSpecshorizantal">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbsSpecshorizantal" />
                <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <Calendar Width="200px"></Calendar>
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>


<%--<fieldset class="fldSpecs" style="width: 100%">--%>
<%-- <legend class="legend">
        <asp:Label runat="server" ID="lblCustomFields" meta:ResourceKey="lblCustomFields" Text="Custom Fields"></asp:Label>
    </legend>--%>

<style>
    .Documentspec .rgMasterTable.rgClipCells {
    white-space: normal !important;
}
</style>

 <div class="PMHeader" style="padding-top:0px">
    <div class="row">
        <div class="col-2" style="padding-right:20px;">
             <telerik:RadTabStrip ID="tbsSpecs" CssClass="tbsSpecPC tbsFolderManagerSpecs tbsDocSpec" Height="100%" 
                runat="server" Skin="Default" Orientation="VerticalLeft" Width="100%"
                EnableViewState="True" ScrollChildren="true" ScrollButtonsPosition="Left" CausesValidation="False">
            </telerik:RadTabStrip>
                <telerik:RadTabStrip ID="tbsSpecshorizantal"  
                runat="server" Skin="Default"  ScrollButtonsPosition="Left" CssClass="tbshorizantaltabs"
                EnableViewState="True" ScrollChildren="true"  CausesValidation="False">
            </telerik:RadTabStrip>
        </div>
        <div class="col-10" >
                     <telerik:RadGrid ID="rdgSpecifications" ShowGroupPanel="false" runat="server" HeaderStyle-Font-Size="8" ClientSettings-Scrolling-AllowScroll="true" CssClass="Documentspec"
                AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" FitParentContainer="true"
                AppendMenus="true" UseEditFormInMobile="true" IgnoreColumnWidth="true" SetWidth="true">
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="SpecificationId,Id" CommandItemDisplay="Top" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="180px"
                            SortExpression="Specification" UniqueName="Specification">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Specification") = String.Empty, "&nbsp;", Container.DataItem("Specification"))%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="80px"
                            SortExpression="UOM" UniqueName="UOM">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Measure" HeaderStyle-Width="180px" SortExpression="Measure">
                            <ItemTemplate>
                                <asp:PlaceHolder ID="plcLabel" runat="server"></asp:PlaceHolder>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="LeftAlignOnEditForm" style="width: 100%;text-align:right;">
                                    <asp:TextBox ID="txtMeasure" Visible="false" MaxLength="4000" Width="100%" runat="server"></asp:TextBox>
                                    <asp:CheckBox ID="chkMeasure" Visible="false" runat="server" />
                                    <asp:TextBox ID="txtDate" MaxLength="100" Style="text-align: right" Visible="false" Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                        onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                    <telerik:RadComboBox MarkFirstMatch="True" Filter="Contains" AllowCustomText="True"
                                        sNoWrap="true" DropDownWidth="250px" EmptyMessage="Select..." ID="ddlMeasure" runat="server" Width="100%" Height="400px" Visible="false" Skin="Default"
                                        EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:TextBox runat="server" Visible="false" Width="80%" TextMode="MultiLine" Height="14px" ID="txtMemo"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgMemo" Visible="false" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtMemo'))" CssClass="SearchButton">
                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:RequiredFieldValidator ID="rfvMeasure" runat="server" ControlToValidate=""
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                        Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Notes" HeaderStyle-Width="180px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <div><%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" ID="txtNotes" Text='<%#Container.DataItem("Notes") %>'></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                    CssClass="SearchButton">
                               <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <table cellpadding="2" cellspacing="0">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                    CommandName="EditRows" Visible='<%# rdgSpecifications.EditIndexes.Count = 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lbledit" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
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
                  
            
        </div>
    </div>
    </div>

<%--<table style="width: 100%; height: calc(100vh - 148px);" cellpadding="0" cellspacing="0" class="SpecTableMargin">
    <tr style="height:100%;">
        <td style="vertical-align: top; width: 120px;" class="SpecStripDesignOnMobile">
           
            <div style="width:119px;height:94%; border-bottom:1px solid #666666;border-right:1px solid #666666;" class="HideOnMobile"></div>
        </td>
        <td style="padding-left: 20px; vertical-align: top;" class="SpecGridDesignOnMobile">
            
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <div id="dvClear" style="clear: both">&nbsp;</div>
            <div style="clear: both">&nbsp;</div>
        </td>
    </tr>
</table>--%>

<%--</fieldset>--%>
