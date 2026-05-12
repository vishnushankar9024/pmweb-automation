<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Adjustments.aspx.vb" Inherits="Website.Adjustments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            function CheckManual(chkManual, RecordCurrencyId) {
                var chkNewLine = $($('#' + chkManual.id.replace('_chkIsManual', '_chkAppendLine'))[0])[0];
                var ddlCurrencies = $find(chkManual.id.replace('_chkIsManual', '_ddlCurrencies'));

                if (ddlCurrencies && chkNewLine) {
                    if (!(chkNewLine.checked)) {
                        if (chkManual.checked) {
                            var comboitem = ddlCurrencies.findItemByValue("-1");
                            if (comboitem != null) {
                                ddlCurrencies.get_items().remove(comboitem);
                            }
                            ddlCurrencies.set_enabled(true);
                            ddlCurrencies._inputDomElement.removeAttribute("disabled");
                            ddlCurrencies.findItemByValue(RecordCurrencyId).select();
                        }
                        else {
                            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                            comboItem.set_text("");
                            comboItem.set_value("-1");
                            var RecordItem = ddlCurrencies.findItemByValue(RecordCurrencyId);
                            comboItem.get_attributes()._add("symbol", RecordItem.get_attributes().getAttribute("symbol"))
                            comboItem.get_attributes()._add("symbolposition", RecordItem.get_attributes().getAttribute("symbolposition"))
                            ddlCurrencies.get_items().add(comboItem);
                            ddlCurrencies._inputDomElement.setAttribute("disabled", "disabled");
                            comboItem.select();
                            ddlCurrencies.set_enabled(false);
                        }
                    }
                }
            }

            function AppendLineClicked(chkNewLine, RecordCurrencyId) {
                var chkManual = $($('#' + chkNewLine.id.replace('_chkAppendLine', '_chkIsManual'))[0])[0];
                var ddlCurrencies = $find(chkNewLine.id.replace('_chkAppendLine', '_ddlCurrencies'));
                if (ddlCurrencies && chkNewLine) {
                    if (!(chkManual.checked)) {
                        if (chkNewLine.checked) {
                            var comboitem = ddlCurrencies.findItemByValue("-1");
                            if (comboitem != null) {
                                ddlCurrencies.get_items().remove(comboitem);
                            }
                            ddlCurrencies.set_enabled(true);
                            ddlCurrencies._inputDomElement.removeAttribute("disabled");
                            ddlCurrencies.findItemByValue(RecordCurrencyId).select();
                        }
                        else {
                            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                            comboItem.set_text("");
                            comboItem.set_value("-1");
                            var RecordItem = ddlCurrencies.findItemByValue(RecordCurrencyId);
                            comboItem.get_attributes()._add("symbol", RecordItem.get_attributes().getAttribute("symbol"))
                            comboItem.get_attributes()._add("symbolposition", RecordItem.get_attributes().getAttribute("symbolposition"))
                            ddlCurrencies.get_items().add(comboItem);
                            ddlCurrencies._inputDomElement.setAttribute("disabled", "disabled");
                            comboItem.select();
                            ddlCurrencies.set_enabled(false);
                        }
                    }
                }
            }
        </script>
         <style>
             @media screen and (min-width: 320px) and (max-width: 843px) {
                /* .divContentHolder {
                     margin-top: 60px;
                 }*/
             }
        </style>
    </telerik:RadCodeBlock>


    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgAdjustments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

                                        <telerik:RadGrid ID="rdgAdjustments" runat="server" HeaderStyle-Font-Size="8" UseEditFormInMobile="true" 
                                            AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                            AllowMultiRowEdit="True" AllowSorting="True" PageSize="250" AllowPaging="True" AllowMultiRowSelection="true" ShowGroupPanel="True">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                                                <Columns>

                                                    <telerik:GridTemplateColumn HeaderText="Column*" DataField="AdjustmentColumn" SortExpression="AdjustmentColumn" GroupByExpression="AdjustmentColumn [GridColumn_AdjustmentColumn] Group By AdjustmentColumn ASC" UniqueName="AdjustmentColumn">
                                                        <ItemTemplate>
                                                            <span><%#IIf(CStr(Eval("AdjustmentColumn")) = String.Empty, "&nbsp;", Eval("AdjustmentColumn"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlColumns" runat="server" Width="100%">
                                                            </telerik:RadComboBox>

                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="120px" />
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="ID*" SortExpression="Code" Groupable="false" UniqueName="Code" DataField="Code">
                                                        <ItemTemplate>
                                                            <span><%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>

                                                            <asp:TextBox ID="txtCode" runat="server" Text='<%# Eval("Code") %>' Width="100%"
                                                                MaxLength="200"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvCode" ControlToValidate="txtCode" Display="Dynamic"
                                                                runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>

                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="80px" />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" DataField="Description"
                                                        GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                                        <ItemTemplate>
                                                            <span>
                                                                <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' Width="100%" MaxLength="255"></asp:TextBox>

                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="120px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" UniqueName="Company" DataField="Company"
                                                        GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("CompanyId") = -1 Or Container.DataItem("CompanyId") = 0, "&nbsp;", Container.DataItem("Company"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"  Filter="Contains"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                                NoWrap="True" AllowCustomText="true"
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="120px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                                                        GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" 
                                                                Skin="Default" Height="250px">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="150"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="%" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage ASC" UniqueName="Percentage" DataField="Percentage"
                                                        SortExpression="Percentage">
                                                        <ItemTemplate>
                                                            <span><%#IIf(CStr(Eval("Percentage")) = "0", "&nbsp;", FormatPercent(Container.DataItem("Percentage")))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtPercentage" CssClass="Percent" runat="server" precision="5" Width="100%" MaxLength="15"
                                                                Text='<%#  FormatPercent(Eval("Percentage"), NumDigitsAfterDecimal:=5) %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="72px" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostTypes" GroupByExpression="CostTypes [GridColumn_CostTypes] Group By CostTypes ASC" UniqueName="CostTypes" DataField="CostTypes">
                                                        <ItemTemplate>
                                                            <span><%#IIf(CStr(Eval("CostTypes")) = String.Empty, "&nbsp;", Eval("CostTypes"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlCostTypes" runat="server" AllowCustomText="True" Width="100%" Filter="Contains" MarkFirstMatch="true"
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

                                                    <telerik:GridTemplateColumn HeaderText="Cumulative" DataField="IsCumulative" GroupByExpression="IsCumulative [GridColumn_IsCumulative] Group By IsCumulative ASC" UniqueName="IsCumulative">
                                                        <ItemTemplate>
                                                            <img src='Images/Global/<%# CStr(IIf(Eval("IsCumulative"), "checked.png", "unchecked.png")) %>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkIsCumulative" Checked='<%# CBool(IIf(Eval("IsCumulative") Is System.DBNull.Value, 1, Eval("IsCumulative")))%>'
                                                                runat="server" class="mobile-switch" />
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="90px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Manual" DataField="IsManual" GroupByExpression="IsManual [GridColumn_IsManual] Group By IsManual ASC" UniqueName="IsManual">
                                                        <ItemTemplate>
                                                            <img src='Images/Global/<%# CStr(IIf(Eval("IsManual"), "checked.png", "unchecked.png")) %>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkIsManual" Checked='<%# CBool(IIf(Eval("IsManual") Is System.DBNull.Value, 0, Eval("IsManual")))%>'
                                                                runat="server" class="mobile-switch" />
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="90px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Adjustment Amount" DataField="Amount" GroupByExpression="Amount [GridColumn_Amount] Group By Amount ASC" UniqueName="Amount"
                                                        SortExpression="Amount">
                                                        <ItemTemplate>
                                                            <span><%#IIf(CStr(Eval("Amount")) = "0", "&nbsp;", FormatCurrency(Container.DataItem("Amount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.CurrenciesController.GetDefault, Eval("CurrencyId"))))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                                                Text='<%# FormatCurrency(Eval("Amount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value OrElse Eval("CurrencyId") <= 0, PM.CurrenciesController.GetDefault, Eval("CurrencyId")))%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="110px"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="New Line" DataField="AppendLine" GroupByExpression="AppendLine [GridColumn_AppendLine] Group By AppendLine ASC" UniqueName="AppendLine">
                                                        <ItemTemplate>
                                                            <img src='Images/Global/<%# CStr(IIf(Eval("AppendLine"), "checked.png", "unchecked.png")) %>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkAppendLine" Checked='<%# CBool(IIf(Eval("AppendLine") Is System.DBNull.Value, 0, Eval("AppendLine")))%>'
                                                                runat="server" class="mobile-switch" />
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="90px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridTemplateColumn HeaderText="Adjustment Type" DataField="AdjustmentType" SortExpression="AdjustmentType" HeaderStyle-Width="100px" GroupByExpression="AdjustmentType [GridColumn_AdjustmentType] Group By AdjustmentType ASC" UniqueName="AdjustmentType">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("AdjustmentType") = String.Empty, "&nbsp;", Container.DataItem("AdjustmentType"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlAdjustmentType" CausesValidation="False" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                                runat="server" Skin="Default" Width="100%">
                                                            </telerik:RadComboBox>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Inactive" DataField="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC" UniqueName="Inactive">
                                                        <ItemTemplate>
                                                            <img src='Images/Global/<%# CStr(IIf(Eval("Inactive"), "checked.png", "unchecked.png")) %>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkInactive" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>'
                                                                runat="server" class="mobile-switch" />
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="90px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                                                        GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%" MaxLength="200"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <HeaderStyle Width="200px"></HeaderStyle>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="Code"></telerik:GridSortExpression>
                                                </SortExpressions>
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">

                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                                            SecurityButtonType="ItemMode_Edit"
                                                            CommandName="EditRows" Visible='<%# rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" CssClass="GridCmdUpdateEdited"
                                                            SecurityButtonType="AddEditMode_Edit"
                                                            CommandName="UpdateEdited" Visible='<%# rdgAdjustments.EditIndexes.Count > 0 %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true"
                                                            SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                                            CommandName="PerformInsert" Visible='<%# rdgAdjustments.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                                            SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                            CommandName="CancelAll" Visible='<%# rdgAdjustments.EditIndexes.Count > 0 Or rdgAdjustments.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                                            CommandName="InitNewRow" Visible='<%# rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label Text="Add line" runat="server" ID="lblAdd"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                                            SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                                            Visible='<%# rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>'
                                                            runat="server" CommandName="DeleteRows">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                            Visible='<%# rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>&nbsp;&nbsp;   
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
                                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowRowsDragDrop="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
<%--                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>--%>

</asp:Content>
