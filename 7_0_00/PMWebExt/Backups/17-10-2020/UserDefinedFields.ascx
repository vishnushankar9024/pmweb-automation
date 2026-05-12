<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UserDefinedFields.ascx.vb" Inherits="Website.UserDefinedFields" %>
     <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div style="width: 100%;">
    <span>
        <asp:Label runat="server"  Width="100%" Style="text-align: right" ID="lblNumberData" Visible="false"></asp:Label>
    </span>
    <span>
        <asp:Label runat="server" ID="lblTextData" Visible="false"></asp:Label>
    </span>
    <span style="text-align: Center;Width:100%">
        <asp:Image runat="server" ID="imgChkbox" Visible="false" />
    </span>
    <asp:TextBox ID="txtData" Visible="false" MaxLength="2000" Width="100%" runat="server"></asp:TextBox>
    <asp:CheckBox ID="chkData" Visible="false" runat="server" class="mobile-switch"/>
    <asp:TextBox ID="txtDate" MaxLength="100" Style="text-align: right" Visible="false"
        Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
        onblur="parseDate(this, event);" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtMemo" runat="server" visible="false" Width="75%" TextMode="MultiLine" Height="14px"></asp:TextBox>
       
    <asp:LinkButton runat="server" ID="imgMemo" CssClass="SearchButton"  OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtMemo'))">
    <span class="Icon"></span>
    </asp:LinkButton>

    <telerik:RadComboBox ID="ddlData" runat="server" AutoPostBack="False" Skin="Default" 
        DropDownWidth="250px" EmptyMessage="Select..." OnClientItemsRequesting="GetUDFValueToReturn" AllowCustomText="true"
        NoWrap="true" Width="100%" Height="320px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
        EnableVirtualScrolling="True" OnItemsRequested="ItemsLoadRequested">
    </telerik:RadComboBox>
</div>  