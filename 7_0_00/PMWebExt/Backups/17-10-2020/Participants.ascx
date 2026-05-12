<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Participants.ascx.vb"
    Inherits="Website.Participants" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock runat="server" ID="script1">

    <script language="javascript" type="text/javascript">
        function refreshGrid(arg) {
            $find("<%= pnlParticipants.ClientID %>").ajaxRequest("Rebind");
        }

        function OpenParticipantsPopup(OpenParticipantsPopup, ddlProjectId) {
            var left = (screen.width - 920) / 2;
            var top = (screen.height - 300) / 2;

            var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=NotExist&txtEmail=NotExist&Type=Contacts&ProjectRequired=1&ProjectId=' + <%=Me.PM.Document.MeetingMinutesInfo.ProjectId%> + '&txtIds=NotExist&ddlType=Multiple&Source=Participants', '',
                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
            return false;
        }
    </script>

</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgParticipants">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgParticipants" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="pnlParticipants">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgParticipants" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshParticipant">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgParticipants" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshParticipant" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxPanel ID="pnlParticipants" runat="server">
    <telerik:RadGrid ID="rdgParticipants" runat="server" CssClass="LightWeight" SetWidth="true" AppendMenus="true" FitParentContainer="true"
        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px"
        AllowPaging="True" PageSize="5" ShowGroupPanel="False" AllowMultiRowEdit="true" AllowMultiRowSelection="true"
        AllowSorting="False" GridLines="None" UseEditFormInMobile="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
        <HeaderContextMenu EnableViewState="false">
        </HeaderContextMenu>
        <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
            UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
            EnableHeaderContextMenu="true" TableLayout="Fixed">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Contact" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-Wrap="false" Groupable="false" UniqueName="Contact" Reorderable="false">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("CompanyContactName") = String.Empty, "&nbsp;", Container.DataItem("CompanyContactName"))%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div style="width: 100%; white-space: nowrap">
                            <telerik:RadComboBox ID="ddlFromContact" runat="server" Width="90%"
                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                NoWrap="True" AllowCustomText="true" DropDownWidth="380px" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                OnClientDropDownClosed="dllcompClientClosed"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                OnItemsRequested="ddl_ItemsRequested"
                                Style="font-size: 11px" Height="250px">
                                <HeaderTemplate>
                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="width: 250px;">
                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                            <td style="width: 135px;">
                                                <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                        <tr>
                                            <td style="width: 250px;">
                                                <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                            </td>
                                            <td style="width: 135px;">
                                                <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:LinkButton runat="server" ID="imgfilter"
                                OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlFromContact'),'Contacts')"
                                CssClass="SearchButton">
                                             <span class="Icon"></span>
                            </asp:LinkButton>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </div>
                    </EditItemTemplate>
                    <HeaderStyle Wrap="False" Width="198px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="Present" HeaderText="Present" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Present"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbPresent" Checked='<%# Cbool(IIF(Eval("Present") is system.DBNULL.value, 0,Eval("Present")))%>' runat="server" />
                    </EditItemTemplate>
                    <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                    CancelImageUrl="Cancel.gif">
                </EditColumn>
            </EditFormSettings>
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                        SecurityButtonType="ItemMode_Edit" Visible='<%# rdgParticipants.EditIndexes.Count = 0 And (Not rdgParticipants.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                        SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgParticipants.EditIndexes.Count > 0 %>'
                        meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Record">
                        <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                        SecurityButtonType="AddEditMode_Add" Visible='<%# rdgParticipants.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnSaveResource1" ValidationGroup="Record">
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                        SecurityButtonType="AddEditMode" Visible='<%# rdgParticipants.EditIndexes.Count > 0 Or rdgParticipants.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                        SecurityButtonType="ItemMode_Add" Visible='<%# rdgParticipants.EditIndexes.Count = 0 And (Not rdgParticipants.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAddMultiple" runat="server" CausesValidation="False" CommandName="AddMultiple" CssClass="GridCmdAddMultiple"
                        OnClientClick="javascript:return OpenParticipantsPopup();"
                        SecurityButtonType="ItemMode_Add" Visible='<%# rdgParticipants.EditIndexes.Count = 0 And (Not rdgParticipants.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddMultipleContacts" runat="server" Text="Add line" meta:resourcekey="lblAddMultipleContacts"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdgParticipants.EditIndexes.Count = 0 And (Not rdgParticipants.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings Resizing-AllowColumnResize="true">
        </ClientSettings>
    </telerik:RadGrid>

    <asp:Button ID="btnRefreshParticipant" runat="server" CssClass="Hide" />

</telerik:RadAjaxPanel>
