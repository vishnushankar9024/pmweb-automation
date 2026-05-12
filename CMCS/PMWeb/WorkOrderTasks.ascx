<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderTasks.ascx.vb" Inherits="Website.WorkOrderTasks" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamLabors" runat="server">
    <ajaxsettings>
        <telerik:AjaxSetting AjaxControlID="rdgWorkOrderTasks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgWorkOrderTasks" LoadingPanelID="ldpPM" />
                
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </ajaxsettings>
</telerik:RadAjaxManagerProxy>
<table>
<tr>
<td class="NoWrap">
 <asp:Label ID="lblSubmittedBy" Width="100%" runat="server" meta:resourcekey="lblSubmittedBy" Text="Submitted By"></asp:Label>
</td>
<td>
    <telerik:RadComboBox ID="ddlResources" runat="server" Height="200px" Skin="Default"
        Width="220px" DropDownWidth="250px" CloseDropDownOnBlur="true" meta:resourcekey="ddlResources"
        EmptyMessage="Select Resource..." NoWrap="False" AllowCustomText="true" EnableLoadOnDemand="True"
        ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
        <CollapseAnimation Duration="200" Type="OutQuint" />
    </telerik:RadComboBox>
</td>



</tr>
<tr>
<td class="NoWrap">
 <asp:Label ID="lblSubmittedDate" Width="100%" runat="server" meta:resourcekey="lblSubmittedDate" Text="Submitted Date"></asp:Label>
</td>
<td>
    <telerik:RadDatePicker ID="dtpSubmittedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
        Width="120px" Skin="Default" EnableTyping="True">
        <DateInput ID="DateInput5" Skin="Default" runat="server">
        </DateInput>
    </telerik:RadDatePicker>
</td>
</tr>
</table>
    <telerik:RadGrid ID="rdgWorkOrderTasks" runat="server" 
                  AutoGenerateColumns="False" ShowStatusBar="True"
                Font-Size="8px" PageSize="250" ShowFooter="false" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None"
                >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" Name="Master">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="TaskNumber" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TaskNumber" Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <span><%#Container.DataItem("TaskNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("TaskNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="Completed" UniqueName="Completed" HeaderStyle-Width="60px"
                ItemStyle-Wrap="false" SortExpression="Completed" GroupByExpression="Completed [GridColumn_Completed] Group By Completed ASC"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Completed"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbCompleted" Checked='<%# Cbool(IIF(Eval("Completed") is system.DBNULL.value, 0,Eval("Completed")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Task ID" UniqueName="TaskCode" SortExpression="TaskCode"
                            GroupByExpression="TaskCode [GridColumn_TaskCode] Group By TaskCode">
                            <ItemTemplate>
                               <span><%#IIf(Container.DataItem("TaskCode") = String.Empty, "&nbsp;", Container.DataItem("TaskCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTaskCode" MaxLength="15" Width="100%" runat="server" Text='<%#Eval("TaskCode")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="40px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                               <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTaskDescription" MaxLength="250" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="Task Type" UniqueName="TaskType" SortExpression="TaskType" GroupByExpression="TaskType [GridColumn_TaskType] Group By TaskType ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskType") = String.Empty, "&nbsp;", Container.DataItem("TaskType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTaskType" runat="server" Width="100%" >
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                          <telerik:GridTemplateColumn HeaderText="Skills" SortExpression="SkillName" UniqueName="SkillName"
                          GroupByExpression="SkillName [GridColumn_SkillName] Group By SkillName ASC">
                    <ItemTemplate>
                        <span> <%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlTaskSkills"  runat="server" Height="250px"
                            AllowCustomText="True" Width="100%" dropdownWidth="300px" Skin="Default">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApplySkills" 
                                      />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills" 
                                       ></asp:Label>
                                       <%#Eval("Skills")%>
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                 <HeaderStyle Width="180px"></HeaderStyle>
               </telerik:GridTemplateColumn>                                
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                            <ItemTemplate>
<%--                                <span><asp:Button ID="btnHtmlNotes" runat="server" CssClass="SmallButton" OnClientClick="return OpenHtmlNotesPopup(this);"/></span>--%>
                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTaskNotes" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="100%" MaxLength="200" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn> 
 <telerik:GridTemplateColumn HeaderText="Optional"  UniqueName="Optional"   HeaderStyle-Width="50px"  ItemStyle-Wrap="false"
SortExpression="Optional" GroupByExpression="Optional [GridColumn_Optional] Group By Optional ASC" 
ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
<ItemTemplate>
<img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Optional"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
</ItemTemplate>
<EditItemTemplate>
<asp:CheckBox ID="chkOptional" Checked='<%# Cbool(IIF(Eval("Optional") is system.DBNULL.value, 0,Eval("Optional")))%>' runat="server" />
</EditItemTemplate>
</telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />  
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp; 
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 AND (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgWorkOrderTasks.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgWorkOrderTasks.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgWorkOrderTasks.EditIndexes.Count > 0 Or rdgWorkOrderTasks.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 AND (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 AND (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 AND (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                 &nbsp;&nbsp;
                            </asp:LinkButton>
                                   <asp:Button ID="btnAddTasks" runat="server" CausesValidation="False" CommandName="AddTasks"
                    SecurityButtonType="ItemMode_Add" Text="Add Tasks" meta:resourcekey="btnAddTasks"
                    Visible='<%# rdgWorkOrderTasks.EditIndexes.Count = 0 AND (Not rdgWorkOrderTasks.MasterTableView.IsItemInserted) %>'
                    OnClientClick="return OpenTaskPopup(); " />
                            </span>
                            </div>
                        </CommandItemTemplate>
                        <DetailTables>
        <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="Top"  AllowPaging="True"
                DataKeyNames="Id,TaskId"  Width="100%" AllowSorting="true"  EditMode="InPlace" Name="Steps" PageSize="250">
                 <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="TaskId" MasterKeyField="Id" />
                </ParentTableRelation>
              <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                 <Columns>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepNumber %>" UniqueName="StepNumber" ItemStyle-HorizontalAlign="Right"
                            SortExpression="StepNumber" 
                            Groupable="false" Reorderable="False">
                            <ItemTemplate>
                                <span><%#Container.DataItem("StepNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("StepNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                   <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Completed %>" UniqueName="Completed" HeaderStyle-Width="60px"
                ItemStyle-Wrap="false" SortExpression="Completed" GroupByExpression="Completed [GridColumn_Completed] Group By Completed ASC"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" Groupable="false" Reorderable="False">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Completed"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chbStepCompleted" Checked='<%# Cbool(IIF(Eval("Completed") is system.DBNULL.value, 0,Eval("Completed")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepId %>" UniqueName="StepId" SortExpression="StepId"
                            GroupByExpression="StepId [GridColumn_StepId] Group By StepId" Groupable="false" Reorderable="False">
                            <ItemTemplate>
                               <span><%#IIf(Container.DataItem("StepId") = String.Empty, "&nbsp;", Container.DataItem("StepId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStepId" MaxLength="15" Width="100%" runat="server" Text='<%#Eval("StepId")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" Reorderable="False" Groupable="false">
                            <ItemTemplate>
                               <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="250" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_StepType %>" UniqueName="StepType" SortExpression="StepType" GroupByExpression="StepType [GridColumn_StepType] Group By StepType ASC" Reorderable="False" Groupable="false">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("StepType") = String.Empty, "&nbsp;", Container.DataItem("StepType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStepType" runat="server" Width="100%" >
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                          <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_SkillName %>" SortExpression="SkillName" UniqueName="SkillName"
                          GroupByExpression="SkillName [GridColumn_SkillName] Group By SkillName ASC" Reorderable="False" Groupable="false">
                    <ItemTemplate>
                        <span> <%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlSkills"  runat="server" Height="250px"
                            AllowCustomText="True" Width="100%" dropdownWidth="300px" Skin="Default">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApplySkills" 
                                      />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills" 
                                       ></asp:Label>
                                       <%#Eval("Skills")%>
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                 <HeaderStyle Width="180px"></HeaderStyle>
               </telerik:GridTemplateColumn>                                
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Notes %>" SortExpression="Notes" Reorderable="False" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" Groupable="false">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="100%" MaxLength="200" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="180px"></HeaderStyle>
                        </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Optional %>"  UniqueName="Optional"   HeaderStyle-Width="50px"  ItemStyle-Wrap="false"
SortExpression="Optional" GroupByExpression="Optional [GridColumn_Optional] Group By Optional ASC" 
ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" Groupable="false" Reorderable="False">
<ItemTemplate>
<img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Optional"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
</ItemTemplate>
<EditItemTemplate>
<asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("Optional") is system.DBNULL.value, 0,Eval("Optional")))%>' runat="server" />
</EditItemTemplate>
</telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                    Visible='<%# HideShow(container) %>' SecurityButtonType="ItemMode_Edit" meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="<%$ Resources:PMWeb, EditSelectedLines %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" Visible='<%# HideShowUpdate(container) %>' CssClass="GridCmdUpdateEdited"
                                    meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdate" runat="server" Text="<%$ Resources:PMWeb, UpdateEdited %>" ></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert"  SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                    Visible='<%# HideShowSave(container) %>' meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="<%$ Resources:PMWeb, PerformInsert %>" ></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    Visible='<%# NOT HideShow(container) %>' meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    Visible='<%# HideShow(container) %>'    SecurityButtonType="ItemMode_Add">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
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
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">                        
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>