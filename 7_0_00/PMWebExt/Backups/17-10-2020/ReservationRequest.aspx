<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ReservationRequest.aspx.vb" Inherits="Website.ReservationRequest" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ReservationDetails.ascx" TagName="ReservationDetails" TagPrefix="uc1" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc6" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc7" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            function Details_OnClientLoad(editor, args) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
            }
        </script>

        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {

                var Description = '<%=JSEscape(PM.Asset.ReservationRequestInfo.Description)%>';
                var Id = '<%=PM.Asset.ReservationRequestInfo.Id%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=RESERVATIONREQUEST&Id=" +
                               '<%= PM.Asset.ReservationRequestInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + Description
                            + "&EntityId=0" + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'New':
                        window.location = "ReservationRequest.aspx";
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

        </script>
    </telerik:RadCodeBlock>
    <style>
        .col-4 .RadEditor iframe.reHtmlMode{
            height:0px !important
        }
         .col-4 .RadEditor iframe{
            height:295px !important
        }
         .col-4 .RadEditor .reTextArea {
    height: 295px !important;
}
    </style>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
              <telerik:AjaxSetting AjaxControlID="mlpReservationRequest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReservationRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReservationRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
         
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=160">
                            <div class="btnToolbarSearchDocument">
                                &nbsp; 
                            </div>
                            </asp:LinkButton>
                        </td>
                        <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                            <asp:LinkButton runat="server" ID="btnRecent">
                            <div class="btnToolbarRecent">
                                &nbsp; 
                            </div>
                            </asp:LinkButton>
                        </td>
                        <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                            <telerik:RadComboBox ID="ddlreservation" runat="server" OnClientTextChange="LOD_DropDownTextChange" OnItemsRequested="ddl_ItemsRequested"
                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                AutoPostBack="False" NoWrap="true" CausesValidation="False" EnableVirtualScrolling="True" Height="400px" Width="240px"
                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                                    </telerik:RadToolBarButton>


                                       <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>


                                    <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('RESERVATIONREQUEST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpReservationRequest" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <%--<telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />--%>
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpReservationRequest" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCode" meta:resourcekey="lblCode" runat="server" Text="Code*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                            CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                            ValidationGroup="Save" Operator="NotEqual" meta:resourcekey="rfvCode">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCodeUnique" meta:resourcekey="lblCodeUnique" Text="<br>Code must be unique."
                                            runat="server" CssClass="Validator" Visible="false">
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocation" runat="server" AutoPostBack="True"
                                            Skin="Default" EnableVirtualScrolling="True"
                                            NoWrap="true" Height="300px"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuilding" meta:resourcekey="lblBuilding" runat="server" Text="Building"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBuilding" runat="server" AutoPostBack="True"
                                            Skin="Default" EnableVirtualScrolling="True"
                                            NoWrap="true" Height="300px"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFloor" meta:resourcekey="lblFloor" runat="server" Text="Floor"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFloor" runat="server" AutoPostBack="True"
                                            Skin="Default" EnableVirtualScrolling="True"
                                            NoWrap="true" Height="300px"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubject" meta:resourcekey="lblSubject" runat="server" Text="Subject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSubject" runat="server" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSpace" meta:resourcekey="lblSpace" runat="server" Text="Space"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSpaces" runat="server" AutoPostBack="false" Skin="Default"
                                            NoWrap="true" EnableVirtualScrolling="True"
                                            Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEquipment" meta:resourcekey="lblEquipment" runat="server" Text="Equipment"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEquipment" runat="server" Height="200px" Skin="Default"
                                            CloseDropDownOnBlur="true" NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStartDate" runat="server" Height="16px" Text="Start Date*" meta:ResourceKey="lblStartDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpStart" style="display: block">
                                            <telerik:RadDatePicker ID="dtpStart" runat="server" Culture="English (United States)" Skin="Default" Width="100%">
                                                <Calendar ID="Calendar1" Skin="Default" runat="server" UseColumnHeadersAsSelectors="False"
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvStart" runat="server" ControlToValidate="dtpStart"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:resourcekey="rfvStarts"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStartTime" runat="server" Height="16px" Text="Start Time*" meta:ResourceKey="lblStartTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpStart" Width="100%" runat="server" Skin="Default"></telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvTimeStart" runat="server" ControlToValidate="tpStart"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:resourcekey="rfvTimeStart"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinishDate" runat="server" Height="16px" Text="Finish Date*" meta:ResourceKey="lblFinishDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpFinish" style="display: block">
                                            <telerik:RadDatePicker ID="dtpFinish" runat="server" Culture="English (United States)" Skin="Default" Width="100%">
                                                <Calendar ID="Calendar2" Skin="Default" runat="server" UseColumnHeadersAsSelectors="False"
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvFinish" runat="server" ControlToValidate="dtpFinish"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:resourcekey="rfvFinishs"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinishTime" runat="server" Height="16px" Text="Finish Time*" meta:ResourceKey="lblFinishTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpFinish" Width="100%" runat="server" Skin="Default"></telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvTimeFinish" runat="server" ControlToValidate="tpFinish"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:resourcekey="rfvTimeFinishs"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" meta:resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc1:ReservationDetails ID="ReservationDetails1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:ReservationDetails ID="ReservationDetails1" runat="server" Selected="True" />
        </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc6:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
