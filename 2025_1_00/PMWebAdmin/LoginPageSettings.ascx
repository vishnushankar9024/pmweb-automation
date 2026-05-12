<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LoginPageSettings.ascx.vb" Inherits="Website.LoginPageSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLoginSettings">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLoginSettings" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<table>
    <tr>
        <td  rowspan="3" valign="top">
            <fieldset>
                <legend><asp:Label ID="lblLoginSettings" runat="server" Text="Login Page Settings"></asp:Label></legend>
                    <telerik:RadGrid ID="rdgLoginSettings" runat="server" EnableEmbeddedSkins="False" Skin="Default"  AutoGenerateColumns="False" ShowStatusBar="True"
                    ShowFooter="false" AllowPaging="true" ShowGroupPanel="false" AllowMultiRowEdit="True" AllowMultiRowSelection="True" 
                    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" Width="750px"  >
                    <HeaderContextMenu EnableEmbeddedSkins="False" EnableViewState="false"></HeaderContextMenu>
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top"   
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                        EnableHeaderContextMenu="true" Width="750px">
                <Columns>   
                         <telerik:GridTemplateColumn HeaderStyle-Width="70px"  ItemStyle-Wrap="false"  HeaderText="Display" UniqueName="Display" 
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="Display" >
                            <ItemTemplate> 
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Display"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               <asp:CheckBox ID="chbDisplay" Checked='<%# Cbool(IIF(Eval("Display") is system.DBNULL.value, 0,Eval("Display")))%>' runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn> 

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" UniqueName="Description" HeaderText="Description"  ItemStyle-Wrap="false"
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="Description" > 
                            <ItemTemplate> 
                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                            </ItemTemplate>
                            <%--<EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="50" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvDatabaseName" runat="server" ControlToValidate="txtDatabaseName"
                                        CssClass="Validator" ErrorMessage="Enter Database Name" 
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>--%>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="400px" HeaderText="Value"  ItemStyle-Wrap="false" UniqueName="Value" 
                                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="Value">
                            <ItemTemplate> 
                                <span><%#IIf(Container.DataItem("Value").ToString = String.Empty, "&nbsp;", Container.DataItem("Value").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtValue" runat="server" Text='<%# Eval("Value") %>' Width="100%" ></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="400px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px"  ItemStyle-Wrap="false"  HeaderText="New Tab" UniqueName="NewTab" 
                                                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="NewTab" >
                            <ItemTemplate> 
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("NewTab"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" class="Hide" />
                            </ItemTemplate>
                            <EditItemTemplate>
                               <asp:CheckBox ID="chbNewTab" Checked='<%# Cbool(IIF(Eval("NewTab") is system.DBNULL.value, 0,Eval("NewTab")))%>' runat="server" Visible="false"  />
                            </EditItemTemplate>
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn> 
                </Columns>
                <CommandItemTemplate>
                    <div style="padding:2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                    SecurityButtonType="ItemMode_Edit"
                                    CommandName="EditRows" 
                                    Visible='<%# rdgLoginSettings.EditIndexes.Count = 0 AND (Not rdgLoginSettings.MasterTableView.IsItemInserted)%>'>
                                    <img style="border:0px;vertical-align:middle;" src="Images/Global/EditLine.png" alt="Edit"/> 
                                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                                    Text="Edit" ></asp:Label>
                                &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                                    SecurityButtonType="AddEditMode_Edit"
                                    ValidationGroup="Save" CommandName="UpdateEdited"  
                                    Visible='<%# rdgLoginSettings.EditIndexes.Count > 0 %>'>
                                    <img style="border:0px;vertical-align:middle;" alt="Update" src="Images/Global/Save.png" />
                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" ></asp:Label>
                                &nbsp;&nbsp;
                                </asp:LinkButton>

                                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" 
                                    SecurityButtonType="AddEditMode_Add"
                                    CommandName="PerformInsert"  
                                    Visible='<%# rdgLoginSettings.MasterTableView.IsItemInserted %>'>
                                    <img style="border:0px;vertical-align:middle;" alt="Update" src="Images/Global/Save.png" />
                                    <asp:Label ID="lblSave" runat="server" Text="Save" ></asp:Label>
                                &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" 
                                    SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" 
                                    Visible='<%# rdgLoginSettings.EditIndexes.Count > 0 Or rdgLoginSettings.MasterTableView.IsItemInserted %>' >
                                    <img style="border:0px;vertical-align:middle;" alt="Cancel" src="Images/Global/cancel.png" />
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" ></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                           <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" 
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" 
                                Visible='<%# rdgLoginSettings.EditIndexes.Count = 0 AND (Not rdgLoginSettings.MasterTableView.IsItemInserted) %>'>
                                <img style="border:0px;vertical-align:middle;" alt="Refresh" src="Images/Global/Refresh.png" />
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" ></asp:Label>
                            </asp:LinkButton>
                        </div>
                </CommandItemTemplate>
            </MasterTableView>
            <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            </ClientSettings>
            <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
        </telerik:RadGrid>
           </fieldset>
       </td>
    </tr>
</table>