<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BidRFIs.ascx.vb" Inherits="Website.BidRFIs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgBidRFIs">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgBidRFIs" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12" style="margin-bottom:24px;">
            <telerik:RadGrid ID="rdgBidRFIs" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Width="100%"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="true" AllowMultiRowEdit="True" 
                AllowMultiRowSelection="true" ItemStyle-Height="20px" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                    EditMode="InPlace">
                    <Columns>
                       
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
                        <telerik:GridTemplateColumn HeaderText="Question Attachments" SortExpression="QuestionAttachments"
                            UniqueName="QuestionAttachments" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="QuestionAttachments"
                            GroupByExpression="QuestionAttachments [GridColumn_QuestionAttachments] Group By QuestionAttachments">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnQuestionAttachments"> 
                              <span> (<%#Container.DataItem("QuestionAttachments")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("QuestionAttachments") Is DBNull.Value, "", "(" + Eval("QuestionAttachments").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Question*" SortExpression="Question" UniqueName="Question" DataField="Question"
                            GroupByExpression="Question [GridColumn_Question] Group By Question" >
                            <ItemTemplate>
                                <span style="white-space:pre-wrap;"><%# Eval("Question") %></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Rows="4" Text='<%#Eval("Question")%>' Width="80%" style="height: 160px;overflow:auto;resize:none;"></asp:TextBox>
                                 <asp:LinkButton runat="server" ID="imgMemo" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtQuestion'))" CssClass="SearchButton">
                                                                               <span class="Icon"></span>
                                 </asp:LinkButton>
                                 <br />
                                <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Question Required."
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Reply Attachments" SortExpression="ReplyAttachments"
                            UniqueName="ReplyAttachments" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ReplyAttachments"
                            GroupByExpression="ReplyAttachments [GridColumn_ReplyAttachments] Group By ReplyAttachments">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnReplyAttachments"> 
                              <span> (<%#Container.DataItem("ReplyAttachments")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("ReplyAttachments") Is DBNull.Value, "", "(" + Eval("ReplyAttachments").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Reply" SortExpression="Reply"  UniqueName="Reply" DataField="Reply"
                            GroupByExpression="Reply [GridColumn_Reply] Group By Reply">
                            <ItemTemplate>
                                <span><%# Eval("Reply") %></span>&nbsp;
                            </ItemTemplate>
                         
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
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
                                CommandName="EditRows" Visible='<%# rdgBidRFIs.EditIndexes.Count = 0 And (Not rdgBidRFIs.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" Visible='<%# rdgBidRFIs.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" Visible='<%# rdgBidRFIs.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" Visible='<%# rdgBidRFIs.EditIndexes.Count > 0 Or rdgBidRFIs.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" Visible='<%# rdgBidRFIs.EditIndexes.Count = 0 And (Not rdgBidRFIs.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                          
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgBidRFIs.EditIndexes.Count = 0 And (Not rdgBidRFIs.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" Visible='<%# rdgBidRFIs.EditIndexes.Count = 0 And (Not rdgBidRFIs.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>       
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>
                <ClientSettings  ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                     <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                     <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>

        </div>
    </div>
</div>
