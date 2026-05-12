<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsScoring.ascx.vb" Inherits="Website.VendorApprovalsScoring" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgScoring">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgScoring"  runat="server" UseEditFormInMobile="true"
            AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
            PageSize="25" AllowPaging="true" ShowFooter="true" ShowGroupPanel="true"
            AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <GroupPanel Text="Group by"></GroupPanel>
        <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
            EditMode="InPlace" EnableHeaderContextMenu="false">
             <Columns> 
                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <span><%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                          <%#Eval("LineNumber").ToString%>
                    </EditItemTemplate>
                    
                    <HeaderStyle Width="50px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn> 
               
                <telerik:GridTemplateColumn HeaderText="Group" SortExpression="Group" UniqueName="Group" 
                    GroupByExpression="Group [GridColumn_Group] Group By Group ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlGroup" runat="server" Width="100%">
                        </asp:DropDownList>
                      </EditItemTemplate>
                     <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>
               
                    <telerik:GridTemplateColumn HeaderText="Question ID" SortExpression="QuestionID" UniqueName="QuestionID"
                    GroupByExpression="QuestionID [GridColumn_QuestionID] Group By QuestionID">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("QuestionID") = String.Empty, "&nbsp;", Container.DataItem("QuestionID"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuestionID" runat="server" Text='<%#Eval("QuestionID")%>' Width="100%" MaxLength="50"></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="90px"></HeaderStyle>
               </telerik:GridTemplateColumn>
               
                <telerik:GridTemplateColumn HeaderText="Question" SortExpression="Question" UniqueName="Question"
                    GroupByExpression="Question [GridColumn_Question] Group By Question">
                    <ItemTemplate>
                      <span><%# Eval("Question") %></span>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                           <asp:TextBox ID="txtQuestion" runat="server" Text='<%#Eval("Question")%>' Width="100%" ></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
                      <Itemstyle wrap="false" />
               </telerik:GridTemplateColumn>
               
                   
                <telerik:GridTemplateColumn HeaderText="Answer" SortExpression="Answer" UniqueName="Answer"
                    GroupByExpression="Answer [GridColumn_Answer] Group By Answer">
                   <ItemTemplate>
                        <span> <%# Eval("Answer") %></span>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                          <asp:TextBox ID="txtAnswer" runat="server" Text='<%#Eval("Answer")%>' Width="100%" ></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
                      <Itemstyle wrap="false" />
               </telerik:GridTemplateColumn>
 
                <telerik:GridTemplateColumn HeaderText="Score" SortExpression="Score" UniqueName="Score"
                    GroupByExpression="Score [GridColumn_Score] Group By Score">
                    <ItemTemplate>
                       <span> <%#FormatNumber(Container.DataItem("Score"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                      <asp:TextBox ID="txtScore" runat="server" MaxLength="15"  
                            Text='<%#FormatNumber(IIF(Eval("Score") is system.DBNULL.value, "0", Eval("Score"))) %>'
                            Width="100%" CssClass="Double"></asp:TextBox>
                    </EditItemTemplate>
                      <FooterTemplate>
                                <asp:Label ID="lblSumScore" runat="server"></asp:Label>
                            </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="95px"></HeaderStyle>
               </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Points Available" SortExpression="PointsAvailable" UniqueName="PointsAvailable"
                    GroupByExpression="PointsAvailable [GridColumn_PointsAvailable] Group By PointsAvailable">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("PointsAvailable"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPointsAvailable" runat="server" MaxLength="15"  
                            Text='<%#FormatNumber(IIF(Eval("PointsAvailable") is system.DBNULL.value, "1", Eval("PointsAvailable"))) %>'
                            Width="100%" CssClass="Double"></asp:TextBox>
                    </EditItemTemplate>
                         <FooterTemplate>
                                <asp:Label ID="lblSumPointsAvailable" runat="server"></asp:Label>
                            </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>

               <telerik:GridTemplateColumn HeaderText="Weight" UniqueName="Weight" SortExpression="Weight" GroupByExpression="Weight [GridColumn_Weight] Group By Weight ASC">
                <ItemTemplate>
                    <span><%#FormatPercent(Container.DataItem("Weight"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtWeight" CssClass="Percent" runat="server"  Width="100%" MaxNumber="100" MinNumber="-100" MaxLength="15"
                        Text='<%#  FormatPercent(Eval("Weight")) %>'></asp:TextBox>
                </EditItemTemplate>
                 <FooterTemplate>
                                <asp:Label ID="lblSumWeight" runat="server"></asp:Label>
                            </FooterTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            
          <telerik:GridTemplateColumn HeaderText="Weighted Score" SortExpression="WeightedScore" UniqueName="WeightedScore"
                    GroupByExpression="WeightedScore [GridColumn_WeightedScore] Group By WeightedScore">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("WeightedScore"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtWeightedScore" runat="server" MaxLength="15" Precision="2"  
                            Text='<%#FormatNumber(IIF(Eval("WeightedScore") is system.DBNULL.value, "0", Eval("WeightedScore"))) %>'
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
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Use")),"checked.png" , "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbUse" runat="server" Checked='<%# Cbool(IIF(Eval("Use") is system.DBNULL.value, 0,Eval("Use")))%>' class="mobile-switch"/>
                    </EditItemTemplate>
                     <HeaderStyle Width="40px"></HeaderStyle>
               </telerik:GridTemplateColumn>   
               
                      <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' 
                                Width="80%" TextMode="MultiLine" Height="14px"></asp:TextBox>
                               
                           <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>

                                 </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            
                       </telerik:GridTemplateColumn> 
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
            <FooterStyle CssClass="GridFooter" />
            <SortExpressions>
                <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
            </SortExpressions>
            <CommandItemTemplate> 
                <div style="padding:2px">
                    &nbsp;&nbsp; 
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows" 
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows" Visible='<%# rdgScoring.EditIndexes.Count = 0 AND (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"  CssClass="GridCmdUpdateEdited" 
                        SecurityButtonType="AddEditMode_Edit"
                        CommandName="UpdateEdited" Visible='<%# rdgScoring.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"  CssClass="GridCmdPerformInsert" 
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert" Visible='<%# rdgScoring.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"  CssClass="GridCmdCancelAll" 
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll" Visible='<%# rdgScoring.EditIndexes.Count > 0 Or rdgScoring.MasterTableView.IsItemInserted %>'>
                       <span class="Icon"></span>
                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                                   
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow" 
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" Visible='<%# rdgScoring.EditIndexes.Count = 0 AND (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                        Visible='<%# rdgScoring.EditIndexes.Count = 0 AND (Not rdgScoring.MasterTableView.IsItemInserted) %>'
                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                        <span class="Icon"></span>
                       <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                        
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"  CssClass="GridCmdRebindGrid" 
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" Visible='<%# rdgScoring.EditIndexes.Count = 0 AND (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False" 
                        CommandName="SaveState" Visible='true'>
                         <asp:Label ID="Label1" runat="server"></asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode" 
                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                    </asp:LinkButton>
                    </span>
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