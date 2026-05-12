  <%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectExplorer.ascx.vb" Inherits="Website.ProjectExplorer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<style>
    .combo-item-template{
        padding-left:25px;
    }

    .rcbSlide{
        z-index: 10000 !important;
    }

    .slide-down{
        transform:translateY(0);
        opacity:3;
    }
   

  
    .ToolBar {
    z-index: 996;
}

 .SelectedNode {
     border-radius: 6px;
     display:inline-block;
     background-color: /*4*/#D6D6D6/*4*/ !important;
     padding:2px 5px;
 }
 .AngularControl .rcbInner{
     border-radius:12px;
 }

 .AngDropDown .rcbinput,
 .AngDropDown .rcbInner{
     border-radius:10px;
 }
.AngularFilter .RadInput input{
    border-radius:6px !important;
    border: 1px solid rgba(208, 213, 221, 1) !important;
}
.Clearddlbutton{
   transform: translateX(130px);
    top:19% !important;
}
.ProjectExplorerContainer {

    min-width:426px !important;
}
    .ProjectExplorerTree {
        min-width:390px;
        height:calc(100vh - 350px) !important;
    }

    .ProjectExplorerLabel{
        font-family: InterVariable, sans-serif;
        font-weight: 400;
        font-style: normal;
        font-size: 12px;
        color: #101828 !important;
 
    }

     .ClearSearchImg {
            position: absolute;
            top: 19px;
            width: 24px;
            height: 24px;
            left: 341px;
        }
     .SelectedItemClass{
       background-image: url('../CSS/Images/ResponsiveIcons/Icons/Icons/selected.svg');
       background-repeat: no-repeat !important;
       background-position-x: 334px;
           background-position-y: 7px;
     }

</style>

<table style="padding-left:10px">
<%--    <tr>
        <td colspan="2" class="tdProgramprojectLogin">
             <asp:Label ID="lblProgramprojectLogin"  runat="server" meta:Resourcekey="lblProgramprojectLogin" Text="Program / Project Login"></asp:Label>
            
            
           </td>
    </tr>--%>

     <tr>

      <td class="labelWidth ProjectExplorerLabel" style="top:20px !important">
            <asp:Label ID="lblView" runat="server" meta:Resourcekey="lblView" Text="View"></asp:Label>
        </td>
         </br>
        <td class="AngularControl">
            <div class="AngularComboBox">
            <telerik:RadComboBox runat="server" Id="ddlViews" Width="374px" AutoPostBack="true" onclick="ClosedllViews()"  OnClientDropDownClosed="ddlViewsClosed" OnClientDropDownOpened="ddlViewsOpened" CssClass="AngDropDown" DropDownCssClass="AngularDropDown"></telerik:RadComboBox>
                <ItemTemplate>
                <%--<div class="selected-svg" style="display: inline-block;">
                   <svg xmlns="http://www.w3.org/2000/svg" fill="#155EEF" width="24px" height="24px" viewBox="0 -960 960 960">
                      <path d="M382-240 154-468l57-57 171 171 367-367 57 57-424 424Z"/>
                          </svg>
                              </div>--%>

                    <ItemTemplate>
            </div>
        </td>
    </tr>
    
 <tr>
      <td class="labelWidth ProjectExplorerLabel" style="top:93px !important">
            <asp:Label ID="lblStatuses" runat="server" Text="Project Status"></asp:Label>
        </td>
        <td class="AngularControl"  style="top:108px !important">
            <div class="AngularComboBox">
          <telerik:RadComboBox ID="ddlProjectStatus" CssClass="ProjectExplorerTextbox " runat="server" onclick="ClosedllProjectStatus()" class="AngularComboBox AngDropDown"
                Skin="Default" CloseDropDownOnBlur="true" OnClientDropDownClosing="ProjectExplorerStatusddlClosed" OnClientDropDownOpened="ProjectExplorerStatusddlOpened"
            NoWrap="True" AllowCustomText="true" DropDownCssClass="AngularDropDown" Width="374px" >
             
            <ItemTemplate>
                <div onclick="StopPropagation(event)" class="combo-item-template" >
                    <asp:CheckBox runat="server" ID="chkApply" Text='<%#Eval("Status")%>' />
                </div>
            </ItemTemplate>
        </telerik:RadComboBox> <asp:Image class="Clearddlbutton" style="display:none" runat="server" ImageUrl="~/CSS/Images/ToolBar/XIcon.png" ID="ClearSelection" postback="false" onclick="return ClearSelection(this)"/>
                 </div>
             <asp:HiddenField runat="server" ID="hddnIds" />
             <asp:HiddenField runat="server" ID="hddnNames" />
        </td>
    </tr>
    <tr>
    <%--    <td class="labelWidth ProjectExplorerLabel"  style="top:146px !important">
            <asp:Label ID="lblSearch" runat="server" meta:Resourcekey="lblSearch" Text="Filter"></asp:Label>
        </td>--%>
        <asp:Button ID="btnHidden" AutoPostBack="true" CssClass="HiddenPostBack" runat="server" Style="display:none" />
        <td class="AngularControl AngularFilter" style="top:163px !important; ">         
            <telerik:RadTextBox ID="txtSearch" runat="server" Width="374px"
                meta:resourcekey="txtSearch" MaxLength="500" AutoPostBack="false" PlaceHolder="Filter...">
            <ClientEvents OnLoad="txtSearchLoaded" />
            </telerik:RadTextBox><asp:ImageButton class="ClearSearchImg" runat="server" ImageUrl="~/CSS/Images/ToolBar/XIcon.png" id="ClearSearch" OnClientClick="return Cleartext()"/>
        </td>
    </tr>

    <tr>
        <td class="controlWidth" colspan="2" style="padding-top:209px">
            <div style="width:100%;">
                <telerik:RadTreeView ID="rtvProjectExplorer" runat="server"  MultipleSelect="True" Skin="Default"  CssClass="ProjectExplorerTree WhiteTree"
                    ShowLineImages="False"   CausesValidation="False" OnClientNodeClicking="OnProjectExplorerClientNodeClicking">
                    <ExpandAnimation Duration="100" />
                    <CollapseAnimation Duration="100" Type="OutQuint" />
                </telerik:RadTreeView>
            </div>
            
        </td>
    </tr>
</table>
<asp:button ID="btnddlStatusChanged" runat="server" CssClass="Hide" />





