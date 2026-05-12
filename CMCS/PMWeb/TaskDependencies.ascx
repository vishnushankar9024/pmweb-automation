<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TaskDependencies.ascx.vb" Inherits="Website.TaskDependencies" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style>
    @media screen and (min-width: 901px) {
        .col-6 {
            max-width: 45% !important;
        }
    }

    .row {
        min-width: 100% !important;
    }

    @media screen and (max-width:900px) {
        .rmpView.row {
            min-width: 100% !important;
        }

        .col-6 {
            width: 100% !important;
        }
    }

    @media screen and (max-width: 1251px) and (min-width: 880px) {
        .row {
            padding-right: 0px !important;
        }
    }
</style>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPredecessors">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPredecessors" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgSuccessors">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSuccessors" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMMainPage">
    <div class="row">
        <div class="col-12">

            <fieldset>
                <legend>
                    <asp:Label ID="lblPredecessors" runat="server" meta:resourcekey="lblPredecessors" Text="Predecessors"></asp:Label></legend>
                            <telerik:RadGrid ID="rdgPredecessors" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" Width="200" UseEditFormInMobile="true"
                                PageSize="250" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" CssClass="ResponsiveMargin"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"
                                ItemStyle-Height="20px">
                                <PagerStyle Mode="NextPrevAndNumeric" />
                                <GroupPanel Text="Group by"></GroupPanel>
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                                    EditMode="InPlace" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectFullName" ItemStyle-Wrap="false" HeaderText="Project"
                                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectName] Group By ProjectFullName ASC">
                                            <ItemTemplate>
                                                <span><%# IIf(CStr(Eval("ProjectFullName")) = String.Empty, "&nbsp;", Eval("ProjectFullName"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="False" CausesValidation="False"
                                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                                    NoWrap="true" Skin="Default" Width="100%" DropDownWidth="250px" ShowMoreResultsBox="True" OnClientSelectedIndexChanged="ResetCombos" OnClientBlur="ComboBlur"
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                </telerik:RadComboBox>
                                                <%--                                <br />
                                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                                    CssClass="Validator" InitialValue="" ErrorMessage="Project Required."
                                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Schedule" UniqueName="Schedule" SortExpression="Schedule"
                                            GroupByExpression="Schedule [GridColumn_Schedule] Group By Schedule ASC" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Eval("Schedule").ToString = "", "&nbsp;", Eval("Schedule").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlSchedules" runat="server" Width="100%"
                                                    CloseDropDownOnBlur="true" EmptyMessage="Select Schedule..." AutoPostBack="False" CausesValidation="False"
                                                    NoWrap="True" AllowCustomText="true" OnClientItemsRequesting="GetValueToReturnFromCombobox" OnClientSelectedIndexChanged="ResetCombos" OnClientBlur="ComboBlur"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested"
                                                    Style="font-size: 11px" Height="250px">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task" Groupable="false" SortExpression="predecessorID" UniqueName="predecessorID">
                                            <ItemTemplate>
                                                <span><%# IIf(Eval("Task").ToString = "", "&nbsp;", Eval("Task").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="410px"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturnFromCombobox"
                                                    Style="font-size: 11px" Height="200px">
                                                    <HeaderTemplate>
                                                        <table style="width: 400px" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 240px;">
                                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                                <td style="width: 80px;">
                                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                                <td style="width: 80px;">
                                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 400px" cellspacing="0" cellpadding="2">
                                                            <tr>
                                                                <td style="width: 240px;">
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
                                            <HeaderStyle Width="250px"></HeaderStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Depend. Type" Groupable="false" SortExpression="Type" UniqueName="Type">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTaskDepType"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlDependTypes" runat="server" Width="100%">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_fs %>' Value="fs"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_ff %>' Value="ff"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_sf %>' Value="sf"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_ss %>' Value="ss"></telerik:RadComboBoxItem>
                                                    </Items>
                                                    
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="130px"></HeaderStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Lag" Groupable="false" SortExpression="Lag" UniqueName="Lag">
                                            <ItemTemplate>
                                                <%#CStr(Val(Container.DataItem("Lag")))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtLag" runat="server" Width="100%"
                                                    MaxLength="9" CssClass="Integer"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="75px"></HeaderStyle>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <%--                                  <telerik:GridTemplateColumn HeaderText="Float" Groupable="false" SortExpression="Float" UniqueName="Float">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Float")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFloat" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>   --%>
                                    </Columns>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="PredecessorId"></telerik:GridSortExpression>
                                    </SortExpressions>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                       <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                           SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows">
                                           <span class="Icon"></span>
                                           <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                       </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                                SecurityButtonType="AddEditMode_Add"
                                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgPredecessors.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                                SecurityButtonType="AddEditMode"
                                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgPredecessors.EditIndexes.Count > 0 Or rdgPredecessors.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancelAll" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false"
                                                SecurityButtonType="ItemMode_Add"
                                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgPredecessors.EditIndexes.Count = 0 And (Not rdgPredecessors.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAdd" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgPredecessors.EditIndexes.Count = 0 And (Not rdgPredecessors.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                                runat="server" CommandName="DeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDelete" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>

                                        </div>
                                    </CommandItemTemplate>

                                </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="true" />
                                    <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" />
                            </telerik:RadGrid>

            </fieldset>




        </div>
        <div class="col-12" style="padding-top: 24px;">

            <fieldset>
                <legend>
                    <asp:Label ID="lblSuccessors" runat="server" meta:resourcekey="lblSuccessors" Text="Successors"></asp:Label></legend>  
                            <telerik:RadGrid ID="rdgSuccessors" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" Width="200" UseEditFormInMobile="true"
                                PageSize="250" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" CssClass="ResponsiveMargin"
                                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"
                                ItemStyle-Height="20px">
                                <PagerStyle Mode="NextPrevAndNumeric" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top" EditMode="InPlace"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="ProjectFullName" ItemStyle-Wrap="false" HeaderText="Project"
                                            SortExpression="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectName] Group By ProjectFullName ASC">
                                            <ItemTemplate>
                                                <span><%# IIf(CStr(Eval("ProjectFullName")) = String.Empty, "&nbsp;", Eval("ProjectFullName"))%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="False" CausesValidation="False"
                                                    CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:resourcekey="ddlProjects"
                                                    NoWrap="true" Skin="Default" Width="100%" ShowMoreResultsBox="True" OnClientSelectedIndexChanged="ResetCombos" OnClientBlur="ComboBlur"
                                                    EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                </telerik:RadComboBox>
                                                <%--                                <br />
                                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                                    CssClass="Validator" InitialValue="" ErrorMessage="Project Required."
                                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Schedule" UniqueName="Schedule" SortExpression="Schedule"
                                            GroupByExpression="Schedule [GridColumn_Schedule] Group By Schedule ASC" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Eval("Schedule").ToString = "", "&nbsp;", Eval("Schedule").ToString)%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlSchedules" runat="server" Width="100%"
                                                    CloseDropDownOnBlur="true" EmptyMessage="Select Schedule..." AutoPostBack="False" CausesValidation="False"
                                                    NoWrap="True" AllowCustomText="true" OnClientItemsRequesting="GetValueToReturnFromCombobox" OnClientSelectedIndexChanged="ResetCombos" OnClientBlur="ComboBlur"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested"
                                                    Style="font-size: 11px" Height="250px">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task" Groupable="false" SortExpression="SuccessorID" UniqueName="SuccessorID">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("Task").ToString%></span>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%"
                                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="410px"
                                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturnFromCombobox"
                                                    Style="font-size: 11px" Height="200px">
                                                    <HeaderTemplate>
                                                        <table style="width: 400px" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 240px;">
                                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                                <td style="width: 80px;">
                                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                                <td style="width: 80px;">
                                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 400px" cellspacing="0" cellpadding="2">
                                                            <tr>
                                                                <td style="width: 240px;">
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
                                            <HeaderStyle Width="250px"></HeaderStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Depend. Type" Groupable="false" SortExpression="Type" UniqueName="Type">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTaskDepType"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlDependTypes" runat="server" Width="100%">
                                                    <Items>
                                                            <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_fs %>' Value="fs"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_ff %>' Value="ff"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_sf %>' Value="sf"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text='<%$Resources:DependTypes_ss %>' Value="ss"></telerik:RadComboBoxItem>
                                                    </Items>
                                                
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="130px"></HeaderStyle>
                                            <ItemStyle Wrap="false" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Lag" Groupable="false" SortExpression="Lag" UniqueName="Lag">
                                            <ItemTemplate>
                                                <%#CStr(Val(Container.DataItem("Lag")))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtLag" runat="server" Width="100%"
                                                    MaxLength="9" CssClass="Integer"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="75px"></HeaderStyle>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <%--                                  <telerik:GridTemplateColumn HeaderText="Float" Groupable="false" SortExpression="Float" UniqueName="Float">
                                        <ItemTemplate>
                                            <%#CStr(Val(Container.DataItem("Float")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFloat" runat="server" Width="100%"
                                               MaxLength="9" CssClass="Integer"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="10%"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>   --%>
                                    </Columns>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                         <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                             SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows">
                                             <span class="Icon"></span>
                                             <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                         </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton5" runat="server" ValidationGroup="Save"
                                                SecurityButtonType="AddEditMode_Add"
                                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgSuccessors.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label7" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="false"
                                                SecurityButtonType="AddEditMode"
                                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSuccessors.EditIndexes.Count > 0 Or rdgSuccessors.MasterTableView.IsItemInserted %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label8" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="false"
                                                SecurityButtonType="ItemMode_Add"
                                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgSuccessors.EditIndexes.Count = 0 And (Not rdgSuccessors.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label9" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton8" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgSuccessors.EditIndexes.Count = 0 And (Not rdgSuccessors.MasterTableView.IsItemInserted) %>'
                                                SecurityButtonType="ItemMode_Delete"
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="Label10" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>

                                        </div>
                                    </CommandItemTemplate>

                                </MasterTableView>
                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                    AllowDragToGroup="false">
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                        AllowColumnResize="true" />
                                    <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                            </telerik:RadGrid>

            </fieldset>



        </div>
    </div>
</div>
