<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagerConfigure.ascx.vb" Inherits="Website.IntegrationManagerConfigure" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgImportRecords">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgImportRecords" LoadingPanelID="LdpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgInToPMWebWebServices">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInToPMWebWebServices" LoadingPanelID="LdpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnManualReceive">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInToPMWebWebServices" LoadingPanelID="LdpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnManualReceive" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgRecords">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRecords" LoadingPanelID="LdpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgOutFromPMWebWebServices">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOutFromPMWebWebServices" LoadingPanelID="LdpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<fieldset>
    <legend>
        <asp:Label runat="server" Text="Out From PMWeb" meta:resourcekey="lblOutFromPMweb" ID="lblOutFromPMweb"></asp:Label>
    </legend>
    <table>
        <tr>
            <td class="NoWrap">
                <asp:Label ID="lblOutputileAS" Width="100%" runat="server" meta:resourcekey="lblOutputileAS" Text="Output File As"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlOutputFile" Width="200px" runat="server">
                    <asp:ListItem Selected="True" Text="MS Excel" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Text(Comma Delimited)" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Text(Tab Delimited)" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Text(Pipe Delimited)" Value="5"></asp:ListItem>
                    <asp:ListItem Text="XML" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:CheckBox ID="chkOverwriteFiles" Text="Overwrite Files" meta:resourcekey="chkOverwriteFiles" runat="server" />
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="rdgRecords" runat="server"
        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10"
        ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True"
        AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="True" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" EnableHeaderContextMenu="false">
            <Columns>

                <telerik:GridTemplateColumn HeaderText="Record Type" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                    UniqueName="RecordType" SortExpression="RecordType">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlRecordType" MarkFirstMatch="true" runat="server" OnClientSelectedIndexChanged="SetfileName"
                            Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                            CausesValidation="False">
                        </telerik:RadComboBox>
                        <asp:HiddenField ID="txtId" Value='<%#Eval("Id")%>' runat="server"></asp:HiddenField>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Select Fields" UniqueName="SelectFields" SortExpression="SelectFields"
                    GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields">

                    <ItemTemplate>
                        <asp:HyperLink ID="hplSelectFields" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                            Text='<%#IIf(Container.DataItem("SelectFields") = String.Empty, "&nbsp;", Container.DataItem("SelectFields"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox OnClientDropDownClosed="onSelectedIndexChanging"
                            ID="ddlSelectFields" Width="100%" runat="server">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="150px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Record Status" UniqueName="RecordStatus" SortExpression="RecordStatus"
                    GroupByExpression="RecordStatus [GridColumn_RecordStatus] Group By RecordStatus ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("RecordStatus") = String.Empty, "&nbsp;", Container.DataItem("RecordStatus"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlRecordStatus" runat="server" Height="250px"
                            AllowCustomText="True" Width="100%" DropDownWidth="300px">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApplySkills" />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills"></asp:Label>
                                    <%#Eval("Value")%>
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="File Name" SortExpression="FileName" UniqueName="FileName"
                    GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("FileName") = String.Empty, "&nbsp;", Container.DataItem("FileName"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFileName" runat="server" Text='<%# Eval("FileName") %>' Width="100%"
                            MaxLength="4000"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFileName" ValidationGroup="Record"
                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Decimal Places" UniqueName="DecimalPalces"
                    SortExpression="DecimalPalces" GroupByExpression="DecimalPalces [GridColumn_DecimalPalces] Group By DecimalPalces ASC">
                    <ItemTemplate>
                        <span><%#Container.DataItem("DecimalPalces")%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDecimalPalces" runat="server" Width="100%" CssClass="Integer"
                            MaxLength="15" MinNumber="2" MaxNumber="6" Text='<%# IIF(Eval("DecimalPalces") is system.DBNULL.value, "2", Eval("DecimalPalces")) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="70px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Enable Auto <br> Send" UniqueName="EnableAutoSend" HeaderStyle-Width="50px"
                    ItemStyle-Wrap="false" SortExpression="EnableAutoSend" GroupByExpression="EnableAutoSend [GridColumn_EnableAutoSend] Group By EnableAutoSend ASC"
                    ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("EnableAutoSend"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbEnableAutoSend" Checked='<%# Cbool(IIF(Eval("EnableAutoSend") is system.DBNULL.value, 0,Eval("EnableAutoSend")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <table>
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgRecords.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Record">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgRecords.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgRecords.EditIndexes.Count > 0 Or rdgRecords.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:Button ID="btnSendNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="LargeButton"
                                    SecurityButtonType="ItemMode_Add" Text="Manual Send" meta:resourcekey="btnSendNow"
                                    Visible='<%# rdgRecords.EditIndexes.Count = 0 And (Not rdgRecords.MasterTableView.IsItemInserted) %>' />
                            </td>
                        </tr>
                    </table>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="False">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
            <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
        </ClientSettings>
        <ValidationSettings ValidationGroup="Record" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>
    <br />
    <telerik:RadGrid ID="rdgOutFromPMWebWebServices" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8"
        Width="100%" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="false">
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Web Service URL*" UniqueName="URL" HeaderStyle-Width="311px"
                    SortExpression="URL">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("URL")%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOutWebserviceUrl" runat="server" Width="100%" Text='<%# Eval("URL") %>'>
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtOutWebserviceUrl" ValidationGroup="OutPMweb"
                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Use Network Credential" UniqueName="UseNetworkCredential" HeaderStyle-Width="90px"
                    SortExpression="UseNetworkCredential">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("UseNetworkCredential"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkOutUseCredential" OnClick='EnableDisableOutCredential(this, event);' Checked='<%# Cbool(IIF(Eval("UseNetworkCredential") is system.DBNULL.value, 0,Eval("UseNetworkCredential")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="User" UniqueName="WebServiceUser" HeaderStyle-Width="100px"
                    SortExpression="WebServiceUser">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("WebServiceUser").ToString = String.Empty, "&nbsp;", Container.DataItem("WebServiceUser").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOutUser" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WebServiceUser") %>'>
                        </asp:TextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Password" UniqueName="WebServicePassword" HeaderStyle-Width="90px">
                    <ItemTemplate>
                        <span>***
                        </span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOutPassword" MaxLength="130" Width="100%" runat="server" TextMode="Password">
                        </asp:TextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Folder Path*" UniqueName="FolderPath" HeaderStyle-Width="300px"
                    SortExpression="FolderPath">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("FolderPath").ToString = String.Empty, "&nbsp;", Container.DataItem("FolderPath").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOutFilePath" Width="100%" runat="server" Text='<%# Eval("FolderPath") %>'>
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvoutFilePath" ControlToValidate="txtOutFilePath" ValidationGroup="OutPMweb"
                            runat="server" ForeColor="" Display="Dynamic" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
                <div style="padding: 2px">

                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CssClass="GridCmdEditRows"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows"
                        Visible='<%# rdgOutFromPMWebWebServices.EditIndexes.Count = 0 AND (Not rdgOutFromPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label1" runat="server"
                            Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="GridCmdUpdateEdited"
                        SecurityButtonType="AddEditMode_Edit"
                        ValidationGroup="OutPMweb" CommandName="UpdateEdited"
                        Visible='<%# rdgOutFromPMWebWebServices.EditIndexes.Count > 0 %>'
                        meta:resourcekey="btnUpdateEditedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label2" runat="server" Text="Update records"
                            meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" ValidationGroup="OutPMweb" CssClass="GridCmdPerformInsert"
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert"
                        Visible='<%# rdgOutFromPMWebWebServices.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label3" runat="server" Text="Save"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll"
                        Visible='<%# rdgOutFromPMWebWebServices.EditIndexes.Count > 0 Or rdgOutFromPMWebWebServices.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label4" runat="server" Text="Cancel"
                            meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CssClass="GridCmdInitNewRow"
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow"
                        Visible='<%# rdgOutFromPMWebWebServices.EditIndexes.Count = 0 AND (Not rdgOutFromPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Add line"
                            meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CssClass="GridCmdRebindGrid"
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid"
                        Visible='<%# rdgOutFromPMWebWebServices.EditIndexes.Count = 0 AND (Not rdgOutFromPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnRefreshResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label6" runat="server" Text="Refresh"
                            meta:resourcekey="lblRefreshResource1"></asp:Label>
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <HeaderStyle Font-Size="8pt"></HeaderStyle>
        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
        </ClientSettings>
        <ValidationSettings ValidationGroup="OutPMweb" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>
</fieldset>
<br />
<fieldset>
    <legend>
        <asp:Label ID="lblInToPmweb" Text="In To PMWeb" meta:resourcekey="lblInToPmweb" runat="server"></asp:Label>
    </legend>
    <table style="display: none;">
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td style="width: 200px;" align="right">
                <asp:Button ID="btnViewTemplate" meta:resourcekey="btnViewTemplate" runat="server" CausesValidation="false"
                    OnClientClick="return OpenImportTemplate();"
                    Text="View Templates"></asp:Button>
            </td>
        </tr>
    </table>
    <br />
    <telerik:RadGrid ID="rdgImportRecords" runat="server"
        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10"
        ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True"
        AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="True" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" EnableHeaderContextMenu="false">
            <Columns>

                <telerik:GridTemplateColumn HeaderText="Record Type" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                    UniqueName="RecordType" SortExpression="RecordType">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlRecordType" MarkFirstMatch="true" runat="server" OnClientSelectedIndexChanged="SetfileName"
                            Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                            CausesValidation="False">
                        </telerik:RadComboBox>
                        <asp:HiddenField ID="txtId" Value='<%#Eval("Id")%>' runat="server"></asp:HiddenField>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Download Template" UniqueName="DownloadTemplate"
                    GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields" Groupable="false">

                    <ItemTemplate>
                        <asp:HyperLink ID="hplDownloadTemplate" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                            Text="Download Template" Target="_blank"
                            NavigateUrl='http://www.pmweb.com/pages/integrationmanagerdownloads.aspx'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                        &nbsp;
                    </EditItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Map Fields" UniqueName="MapFileds"
                    GroupByExpression="SelectFields [GridColumn_SelectFields] Group By SelectFields" Groupable="false">

                    <ItemTemplate>
                        <asp:HyperLink ID="hplMapFileds" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                            Text='<%#IIf(Container.DataItem("MapFields") = String.Empty, "&nbsp;", Container.DataItem("MapFields"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                        &nbsp;
                    </EditItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="File Path*" SortExpression="ImportFileName" UniqueName="FilePath"
                    GroupByExpression="ImportFileName [GridColumn_ImportFileName] Group By ImportFileName ASC" DataField="ImportFileName">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("ImportFileName") = String.Empty, "&nbsp;", Container.DataItem("ImportFileName"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtImportFileName" runat="server" Text='<%# Eval("ImportFileName") %>' Width="100%"
                            MaxLength="4000"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtImportFileName" ValidationGroup="Record"
                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Enable Auto <br> Receive" UniqueName="EnableAutoReceive" HeaderStyle-Width="50px"
                    ItemStyle-Wrap="false" SortExpression="EnableAutoReceive" GroupByExpression="EnableAutoReceive [GridColumn_EnableAutoReceive] Group By EnableAutoReceive ASC"
                    ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EnableAutoReceive")) = CBool(1), "checked.png", "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbEnableAutoReceive" Checked='<%# CBool(IIf(Eval("EnableAutoReceive") Is System.DBNull.Value, 0, Eval("EnableAutoReceive")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn HeaderText="Delete Previous" UniqueName="DeletePrevious" HeaderStyle-Width="50px"
                    ItemStyle-Wrap="false" SortExpression="DeletePreviousRecord" GroupByExpression="DeletePreviousRecord [GridColumn_DeletePrevious] Group By DeletePreviousRecord ASC"
                    ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("DeletePreviousRecord")) = CBool(1), "checked.png", "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbDeletePrevious" Checked='<%# CBool(IIf(Eval("DeletePreviousRecord") Is System.DBNull.Value, 0, Eval("DeletePreviousRecord")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <table>
                        <tr>
                            <td>
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgImportRecords.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Record">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgImportRecords.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode" Visible='<%# rdgImportRecords.EditIndexes.Count > 0 Or rdgImportRecords.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode" Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:Button ID="btnReceiveNow" runat="server" CausesValidation="False" CommandName="SendNow" CssClass="LargeButton"
                                    SecurityButtonType="ItemMode_Add" Text="Receive Selected Lines" meta:resourcekey="btnReceiveNow"
                                    Visible='<%# rdgImportRecords.EditIndexes.Count = 0 AND (Not rdgImportRecords.MasterTableView.IsItemInserted) %>' />
                            </td>
                        </tr>
                    </table>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="False">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
            <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
        </ClientSettings>
        <ValidationSettings ValidationGroup="Record" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>
    <br />
    <telerik:RadGrid ID="rdgInToPMWebWebServices" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8"
        Width="100%" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="False">
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Web Service URL*" UniqueName="URL" HeaderStyle-Width="311px"
                    SortExpression="URL">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("URL")%>&nbsp;</span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtInWebserviceUrl" runat="server" Width="100%" Text='<%# Eval("URL") %>'>
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtInWebserviceUrl" ValidationGroup="InToPmweb"
                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Use Network credential" UniqueName="UseNetworkCredential" HeaderStyle-Width="90px"
                    SortExpression="UseNetworkCredential">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("UseNetworkCredential")) = CBool(1), "checked.png", "unchecked.png"))%>"
                            alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkInUseCredential" OnClick='EnableDisableCredential(this, event);' Checked='<%# CBool(IIf(Eval("UseNetworkCredential") Is System.DBNull.Value, 0, Eval("UseNetworkCredential")))%>'
                            runat="server" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="User" UniqueName="WebServiceUser" HeaderStyle-Width="100px"
                    SortExpression="WebServiceUser">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("WebServiceUser").ToString = String.Empty, "&nbsp;", Container.DataItem("WebServiceUser").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtInUser" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("WebServiceUser") %>'>
                        </asp:TextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Password" UniqueName="WebServicePassword" HeaderStyle-Width="90px">
                    <ItemTemplate>
                        <span>***
                        </span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtInPassword" MaxLength="130" Width="100%" runat="server" TextMode="Password">
                        </asp:TextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
                <div style="padding: 2px">

                    <asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" CssClass="GridCmdEditRows"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows"
                        Visible='<%# rdgInToPMWebWebServices.EditIndexes.Count = 0 And (Not rdgInToPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label7" runat="server"
                            Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton8" runat="server" CssClass="GridCmdUpdateEdited"
                        SecurityButtonType="AddEditMode_Edit"
                        ValidationGroup="InToPmweb" CommandName="UpdateEdited"
                        Visible='<%# rdgInToPMWebWebServices.EditIndexes.Count > 0 %>'
                        meta:resourcekey="btnUpdateEditedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label8" runat="server" Text="Update records"
                            meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton9" runat="server" ValidationGroup="InToPmweb" CssClass="GridCmdPerformInsert"
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert"
                        Visible='<%# rdgInToPMWebWebServices.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label9" runat="server" Text="Save"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton10" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll"
                        Visible='<%# rdgInToPMWebWebServices.EditIndexes.Count > 0 Or rdgInToPMWebWebServices.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label10" runat="server" Text="Cancel"
                            meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton11" runat="server" CausesValidation="False" CssClass="GridCmdInitNewRow"
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow"
                        Visible='<%# rdgInToPMWebWebServices.EditIndexes.Count = 0 And (Not rdgInToPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label11" runat="server" Text="Add line"
                            meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton12" runat="server" CausesValidation="False" CssClass="GridCmdRebindGrid"
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid"
                        Visible='<%# rdgInToPMWebWebServices.EditIndexes.Count = 0 And (Not rdgInToPMWebWebServices.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnRefreshResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label12" runat="server" Text="Refresh"
                            meta:resourcekey="lblRefreshResource1"></asp:Label>
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <HeaderStyle Font-Size="8pt"></HeaderStyle>
        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
        </ClientSettings>
        <ValidationSettings ValidationGroup="InToPmweb" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>

</fieldset>
