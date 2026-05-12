<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentScoring.ascx.vb" Inherits="Website.DocumentScoring" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<%@ Register Src="ScoringAnswer.ascx" TagName="ScoringAnswer" TagPrefix="uc1" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgScoring">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12" style="margin-bottom:24px;">
            <telerik:RadGrid ID="rdgScoring" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Width="100%"
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                PageSize="25" AllowPaging="true" ShowFooter="true" ShowGroupPanel="true" AllowMultiRowEdit="True"
                AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                    EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="80px" ItemStyle-Wrap="false" Visible="false" HeaderText="Include in Bid" UniqueName="IncludeInBid" DataField="IncludeInBid"
                            SortExpression="IncludeInBid" GroupByExpression="IncludeInBid [GridColumn_IncludeInBid] Group By IncludeInBid ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IncludeInBid")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbIncludeInBid" Checked='<%# CBool(IIf(Eval("IncludeInBid") Is System.DBNull.Value, 0, Eval("IncludeInBid")))%>' runat="server" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" Groupable="false" Reorderable="true" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("LineNumber").ToString%>
                            </EditItemTemplate>

                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Group" SortExpression="Group" UniqueName="Group" DataField="Group"
                            GroupByExpression="Group [GridColumn_Group] Group By Group ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlGroup" runat="server" Width="100%" AllowCustomText="True">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Question ID" SortExpression="QuestionID" UniqueName="QuestionID"
                            GroupByExpression="QuestionID [GridColumn_QuestionID] Group By QuestionID" DataField="QuestionID">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("QuestionID") = String.Empty, "&nbsp;", Container.DataItem("QuestionID"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuestionID" runat="server" Text='<%#Eval("QuestionID")%>' Width="100%" MaxLength="50"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Question" SortExpression="Question" UniqueName="Question" DataField="Question"
                            GroupByExpression="Question [GridColumn_Question] Group By Question">
                            <ItemTemplate>
                                <span style="white-space: break-spaces;"><%# Eval("Question") %></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuestion" runat="server" Text='<%#Eval("Question")%>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Answer" SortExpression="Answer" UniqueName="Answer" DataField="Answer"
                            GroupByExpression="Answer [GridColumn_Answer] Group By Answer" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <uc1:ScoringAnswer ID="ScoringAnswer" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:ScoringAnswer ID="EditScoringAnswer" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Score" SortExpression="Score" UniqueName="Score" DataField="Score"
                            GroupByExpression="Score [GridColumn_Score] Group By Score">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Score"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtScore" runat="server" MaxLength="15"
                                    Text='<%#FormatNumber(IIf(Eval("Score") Is System.DBNull.Value, "0", Eval("Score"))) %>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblSumScore" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="95px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Points Available" SortExpression="PointsAvailable" UniqueName="PointsAvailable"
                            GroupByExpression="PointsAvailable [GridColumn_PointsAvailable] Group By PointsAvailable" DataField="PointsAvailable">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("PointsAvailable"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPointsAvailable" runat="server" MaxLength="15"
                                    Text='<%#FormatNumber(IIf(Eval("PointsAvailable") Is System.DBNull.Value, "1", Eval("PointsAvailable"))) %>'  ReadOnly="True"
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblSumPointsAvailable" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Weight" UniqueName="Weight" DataField="Weight" SortExpression="Weight" GroupByExpression="Weight [GridColumn_Weight] Group By Weight ASC">
                            <ItemTemplate>
                                <span><%#FormatPercent(Container.DataItem("Weight"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWeight" CssClass="Percent" runat="server" Width="100%" MaxNumber="100" MinNumber="-100" MaxLength="15" ReadOnly="True"
                                    Text='<%#  FormatPercent(Eval("Weight")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblSumWeight" runat="server"></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Weighted Score" SortExpression="WeightedScore" UniqueName="WeightedScore" DataField="WeightedScore"
                            GroupByExpression="WeightedScore [GridColumn_WeightedScore] Group By WeightedScore">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("WeightedScore"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWeightedScore" runat="server" MaxLength="15"
                                    Text='<%#FormatNumber(IIf(Eval("WeightedScore") Is System.DBNull.Value, "0", Eval("WeightedScore"))) %>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblSumWeightedScore" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Use" SortExpression="Use" UniqueName="Use"
                            GroupByExpression="Use [GridColumn_Use] Group By Use ASC" DataField="Use">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Use")), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbUse" runat="server" Checked='<%# CBool(IIf(Eval("Use") Is System.DBNull.Value, 0, Eval("Use")))%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="40px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>'
                                    Width="80%" TextMode="MultiLine" Height="14px"></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                    CssClass="SearchButton">
                               <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>

                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" Visible='<%# rdgScoring.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" Visible='<%# rdgScoring.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" Visible='<%# rdgScoring.EditIndexes.Count > 0 Or rdgScoring.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddScoring" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="AddScoring" CssClass="GridCmdAddScoring"
                                OnClientClick="return OpenSelectScoringPopup();"
                                Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddScoring">
                                <span class="Icon"></span>
                                <asp:Label ID="Label10" runat="server" meta:resourcekey="lblAddClausesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
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
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>

        </div>
    </div>
</div>


