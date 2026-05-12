<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ScoringAnswer.ascx.vb" Inherits="Website.ScoringAnswer" %>
     <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="width:100%">
      <span>
        <asp:Label runat="server"  Width="100%" Style="text-align: right" ID="lblNumberData" Visible="false"></asp:Label>
    </span>
    <span>
        <asp:Label runat="server" ID="lblTextData" Visible="false"></asp:Label>
    </span>

    <asp:TextBox ID="txtData" Visible="false"  Width="100%" runat="server"></asp:TextBox>

         <telerik:RadDatePicker ID="dtpDatepicker"   runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" 
             Width="100%" Skin="Default" EnableTyping="true">
             <DateInput ID="DateInput2"  runat="server"></DateInput>
        </telerik:RadDatePicker>

        <telerik:RadTimePicker ID="dtpTimePicker" runat="server" Skin="Default" Width="100%"></telerik:RadTimePicker>

   <telerik:RadDateTimePicker runat="server"  ID="dtpDatetimePicker" MinDate="1901-01-01" MaxDate="2100-01-01"   
       Skin="Default"  DateInput-DateFormat="MMM-dd-yyyy hh:mm:ss tt" Width="100%">
   </telerik:RadDateTimePicker>

    <asp:TextBox ID="txtMemo" runat="server" visible="false" Width="85%" TextMode="MultiLine" Height="14px"></asp:TextBox>
    <asp:LinkButton runat="server" ID="imgMemo" visible="false" 
          CssClass="SearchButton">
      <span class="Icon"></span>
    </asp:LinkButton>

    <telerik:RadComboBox ID="ddlSingleDataSelect" runat="server" AutoPostBack="False" Skin="Default" Visible="false" 
        DropDownWidth="250px" EmptyMessage="Select..."  AllowCustomText="true"
        NoWrap="true" Width="100%" Height="320px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
        EnableVirtualScrolling="True" OnItemsRequested="ItemsLoadRequested">
    </telerik:RadComboBox>

    <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="45%"></telerik:RadComboBox>

    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" DropDownWidth="250px" Width="45%" Height="320px" >
    </telerik:RadComboBox>

   

    <telerik:RadComboBox ID="ddlMultiDataSelect" runat="server" Width="90%" DropDownWidth="405px" 
                             Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                            NoWrap="True" AllowCustomText="true" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="MultiSelectItemsRequested" OnClientItemsRequesting="GetMultiSelectValueToReturn"
                            Style="font-size: 11px" Height="250px" >
                            <ItemTemplate> 
                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                <table style="width: 395px" cellspacing="0" cellpadding="2">
                                    <tr>
                                    <td style="width: 10px;"> 
                                    <asp:checkbox runat="server" id="chk"></asp:checkbox>
                                           </td> 
                                        <td style="width: 250px;">
                                            <%#DataBinder.Eval(Container, "Text")%>
                                        </td>
                                    </tr>
                                </table></div>
                            </ItemTemplate>
                        </telerik:RadComboBox> 

    <asp:RadioButtonList ID="rbldata" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="RadioCss RadioPadding">
    </asp:RadioButtonList>
    <asp:Repeater runat="server" ID="chkData">
        <ItemTemplate>
            <asp:CheckBox runat="server" ID="chkoption"/>
            <asp:Label runat="server" ID="lblOption" style="white-space:normal !important"></asp:Label>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Repeater runat="server" ID="hplAttachments">
        <ItemTemplate>
             <asp:HyperLink ID="hplAttachment" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: pointer; white-space:normal !important" 
                 Text="" ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>&nbsp;
              </ItemTemplate>
    </asp:Repeater>
     <asp:LinkButton  id ="imgUploadFiles" style="cursor :pointer;float:right"  runat ="server"   
         CssClass="EmptyDetails">
    <span class="Icon"></span>
    </asp:LinkButton>

     <asp:HiddenField runat="server" ID="hddnMultiIds" />
     <asp:HiddenField runat="server" ID="hddnMultiNames" />
</div>
