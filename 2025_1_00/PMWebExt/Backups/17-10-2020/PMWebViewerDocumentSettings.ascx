<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMWebViewerDocumentSettings.ascx.vb" Inherits="Website.PMWebViewerDocumentSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgPMWebViewerDocumentSettings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgPMWebViewerDocumentSettings" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgPMWebViewerDocumentSettings" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="20" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"   />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage"  EditMode="InPlace">
                    <Columns>
                         <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                  <asp:Label Text="&nbsp;" width="100%" runat="server" Id="lblColor" ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadColorPicker ShowIcon="true" ID="rcpColor" runat="server" CssClass="NewColorPicker"  KeepInScreenBounds="true"
                                               PaletteModes="WebPalette" Preset ="Default" EnableCustomColor="true" RenderMode="Lightweight" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="User" UniqueName="User" HeaderStyle-Width="250px" >
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("User") = String.Empty, "&nbsp;", Container.DataItem("User"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="true"
                                    NoWrap="True" AllowCustomText="true" ValidationGroup="Save" OnSelectedIndexChanged="ddlUserSelectedIndexChanged" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" HeaderStyle-Width="250px">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlCompanies" runat="server" width="100%"
                        Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select Company..."  AutoPostBack="true"
                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies"  OnSelectedIndexChanged="ddlCompaniesSelectedIndexChanged"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Apply to All in Company" UniqueName="ApplyToAllInCompany"
                           ItemStyle-Wrap="false" SortExpression="ApplyToAllInCompany" HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ApplyToAllInCompany")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:checkbox id="chbApplyToAllInCompany" checked='<%# CBool(IIf(Eval("ApplyToAllInCompany") Is System.DBNull.Value, 0, Eval("ApplyToAllInCompany")))%>'
                                    runat="server" />
                            </EditItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Free Color Selection" UniqueName="FreeColorSelection" HeaderStyle-Width="60px"
                             ItemStyle-Wrap="false" SortExpression="FreeColorSelection" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("FreeColorSelection")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                    alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:checkbox id="chbFreeColorSelection" checked='<%# CBool(IIf(Eval("FreeColorSelection") Is System.DBNull.Value, 0, Eval("FreeColorSelection")))%>'
                                    runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Stamps - Text" UniqueName="StampsText" HeaderStyle-Width="80px"
                             ItemStyle-Wrap="false" SortExpression="StampsText" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                 <asp:LinkButton ID="btnStampsText" Style="cursor: pointer" runat="server" 
                                            CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                                <asp:Label ID="lblAll" runat="server" Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnStampsTextEdit" Style="cursor: pointer" runat="server" 
                                            CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                                <asp:Label ID="lblAllEdit" runat="server" Visible="false"></asp:Label>
                                <asp:HiddenField runat="server" ID="hdnStampTextIds" Value='<%#Eval("StampsTextIds")%>'/>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Stamps - Images" UniqueName="StampsImages" HeaderStyle-Width="80px"
                            ItemStyle-Wrap="false" SortExpression="StampsImages" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Wrap="false">
                             <ItemTemplate>
                                 <asp:LinkButton ID="btnStampsImages" Style="cursor: pointer" runat="server" 
                                            CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                                <asp:Label ID="lblImagesAll" runat="server" Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnStampsImagesEdit" Style="cursor: pointer" runat="server" 
                                            CssClass="EmptyDetails">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                                <asp:Label ID="lblAllImagesEdit" runat="server" Visible="false"></asp:Label>
                                <asp:HiddenField runat="server" ID="hdnStampImagesIds" Value='<%#Eval("StampsImagesIds")%>'/>
                            </EditItemTemplate>
                        
                        </telerik:GridTemplateColumn>
                    </Columns>
                     <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
            <div style="padding:2px">
               <asp:LinkButton ID="btnCustomize" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="Customize" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted)%>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label1" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
               </asp:LinkButton>
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted)%>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
               </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                    Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count > 0%>'  meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted%>' >
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    ></asp:Label>
                     &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count > 0 Or rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted%>' meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" 
                    Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted)%>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
               <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted)%>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"  SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                Visible='<%# rdgPMWebViewerDocumentSettings.EditIndexes.Count = 0 And (Not rdgPMWebViewerDocumentSettings.MasterTableView.IsItemInserted)%>' 
                meta:resourcekey="btnRefreshResource1">
                <span class="Icon"></span>
                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                meta:resourcekey="lblRefreshResource1"></asp:Label>
            </asp:LinkButton>
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="False" ClientEvents-OnRowSelecting="rdgPMWebViewerDocumentSettings_OnRowSelecting"  ClientEvents-OnGridCreated="GridCreated">
                    <Selecting AllowRowSelect="True"/>
                    <Resizing EnableRealTimeResize="True"  ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" 
                                  AllowColumnResize="True" />
                </ClientSettings>
                 <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
                