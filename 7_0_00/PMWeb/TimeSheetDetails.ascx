<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TimeSheetDetails.ascx.vb" Inherits="Website.TimeSheetDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgTimeSheetDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgTimeSheetDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
 <%-- <script runat="server"> 
          Private Sub rdgTimeSheetDetails_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdgTimeSheetDetails.PreRender
            rdgTimeSheetDetails.ClientSettings.ClientEvents.OnRowDblClick = ""
         End Sub
    </script>--%>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
<script type="text/javascript">

    function GetValueToReturn(combobox, eventArgs) {
    if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
        eventArgs.set_cancel(true);
    } else {
        eventArgs.set_cancel(false);
    }
     var SelectedValue;
     if ((combobox.get_id().indexOf('ddlResourcePayTypes') > 0) || (combobox.get_id().indexOf('ddlResourceClasses') > 0)) {
         var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResources');
         SelectedValue = ddlResources.get_value();
         
     } else {
         var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
         SelectedValue = ddlProjects.get_value();
     }
     var context = eventArgs.get_context();
     context["FilterString"] = SelectedValue;
 }

 function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
     if (AutoFill == 'True') {
     var item = eventArgs.get_item();
     var itemId = item.get_parent()._clientStateFieldID;

     var descriptions = item.get_text().split("-");
     var description = descriptions[descriptions.length - 1];
     $("#" + itemId).parents("tr:first").find("input[id$='txtDescription']").val(description.replace(/\s/g, ''));
     
     }
 }

  function ResetCombos(combobox, eventArgs) {
      var item = eventArgs.get_item();
      if (combobox.get_id().indexOf('ddlResources') > 0) {
          var ddlResourcePayTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResourcePayTypes');
          ddlResourcePayTypes.clearItems();
          ddlResourcePayTypes.set_text(item.get_attributes().getAttribute("ResourcePayType"));
          ddlResourcePayTypes.set_value(item.get_attributes().getAttribute("PayTypeId"));

          var ddlResourceClasses = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResourceClasses');
          ddlResourceClasses.clearItems();
          ddlResourceClasses.set_text(item.get_attributes().getAttribute("ResourceClassification"));
          ddlResourceClasses.set_value(item.get_attributes().getAttribute("ClassificationId"));
          
      } else {

      var ddlCostCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCostCodes');
      ddlCostCodes.clearItems();
      ddlCostCodes.set_text("");
      ddlCostCodes.set_value("0");

      var ddlTasks = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlTasks');
      ddlTasks.clearItems();
      ddlTasks.set_text("");
      ddlTasks.set_value("0");

      var ddlFundingCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlFundingCodes');
      ddlFundingCodes.clearItems();
      ddlFundingCodes.set_text("");
      ddlFundingCodes.set_value("0");

      var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
      ddlPeriods.clearItems();
      ddlPeriods.set_text("");
      ddlPeriods.set_value("0");
      
      }
  
  }
  
</script>
</telerik:RadCodeBlock>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgTimeSheetDetails" runat="server"  CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                              AutoGenerateColumns="False" ShowStatusBar="false" UseEditFormInMobile="true" HasPasteFromExcel="true" HasCostCodePoup="true"
                            Font-Size="8px" PageSize="20" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True"
                            AllowSorting="True" AllowMultiRowSelection="true" AllowMultiRowEdit="true" >
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" ShowGroupFooter="true" EnableHeaderContextMenu="true">
                                <Columns>
                    
                                    <telerik:GridTemplateColumn HeaderText="Resource" SortExpression="Resource" UniqueName="Resource" DataField="Resource"
                                        GroupByExpression="Resource [GridColumn_Resource] Group By Resource ASC">
                                        <ItemTemplate>
                                                 <%#IIf(Container.DataItem("Resource") = "", "&nbsp;", Container.DataItem("Resource"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlResources" runat="server" Width="100%" Filter="Contains" DropDownWidth="250px" ValidationGroup="SaveDetail"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage=""
                                               NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                
                                            <asp:RequiredFieldValidator runat="server" meta:resourcekey="cmpddlResource"  ID="cmpddlResource" ControlToValidate="ddlResources" Display="Dynamic" CssClass="Validator"  ValidationGroup="SaveDetail"
                                            ErrorMessage="Select resource"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                         <HeaderStyle Width="150px"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Project" SortExpression="ProjectFullName" DataField ="ProjectFullName" UniqueName="Project" 
                                        GroupByExpression="ProjectFullName [GridColumn_Project] Group By ProjectFullName ASC">
                                        <ItemTemplate>
                                                 <%#IIf(Container.DataItem("ProjectFullName") = "", "&nbsp;", Container.DataItem("ProjectFullName"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlProjects" AutoPostBack ="true"  runat="server" Width="100%" Filter="Contains" DropDownWidth="250px" meta:resourcekey="ddlProjects"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Project..."
                                                NoWrap="True" AllowCustomText="true"  OnClientSelectedIndexChanged="ResetCombos" OnSelectedIndexChanged ="ddlProjects_SelectedIndexChanged" 
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                         <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                                        UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                                        GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal"> 
                                        <ItemTemplate> 
                                             <asp:LinkButton runat="server" ID="btnAttachments"  > 
                                          <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                                <span> <%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                                         </EditItemTemplate>
                                        <HeaderStyle Width="75px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                     <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                                        GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                            </asp:HyperLink>
                                            <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"  DropDownWidth="300px"
                                                 Skin="Default" CloseDropDownOnBlur="true" OnClientSelectedIndexChanged="ddlCostCodes_OnClientSelectedIndexChanged"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"  OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="250px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description" DataField="Description"
                                        SortExpression="Description">
                                        <ItemTemplate>
                                            <div><%#CStr(IIF(Eval("Description") = String.Empty,"&nbsp;",Eval("Description")))%></div>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server"  MaxLength="500"  Width="100%" ID="txtDescription" Text='<%#Eval("Description")%>'   />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle> 
                                          <ItemStyle Wrap ="false" />    
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Task" SortExpression="Task" UniqueName="Task" DataField="Task"
                                        GroupByExpression="Task [GridColumn_Task] Group By Task ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Task") = "", "&nbsp;", Container.DataItem("Task"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains" DropDownWidth="465px"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"  OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                                 <HeaderTemplate>
                                                    <table style="width: 435px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 275px;">
                                                                Task</td>
                                                            <td style="width: 80px;">
                                                                Start</td>
                                                            <td style="width: 80px;">
                                                                Finish</td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 435px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 275px;">
                                                                <%# DataBinder.Eval(Container, "Text")%>
                                                            </td>
                                                            <td style="width: 80px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['EarlyStartDate']")%>
                                                            </td>
                                                            <td style="width: 80px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['EarlyFinishDate']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                        </ItemTemplate>

                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                        
                                    <%--<telerik:GridBoundColumn Aggregate="SUM" DataField="W" visible="False"/>--%>
                        
                                     <telerik:GridTemplateColumn HeaderText="Su" SortExpression="Su" UniqueName="Su" Groupable="False" DataField="Su" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("Su"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSu" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("Su"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="M" SortExpression="M" UniqueName="M" Groupable="False" DataField="M" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("M"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtM" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("M"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                         <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                <telerik:GridTemplateColumn HeaderText="T" SortExpression="T" UniqueName="T" Groupable="False" DataField="T" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                           <%#FormatNumber(Container.DataItem("T"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtT" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("T"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                     <telerik:GridTemplateColumn HeaderText="W" SortExpression="W" UniqueName="W" Groupable="False" DataField="W" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("W"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtW" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("W"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                       <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                             <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                  <telerik:GridTemplateColumn HeaderText="Th" SortExpression="Th" UniqueName="Th" Groupable="False" DataField="Th" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                           <%#FormatNumber(Container.DataItem("Th"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTh" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("Th"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                       <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                     <telerik:GridTemplateColumn HeaderText="F" SortExpression="F" UniqueName="F" Groupable="False" DataField="F" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("F"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtF" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("F"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                     <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                      <telerik:GridTemplateColumn HeaderText="Sa" SortExpression="Sa" UniqueName="Sa" Groupable="False" DataField="Sa" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("Sa"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSa" runat="server" Text='<%# FormatNumber(ParseDouble(Eval("Sa"))) %>' CssClass="Double"
                                                Width="100%" MaxLength="15"></asp:TextBox>
                                        </EditItemTemplate>
                                   <HeaderStyle Width="45px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Ttl" UniqueName="Total" Groupable="False" DataField="TotalHours" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                             <%#FormatNumber(Container.DataItem("TotalHours"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>&nbsp;
                                        </EditItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                         <FooterStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                        
                                     <telerik:GridTemplateColumn HeaderText="%C" SortExpression="PctComplete" UniqueName="PctComplete"  Aggregate="Custom" FooterAggregateFormatString="{0:F6}"
                                     GroupByExpression="PctComplete [%C] Group By PctComplete ASC">
                                        <ItemTemplate>
                                            <%#FormatPercent(Container.DataItem("PctComplete"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtPctComplete" runat="server" Text='<%# FormatPercent(ParseDouble(Eval("PctComplete"))) %>' CssClass="Percent"
                                                Width="100%" MaxLength="15" maxnumber="100" minnumber="0"></asp:TextBox>
                                        </EditItemTemplate>
                                       <HeaderStyle Width="60px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FooterStyle HorizontalAlign="Right" Wrap="false"/>
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Class" SortExpression="ResourceClass" UniqueName="ResourceClass" DataField="ResourceClass"
                                        GroupByExpression="ResourceClass [GridColumn_ResourceClass] Group By ResourceClass ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("ResourceClass") = "", "&nbsp;", Container.DataItem("ResourceClass"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                             <telerik:RadComboBox ID="ddlResourceClasses" runat="server" Width="100%" Filter="Contains" DropDownWidth="200px"  meta:resourcekey="ddlResourceClasses"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="180px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Pay Type" SortExpression="ResourcePayType" UniqueName="ResourcePayType" DataField="ResourcePayType"
                                        GroupByExpression="ResourcePayType [GridColumn_ResourcePayType] Group By ResourcePayType ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("ResourcePayType") = "", "&nbsp;", Container.DataItem("ResourcePayType"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                             <telerik:RadComboBox ID="ddlResourcePayTypes" runat="server" Width="100%" Filter="Contains" DropDownWidth="150px" meta:resourcekey="ddlResourcePayTypes"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..."
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>'
                                                TextMode="MultiLine" Height="14px"  Width="80%" MaxLength="4000"></asp:TextBox>
                                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" >
                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn HeaderText="Req. Code" DataField ="ReqCodeName" SortExpression="ReqCodeName" UniqueName="ReqCode"
                                GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                         <telerik:RadComboBox ID="ddlReqCodes" Runat="server"  AllowCustomText="false"
                                            Skin="Default" CloseDropDownOnBlur="true" Width="100%" DropDownWidth="310px" AutoPostBack="false" NoWrap="true"
                                            height="260px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="" /> 
                                            </Items>
                                            <ItemTemplate>
                                                    <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server" Width="285px"
                                                        Height="240px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvReqNodeClicking"
                                                        OnNodeDataBound="rdvReqCode_NodeDataBound" OnNodeExpand="rdvReqCode_NodeExpand" >
                                                    </telerik:RadTreeView> 
                                            </ItemTemplate>                   
                                        </telerik:RadComboBox>
                                </EditItemTemplate>
                                 <HeaderStyle Width="200px"></HeaderStyle>
                           </telerik:GridTemplateColumn> 
                                    <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" DataField="Period"
                                        GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Period") = "", "&nbsp;", Container.DataItem("Period"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" Filter="Contains" DropDownWidth="100px"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"  OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Funding Code" SortExpression="FundingCode" UniqueName="FundingCode" DataField="FundingCode"
                                        GroupByExpression="FundingCode [GridColumn_FundingCode] Group By FundingCode ASC">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("FundingCode") = "", "&nbsp;", Container.DataItem("FundingCode"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlFundingCodes" runat="server" Width="100%" Filter="Contains" DropDownWidth="250px"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true"  EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"  OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                        <ItemStyle Wrap="false" />
                                    </telerik:GridTemplateColumn>
                        
                                    <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                           Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                           Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                             Groupable="false" >
                            <ItemTemplate>
                              <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>        
                        
                                </Columns>
                                   <FooterStyle CssClass="GridFooter" />
                                <ItemStyle Wrap="false" />
                                <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                                  <CommandItemTemplate>
                                    <div style="padding: 2px">
                           
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                            SecurityButtonType="ItemMode_Edit"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 And (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnEditSelectedResource1">
                                           <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" ValidationGroup="SaveDetail" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited"
                                            SecurityButtonType="AddEditMode_Edit"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" ValidationGroup="SaveDetail" CommandName="PerformInsert"  CssClass="GridCmdPerformInsert"
                                            SecurityButtonType="AddEditMode_Add"
                                            Visible='<%# rdgTimeSheetDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"  CssClass="GridCmdCancelAll"
                                            SecurityButtonType="AddEditMode"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count > 0 Or rdgTimeSheetDetails.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow"  CssClass="GridCmdInitNewRow"
                                            SecurityButtonType="ItemMode_Add"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 AND (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                           <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAddResource" runat="server"  CausesValidation="False" CommandName="TimeSheetAddResources"  CssClass="GridCmdTimeSheetAddResources"
                                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=TimeSheet',900,540,true)"
                                                Visible='<%# (rdgTimeSheetDetails.EditIndexes.Count = 0 And (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted)) And PM.Scheduling.TimeSheetInfo.ResourceId = 0%>'
                                                meta:resourcekey="btnAddResource1">
                                                 <span class="Icon"></span>
                                                <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAddTasks" runat="server" CausesValidation="False" CommandName="AddTasks"  CssClass="GridCmdAddTasks"
                                            SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectTasksPopup.aspx',1200,700,true)"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 AND (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddTasks" runat="server" Text="Task(s)" meta:resourcekey="lblAddTasks"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>                                              
                                        <asp:LinkButton ID="btnAddCostCodes" CommandName="AddCostCodes" runat="server" CausesValidation="False"  CssClass="GridCmdAddCostCodes"
                                          Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 And (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted)%>'
                                          SecurityButtonType="ItemMode_Add" OnClientClick="return OpenCostCodesPOPUp('TIMESHEET', 1000, 600);">
                                          <span class="Icon"></span>
                                          <asp:Label ID="lblAddCostCodes" meta:resourcekey="lblAddCostCodes" runat="server"></asp:Label>
                                          &nbsp;&nbsp;
                                     </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"  CssClass="GridCmdDeleteRows"
                                            SecurityButtonType="ItemMode_Delete" Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 AND (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                           <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid"
                                            SecurityButtonType="ItemMode"
                                            Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 AND (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                &nbsp;&nbsp
                                        </asp:LinkButton>
                                          <asp:LinkButton ID="btnExportExcel" runat="server"  
                                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel" 
                                                Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 And (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted)%>'>
                                              <span class="Icon"></span>  
                                              <asp:Label ID="Label8" text="Export To Exel" runat="server"></asp:Label>
                                                &nbsp;&nbsp
                                            </asp:LinkButton>
                                        <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"  CssClass="GridCmdPasteClipBoard"
                                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" ValidationGroup="SaveDetail"
                                                Visible='<%# rdgTimeSheetDetails.EditIndexes.Count = 0 AND (Not rdgTimeSheetDetails.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp
                                            </asp:LinkButton> 
                                        <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                            CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                            EnableShadows="true" CausesValidation="false"
                                            Visible="true">
                                        </telerik:RadMenu>
                                      <asp:Button runat="server" ID="btnEditRowsFromCostCodesPopup" CommandName="EditRowsFromCostCodesPopup" CausesValidation="false"
                                        CssClass="Hide" />
                                      </div>
                                </CommandItemTemplate>
                                  </MasterTableView>
                               <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                                  <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                            </ClientSettings>
                
                        </telerik:RadGrid>
        </div>
    </div>
</div>



<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />