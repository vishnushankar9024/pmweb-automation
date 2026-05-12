<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinkFundingPopup.aspx.vb" Inherits="Website.LinkFundingPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<script language="javascript" type="text/javascript">
    
    function CheckTotal(chk) {

        var check = chk.id;
        var balance = CDbl($("#" + check).parents("tr:first").find("input[id$='hdnBalance']").val());
        var amountTxt = $("#" + check).parents("tr:first").find("input[id$='txtAmount']")
        var total=CDbl($("input[id$=txtTotalAuthorized]").val())

        if (chk.checked) {
            $("input[id$=txtTotalAuthorized]").val(CCur(total + balance))
            amountTxt.val(CCur(balance))
        }
        else {
            $("input[id$=txtTotalAuthorized]").val(CCur(total - CDbl(amountTxt.val())))
            amountTxt.val(CCur(0))
        }

    }

    var OldAmountVal = 0;
    function AdjustCostCalculation(gridId) {
        var grid = $("#" + gridId);

        $("input[id*=" + gridId + "][id$=txtAmount]").change(function() {
            var me = $(this);
            var row = me.parents("tr:first");
            var checked = row.find("input[type='checkbox']").is(':checked');
            var balance = row.find("input[id$='hdnBalance']").val();
            
            if (CDbl(me.val()) > CDbl(balance)){
                me.val(balance);
                }
                else if(CDbl(me.val()) < 0){
                me.val(CCur(0.0));
                }
                
            if (checked) {
                
                var total = CDbl($("input[id$=txtTotalAuthorized]").val());

                var NewAmountVal = CDbl(me.val());
                total = total + NewAmountVal - OldAmountVal;
                $("input[id$=txtTotalAuthorized]").val(CCur(total));
            }
        }
    ).focus(function() {
        OldAmountVal = CDbl($(this).val());

    }
   );
    }
</script>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center" Skin="Default" />
    <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
        DefaultLoadingPanelID="ldpPM">
        <ajaxsettings>
            <telerik:AjaxSetting AjaxControlID="rdgFundingLines">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFundingLines" LoadingPanelID="ldpPM" />
                     <telerik:AjaxUpdatedControl ControlID="txtTotalAuthorized" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </ajaxsettings>
    </telerik:RadAjaxManager>

    <table cellpadding="0" cellspacing="0" width="99%">
            <tr>
                <td width="70%">
                    <table style="vertical-align: top; margin: 5px;" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblTotalAuthorized" runat="server" meta:resourcekey="lblTotalAuthorized" Text="Total Authorized"></asp:Label>
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:TextBox ID="txtTotalAuthorized"  CssClass ="Double" runat="server" Text="" Width="80px"></asp:TextBox>
                            </td> 
                           
                        </tr>
                       
                        </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                
                     <telerik:RadGrid Id="rdgFundingLines" AllowMultiRowSelection="false" runat="server" 
                         ShowGroupPanel="true"   HeaderStyle-Font-Size="8"  
                         AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                         PageSize="250">
                        <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                              <telerik:GridTemplateColumn HeaderText="Use" UniqueName="Use"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked='<%# Container.DataItem("Use") %>' onclick="CheckTotal(this);"
                                              />
                                    </ItemTemplate>
                            
                            <HeaderStyle HorizontalAlign="Center" Width="40px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    
                                <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount"
                                Groupable="false" Reorderable="false">
                                  <ItemTemplate>
                                   <asp:HiddenField runat = "server" ID="hdnBalance" Value ='<%# FormatCurrency(Container.DataItem("Balance")) %>' />
                                     <asp:TextBox ID="txtAmount" runat="server" Width ="100%"  MaxLength="15" Text='<%# FormatCurrency(Container.DataItem("Amount")) %>'
                                       CssClass="Currency"></asp:TextBox>
                                      
                                     </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Funding #" UniqueName="FundingNumber" SortExpression="FundingNumber"
                                GroupByExpression="FundingNumber [GridColumn_FundingNumber] Group By FundingNumber ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("FundingNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("FundingNumber"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                               <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" 
                                HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <%#Container.DataItem("LineNumber").ToString%>
                                </ItemTemplate>
                                <HeaderStyle Width="50px" />
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                             
                            
                            <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" SortExpression="Year"
                                GroupByExpression="Year [GridColumn_Year] Group By Year ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Year").ToString = "0", "&nbsp;", Container.DataItem("Year"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" SortExpression="Project"
                                GroupByExpression="Project [GridColumn_Project] Group By Project ASC">
                                <ItemTemplate>
                                     <%#IIf(Container.DataItem("Project") = String.Empty, PM.LanguagesInfo.GlobalResource("Portfolio"), Container.DataItem("Project"))%> 
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                                <ItemStyle />
                            </telerik:GridTemplateColumn>
                            
                              <telerik:GridTemplateColumn HeaderText="Source" SortExpression="FundingSourceText"
                                UniqueName="FundingSource" GroupByExpression="FundingSourceText [GridColumn_FundingSource] Group By FundingSourceText ASC">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("FundingSourceText") = String.Empty, "&nbsp;", Container.DataItem("FundingSourceText"))%>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle  />
                            </telerik:GridTemplateColumn>
                            
                             <telerik:GridTemplateColumn HeaderText="Code" SortExpression="Code"
                                UniqueName="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle/>
                            </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Funded" UniqueName="Funded"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("Funded"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Authorized" UniqueName="Authorized"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("Authorized"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Balance" UniqueName="Balance"
                                Groupable="false" Reorderable="false">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Eval("Balance"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"/>
                            </telerik:GridTemplateColumn>
                            
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo" 
                                        Visible='<%# rdgFundingLines.EditIndexes.Count = 0 AND (Not rdgFundingLines.MasterTableView.IsItemInserted) %>' 
                                        >
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                         </MasterTableView>
                         <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                         <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">
                             <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                             <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                 AllowColumnResize="True" />
                         </ClientSettings>
                     </telerik:RadGrid>
                            
      </td>
            </tr>
             <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right" style ="padding-right :15px">
                <table width="750px" class="NormalWhiteBack">
                    <tr>
                        <td colspan="2" align="right">
                            <asp:LinkButton ID="lbtSave" CausesValidation ="true" ValidationGroup ="Save" runat="server" Text="<%$ Resources:PMWeb, Save %>"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Cancel %>"></asp:LinkButton>&nbsp;&nbsp;
                        </td>
                    </tr>
                 </table>
                </td>
            </tr>
        </table>
    
    </form>
</body>
</html>
