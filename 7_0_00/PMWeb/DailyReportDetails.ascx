<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DailyReportDetails.ascx.vb" Inherits="Website.DailyReportDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>


<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgOnSite">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOnSite" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdvLocations">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOnSite" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdvLocations" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lbtMoveItems">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPunchListDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadContextMenu ID="cmAddFirstNode" runat="server" OnClientItemClicking="AddFirstNode">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="dvTree" />
    </Targets>
    <Items>
        <telerik:RadMenuItem Text="Add Location" meta:resourcekey="MenuItem_AddRootNode" PostBack="false" Value="AddRootNode" EnableImageSprite="true" CssClass="MenuAdd" />
    </Items>
</telerik:RadContextMenu>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style>
        .MobileAssetExplorerBarClosed {
            position: static !important;
            height: calc(100vh - 122px) !important;
        }

        @media screen and (max-width:844px) {
            #ctl00_CPH1_DailyReportDetails_tdOnSite {
                position: absolute !important;
            }

            .MobileFormsTree {
                height: calc(100vh - 138px);
            }

            .MobileFormsExplorerBar {
                height: calc(100vh - 124px) !important;
            }

            div#dvTree {
                height: calc(100vh - 123px) !important;
                overflow-y: auto;
            }
        }

        #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DailyReportDetails_treeGroupsAndItemsPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DailyReportDetails_RadContentPane {
            height: calc(100vh - 123px) !important;
        }

        #Splitter {
            height: calc(100vh - 123px) !important;
        }

        #ctl00_CPH1_DailyReportDetails_RadSplitter1 {
            width: 100% !important;
        }

        @media screen and (max-width:843px) {
            .GridLayoutsLeftSplitterPane {
                position: fixed;
                width: 60vw !important;
                top: 0;
                height: calc(100vh - 123px) !important;
                z-index: 3000;
                border: 1px solid #999;
                margin-top: 89px;
            }

            .GridsLayoutSplitter {
                position: fixed;
                left: calc(60vw);
                z-index: 3000;
                height: calc(100vh - 123px) !important;
            }

            .GridLayoutsSplitterPane {
                width: calc(100vw - 6px) !important;
            }
        }

        .removeLeft {
            left: 0 !important;
        }

        .CheckBoxesTreeview {
            height: calc(100vh - 123px);
        }

        td.rspFirstItem {
            position: relative;
        }

        .btnTreeDropItems {
            display: block !important;
        }
    </style>
</telerik:RadCodeBlock>
<textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
                <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="GridLayoutsLeftSplitterPane" EnableEmbeddedBaseStylesheet="False" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
                    <div id="dvTree" style="width: 100%; height: calc(100vh - 123px); position: relative">
                        <telerik:RadTreeView ID="rdvLocations" runat="server" OnClientNodeEditing="rdvLocations_OnClientNodeEditing" OnClientNodeEditStart="OnClientNodeEditStartHandler" 
                            EnableDragAndDrop="True" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                            MultipleSelect="true" OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnClientContextMenuShowing="onClientContextMenuShowing" CssClass="CheckBoxesTreeview">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <ContextMenus>
                                <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" CssClass="trvContextMenu">
                                    <Items>
                                        <telerik:RadMenuItem Value="AddChild" meta:resourcekey="MenuItem_AddChild" Text="Add Sub-Location" EnableImageSprite="true" CssClass="MenuAdd"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="DELETE" meta:resourcekey="MenuItem_DELETE" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="Rename" meta:resourcekey="MenuItem_Rename" Text="Rename" EnableImageSprite="true" CssClass="MenuRename"></telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadTreeViewContextMenu>
                            </ContextMenus>
                        </telerik:RadTreeView>
                        <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                            <div class="btnTreeDropItems">&nbsp; </div>
                        </asp:LinkButton>
                    </div>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />
                <telerik:RadPane ID="RadContentPane" CssClass="GridLayoutsSplitterPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="ClientResized">
                    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
                        MaxDate="12/31/2100" runat="server" Skin="Default">
                        <ClientEvents OnDateSelected="dateSelected" />
                    </telerik:RadDatePicker>
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgOnSite" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true" AllowFilteringByColumn="true"
                                    FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" HeaderStyle-Font-Size="8"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="10" UseEditFormInMobile="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                                    AllowPaging="True" ShowFooter="false" ShowGroupPanel="True" HasPasteFromExcel="true">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                                SortExpression="LineNumber" Groupable="false" Reorderable="true" DataField="LineNumber" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#Container.DataItem("LineNumber").ToString%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%#Eval("LineNumber").ToString%>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                                                UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                                                GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnAttachments"> 
                                                        <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "("+Eval("AttachmentTotal").ToString()+")")%></span></EditItemTemplate>
                                                <HeaderStyle Width="75px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Location" SortExpression="Location" DataField="Location"
                                                GroupByExpression="Location [GridColumn_Location] Group By Location"
                                                UniqueName="Location">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtLocation" MaxLength="200" runat="server" Text='<%# Eval("Location") %>'
                                                        Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="200px"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Company" HeaderStyle-HorizontalAlign="left" DataField="Company"
                                                HeaderStyle-Width="150px" UniqueName="Company" SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="width: 100%; white-space: nowrap">
                                                        <telerik:RadComboBox
                                                            ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="85%" DropDownWidth="220px"
                                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                            OnClientDropDownClosed="dllcompClientClosed"
                                                            OnItemsRequested="ddl_ItemsRequested">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')"
                                                            CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    </div>
                                                </EditItemTemplate>
                                                <ItemStyle Wrap="false" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Classification" SortExpression="Classification" UniqueName="Classification" DataField="Classification"
                                                GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <%#IIf(Container.DataItem("Classification") = "", "&nbsp;", Container.DataItem("Classification"))%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%" DropDownWidth="200px" meta:resourcekey="ddlResourceClasses"
                                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                        Style="font-size: 11px" Height="200px">
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="160px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Quantity" HeaderText="Qty." HeaderStyle-Wrap="false"
                                                HeaderStyle-Width="60px" SortExpression="Quantity" DataField="Quantity"
                                                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "0", Eval("Quantity")))%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="PositiveDouble"
                                                        MaxLength="15" MinNumber="0" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "0", Eval("Quantity"))) %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="60px"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                                                UniqueName="UOM" ItemStyle-Wrap="false" DataField="UOM">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>


                                                    <%--                                <asp:DropDownList ID="ddlUOM" runat="server" Width="100%">
                                </asp:DropDownList>--%>

                                                    <telerik:RadComboBox ID="ddlUOM" AllowCustomText="true" runat="server" Width="100%" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                                        Style="font-size: 11px">
                                                    </telerik:RadComboBox>


                                                </EditItemTemplate>
                                                <HeaderStyle Width="50px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                                                GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                                    </asp:HyperLink>
                                                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                                                        EnableItemCaching="true" AllowCustomText="False" meta:resourcekey="ddlCostCodes"
                                                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                                        NoWrap="True"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                                        Style="font-size: 11px" Height="250px">
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="100px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                                                GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description"
                                                UniqueName="Description">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                                        Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false" DataField="Notes"
                                                HeaderStyle-Width="150px" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                                                    </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'
                                                        Width="80%"></asp:TextBox>
                                                    <asp:LinkButton runat="server" ID="imgNotesOnStite" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotesOnStite','txtNotes'))"
                                                        CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                                                Groupable="false" DataField="Field1" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                                Groupable="false" DataField="Field2" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                                Groupable="false" DataField="Field3" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                                Groupable="false" DataField="Field4" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                                Groupable="false" DataField="Field5" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                                Groupable="false" DataField="Field6" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                                Groupable="false" DataField="Field7" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                                Groupable="false" DataField="Field8" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                                Groupable="false" DataField="Field9" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                                Groupable="false" DataField="Field10" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">

                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnEditSelectedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgOnSite.EditIndexes.Count > 0 %>'
                                                    meta:resourcekey="btnUpdateEditedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgOnSite.MasterTableView.IsItemInserted %>'
                                                    meta:resourcekey="btnSaveResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                    SecurityButtonType="AddEditMode" Visible='<%# rdgOnSite.EditIndexes.Count > 0 Or rdgOnSite.MasterTableView.IsItemInserted %>'
                                                    meta:resourcekey="btnCancelResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewLine" CssClass="GridCmdInitNewRow"
                                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnAddResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    SecurityButtonType="ItemMode" Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnExportExcel" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                                    Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>' >
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblExpToExcel" Text="Copy To Excel" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick=" return GetClipboardData();" CausesValidation="false"
                                                    SecurityButtonType="ItemMode_Add" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblPasteLines" runat="server" Text="Paste From Excel"></asp:Label>
                                                </asp:LinkButton>

                                                <%--    <asp:Button ID="btnAddResources" runat="server" CausesValidation="False" CommandName="ChangeOrders"
                                SecurityButtonType="ItemMode_Add" Text="Add Rsources" meta:resourcekey="btnAddResources"
                                Visible='<%# rdgOnSite.EditIndexes.Count = 0 AND (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenResourcePopup(); " />
                            &nbsp;&nbsp;
                            <asp:Button ID="btnAddCompanies" runat="server" CausesValidation="False" CommandName="Comp"
                                SecurityButtonType="ItemMode_Add" Text="Add Companies" meta:resourcekey="btnAddCompanies"
                                Visible='<%# rdgOnSite.EditIndexes.Count = 0 AND (Not rdgOnSite.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenCompanyPopup(); " />
                            &nbsp;&nbsp;--%>

                                                <span>
                                                <asp:Label ID="lblTreeLevelGrouping" runat="server" meta:resourcekey="lblTreeLevelGrouping" Text="Group by Tree Level"
                                                    Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'></asp:Label>
                                                <telerik:RadComboBox ID="ddlTreeLevel" runat="server" OnSelectedIndexChanged="ddlTreeLevel_SelectedIndexChanged"
                                                    Width="90px" AutoPostBack="true" Style="font-size: 11px; padding-left: 15px;"
                                                    Visible='<%# rdgOnSite.EditIndexes.Count = 0 And (Not rdgOnSite.MasterTableView.IsItemInserted) %>'>
                                                </telerik:RadComboBox>
                                                </span>
                                                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                    EnableShadows="true" CausesValidation="false"
                                                    Visible="true">
                                                </telerik:RadMenu>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings AllowDragToGroup="true">
                                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                            AllowColumnResize="True"></Resizing>
                                    </ClientSettings>
                                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true"
                                        ValidationGroup="WorkOrder" />
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </telerik:RadPane>

            </telerik:RadSplitter>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
