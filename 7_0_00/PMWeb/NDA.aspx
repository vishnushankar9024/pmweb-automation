<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="NDA.aspx.vb" Inherits="Website.NDA" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">


        <script type="text/javascript">

            function ClientLoad(editor) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
            }


            function click_handler(sender, args) {

                switch (args.get_item().get_commandName()) {

                    case 'New':
                        window.location = "NDA.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
        </script>
    </telerik:RadCodeBlock>


    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=240">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                            </asp:HyperLink>
                        </td>
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar">
                            <telerik:RadComboBox ID="ddlNDA" runat="server" AllowCustomText="true" Skin="Default"
                                Height="400px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="Select NDA..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                                Width="240px" AutoPostBack="false" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlNDA"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save"
                                        ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>

                                   
                                    <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                                 </telerik:RadToolBarButton>
                                    
                                     <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" Width="150px" ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNDAS" runat="server" Text="NDA#*" meta:Resourcekey="lblNDAS"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtNDACode" runat="server" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNDA" runat="server" ValidationGroup="Save" ControlToValidate="txtNDACode"
                                    CssClass="Validator" Display="Dynamic"  meta:Resourcekey="rfv_NDA"
                                    ForeColor=""></asp:RequiredFieldValidator>
                                <asp:Label ID="lblNDACodeUnique" meta:resourcekey="lblNDACodeUnique" Text="<br>NDA Number should be unique." runat="server" CssClass="Validator" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"></telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" ></telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDefault" runat="server" Text="Default" meta:resourcekey="lblDefault"></asp:Label>
                            </td>
                            <td class="controlWidth chkBox">
                                <asp:CheckBox ID="chkDefault" runat="server" ClientIDMode="Static" Style="margin-left: -4px !important" />
                                <label for="chkDefault">
                                    <i class="icon"></i>
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12 ResponsiveMargin">
                        <telerik:RadEditor ID="edtNDA" DialogsScriptFile="~/JS/RadEditorDialog.js"  runat="server" OnClientLoad="ClientLoad" Style="min-height: 500px; width: 100%; box-sizing: border-box; height: 100%;"
                            Skin="Default" ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                            <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                ViewPaths="~/Images/Shared" />
                            <TemplateManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000"
                                SearchPatterns="*.*" UploadPaths="~/Images/Shared"
                                ViewPaths="~/Images/Shared" />
                        </telerik:RadEditor>
                    </div>
                </div>
            </div>
        </div>



    </telerik:RadAjaxPanel>


</asp:Content>
