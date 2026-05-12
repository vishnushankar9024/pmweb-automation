<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderServiced.ascx.vb" Inherits="Website.WorkOrderServiced" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgServiced">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgServiced" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
       <%--  <telerik:AjaxSetting AjaxControlID="btnUnlinkAsset">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgServiced" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="btnUnlinkAsset" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btlinkAsset">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgServiced" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="btnlinkAsset" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy> --%>


<telerik:RadGrid ID="rdgServiced" UseEditFormInMobile="true" width="100%" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="true" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
      HeaderStyle-Font-Size="8" AllowMultiRowEdit="True"  CssClass="WithoutTopBorder"
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false" ShowFooter ="false"  AllowPaging="true" PageSize="10">
    <grouppanel text="<%$Resources:PMWeb, Grid_GroupPanel %>"></grouppanel>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%" ShowGroupFooter ="false"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" ShowFooter ="false" 
        Name="Master"  EnableHeaderContextMenu="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Asset" UniqueName="Asset" DataField="Asset"
                SortExpression="Asset" GroupByExpression="Asset [GridColumn_Asset] Group By Asset ASC"
                Groupable="true" Reorderable="true">
                <ItemTemplate>
                
                 <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("Asset").ToString%>' NavigateUrl='<%#Eval("AssetPostBackUrl").ToString%>'></asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                   <asp:HyperLink ID="hliAssetEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("Asset").ToString%>' NavigateUrl='<%#Eval("AssetPostBackUrl").ToString%>'></asp:HyperLink>
                </EditItemTemplate>
                <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Previous reading" UniqueName="PreviousReading" DataField="PreviousReading"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="left"
                 SortExpression="PreviousReading" GroupByExpression="PreviousReading [GridColumn_PreviousReading] Group By PreviousReading ASC">
                <ItemTemplate>
                     <asp:label runat="server" id="lblPreviousReading" Text='<%#FormatNumber(Container.DataItem("PreviousReading"))%>'></asp:label>
                 <asp:label runat="server" id="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>' style="display:none;"></asp:label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:label runat="server" id="lblPreviousReading" Text='<%#FormatNumber(IIF(Eval("PreviousReading") is system.DBNULL.value, "0", Eval("PreviousReading"))) %>'></asp:label>
                     <asp:label runat="server" id="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>' style="display:none;"></asp:label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Current reading" UniqueName="CurrentReading" DataField="CurrentReading"
                ItemStyle-HorizontalAlign="Right" GroupByExpression="CurrentReading [GridColumn_CurrentReading] Group By CurrentReading ASC"
                HeaderStyle-HorizontalAlign="left" SortExpression="CurrentReading">
                <ItemTemplate>
                    <asp:label runat="server" id="lblCurrentReading" Text='<%#FormatNumber(Container.DataItem("CurrentReading"))%>'></asp:label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentReading" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("CurrentReading") is system.DBNULL.value, "0", Eval("CurrentReading"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Current Usage" UniqueName="CurrentUsage" DataField="CurrentUsage"
                ItemStyle-HorizontalAlign="Right" GroupByExpression="CurrentUsage [GridColumn_CurrentUsage] Group By CurrentUsage ASC"
                HeaderStyle-HorizontalAlign="left" SortExpression="CurrentUsage">
                <ItemTemplate>
                 <asp:Label ID="lblUsage" runat="server" Width="100%" CssClass="Right" 
                        Text='<%#FormatNumber(Container.DataItem("CurrentUsage"))%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblUsage" runat="server" Width="100%" CssClass="Right" 
                        Text='<%#FormatNumber(IIF(Eval("CurrentUsage") is system.DBNULL.value, "0", Eval("CurrentUsage"))) %>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM"
                GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" >
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Service(s) Performed" UniqueName="ServicePerformed" SortExpression="ServicePerformed" DataField="ServicePerformed"
                GroupByExpression="ServicePerformed [GridColumn_ServicePerformed] Group By ServicePerformed ASC" >
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("ServicePerformed") = String.Empty, "&nbsp;", Container.DataItem("ServicePerformed"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlServicePerformed" runat="server"  Width="100%" DropDownWidth="300px" height="400px" 
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListServicePerformedEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetServicedPerformedValueToReturn"
                                        OnItemsRequested="ddl_ItemsRequested"
                                        Style="font-size: 11px" >
                        <ItemTemplate>
                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                <asp:CheckBox runat="server" ID="chkApplyRole" />
                            </div>
                        </ItemTemplate>
                    </telerik:RadComboBox> 
                           <asp:HiddenField runat="server" ID="hddnIds" />
                           <asp:HiddenField runat="server" ID="hddnNames" /> 
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Condition" UniqueName="Condition" SortExpression="Condition" DataField="Condition"
               GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC"  Groupable="true" Reorderable="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Condition") = String.Empty, "&nbsp;", Container.DataItem("Condition"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlAssetConditions" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Condition Date" UniqueName="ConditionDate" DataField="ConditionDate" 
                ItemStyle-HorizontalAlign="left" GroupByExpression="ConditionDate [GridColumn_ConditionDate] Group By ConditionDate ASC"
                SortExpression="ConditionDate" HeaderStyle-HorizontalAlign="left"  Groupable="true" Reorderable="true">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Container.DataItem("ConditionDate"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                     <telerik:RadDatePicker ID="dtpConditionDate"  MinDate="01/01/1901"
                                MaxDate="12/31/2100" runat="server" Skin="Default" width="100%">
                               <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                     </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
             <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" DataField="Notes"
                UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                       
                        <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                        <span class="Icon"></span>
                        </asp:LinkButton>

                    </EditItemTemplate>
                    <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgServiced.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgServiced.EditIndexes.Count > 0 Or rdgServiced.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnlinkAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkAsset" CssClass="GridCmdlinkAsset"
                                 OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=1&IsInstalled=0&IsServiced=1',1035, 710,true,'rdgServiced');"
                                Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUnlinkAsset" runat="server" OnClientClick="javascript:return ConfirmDelete();"  CssClass="GridCmdUnlinkAsset"
                                CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="UnlinkAsset"
                                Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'>
                               <span class="Icon"></span>
                                <asp:Label runat="server" ID="Label1" Text="Unlink Asset(s)"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="UpdateAssets" CssClass="GridCmdUpdateAssets"
                                Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'>
                               <span class="Icon"></span>
                                <asp:Label runat="server" ID="Label7" Text="Update Assets"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
            </div>
        </CommandItemTemplate>
        <DetailTables>
            <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="Top"  AllowSorting="false"  AllowPaging="false" AllowFilteringByColumn="true"
                DataKeyNames="Id,WorkOrderServicedId" ClientDataKeyNames="InventoryStockId,Id,InventoryQuantityReturned"  Width="100%" Name="Components">
                 <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="WorkOrderServicedId" MasterKeyField="Id" />
                </ParentTableRelation>
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                 <Columns>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LineNumber %>" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" DataField="LineNumber"
                                SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                                Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <asp:label runat="server" id="lblLineNumberConponent" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:label>
                        </ItemTemplate>
                        <EditItemTemplate>
                             <asp:label runat="server" id="lblLineNumberEdit" Text='<%#Eval("LineNumber").ToString()%>'></asp:label>
                        </EditItemTemplate>
                        <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Removed %>" SortExpression="Removed" UniqueName="Removed" DataField="IsRemoved" DataType="System.Boolean"
                        GroupByExpression="Removed [GridColumn_Removed] Group By Removed ASC" Groupable="false" Reorderable="true">
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkRemoved" runat="server" Checked='<%# CBool(IIF(Eval("IsRemoved") is system.DBNULL.value, 0, Eval("IsRemoved"))) %>' class="mobile-switch" />
                        <asp:HiddenField runat="server" ID="hdnReturnQuantity" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <img src='Images/Global/<%# CStr(IIF(Container.DataItem("IsRemoved"),"checked.png" , "unchecked.png")) %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Serviced %>" SortExpression="Serviced" UniqueName="Serviced" DataField="IsServiced" DataType="System.Boolean"
                        GroupByExpression="Serviced [GridColumn_Serviced] Group By Serviced ASC" Groupable="false" Reorderable="true">
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkServiced" runat="server" Checked='<%# CBool(IIF(Eval("IsServiced") is system.DBNULL.value, 0, Eval("IsServiced"))) %>' class="mobile-switch"  />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <img src='Images/Global/<%# CStr(IIF(Container.DataItem("IsServiced"),"checked.png" , "unchecked.png")) %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ServicePerformed %>" UniqueName="ServicePerformed" SortExpression="ServicePerformed" DataField="ServicePerformed"
                        GroupByExpression="ServicePerformed [GridColumn_ServicePerformed] Group By ServicePerformed ASC" Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("ServicePerformed") = String.Empty, "&nbsp;", Container.DataItem("ServicePerformed"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="ddlServicePerformed" runat="server"  Width="100%" DropDownWidth="405px" 
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListServicePerformedEmptyMsg %>'
                                                NoWrap="True" AllowCustomText="true" OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetServicedPerformedValueToReturn"
                                                Style="font-size: 11px" Height="250px" >
                                <ItemTemplate>
                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                        <asp:CheckBox runat="server" ID="chkApplyRole" />
                                    </div>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:HiddenField runat="server" ID="hddnIds" />
                           <asp:HiddenField runat="server" ID="hddnNames" /> 
                        </EditItemTemplate>
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridTemplateColumn>

             <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Condition %>" UniqueName="Condition" SortExpression="Condition" DataField="Condition"
               GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC"  Groupable="false" Reorderable="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Condition") = String.Empty, "&nbsp;", Container.DataItem("Condition"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlAssetConditions" Width="100%" runat="server" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ConditionDate %>" UniqueName="ConditionDate" DataField="ConditionDate"
                ItemStyle-HorizontalAlign="left" GroupByExpression="ConditionDate [GridColumn_ConditionDate] Group By ConditionDate ASC"
                SortExpression="ConditionDate" HeaderStyle-HorizontalAlign="left"  Groupable="false" Reorderable="true">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Container.DataItem("ConditionDate"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                     <telerik:RadDatePicker ID="dtpConditionDate"  MinDate="01/01/1901"
                                MaxDate="12/31/2100" runat="server" Skin="Default" width="100%">
                               <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                     </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Notes %>" SortExpression="Notes" DataField="Notes"
                        UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                               
                           <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"  
                               OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" >
                            <span class="Icon"></span>
                                </asp:LinkButton>
                                 </EditItemTemplate>
                            <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_RecordNumber %>" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="RecordNumber"
                        Groupable="false" Reorderable="true" UniqueName="RecordNumber" 
                        GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                        <ItemTemplate>
                            <%#Container.DataItem("RecordNumber")%>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblRecord" runat="server" Text='<%#Eval("RecordNumber").ToString%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="70px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ComponentType %>" UniqueName="ComponentType" SortExpression="ComponentType" DataField="ComponentType"
                       GroupByExpression="ComponentType [GridColumn_ComponentType] Group By ComponentType ASC" Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("ComponentType") = String.Empty, "&nbsp;", Container.DataItem("ComponentType"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblComponentType" runat="server" Text='<%#IIF(Eval("ComponentType").ToString = String.Empty , "&nbsp;" ,Eval("ComponentType").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" HeaderStyle-HorizontalAlign="left" UniqueName="Description" DataField="Description"
                        HeaderStyle-Width="190px" SortExpression="Description" Groupable="false" Reorderable="true"
                        GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                        <ItemTemplate>
                            <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" Text='<%#IIF(Eval("Description").ToString = String.Empty , "&nbsp;" ,Eval("Description").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LifeRemaining %>" UniqueName="LifeRemaining" DataField="LifeRemaining"
                        ItemStyle-HorizontalAlign="Right" GroupByExpression="LifeRemaining [GridColumn_LifeRemaining] Group By LifeRemaining ASC"
                        HeaderStyle-HorizontalAlign="left" SortExpression="LifeRemaining" Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <asp:label runat="server" id="lblLifeRemaining" Text='<%#FormatNumber(Container.DataItem("LifeRemaining"))%>'></asp:label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:label runat="server" id="lblLifeRemainingEdit" Text='<%#FormatNumber(IIF(Eval("LifeRemaining") is system.DBNULL.value, "0", Eval("LifeRemaining"))) %>'></asp:label>
                        </EditItemTemplate>
                        <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_RemainingPercentage %>" UniqueName="RemainingPercentage" DataField="RemainingPercentage"
                        ItemStyle-HorizontalAlign="Right" GroupByExpression="RemainingPercentage [GridColumn_RemainingPercentage] Group By RemainingPercentage ASC"
                        HeaderStyle-HorizontalAlign="left" SortExpression="RemainingPercentage" Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <asp:label runat="server" id="lblRemainingPercentage" Text='<%#FormatPercent(Container.DataItem("RemainingPercentage"))%>'></asp:label>
                        </ItemTemplate>
                        <EditItemTemplate>
                             <asp:label runat="server" id="lblRemainingPercentageEdit" Text='<%#FormatPercent(IIF(Eval("RemainingPercentage") is system.DBNULL.value, "0", Eval("RemainingPercentage"))) %>'></asp:label>
                        </EditItemTemplate>
                        <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_SerialNumber %>" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="SerialNumber"
                        Groupable="false" Reorderable="true" UniqueName="SerialNumber" SortExpression="SerialNumber"
                        GroupByExpression="SerialNumber [GridColumn_SerialNumber] Group By SerialNumber ASC">
                        <ItemTemplate>
                            <%#Container.DataItem("SerialNumber")%>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblSerialNumber" runat="server" Text='<%#IIF(Eval("SerialNumber").ToString = String.Empty , "&nbsp;" ,Eval("SerialNumber").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_AssetId %>" UniqueName="AssetId" DataField="AssetId"
                        SortExpression="AssetId" GroupByExpression="AssetId [GridColumn_AssetId] Group By AssetId ASC"
                        Groupable="false" Reorderable="true">
                        <ItemTemplate>
                         <asp:HyperLink ID="HyperLink1" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                    Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("AssetPostBackUrl").ToString%>'></asp:HyperLink>
                        </ItemTemplate>
                        <EditItemTemplate>
                           <asp:HyperLink ID="HyperLink2" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                    Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("AssetPostBackUrl").ToString%>'></asp:HyperLink>
                        </EditItemTemplate>
                        <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: Gridcolumn_Item %>" UniqueName="ItemId" DataField="ItemId"
                            SortExpression="ItemId" GroupByExpression="ItemId [GridColumn_ItemId] Group By ItemId ASC"
                            Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <asp:HyperLink ID="hliItem" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                    Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:HyperLink ID="hliItemEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                    Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                        </EditItemTemplate>
                        <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Manufacturer %>" UniqueName="Manufacturer" SortExpression="Manufacturer" DataField="Manufacturer"
                        GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer ASC" Groupable="false" Reorderable="true">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblManufacturer" runat="server" Text='<%#IIF(Eval("Manufacturer").ToString = String.Empty , "&nbsp;" ,Eval("Manufacturer").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ManufacturerNumber %>" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="ManufacturerNumber"
                            Groupable="false" Reorderable="true" UniqueName="ManufacturerNumber"  SortExpression="ManufacturerNumber"
                            GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber ASC">
                        <ItemTemplate>
                            <%#Container.DataItem("ManufacturerNumber")%>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblManufacturerNumber" runat="server" Text='<%#IIF(Eval("ManufacturerNumber").ToString = String.Empty , "&nbsp;" ,Eval("ManufacturerNumber").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StockNumber %>" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="StockNumber"
                            Groupable="false" Reorderable="true" UniqueName="StockNumber" SortExpression="StockNumber"
                            GroupByExpression="StockNumber [GridColumn_StockNumber] Group By StockNumber ASC">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlistock" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
                            <asp:label runat="server" Text="&nbsp;" id="lblstock"></asp:label>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                             <asp:HyperLink ID="hlistockEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
                             <asp:label runat="server" Text="&nbsp;" id="lblstockEdit"></asp:label>&nbsp;
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LotNumber %>" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="LotNumber"
                            Groupable="false" Reorderable="true" UniqueName="LotNumber" SortExpression="LotNumber"
                            GroupByExpression="LotNumber [GridColumn_LotNumber] Group By LotNumber ASC">
                        <ItemTemplate>
                            <%#Container.DataItem("LotNumber")%>&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblLotNumber" runat="server" Text='<%#IIF(Eval("LotNumber").ToString = String.Empty , "&nbsp;" ,Eval("LotNumber").ToString)%>'></asp:Label>
                        </EditItemTemplate>
                        <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </telerik:GridTemplateColumn>
                </Columns>
                <CommandItemTemplate>
                    <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelectedComponent" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                            SecurityButtonType="ItemMode_Edit" Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'
                            meta:resourcekey="btnEditSelectedResource1">
                           <span class="Icon"></span>
                            <asp:Label ID="Label4" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnUpdateEditedComponent" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                            SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgServiced.EditIndexes.Count > 0 %>'
                            meta:resourcekey="btnUpdateEditedResource1">
                          <span class="Icon"></span>
                            <asp:Label ID="Label5" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancelComponent" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                            SecurityButtonType="AddEditMode" Visible='<%# rdgServiced.EditIndexes.Count > 0 Or rdgServiced.MasterTableView.IsItemInserted %>'
                            meta:resourcekey="btnCancelResource1">
                           <span class="Icon"></span>
                            <asp:Label ID="Label6" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnlinkComponent" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkComponent" CssClass="GridCmdlinkComponent"
                                    Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'>
                           <span class="Icon"></span>
                            <asp:Label runat="server" ID="Label2" Text = "link Component(s)"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnUnlinkcomponent" runat="server" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdUnlinkComponent"
                                     CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="UnlinkComponent" 
                                    Visible='<%# rdgServiced.EditIndexes.Count = 0 AND (Not rdgServiced.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label runat="server" ID="Label3" Text = "Unlink Component(s)"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                    </div>
                </CommandItemTemplate>
            </telerik:GridTableView>
        </DetailTables>
    </MasterTableView>
     <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
        <Scrolling UseStaticHeaders="true" />   
        <ClientEvents   OnRowDblClick = "Item_DblClick" /> 
        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />     
    </ClientSettings>
</telerik:RadGrid>

<asp:Button ID="btnEditModeOnDblClick" runat="server" CssClass="Hide" />
