<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementFundingAuthorizationsDetails.ascx.vb" Inherits="Website.CostManagementFundingAuthorizationsDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgFundingAuthorizationsDetails" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder" 
    AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
    HeaderStyle-Font-Size="8" AllowMultiRowEdit="True" ShowGroupPanel="true"
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" showfooter="true"
    PageSize="250" UseEditFormInMobile="true">

    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">

        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber"
                HeaderStyle-Wrap="false" Groupable="false" Reorderable="true" DataField="LineNumber" allowfiltering="false">
                <ItemTemplate>
                    <%#Container.DataItem("LineNumber").ToString%>
                </ItemTemplate>
                <EditItemTemplate>
                    <%#Eval("LineNumber").ToString%>
                </EditItemTemplate>
                <HeaderStyle Width="50px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                <ItemTemplate>
                    <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                    </asp:LinkButton>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                </EditItemTemplate>
                <HeaderStyle Width="75px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>


            <telerik:GridTemplateColumn HeaderText="Funding #" UniqueName="FundingNumber" SortExpression="FundingNumber"
                GroupByExpression="FundingNumber [GridColumn_FundingNumber] Group By FundingNumber ASC" DataField="FundingNumber">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("FundingNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("FundingNumber"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" SortExpression="Year" DataField="Year"
                GroupByExpression="Year [GridColumn_Year] Group By Year ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Year").ToString = "0", "&nbsp;", Container.DataItem("Year"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectFullName" SortExpression="ProjectFullName" DataField="ProjectFullName"
                GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC">
                <ItemTemplate>
                    <asp:HiddenField runat="server" ID="hdnProjectId" Value='<%# Container.DataItem("ProjectId") %>' />
                    <%#IIf(Container.DataItem("ProjectId") = -1, PM.LanguagesInfo.GlobalResource("Program"), IIf(Container.DataItem("ProjectId") = 0, PM.LanguagesInfo.GlobalResource("Portfolio"), Container.DataItem("ProjectFullName")))%>
                </ItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency" DataField="Currency"
                GroupByExpression="Currency [GridColumn_Currency] Group By Currency">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox Width="100%" ID="ddlCurrencies" runat="server" Height="300px" Skin="Default" Style="font-size: 11px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Source" SortExpression="FundingSourceText" DataField="FundingSourceText"
                UniqueName="FundingSource" GroupByExpression="FundingSourceText [GridColumn_FundingSource] Group By FundingSourceText ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("FundingSourceText") = String.Empty, "&nbsp;", Container.DataItem("FundingSourceText"))%>
                </ItemTemplate>
                <HeaderStyle Width="100px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Code" SortExpression="Code" DataField="Code"
                UniqueName="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                </ItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Authorization Code" UniqueName="AuthorizationCode"
                SortExpression="AuthorizationCode" DataField="AuthorizationCode"
                GroupByExpression="AuthorizationCode [GridColumn_AuthorizationCode] Group By AuthorizationCode ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("AuthorizationCode").ToString = String.Empty, "&nbsp;", Container.DataItem("AuthorizationCode").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAuthorizationCode" MaxLength="50" runat="server" Text='<%# Eval("AuthorizationCode") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>
            <%-- <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" 
                SortExpression="Description" 
                GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength ="255" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="200px" />
            </telerik:GridTemplateColumn> --%>


            <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="ThisAuthorization"
                SortExpression="ThisAuthorization" DataField="ThisAuthorization"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                GroupByExpression="ThisAuthorization [GridColumn_ThisAuthorization] Group By ThisAuthorization ASC">
                <ItemTemplate>
                    <%#FormatCurrency(Container.DataItem("ThisAuthorization"), CurrencyId:=CInt(Eval("CurrencyId")))%>
                </ItemTemplate>
                 <EditItemTemplate>
                                <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("ThisAuthorization"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>

            <%--   <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" 
                GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="250px" Filter="Contains"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                        NoWrap="True" AllowCustomText="true"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save" OnClientItemsRequesting="GetValueToReturn" 
                        Style="font-size: 11px" Height="250px" >
                    </telerik:RadComboBox>
                  </EditItemTemplate>
                 <HeaderStyle Width="150px"></HeaderStyle>
           </telerik:GridTemplateColumn> --%>
            <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period"
                GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIf(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
                        Skin="Default" Width="100%" Height="300px" NoWrap="true" CausesValidation="false"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                <ItemTemplate>
                    <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <div style="width: 100%; white-space: nowrap">
                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                        </telerik:RadComboBox>

                        <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                        <span class="Icon"></span>
                        </asp:LinkButton>
                    </div>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes"
                SortExpression="Notes" DataField="Notes"
                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <div><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></div>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>

                    <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                        OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                    </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="250px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field1" DataField="Field1" allowfiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" allowfiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" allowfiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" allowfiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" allowfiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" allowfiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" DataField="Field7" allowfiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" allowfiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" allowfiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" allowfiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
              <telerik:GridTemplateColumn HeaderText="Amount Converted" Visible="false" UniqueName="ThisAuthorizationConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ThisAuthorizationConverted" DataField="ThisAuthorizationConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ThisAuthorizationConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblThisAuthorizationConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                             </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <HeaderStyle Width="100px"></HeaderStyle>
          </telerik:GridTemplateColumn>
                       
        </Columns>
        <ItemStyle Wrap="false" />
        <AlternatingItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
        <FooterStyle CssClass="GridFooter" />
        <SortExpressions>
            <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
        </SortExpressions>
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count = 0 And (Not rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" ValidationGroup="Save"
                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count > 0 %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" ValidationGroup="Save"
                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode" Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count > 0 Or rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnAddFundingCodes" CommandName="AddFundingCodes" CssClass="GridCmdAddFundingCodes" runat="server" CausesValidation="False"
                    Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count = 0 And (Not rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted) %>'
                    SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('FundingSelectorPopup.aspx', 970, 585,true);">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddFundingCodes" Text="Add Funding Codes" meta:resourcekey="lblAddFundingCodes" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count = 0 And (Not rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode" Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count = 0 And (Not rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                    OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgFundingAuthorizationsDetails.EditIndexes.Count = 0 And (Not rdgFundingAuthorizationsDetails.MasterTableView.IsItemInserted) %>'
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
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" AllowDragToGroup="True" AllowRowsDragDrop="False">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
    </ClientSettings>
    <ValidationSettings EnableValidation="true" ValidationGroup="Save" CommandsToValidate="PerformInsert,UpdateEdited" />

</telerik:RadGrid>
        </div>
    </div>
        
</div>
