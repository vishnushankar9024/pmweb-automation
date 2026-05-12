<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentRiskDetails.ascx.vb" Inherits="Website.DocumentRiskDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRiskDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRiskDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdcRisk" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgRiskDetails" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="true" CssClass="WithoutTopBorder" FilterType ="HeaderContext"
                HeaderStyle-Font-Size="8" AllowMultiRowEdit="True" UseEditFormInMobile ="true"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" ShowFooter="true" AllowPaging="true" PageSize="250">
                <GroupPanel Text="<%$Resources:PMWeb, Grid_GroupPanel %>"></GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%" ShowGroupFooter="true"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" ShowFooter="true"
                    Name="Master">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="40px" UniqueName="LineNumber" DataField="LineNumber"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="true" allowfiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("LineNumber").ToString%>
                            </EditItemTemplate>
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
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Risk" HeaderStyle-HorizontalAlign="Center" UniqueName="Risk"
                            HeaderStyle-Width="120px" SortExpression="Risk" GroupByExpression="Risk [GridColumn_Risk] Group By Risk ASC" DataField="Risk">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Risk").ToString = String.Empty, "&nbsp;", Container.DataItem("Risk").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRisk" MaxLength="200" runat="server" Text='<%# Eval("Risk") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" DataField="RiskType" HeaderStyle-Width="100px" GroupByExpression="RiskType [GridColumn_Type] Group By RiskType ASC" UniqueName="Type">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("RiskType") = String.Empty, "&nbsp;", Container.DataItem("RiskType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" runat="server" Skin="Default" CloseDropDownOnBlur="true"  Filter="Contains" MarkFirstMatch="true"
                                    Width="100%" NoWrap="true" CausesValidation="False" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Responsible" DataField="Responsible" HeaderStyle-Width="100px" GroupByExpression="Responsible [GridColumn_Responsible] Group By Responsible ASC" UniqueName="Responsible">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Responsible") = String.Empty, "&nbsp;", Container.DataItem("Responsible"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResponsible" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%" DropDownWidth="250px" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Probability" DataField="Probability" HeaderStyle-Width="70px" GroupByExpression="Probability [GridColumn_Probability] Group By Probability ASC" UniqueName="Probability">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Probability") = String.Empty, "&nbsp;", Container.DataItem("Probability"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProbability" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>                                        
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Impact" UniqueName="Impact" HeaderStyle-Width="100px" DataField="Impact" GroupByExpression="Impact [GridColumn_Impact] Group By Impact ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Impact") = String.Empty, "&nbsp;", Container.DataItem("Impact"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlImpact" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Probability Value" DataField="ProbabilityValue" UniqueName="ProbabilityValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" GroupByExpression="ProbabilityValue [GridColumn_ProbabilityValue] Group By ProbabilityValue ASC">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("ProbabilityValue"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtProbabilityValue" Text='<%#FormatNumber(Eval("ProbabilityValue"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Impact Value" UniqueName="ImpactValue" DataField="ImpactValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" GroupByExpression="ImpactValue [GridColumn_ImpactValue] Group By ImpactValue ASC">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("ImpactValue"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtImpactValue" Text='<%#FormatNumber(Eval("ImpactValue"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Cost" UniqueName="Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" GroupByExpression="Cost [GridColumn_Cost] Group By Cost ASC"
                            DataField="Cost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("Cost")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="Currency" MaxLength="15" runat="server" Width="100%" ID="txtCost" Text='<%#FormatCurrency(Eval("Cost"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Delay" UniqueName="Time" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DataField="Time" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            GroupByExpression="Time [GridColumn_Time] Group By Time ASC">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Time"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtTime" Text='<%#FormatNumber(Eval("Time"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Risk Impact" UniqueName="RiskValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="80px" DataField="RiskValue" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskValue [GridColumn_RiskValue] Group By RiskValue ASC">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("RiskValue"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtRiskValue" Text='<%#FormatNumber(Eval("RiskValue"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Risk Cost" UniqueName="RiskCost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="80px" DataField="RiskCost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskCost [GridColumn_RiskCost] Group By RiskCost ASC">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("RiskCost")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="Currency" MaxLength="15" runat="server" Width="100%" ID="txtRiskCost" Text='<%#FormatCurrency(Eval("RiskCost"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="Risk Delay" UniqueName="RiskDelay" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                            HeaderStyle-Width="50px" DataField="RiskDelay" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskDelay [GridColumn_RiskDelay] Group By RiskDelay ASC">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("RiskDelay"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtRiskDelay" Text='<%#FormatNumber(Eval("RiskDelay"))%>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" DataField="UOM" UniqueName="UOM" HeaderStyle-Width="80px" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUom" DropDownWidth="100px" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%" Height="250px" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Task"  DataField="TaskName" UniqueName="Task" HeaderStyle-Width="110px" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskName") = string.empty, "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px"
                                    Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    EnableItemCaching="true" EmptyMessage="Select Task..." NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="110px" DataField="Notes" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Action" HeaderStyle-Width="100px" DataField="Action" GroupByExpression="Action [GridColumn_Action] Group By Action ASC" UniqueName="Action">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Action") = String.Empty, "&nbsp;", Container.DataItem("Action"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAction" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Rating" DataField="Rating" HeaderStyle-Width="100px" GroupByExpression="Rating [GridColumn_Rating] Group By Rating ASC" UniqueName="Rating">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Rating") = String.Empty, "&nbsp;", Container.DataItem("Rating"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlRating" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                    runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Exposure" UniqueName="Notes2" HeaderStyle-HorizontalAlign="Center" DataField="Notes2"
                            HeaderStyle-Width="110px" SortExpression="Notes2" GroupByExpression="Notes2 [GridColumn_Notes2] Group By Notes2 ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes2").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes2").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes2" MaxLength="200" runat="server" Text='<%# Eval("Notes2") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Use" UniqueName="Use" HeaderStyle-Width="40px" DataField="IsUse"
                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="IsUse [GridColumn_Use] Group By IsUse ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsUse"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbIsUse" Checked='<%# Cbool(IIF(Eval("IsUse") is system.DBNULL.value, 1,Eval("IsUse")))%>' runat="server" />
                            </EditItemTemplate>
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
                        <telerik:GridBoundColumn Aggregate="SUM" DataField="RiskDelay" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditSelectedLines" CssClass="GridCmdEditSelectedLines"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgRiskDetails.EditIndexes.Count = 0 AND (Not rdgRiskDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" Visible='<%# rdgRiskDetails.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgRiskDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgRiskDetails.EditIndexes.Count > 0 Or rdgRiskDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgRiskDetails.EditIndexes.Count = 0 AND (Not rdgRiskDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="<%$ Resources: AddRisk %>"></asp:Label>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete"
                                Visible='<%# rdgRiskDetails.EditIndexes.Count = 0 AND (Not rdgRiskDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgRiskDetails.EditIndexes.Count = 0 AND (Not rdgRiskDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>


                        </div>
                    </CommandItemTemplate>
                    <DetailTables>
                        <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="Top" AllowSorting="false" AllowPaging="false"
                            DataKeyNames="Id,RiskDetailId" Width="100%" EditMode="InPlace" Name="Contingency">
                            <ParentTableRelation>
                                <telerik:GridRelationFields DetailKeyField="RiskDetailId" MasterKeyField="Id" />
                            </ParentTableRelation>
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LineNumber %>" HeaderStyle-Width="40px"
                                    HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("LineNumber").ToString%>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Contingency %>" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="120px" Reorderable="false" SortExpression="Risk" Groupable="false" GroupByExpression="Risk [Contingency] Group By Risk ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Risk").ToString = String.Empty, "&nbsp;", Container.DataItem("Risk").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtRisk" MaxLength="200" runat="server" Text='<%# Eval("Risk") %>'
                                            Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Type %>" Reorderable="false" Groupable="false" HeaderStyle-Width="100px" GroupByExpression="RiskType [Type] Group By RiskType ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("RiskType") = String.Empty, "&nbsp;", Container.DataItem("RiskType"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlType" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Width="100%" NoWrap="true" CausesValidation="False" AllowCustomText="true">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Responsible %>" Groupable="false" HeaderStyle-Width="100px" GroupByExpression="Responsible [Responsible] Group By Responsible ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Responsible") = String.Empty, "&nbsp;", Container.DataItem("Responsible"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlResponsible" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" Groupable="false" HeaderText="<%$Resources: GridColumn_Probability %>" HeaderStyle-Width="70px" GroupByExpression="Probability [GridColumn_Probability] Group By Probability ASC" UniqueName="Probability">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Probability") = String.Empty, "&nbsp;", Container.DataItem("Probability"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlProbability" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Impact %>" Groupable="false" HeaderStyle-Width="100px" GroupByExpression="Impact [Impact] Group By Impact ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Impact") = String.Empty, "&nbsp;", Container.DataItem("Impact"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlImpact" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_ProbabilityValue %>" UniqueName="ProbabilityValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="100px" Groupable="false" ItemStyle-HorizontalAlign="Right" GroupByExpression="ProbabilityValue [GridColumn_ProbabilityValue] Group By ProbabilityValue ASC">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("ProbabilityValue"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtProbabilityValue" Text='<%#FormatNumber(Eval("ProbabilityValue"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" Groupable="false" HeaderText="<%$Resources: GridColumn_ImpactValue %>" UniqueName="ImpactValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" GroupByExpression="ImpactValue [GridColumn_ImpactValue] Group By ImpactValue ASC">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("ImpactValue"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtImpactValue" Text='<%#FormatNumber(Eval("ImpactValue"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>




                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Cost %>" UniqueName="Cost" Groupable="false" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" GroupByExpression="Cost [Cost] Group By Cost ASC">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(ParseDouble(Eval("Cost")))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="Currency" MaxLength="15" runat="server" Width="100%" ID="txtCost" Text='<%#FormatCurrency(Eval("Cost"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Time %>" UniqueName="Time" Groupable="false" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" GroupByExpression="Time [Time] Group By Time ASC">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("Time"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtTime" Text='<%#FormatNumber(Eval("Time"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" Groupable="false" HeaderText="<%$Resources: GridColumn_RiskValue %>" UniqueName="RiskValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskValue [GridColumn_RiskValue] Group By RiskValue ASC">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("RiskValue"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtRiskValue" Text='<%#FormatNumber(Eval("RiskValue"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" Groupable="false" HeaderText="<%$Resources: GridColumn_RiskCost %>" UniqueName="RiskCost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskCost [GridColumn_RiskCost] Group By RiskCost ASC">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(ParseDouble(Container.DataItem("RiskCost")))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="Currency" MaxLength="15" runat="server" Width="100%" ID="txtRiskCost" Text='<%#FormatCurrency(Eval("RiskCost"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>



                                <telerik:GridTemplateColumn Reorderable="false" Groupable="false" HeaderText="<%$Resources: GridColumn_RiskDelay %>" UniqueName="RiskDelay" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                                    HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" GroupByExpression="RiskDelay [GridColumn_RiskDelay] Group By RiskDelay ASC">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("RiskDelay"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" Width="100%" ID="txtRiskDelay" Text='<%#FormatNumber(Eval("RiskDelay"))%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_UOM %>" Groupable="false" HeaderStyle-Width="80px" SortExpression="UOM" GroupByExpression="UOM [UOM] Group By UOM ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlUom" Height="250px" DropDownWidth="100px" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Task %>" Groupable="false" HeaderStyle-Width="110px" GroupByExpression="TaskName [Task] Group By TaskName ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("TaskName") = string.empty, "&nbsp;", Container.DataItem("TaskName"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Notes %>" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="110px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Action %>" HeaderStyle-Width="100px" GroupByExpression="Action [GridColumn_Action] Group By Action ASC" UniqueName="Action" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Action") = String.Empty, "&nbsp;", Container.DataItem("Action"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlAction" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Rating %>" HeaderStyle-Width="100px" GroupByExpression="Rating [GridColumn_Rating] Group By Rating ASC" UniqueName="Rating" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Rating") = String.Empty, "&nbsp;", Container.DataItem("Rating"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlRating" Filter="Contains" MarkFirstMatch="true" CausesValidation="False"
                                            runat="server" Skin="Default" Width="100%" AllowCustomText="true">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Notes2 %>" UniqueName="Notes2" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="110px" SortExpression="Notes2" GroupByExpression="Notes2 [GridColumn_Notes2] Group By Notes2 ASC" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Notes2").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes2").ToString)%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNotes2" MaxLength="200" runat="server" Text='<%# Eval("Notes2") %>' Width="100%"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Reorderable="false" HeaderText="<%$Resources: GridColumn_Use %>" HeaderStyle-Width="40px" Groupable="false" ItemStyle-Wrap="false"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="IsUse [Use] Group By IsUse ASC">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsUse"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbIsUse" Checked='<%# Cbool(IIF(Eval("IsUse") is system.DBNULL.value, 1,Eval("IsUse")))%>' runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Reorderable="false"  HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields  ID="PreviewUserDefinedFields1" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field2" Reorderable="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field3" Reorderable="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field4" Reorderable="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field5" Reorderable="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field6" Reorderable="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field7" Reorderable="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field8" Reorderable="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field9" Reorderable="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Field10" Reorderable="false"  GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                    Groupable="false">
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

                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditSelectedLines" CssClass="GridCmdEditSelectedLines"
                                        Visible='<%# HideShow(container) %>' SecurityButtonType="ItemMode_Edit" meta:resourcekey="btnEditSelectedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="<%$ Resources:PMWeb, EditSelectedLines %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# HideShowUpdate(container) %>' CssClass="GridCmdUpdateEdited"
                                        meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdate" runat="server" Text="<%$ Resources:PMWeb, UpdateEdited %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                        Visible='<%# HideShowSave(container) %>' meta:resourcekey="btnSaveResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="<%$ Resources:PMWeb, PerformInsert %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                        Visible='<%# NOT HideShow(container) %>' meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        Visible='<%# HideShow(container) %>' SecurityButtonType="ItemMode_Add">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server" Text="<%$ Resources: AddContingency %>"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                        Visible='<%# HideShow(container) %>' runat="server" CommandName="DeleteRows"
                                        meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </telerik:GridTableView>
                    </DetailTables>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>

                    <Scrolling UseStaticHeaders="true" />
                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
        </div>
    </div>
</div>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
