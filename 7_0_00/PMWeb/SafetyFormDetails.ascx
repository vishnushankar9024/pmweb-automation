<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SafetyFormDetails.ascx.vb" Inherits="Website.SafetyFormDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgpeopleInvolved">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgpeopleInvolved" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgWitnesses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgWitnesses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgCauses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCauses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <fieldset runat="server" id="FldPeopleInvolved">
                <legend>
                    <asp:Label ID="lblPeopleInvolved" class="legend" meta:resourcekey="lblPeopleInvolved" runat="server" Text="People Involved"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgpeopleInvolved" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true" SetWidth="true" AppendMenus="true"
                    HeaderStyle-Font-Size="8" Width="200px" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="10" AllowPaging="True"
                    ShowFooter="false" ShowGroupPanel="false" UseEditFormInMobile="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber" Groupable="false">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <%#Eval("LineNumber").ToString%>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="75px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" Groupable="false" UniqueName="Name">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtName" MaxLength="200" runat="server" Text='<%# Eval("Name") %>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="175px"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Company" HeaderStyle-HorizontalAlign="left" HeaderStyle-Width="150px" Groupable="false" UniqueName="Company" SortExpression="Company">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="85%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')"
                                            CssClass="SearchButton">
                                               <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="175px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Worker Classification" SortExpression="WorkerClassification" UniqueName="WorkerClassification" ItemStyle-Wrap="false" Groupable="false">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("WorkerClassification") = "", "&nbsp;", Container.DataItem("WorkerClassification"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%" meta:resourcekey="ddlResourceClasses"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="200px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="175px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="Age" HeaderText="Age" HeaderStyle-Wrap="false" HeaderStyle-Width="60px" Groupable="false" SortExpression="Age" DataType="System.Int64">
                                <ItemTemplate>
                                    <span>
                                        <%#ParseInt(IIf(Eval("Age") Is System.DBNull.Value, 0, Eval("Age")))%>
                                    </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAge" runat="server" Width="100%" CssClass="PositiveDouble"
                                        MaxLength="15" MinNumber="0" Text='<%#ParseInt(IIf(Eval("Age") Is System.DBNull.Value, 0, Eval("Age"))) %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Years Experience" SortExpression="YearsExperience" UniqueName="YearsExperience" Groupable="false">
                                <ItemTemplate>
                                    <span>
                                        <%#FormatNumber(Eval("YearsExperience"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtYearsExperience" runat="server" Width="100%" CssClass="PositiveDouble"
                                        MaxLength="15" MinNumber="0" Text='<%#FormatNumber(Eval("YearsExperience")) %>'></asp:TextBox>
                                    <div>
                                        <asp:RangeValidator ID="rgvalidator" runat="server" ControlToValidate="txtYearsExperience" Type="Double"
                                            Display="Dynamic" ValidationGroup="WorkOrder" MinimumValue="0" MaximumValue="1000" CssClass="validator"
                                            ErrorMessage="Invalid range"></asp:RangeValidator>
                                    </div>
                                </EditItemTemplate>                                
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="155px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn Groupable="false" HeaderText="Injury Type" SortExpression="InjuryType" UniqueName="InjuryType" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("InjuryType") = "", "&nbsp;", Container.DataItem("InjuryType"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlResourceInjuryType" runat="server" Width="100%" meta:resourcekey="ddlResourceInjuryType"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Injury Type..."
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="200px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="155px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn Groupable="false" HeaderText="Injured Body Part" SortExpression="InjuredBodyPart" UniqueName="InjuredBodyPart" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("InjuredBodyPart") = "", "&nbsp;", Container.DataItem("InjuredBodyPart"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlResourceInjuredBodyPart" runat="server" Width="100%" meta:resourcekey="ddlResourceInjuredBodyPart"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Injured Body Part..."
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="200px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="155px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn Groupable="false" HeaderText="Injury Severity" SortExpression="InjurySeverity" UniqueName="InjurySeverity" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("InjurySeverity") = "", "&nbsp;", Container.DataItem("InjurySeverity"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlResourceInjurySeverity" runat="server" Width="100%" meta:resourcekey="ddlResourceInjurySeverity"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Injury Severity..."
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="200px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="215px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Current Condition" UniqueName="CurrentCondition" ItemStyle-Wrap="false"
                                HeaderStyle-Width="130px" Groupable="false" SortExpression="CurrentCondition">
                                <ItemTemplate>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="imgReadText2" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText2','lblCurrentCondition'),this)"
                                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblCurrentCondition" Text='<%#IIf(Container.DataItem("CurrentCondition").ToString = String.Empty, "&nbsp;", Container.DataItem("CurrentCondition").ToString)%>'></asp:Label>

                                            </td>
                                        </tr>
                                    </table>

                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCurrentCondition" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("CurrentCondition") %>' Width="80%"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtCurrentCondition'),this)"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <HeaderStyle Width="155px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn Groupable="false" HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false" HeaderStyle-Width="150px" SortExpression="Notes">
                                <ItemTemplate>                                    
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="imgReadText4" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText4','lblNotes'),this)"
                                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblNotes" Text='<%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgNotes1" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes1','txtNotes'))"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <HeaderStyle Width="157px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>

                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgpeopleInvolved.EditIndexes.Count = 0 And (Not rdgpeopleInvolved.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgpeopleInvolved.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgpeopleInvolved.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgpeopleInvolved.EditIndexes.Count > 0 Or rdgpeopleInvolved.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewLine" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgpeopleInvolved.EditIndexes.Count = 0 And (Not rdgpeopleInvolved.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgpeopleInvolved.EditIndexes.Count = 0 And (Not rdgpeopleInvolved.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgpeopleInvolved.EditIndexes.Count = 0 And (Not rdgpeopleInvolved.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>

                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings AllowDragToGroup="false">
                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                    </ClientSettings>
                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true" ValidationGroup="WorkOrder" />
                </telerik:RadGrid>
            </fieldset>
            <fieldset runat="server" id="fldCauses">
                <legend>
                    <asp:Label ID="lblCauses" class="legend" meta:resourcekey="lblCauses" runat="server" Text="Causes"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgCauses" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true" SetWidth="true" AppendMenus="true"
                    HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="10"
                    AllowPaging="True" ShowFooter="false" ShowGroupPanel="false" UseEditFormInMobile="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" SortExpression="LineNumber" Groupable="false">
                                <ItemTemplate>
                                    <span>
                                        <%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <%#Eval("LineNumber").ToString%>
                                </EditItemTemplate>
                                <HeaderStyle Width="123px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Cause Category" UniqueName="CauseCategory" HeaderStyle-Width="150px" HeaderStyle-Wrap="false"
                                SortExpression="CauseCategory" Groupable="false">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("CauseCategory") = "", "&nbsp;", Container.DataItem("CauseCategory"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCauseCategory" runat="server" Width="100%" meta:resourcekey="ddlCauseCategory"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cause Category..."
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="200px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="510px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" ItemStyle-Wrap="false"
                                HeaderStyle-Width="200px" Groupable="false" SortExpression="Description">
                                <ItemTemplate>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="imgReadText2" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText2','lblDescription'),this)"
                                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblDescription" Text='<%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Description") %>'
                                        Width="80%"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtDescription'))"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <HeaderStyle Width="510px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false"
                                HeaderStyle-Width="150px" SortExpression="Notes" Groupable="false">
                                <ItemTemplate>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="imgReadText4" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText4','lblNotes'),this)"
                                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblNotes" Text='<%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'
                                        Width="80%"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgNotes1" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes1','txtNotes'))"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <HeaderStyle Width="510px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgCauses.EditIndexes.Count = 0 And (Not rdgCauses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgCauses.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgCauses.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgCauses.EditIndexes.Count > 0 Or rdgCauses.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewLine" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgCauses.EditIndexes.Count = 0 And (Not rdgCauses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgCauses.EditIndexes.Count = 0 And (Not rdgCauses.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgCauses.EditIndexes.Count = 0 And (Not rdgCauses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings AllowDragToGroup="false">
                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                    </ClientSettings>
                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true" ValidationGroup="WorkOrder" />
                </telerik:RadGrid>
            </fieldset>
            <fieldset runat="server" id="fldWitnesses">
                <legend>
                    <asp:Label ID="lblWitnesses" class="legend" meta:resourcekey="lblWitnesses" runat="server" Text="Witnesses"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgWitnesses" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="true"
                    AllowSorting="true" SetWidth="true" AppendMenus="true" UseEditFormInMobile="true"
                    HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False"
                    ShowStatusBar="true" PageSize="10" AllowPaging="True" ShowFooter="false" ShowGroupPanel="false">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber" Groupable="false">
                                <ItemTemplate>
                                    <span>
                                        <%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <%#Eval("LineNumber").ToString%>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="123px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Company" HeaderStyle-HorizontalAlign="left"
                                HeaderStyle-Width="150px" Groupable="false" UniqueName="Company" SortExpression="Company">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%>
                                    </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="85%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')"
                                            CssClass="SearchButton">
                                               <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Wrap="False" Width="510px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" Groupable="false" UniqueName="Name">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%>
                                    </span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtName" MaxLength="200" runat="server" Text='<%# Eval("Name") %>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="510px"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false"
                                HeaderStyle-Width="150px" Groupable="false" SortExpression="Notes">
                                <ItemTemplate>
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="imgReadText5" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText5','lblNotes'),this)"
                                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblNotes" Text='<%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>'></asp:Label>k
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>
                                    <asp:LinkButton runat="server" ID="imgNotes1" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes1','txtNotes'))"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <HeaderStyle Width="510px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgWitnesses.EditIndexes.Count = 0 And (Not rdgWitnesses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgWitnesses.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgWitnesses.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgWitnesses.EditIndexes.Count > 0 Or rdgWitnesses.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewLine" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgWitnesses.EditIndexes.Count = 0 And (Not rdgWitnesses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgWitnesses.EditIndexes.Count = 0 And (Not rdgWitnesses.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgWitnesses.EditIndexes.Count = 0 And (Not rdgWitnesses.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings AllowDragToGroup="false">
                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                    </ClientSettings>
                    <ValidationSettings CommandsToValidate="PerformInsert,UpdateEdited" EnableValidation="true" ValidationGroup="WorkOrder" />
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
</div>
<script language="javascript" type="text/javascript">
    function OnClientLoad(editor, args) {
        editor.get_contentArea().style.backgroundColor = "white";
        editor.get_contentArea().style.backgroundImage = "none";
    }
</script>
