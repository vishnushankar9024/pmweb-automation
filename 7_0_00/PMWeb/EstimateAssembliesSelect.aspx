<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimateAssembliesSelect.aspx.vb"
    Inherits="Website.EstimateAssembliesSelect" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Assemblies</title>
    <style type="text/css">
        .ShowOnMobilePopup{
            display:none !important;
        }
        .PreviewQuantities{
            width:200px !important;
        }
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .ShowOnMobilePopup {
                
                display: table !important;
            }
        }
        td.labelWidth {
            width: 160px !important;
        }
        span#lblUOMText, span#lblUOM, span#lblQuantityText{
            font-size:9px;
        }    
        .rgFooterDiv{
            margin-right:0 !important;
        }
    </style>                 
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtrImages">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="imagePreview" LoadingPanelID="ldpAssemblies" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnPreviewQuantities">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems"  />
                         <telerik:AjaxUpdatedControl ControlID="rdgAssemblyVariables" LoadingPanelID="ldpAssemblies" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
              
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <script type="text/javascript">
            $(document).ready(function () { 
                $('#txtQuantity').change(function () {
                    $('#txtQuantityMobile').val($('#txtQuantity').val())
                })
                $('#txtQuantityMobile').change(function () {
                    $('#txtQuantity').val($('#txtQuantityMobile').val())
                })
            });
        </script>




        <telerik:RadAjaxLoadingPanel ID="ldpAssemblies" runat="server" Skin="Default" />
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="ForceShow" />
        <div class="ToolBar" style="z-index: 1999 !important;top: 0px !important;">
      <table cellpadding="0" cellspacing="0" style="table-layout:fixed;width:auto !important;">
            <tr>
                <td valign="middle" style="vertical-align: middle;width:172px !important " class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" CssClass="ToolbarSave" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndClose" Enabled="false"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                
                </td>
                <td class="HideOnMobilePopup" width="160px">
                    <asp:Label ID="lblSelectAssemply" Text="Select an Assembly" ForeColor="#666666" runat="server" meta:resourcekey="lblSelectAssemply"></asp:Label>
                </td>
                <td class="ToolbarTd HideOnMobilePopup" style="width:calc(100vw - 532px);">
                    <telerik:RadComboBox ID="ddlAssemblies" runat="server" Filter="Contains" MarkFirstMatch="True"
                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default" Height="300px" Width="100%"
                        AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                        OnItemsRequested="ddlAssemblies_ItemsRequested" meta:resourcekey="ddlAssemblies">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                 <td class="ToolbarTd" style="padding-right: 24px;width:200px">
                    <asp:Button ID="btnPassNotes" Text="Enter Pass Notes" Visible="false" runat="server" meta:resourcekey="btnPassNotes" CssClass="PassNotes" OnClientClick="return OpenSmallNoteDetailPopup(this.id.replace('btnPassNotes','txtPassNotes'))" />
                </td>
                <td class="ToolbarTd" style="padding-right: 24px;width:200px">
                    <asp:Button ID="btnPreviewQuantities" Text="Calculate Items" Visible="false" runat="server" meta:resourcekey="btnPreviewQuantities" CssClass="PreviewQuantities" />
                </td>
             
            </tr>
        </table>
        </div>
        

        <div  class="PMMainPage" >  
             <div class="row documentSinglePage" style="margin-bottom: 0 !important">
                    <div  class="col-4">
                    <table class="colTable ShowOnMobilePopup" >
                        <tr  id="ddlAssembliesMobileDetails" visible="true" runat="server" >
                            <td class="labelWidth">
                                <asp:Label ID="lblAssembliesMobile" Text="Select an Assembly" runat="server" meta:resourcekey="lblSelectAssemply"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlAssembliesMobile" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default" Height="300px" Width="100%"
                                    AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                    OnItemsRequested="ddlAssemblies_ItemsRequested" meta:resourcekey="ddlAssemblies">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                            </tr>
                     </table>
                        </div>
             </div>
            <div  class="row JustifyContent " style="padding-top:0" >
                <div  class="col-4 col-4-left">
             <div id="divFirstRow" runat="server">
                    <table class="colTable"  id="tblFirstRow" runat="server" visible="false">
                        <tr>
                            <td class="labelWidth NoWrap"> 
                                <asp:Label ID="lblUOMText" runat="server" meta:resourcekey="lblTextUOM"></asp:Label>
                                <asp:Label ID="lblUOM" runat="server"></asp:Label>
                                <asp:Label ID="lblQuantityText" runat="server" meta:resourcekey="lblQuantity"></asp:Label>
                                <asp:Label ID="lblQuantityResult" runat="server" ></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align: right">
                                <asp:TextBox ID="txtQuantity" MaxLength="9" runat="server" Text="1" CssClass="Integer"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase"></asp:Label>
                            </td>
                            <td class="controlWidth">

                                <telerik:RadComboBox ID="ddlProjectPhases" runat="server" Filter="Contains" AllowCustomText="true"
                                    MarkFirstMatch="True" Skin="Default" NoWrap="True" Height="200px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td class="controlWidth">

                                <telerik:RadComboBox ID="ddlLocations" runat="server" Filter="Contains" AllowCustomText="true"
                                    MarkFirstMatch="True" Skin="Default" Style="font-size: 11px" NoWrap="True" Height="200px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCostCode" runat="server" meta:resourcekey="lblCostCode"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBudgetCodes" runat="server" Filter="Contains" AllowCustomText="true"
                                    MarkFirstMatch="True" Skin="Default" Style="font-size: 11px" NoWrap="True" Height="200px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                    </table>
                 </div>
              </div>
                <div class="col-4 col-4-middle">
                    <div id="divSecondrow" runat="server">
                    <table  class="colTable" id="tblsecondRow" runat="server" visible="false">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..."
                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" Width="100%" AllowCustomText="true"
                                    MarkFirstMatch="True" Skin="Default" Style="font-size: 11px" NoWrap="True" Height="200px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPeriod" runat="server" Text="Period" meta:resourcekey="lblPeriod"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlPeriods" runat="server" Height="150px" Skin="Default" Width="100%" AllowCustomText="true"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlPeriods" EmptyMessage="Select Period..." NoWrap="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" Filter="Contains">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />

                                </telerik:RadComboBox>
                            </td>
                        </tr>

                        <tr style="display: none">
                            <td class="labelWidth NoWrap">
                                <asp:Label ID="lblUOMTextMobile" runat="server" meta:resourcekey="lblUOMText"></asp:Label>

                                <asp:Label ID="lblUOMMobile" runat="server"></asp:Label>
                                <asp:Label ID="lblQuantityTextMobile" runat="server" meta:resourcekey="lblQuantityText"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align: right">
                                <asp:TextBox Width="100px" ID="txtQuantityMobile" MaxLength="9" runat="server" Text="1" CssClass="Integer"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                        </div>
                </div>

                <div class="col-4 col-4-right">
                    <div style="display:none;">
                        <asp:TextBox ID="txtPassNotes" runat="server"></asp:TextBox>
                    </div>
                    <div>
                        <uc1:AssetRotator ID="PMrot" runat="server" />
                    </div>
                        
                </div>
                
                    
                
                </div>
           
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgAssemblyVariables" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" Visible="false"
                        AutoGenerateColumns="False" GridLines="None" Width="100%" FitParentContainer="true" Height="200px" style="overflow: auto;">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Variable")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Description")%>&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" HeaderStyle-Width="80px" UniqueName="UOM" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%#Container.DataItem("UOM")%>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="Double" MaxLength="15" Width="98%" Text='<%# FormatNumber(0)%>' Ondblclick="OpenRedliningMeasuresLogPopup(this.id,'','ASP',0)"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtNotes" runat="server" Width="90%"
                                    MaxLength="4000" TextMode="MultiLine" Height="20px"></asp:TextBox>
                                        <%--Text='<%# Eval("PassNotes") %>'--%>
                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenSmallNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                                     <span class="Icon"></span>
                                    </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>

                    <%--     <div style="text-align: center; padding-top: 10px;">
                        <asp:Button ID="btnPreviewQuantitiesMobile" Visible="false" CssClass="ShowOnMobile maxWidth lnkCreateNext" Text="Calculate Items" runat="server" meta:resourcekey="btnPreviewQuantities" />
                    </div>--%>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgItems" runat="server" SetWidth="true" FitParentContainer="true" Visible="false" FitPageHeightOffset="24"
                        Width="100%" AutoGenerateColumns="false" GridLines="None" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="80px" SortExpression="ItemId"
                                    ItemStyle-HorizontalAlign="Left" UniqueName="Item">
                                    <ItemTemplate>
                                        <%#Container.DataItem("ItemId").ToString%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-Width="80px" SortExpression="Description">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Description")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" HeaderStyle-Width="80px" SortExpression="UOM">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="Currency">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCurrency" runat="server" Width="100%"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Default Cost" UniqueName="DefaultCost" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="DefaultCost">
                                    <ItemTemplate>
                                        <%#FormatNumber(CDbl(Container.DataItem("DefaultCost")))%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" HeaderStyle-Width="80px"
                                    SortExpression="Variable">
                                    <ItemTemplate>
                                        <%#IIf((Container.DataItem("VariableId") = 0) Or (Container.DataItem("VariableId") = -1), CDbl(Container.DataItem("FixedQuantity")).ToString("#,##0.00"), CStr(Container.DataItem("Variable")))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="Quantity">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity")%>' />
                                        <%--<%#FormatNumber(Container.DataItem("Quantity"))%>--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="TotalCost" FooterStyle-HorizontalAlign="Right"
                                    meta:resourcekey="GridTemplateColumn11">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalCost" runat="server" Text='<%#FormatNumber(CDbl(Container.DataItem("Quantity")) * CDbl(Container.DataItem("DefaultCost")))%>' />
                                        <%--<%#FormatNumber(CDbl(Container.DataItem("Quantity")) * CDbl(Container.DataItem("DefaultCost")))%>--%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                       
                                            <asp:Label ID="lblSumTotalCosts" runat="server" meta:resourcekey="lblSumTotalCosts"></asp:Label>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false" ></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt" ></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true">
                            <Resizing AllowColumnResize="True"></Resizing>
                           
                        </ClientSettings>
                        

                    </telerik:RadGrid>
                </div>
            </div>
       </div>
<%--       <div class="PMHeader fullWidth">
                                            <div class="row Margins">
                                                <div class="col-4" style="padding-left: 16px; padding-top: 16px; padding-right: 16px;box-sizing:border-box;">
                                                    <table class="colTable ShowOnMobile">
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="Label1" Text="Select an Assembly" runat="server" meta:resourcekey="lblSelectAssemply"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="RadComboBox1" runat="server" Filter="Contains" MarkFirstMatch="True"
                                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Skin="Default" Height="300px" Width="100%"
                                                                    AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                                                    OnItemsRequested="ddlAssemblies_ItemsRequested" meta:resourcekey="ddlAssemblies">
                                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        </table>
        </div>
                                                </div>
           </div>--%>

        <%--                <div class="popupDiv" id="gallerypopup">
                                <div class="col-4" style="overflow: hidden;">
                                    <div>
                                        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
                                            <tr valign="top">
                                                <td valign="top">
                                                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td valign="middle" style="vertical-align: middle; width: 10%;" class="ToolbarTd">
                                                                <telerik:RadToolBar ID="RadToolBar2" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile ">
                                                                    <Items>
                                                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeGallery"></telerik:RadToolBarButton>
                                                                    </Items>
                                                                </telerik:RadToolBar>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                               
                                </div>
                            </div>--%>


        <%--    <table class="NormalWhiteBack" style="width: 100%;">  
        <tr>
            <td style="padding-left: 22px; width:250px">
                <asp:Panel ID="pnlActions1" runat="Server">
                    <asp:LinkButton ID="lbtSavetoEstimate" runat="server" meta:resourcekey="lbtSavetoRecord"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtSaveAndClose" runat="server" Text="<%$ Resources:PMWeb, SaveClose %>"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Close %>"></asp:LinkButton>
                </asp:Panel>
            </td>
        </tr>
    </table>--%>
    </form>
</body>
</html>
