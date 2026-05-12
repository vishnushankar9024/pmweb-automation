<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorksheetCostcodePopup.aspx.vb" Title ="Journal Entries" Inherits="Website.WorksheetCostcodePopup" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <script src="JS/Costs/forecast.js" type="text/javascript"></script>
    <script type="text/javascript">
        function ClearText(CntrlId) {
            document.getElementById(CntrlId).innerText = '';
        }

        function AdjustCostCalculation(gridId) {
            var grid = $("#" + gridId);

            // On change quantity
            $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                var me = $(this);
                var tr = me.parents("tr:first");
                tr.find("input[id$='txtTotalAmount']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtUnitCost']").val()))
                );
            });

            // On change unit cost
            $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
                var me = $(this);
                var tr = me.parents("tr:first");
                tr.find("input[id$='txtTotalAmount']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
            });

            // On change total amount
            $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function () {
                var me = $(this);
                var tr = me.parents("tr:first");
                var unitCost = CDbl(tr.find("input[id$='txtUnitCost']").val());
                var calculatedUnitCost = CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val());
                if (unitCost != calculatedUnitCost) {
                    tr.find("input[id$='txtUnitCost']").val(
                CCur(CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
                }
            });

        }

        function BindJSHandlers() {
            $("input[id$=ckbUseUnits]").changeCheckbox(function (e) {
                chkUserUnits_OnChekedChanged(e, this);
            });
        }

        function chkUserUnits_OnChekedChanged(event, checkbox) {
            $("input[id$=btnUseUnits]").click();
        }
    </script>
    <style type="text/css">
            body
            {
                background: white none !important;
                 font-family: Arial, Helvetica, sans-serif;
                font-size: 10px; 
                color: #000000;
            }
 </style>
   
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
      <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center" Skin="Default" />
    <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgJournalEntryDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgJournalEntryDetails" />
                  
                </UpdatedControls>
            </telerik:AjaxSetting>
           
            </AjaxSettings>
    </telerik:RadAjaxManager>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr id="trTbsDetails" runat="server">
                    <td>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div class="PMHeader">
                                        <div class="">
                                         <div class="col-4">
                                                <table class="colTable" border="0">
     <%--   <fieldset style="width:600px;height:100px; "><legend><asp:Label ID="lblPeriodicSpreading" runat="server" meta:resourcekey="lblPeriodicSpreading" Text="Periodic Spreading"></asp:Label></legend>--%>
       
            <tr>
                <td class="labelWidth">
                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>

                </td>
                <td class="controlWidth">
                     <asp:TextBox ID="txtProject" ReadOnly ="true" runat="server" Text="" Width="250px"></asp:TextBox>

                </td>
                      
            </tr> 
            <tr>
                <td class="labelWidth"><asp:Label ID="lblCostCode" runat="server" meta:resourcekey="lblCostCode" Text="Cost Code">

                                       </asp:Label>

                </td>
                <td class="controlWidth">
                     <asp:TextBox ID="txtCostCode" ReadOnly ="true" runat="server" Text="" Width="250px"></asp:TextBox>
                    </asp:TextBox>

                </td>
                
            </tr>
     
            <tr>
                <td colspan="6"><asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label></td>
            </tr>
        </table>
                                             </div>
         <%--</fieldset>--%>
   
    <div style="margin-bottom:8px">
        <asp:Label ID="lblMsgSpread" runat="server" meta:resourcekey="lblMsgSpread"></asp:Label>
     <telerik:RadGrid ID="rdgJournalEntryDetails" runat="server"   
            AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" 
            PageSize="25" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" setwidth="true" 
            AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <GroupPanel Text="Group by"></GroupPanel>
        <HeaderContextMenu   EnableViewState="false"></HeaderContextMenu>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
            EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter ="true"  GroupLoadMode ="Client">
             <Columns> 
          <%--      <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <span><%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString.PadLeft(3, "0"c))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                         
                    </EditItemTemplate>
                    
                    <HeaderStyle Width="50px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
               --%>
              
             
                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description"
                    GroupByExpression="Description [GridColumn_Description] Group By Description">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%#Eval("Description")%>' Width="100%" MaxLength="500" ></asp:TextBox>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
               </telerik:GridTemplateColumn>
               
                <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM"
                     GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("UOMId") = 0, "&nbsp;", Container.DataItem("UOM"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>   
                         <asp:DropDownList ID="ddlUOMs" runat="server" Width="100%">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity"
                    GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField ="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                       <span> <%#FormatNumber(Container.DataItem("Quantity"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" MaxLength="15"  
                            Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'
                            Width="100%" CssClass="Double"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalQuantity" runat="server"></asp:Label>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="95px"></HeaderStyle>
               </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost" UniqueName="UnitCost"
                    GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost" DataField ="UnitCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUnitCost" runat="server" MaxLength="15"  
                            Text='<%#FormatCurrency(Eval("UnitCost"))%>' 
                            Width="100%" CssClass="Currency"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalUnitCost" runat="server"></asp:Label>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Total Amount" SortExpression="TotalAmount" UniqueName="TotalAmount"
                    GroupByExpression="TotalAmount [GridColumn_TotalAmount] Group By TotalAmount" DataField ="TotalAmount" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("TotalAmount"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTotalAmount" runat="server" MaxLength="15"  
                            Text='<%#FormatCurrency(Eval("TotalAmount"))%>' 
                            Width="100%" CssClass="Currency"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalTotalAmount" runat="server"></asp:Label>
                    </FooterTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle Width="100px"></HeaderStyle>
               </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status"
                             UniqueName="Status" GroupByExpression="Status [GridColumn_Status] Group By Status">
                             <ItemTemplate>
                                <%# IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:DropDownList runat="server" ID="ddlCostLedgerStatuses" Width="100%" />
                             </EditItemTemplate>
                             <HeaderStyle Width="100px"></HeaderStyle>
                         </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Worksheet Column*" SortExpression="WorksheetColumn" UniqueName="WorksheetColumn"
                     GroupByExpression="WorksheetColumn [GridColumn_WorksheetColumn] Group By WorksheetColumn ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("WorksheetColumnId") = 0, "&nbsp;", Container.DataItem("WorksheetColumn"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                         <asp:DropDownList ID="ddlWorksheetColumns" runat="server" Width="100%">
                        </asp:DropDownList>
                        <div>
                            <asp:CompareValidator ID="cmpWorksheetColumns" runat="server" ControlToValidate="ddlWorksheetColumns" 
                                ValueToCompare ="0" CssClass="Validator" ErrorMessage="Select the Worksheet column" 
                                Display="Dynamic" ForeColor="" Operator="GreaterThan" meta:resourcekey="cmpWorksheetColumns" ValidationGroup="Save" ></asp:CompareValidator>                              
                        </div>
                    </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
               </telerik:GridTemplateColumn>
               
                <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period"
                     GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                    </ItemTemplate>
                    <EditItemTemplate> 
                        <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="100px" 
                            EnableItemCaching="false"  OnItemsRequested="ddl_ItemsRequested"
                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                            NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
               </telerik:GridTemplateColumn>
                 
                <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                    GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                       <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" 
                       OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                     <span class="Icon"></span>
                    </asp:LinkButton>
                         </EditItemTemplate>
                     <HeaderStyle Width="200px"></HeaderStyle>
               </telerik:GridTemplateColumn> 
             
                    <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
            <FooterStyle CssClass="GridFooter" />
         
            <CommandItemTemplate> 
                <div style="padding:2px">
                    
             <%--       <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                        SecurityButtonType="ItemMode_Edit"
                        CommandName="EditRows" Visible='<%# rdgJournalEntryDetails.EditIndexes.Count = 0 AND (Not rdgJournalEntryDetails.MasterTableView.IsItemInserted) %>'>
                        <img style="border:0px;vertical-align:middle;" src="Images/Global/EditLine.png" alt="Edit"/> 
                      <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>--%>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"  CssClass="GridCmdUpdateEdited" 
                        SecurityButtonType="AddEditMode_Edit"
                        CommandName="UpdateEdited" Visible='<%# rdgJournalEntryDetails.EditIndexes.Count > 0 %>'>
                        <span class="Icon"></span>
                       <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"  CssClass="GridCmdPerformInsert" 
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert" Visible='<%# rdgJournalEntryDetails.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"  CssClass="GridCmdCancelAll" 
                        SecurityButtonType="AddEditMode"
                        CommandName="CancelAll" Visible='<%# rdgJournalEntryDetails.EditIndexes.Count > 0 Or rdgJournalEntryDetails.MasterTableView.IsItemInserted %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                                   
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"  CssClass="GridCmdInitNewRow" 
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" Visible='<%# rdgJournalEntryDetails.EditIndexes.Count = 0 AND (Not rdgJournalEntryDetails.MasterTableView.IsItemInserted) %>'>
                       <span class="Icon"></span>
                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
               
                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                        Visible='<%# rdgJournalEntryDetails.EditIndexes.Count = 0 AND (Not rdgJournalEntryDetails.MasterTableView.IsItemInserted) %>'
                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                        <span class="Icon"></span>
                      <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>                        
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"  CssClass="GridCmdRebindGrid" 
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" Visible='<%# rdgJournalEntryDetails.EditIndexes.Count = 0 AND (Not rdgJournalEntryDetails.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
        
                    
              
                </div>
            </CommandItemTemplate>
            
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
            AllowDragToGroup="true">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                    <Selecting AllowRowSelect ="true" />
           </ClientSettings>
        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
    </telerik:RadGrid>    
        
    </div>
    </div>
                                       </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
            </table>
        
    </form>
</body>
</html>
