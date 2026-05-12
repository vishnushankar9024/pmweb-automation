<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EstimateMarkup.ascx.vb"
    Inherits="Website.EstimateMarkup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamMarkup" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMarkupDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMarkupDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpMarkup" runat="server" Skin="Default" meta:resourcekey="ldpMarkup" />
<%--<div style="overflow: auto; width: 100%;" id="MarkupDiv">--%>
    <telerik:RadGrid ID="rdgMarkupDetails" runat="server" AllowFilteringByColumn="true"  FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
         AutoGenerateColumns="False" HeaderStyle-Font-Size="8" PageSize="15"
        AllowPaging="True" ShowFooter="True" ShowStatusBar="True" GridLines="None">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace"  TableLayout="Fixed" EnableHeaderContextMenu="true">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Description*"  UniqueName="Description" Groupable="false" DataField="Description" >
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription"  MaxLength="200" runat="server" Text='<%# Eval("Description") %>'
                            Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            CssClass="Validator" ErrorMessage="<br />Enter the Description" Display="Dynamic"
                            ForeColor="" ValidationGroup="EstimateMarkup" meta:resourcekey="rfvDescription"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="150px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="%*" UniqueName="Percent" Groupable="false" DataField="Percent">
                    <ItemTemplate>
                        <span><%#FormatNumber(ParseDouble(Eval("Percent")))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPercent" MinNumber="-100" MaxNumber="100" CssClass="Percent" runat="server" 
                            Width="100%" MaxLength="7" Text='<%# CDbl(IIF(Eval("Percent") is system.DBNULL.value, 0, Eval("Percent"))).ToString() %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPercent" runat="server" ControlToValidate="txtPercent"
                            CssClass="Validator" ErrorMessage="<br />Enter the Percent" Display="Dynamic"
                            ForeColor="" ValidationGroup="EstimateMarkup" meta:resourcekey="rfvPercent"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <HeaderStyle Width="50px" />
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Applies To" UniqueName="AppliesTo" Groupable="false" >
                    <ItemTemplate>
                        <asp:Label ID="lblCostTypes" runat="server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlCostTypes" runat="server" AllowCustomText="True" Width="100%"
                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default" meta:resourcekey="ddlCostTypes">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApply" />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply">
                                        <%#Eval("CostType")%>
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="150px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Cumulative" UniqueName="Cumulative" Groupable="false" DataField="IsCumulative">
                    <ItemTemplate>
                        <img src='Images/Global/<%# CStr(IIF(Eval("IsCumulative"),"checked.png" , "unchecked.png")) %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkIsCumulative" runat="server" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotal" runat="server" Text="Total" Font-Bold="True" meta:resourcekey="lblTotal"></asp:Label>
                    </FooterTemplate>
                    <HeaderStyle Width="90px" />
                    <ItemStyle HorizontalAlign="Center" />
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Calculated<br />Markup" ItemStyle-Wrap="false" Groupable="false" 
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" UniqueName="CalculatedAmount">
                    <ItemTemplate>
                        <asp:Label ID="lblCalculatedMarkup" runat="server" Style="text-align: right;" ></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCalculatedAmount" MaxLength ="15" runat="server" CssClass="Currency" Text='<%# FormatCurrency(ParseDouble(Eval("Amount"))) %>'
                            Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalCalculatedMarkup" runat="server" Font-Bold="True" ></asp:Label>
                    </FooterTemplate>
                    <HeaderStyle Width="120px" />
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Markup<br />Amount" ItemStyle-Wrap="false" UniqueName="MarkupAmount"
                    ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" Groupable="false">
                    <ItemTemplate>
                        <asp:Label ID="lblMarkup" runat="server" Style="text-align: right;" ></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAmount" MaxLength ="15" runat="server" Text='<%# FormatCurrency(ParseDouble(Eval("Amount"))) %>'
                            Width="100%" CssClass="Currency"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalMarkup" runat="server" Font-Bold="True" ></asp:Label>
                    </FooterTemplate>
                    <HeaderStyle Width="120px" />
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Manual" UniqueName="IsManual" Groupable="false" DataField="IsManual">
                    <ItemTemplate>
                        <img src='Images/Global/<%# CStr(IIF(Eval("IsManual"),"checked.png" , "unchecked.png")) %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkIsManual" runat="server" />
                    </EditItemTemplate>
                    <HeaderStyle Width="50px" />
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode" Groupable="false" DataField="CostCode">
                    <ItemTemplate>
                        <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                        </asp:HyperLink>
                        <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" MarkFirstMatch="True" Skin="Default"
                            Style="font-size: 11px" NoWrap="True" Height="150px">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="200px" />
                    <HeaderStyle HorizontalAlign="Center" />
                </telerik:GridTemplateColumn>
            </Columns>
            <EditItemStyle Wrap="false" />
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left" Font-Size="8pt"/>
            <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
                <div style="padding: 2px">
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows" 
                        CommandName="EditRows" Visible='<%# rdgMarkupDetails.EditIndexes.Count = 0 AND (Not rdgMarkupDetails.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited" 
                        ValidationGroup="EstimateMarkup" CommandName="UpdateEdited" Visible='<%# rdgMarkupDetails.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert" 
                        CommandName="PerformInsert" Visible='<%# rdgMarkupDetails.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll" 
                        CommandName="CancelAll" Visible='<%# rdgMarkupDetails.EditIndexes.Count > 0 Or rdgMarkupDetails.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                        CommandName="InitNewRow" Visible='<%# rdgMarkupDetails.EditIndexes.Count = 0 AND (Not rdgMarkupDetails.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows" 
                        OnClientClick="return ConfirmDelete()" Visible='<%# rdgMarkupDetails.EditIndexes.Count = 0 AND (Not rdgMarkupDetails.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid" 
                        CommandName="RebindGrid" Visible='<%# rdgMarkupDetails.EditIndexes.Count = 0 AND (Not rdgMarkupDetails.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                    </asp:LinkButton>
                      &nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                    CommandName="SaveState">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </asp:LinkButton>
                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                    CausesValidation="False" CommandName="LoadDefaultState">
                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true"
            Resizing-AllowColumnResize="true">
            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
          <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
        </ClientSettings>

        <ValidationSettings ValidationGroup="EstimateMarkup" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
    </telerik:RadGrid>
<%--</div>--%>
