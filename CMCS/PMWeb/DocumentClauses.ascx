<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentClauses.ascx.vb" Inherits="Website.DocumentClauses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgClauses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy> 
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
<telerik:RadGrid ID="rdgClauses" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
    AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    ShowGroupPanel="True" AllowMultiRowEdit="True" AllowPaging="true" PageSize="250" AllowMultiRowSelection="True" AllowSorting="True"
    ItemStyle-Height="20px" GridLines="None" UseEditFormInMobile="true">

    <PagerStyle AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
        EnableHeaderContextMenu="true">

        <Columns>

            <telerik:GridTemplateColumn HeaderStyle-Width="80px" ItemStyle-Wrap="false" Visible="false" HeaderText="Include in Bid" UniqueName="IncludeInBid" DataField="IncludeInBid"
                SortExpression="IncludeInBid" GroupByExpression="IncludeInBid [GridColumn_IncludeInBid] Group By IncludeInBid ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IncludeInBid"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbIncludeInBid" Checked='<%# Cbool(IIF(Eval("IncludeInBid") is system.DBNULL.value, 0,Eval("IncludeInBid")))%>' runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="80px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Line #" ItemStyle-Wrap="false" UniqueName="LineNumber" DataField="LineNumber"
                SortExpression="LineNumber" Groupable="false">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="70px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Paragraph" ItemStyle-Wrap="false" UniqueName="Paragraph" DataField="Paragraph"
                SortExpression="Paragraph" GroupByExpression="Paragraph [GridColumn_Paragraph] Group By Paragraph ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Paragraph").ToString = String.Empty, "&nbsp;", Container.DataItem("Paragraph").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtParagraph" MaxLength="500" runat="server" Text='<%# Eval("Paragraph") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Category" UniqueName="Category" DataField="Category"
                SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCategory" runat="server" Width="100%" Filter="Contains" AllowCustomText="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Filter="Contains" AllowCustomText="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Text" ItemStyle-Wrap="false" UniqueName="Text" DataField="Text"
                SortExpression="Text" GroupByExpression="Text [GridColumn_Text] Group By Text ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Text") = String.Empty, "&nbsp;", Container.DataItem("Text"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtText" runat="server" Text='<%#Eval("Text")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>
                    <asp:LinkButton runat="server" ID="imgText" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgText','txtText'))"
                        CssClass="SearchButton">
                                           <span class="Icon"></span>
                    </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Responsible" UniqueName="Responsible" DataField="Responsible"
                SortExpression="Responsible" GroupByExpression="Responsible [GridColumn_Responsible] Group By Responsible ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Responsible").ToString = String.Empty, "&nbsp;", Container.DataItem("Responsible").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlResponsible" runat="server" Width="100%" Filter="Contains" AllowCustomText="true"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Start" UniqueName="Start" DataField="Start"
                SortExpression="Start" GroupByExpression="Start [GridColumn_Start] Group By Start ASC">
                <ItemTemplate>
                    <span><%#FormatDate(Eval("Start"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpStart" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                <%--        <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>--%>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" DataField="DaysToStart"
                HeaderText="Days To Start" UniqueName="DaysToStart" Groupable="True"
                SortExpression="DaysToStart" GroupByExpression="DaysToStart [GridColumn_DaysToStart] Group By DaysToStart ASC">
                <ItemTemplate>
                    <asp:Label ID="lblDaysToStart" runat="server" Text='<%#Eval("DaysToStart")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblEditDaysToStart" runat="server" Text='<%#Eval("DaysToStart")%>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="End" UniqueName="End" DataField="End"
                SortExpression="End" GroupByExpression="End [GridColumn_End] Group By End ASC">
                <ItemTemplate>
                    <span><%#FormatDate(Eval("End"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpEnd" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                <%--    <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>--%>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Days To End"
                UniqueName="DaysToEnd" Groupable="True" DataField="DaysToEnd"
                SortExpression="DaysToEnd" GroupByExpression="DaysToEnd [GridColumn_DaysToEnd] Group By DaysToEnd ASC">
                <ItemTemplate>
                    <asp:Label ID="lblDaysToEnd" runat="server" Text='<%#Eval("DaysToEnd")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblEditDaysToEnd" runat="server" Text='<%#Eval("DaysToEnd")%>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>
                    <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                        CssClass="SearchButton">
                                           <span class="Icon"></span>
                    </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" DataType="System.Boolean" UniqueName="Inactive" DataField="Inactive"
                SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("Inactive") is system.DBNULL.value, 0,Eval("Inactive")))%>' runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="70px" />
            </telerik:GridTemplateColumn>

        </Columns>

        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CausesValidation="false" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgClauses.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgClauses.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgClauses.EditIndexes.Count > 0 Or rdgClauses.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnAddClauses" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdAddClauses"
                    CommandName="AddClauses" OnClientClick="return OpenSelectClausesPopup();"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 And (Not rdgClauses.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddClauses">
                    <span class="Icon"></span>
                    <asp:Label ID="Label4" runat="server" meta:resourcekey="lblAddClausesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 And (Not rdgClauses.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>


                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgClauses.EditIndexes.Count = 0 And (Not rdgClauses.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                    EnableShadows="true" CausesValidation="false"
                    Visible="true">
                </telerik:RadMenu>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings AllowDragToGroup="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
    </ClientSettings>

</telerik:RadGrid>
            </div>
        </div>
    </div>