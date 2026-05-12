<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentTeamSettings.ascx.vb" Inherits="Website.TeamInputSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <ajaxsettings>
            <telerik:AjaxSetting AjaxControlID="rdgTeamInput">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgTeamInput" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </ajaxsettings>
    </telerik:RadAjaxManagerProxy>
<div style="padding-top:42px">
<telerik:RadGrid ID="rdgDocumentTeam" runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" SetWidth="true"
                AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowPaging="true" PageSize="10" FitPageHeightOffset="1"
                AllowMultiRowEdit="True"  AllowFilteringByColumn="true" ShowGroupPanel="true" AllowMultiRowSelection="true" 
                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile ="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"  />
                
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage"  AllowSorting="true" EditMode="InPlace">
                                
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Record Type"  Groupable="false" DataField="RecordType" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="RecordType" UniqueName="RecordType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("RecordType")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="180px" />
                        </telerik:GridTemplateColumn>
                                            
                        <telerik:GridTemplateColumn HeaderText="Module" GroupByExpression="Module [GridColumn_Module] Group By Module ASC" DataField="Module" AutoPostBackOnFilter="true" DataType="System.String" SortExpression="Module" UniqueName="Module">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Module") = String.Empty, "&nbsp;", Container.DataItem("Module"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("Module")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="180px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Show Collaborate" DataField="ShowCollaborate"  AutoPostBackOnFilter="true" DataType="System.Boolean" UniqueName="ShowCollaborate"   HeaderStyle-Width="120px"  ItemStyle-Wrap="false" 
                                                    SortExpression="ShowCollaborate" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" GroupByExpression="ShowCollaborate [GridColumn_ShowCollaborate] Group By ShowCollaborate ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ShowCollaborate")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbShowDocumentTeam" Checked='<%# CBool(IIf(Eval("ShowCollaborate") Is System.DBNull.Value, 0, Eval("ShowCollaborate")))%>' runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>   
                    </Columns>       
                
                    <CommandItemTemplate>
                        <div style="padding:2px">
                                   
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" Visible='<%# rdgDocumentTeam.EditIndexes.Count = 0 And (Not rdgDocumentTeam.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span> 
                                <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>                        
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true"  CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" Visible='<%# rdgDocumentTeam.EditIndexes.Count > 0%>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" Visible='<%# rdgDocumentTeam.EditIndexes.Count > 0 Or rdgDocumentTeam.MasterTableView.IsItemInserted%>'>
                                <span class="Icon"></span>
                                <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                                     
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>

                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"  AllowColumnResize="True"></Resizing>
                </ClientSettings>
                <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="UpdateEdited" />
</telerik:RadGrid>
    </div>