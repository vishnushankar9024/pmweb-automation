<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ScoringDetails.ascx.vb" Inherits="Website.ScoringDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 


<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgScoring">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpPM"/>
                 <telerik:AjaxUpdatedControl ControlID="txtHWeightedScore"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                   
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgScoring"  runat="server"    CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
            AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" UseEditFormInMobile ="true"
            PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="true"
            AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <GroupPanel Text="Group by"></GroupPanel>

        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
            EditMode="InPlace" EnableHeaderContextMenu="false">
             <Columns> 
                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" AllowFiltering="false" Groupable="false" Reorderable="true">
                    <ItemTemplate>
                        <span><%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                          <%#Eval("LineNumber").ToString%>
                    </EditItemTemplate>
                    
                    <HeaderStyle Width="50px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn> 
               
                <telerik:GridTemplateColumn HeaderText="Group" SortExpression="Group" UniqueName="Group"  DataField="Group"
                    GroupByExpression="Group [GridColumn_Group] Group By Group ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlGroup" AllowCustomText="true" runat="server" Skin="Default"
                            Style="font-size: 11px" Width="100%">
                        </telerik:RadComboBox>
                      </EditItemTemplate>
                     <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>
               
                    <telerik:GridTemplateColumn HeaderText="Question ID" SortExpression="QuestionID" UniqueName="QuestionID" DataField="QuestionID"
                    GroupByExpression="QuestionID [GridColumn_QuestionID] Group By QuestionID">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("QuestionID") = String.Empty, "&nbsp;", Container.DataItem("QuestionID"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuestionID" runat="server" Text='<%#Eval("QuestionID")%>' Width="100%" MaxLength="50"></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="90px"></HeaderStyle>
               </telerik:GridTemplateColumn>

               <telerik:GridTemplateColumn HeaderText="Abbreviation" SortExpression="Abbreviation" UniqueName="Abbreviation" DataField="Abbreviation"
                    GroupByExpression="Abbreviation [GridColumn_Abbreviation] Group By Abbreviation">
                    <ItemTemplate>
                        <span><%# Eval("Abbreviation")%></span>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAbbreviation" runat="server" Text='<%#Eval("Abbreviation")%>' Width="100%" ></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
                     <Itemstyle wrap="false" />
               </telerik:GridTemplateColumn>

             <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="Type" DataField="Type"
                    GroupByExpression="Type [GridColumn_Type] Group By Type">
                    <ItemTemplate>
                        <span><%# Eval("Type")%></span>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlTypes" AllowCustomText="false" runat="server" Skin="Default"
                            Style="font-size: 11px" Width="180px" CloseDropDownOnBlur="true" DropDownWidth="180px" DropDownCssClass="ddlTreeviewTemplate">
                             <Items>
                                <telerik:RadComboBoxItem Text="" />
                            </Items>
                            <ItemTemplate>
                                <telerik:RadTreeView ID="rtvTypes" Skin="Default" runat="server"
                                    Height="250px" MultipleSelect="false" ShowLineImages="false" OnNodeClick="rtvTypesNodeClicked" 
                                    OnNodeDataBound="rtvTypes_NodeDataBound" OnNodeExpand="rtvTypes_NodeExpand">
                                </telerik:RadTreeView>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
                     <Itemstyle wrap="false" />
               </telerik:GridTemplateColumn>

               
                <telerik:GridTemplateColumn HeaderText="Question" SortExpression="Question" UniqueName="Question" DataField="Question"
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

               <telerik:GridTemplateColumn HeaderText="Options" SortExpression="Options" UniqueName="Options" DataField="OptionsDisplay"
                    GroupByExpression="Options [GridColumn_Options] Group By Options">
                    <ItemTemplate>
                       <%-- <span><%# Eval("OptionsDisplay")%> </span>&nbsp;--%>
                        <asp:Label ID="lblOption" Text="" runat="server" ></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HiddenField runat="server" ID="hdnOptions" Value='<%#Eval("Options")%>'/>
                        <asp:TextBox ID="txtOptions" runat="server" Text='<%#Eval("OptionsDisplay")%>' Visible="false" ReadOnly="true" Width="90%"></asp:TextBox>
                       <%-- <asp:Button ID="btnOptions" CssClass="SmallSplitButton" Text="" runat="server"
                              Visible ="false"  />--%>
                         <asp:LinkButton ID ="btnOptions" cssClass="FilledDetails" runat="server"  Visible="false">
                            <span class="Icon"></span>
                         </asp:LinkButton>


                        <telerik:RadComboBox ID="ddlListOptions" runat="server" Visible="false" Width="100%"></telerik:RadComboBox>

                        <div>  
                            <asp:TextBox ID="txtValidation" runat="server" Text="validation" style="display:none;" ></asp:TextBox>
                              <asp:CustomValidator ID="csvOptions" runat="server" ControlToValidate="txtValidation"
                                       ClientValidationFunction="ValidateOption" Display="Dynamic" ValidationGroup="Save"
                                   CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" Enabled="false">
                                     </asp:CustomValidator>
                              
                        </div>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
                     <Itemstyle wrap="false" />
               </telerik:GridTemplateColumn>
                   
                <telerik:GridTemplateColumn HeaderText="Answer" SortExpression="Answer" UniqueName="Answer" DataField="Answer"
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
 
                <telerik:GridTemplateColumn HeaderText="Score" SortExpression="Score" UniqueName="Score" DataField="Score"
                    GroupByExpression="Score [GridColumn_Score] Group By Score">
                    <ItemTemplate>
                       <span> <%#FormatNumber(Container.DataItem("Score"))%></span>
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

                <telerik:GridTemplateColumn HeaderText="Points Available" SortExpression="PointsAvailable" UniqueName="PointsAvailable" DataField="PointsAvailable"
                    GroupByExpression="PointsAvailable [GridColumn_PointsAvailable] Group By PointsAvailable">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("PointsAvailable"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPointsAvailable" runat="server" MaxLength="15"  
                            Text='<%#FormatNumber(IIf(Eval("PointsAvailable") Is System.DBNull.Value, "1", Eval("PointsAvailable"))) %>'
                            Width="100%" CssClass="Double"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                                <asp:Label ID="lblSumPointsAvailable" runat="server"></asp:Label>
                            </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>

               <telerik:GridTemplateColumn HeaderText="Weight" UniqueName="Weight" SortExpression="Weight" DataField="Weight" GroupByExpression="Weight [GridColumn_Weight] Group By Weight ASC">
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
               
                <telerik:GridTemplateColumn HeaderText="Inactive" SortExpression="Inactive" UniqueName="Inactive"
                    GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC" DataField="Inactive">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Inactive")), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chbInactive" runat="server" Checked='<%# CBool(IIf(Eval("Inactive") Is System.DBNull.Value, 0, Eval("Inactive")))%>' />
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
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" 
                        SecurityButtonType="AddEditMode_Edit"
                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"  Visible='<%# rdgScoring.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" 
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgScoring.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgScoring.EditIndexes.Count > 0 Or rdgScoring.MasterTableView.IsItemInserted %>'>
                       <span class="Icon"></span>
                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                                   
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" 
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow"  Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span> 
                       <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                        Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'
                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" >
                        <span class="Icon"></span>
                       <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                        
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" 
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgScoring.EditIndexes.Count = 0 And (Not rdgScoring.MasterTableView.IsItemInserted) %>'>
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
 
