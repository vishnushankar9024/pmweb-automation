<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RequiredFields.ascx.vb" Inherits="Website.RequiredFields" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="RamLabors" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgFieldSettings">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgFieldSettings" LoadingPanelID="ldpPM" />

            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="trvRecordTypeExplorer">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgFieldSettings" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="trvRecordTypeExplorer" />
                <telerik:AjaxUpdatedControl ControlID="txtRecordType" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    .rtTop .rtSp {
        background-image: url('CSS/Images/ResponsiveIcons/16White.png') !important;
        width: 16px !important;
        height: 22px !important;
        margin-left: -3px !important;
        margin-right: -14px !important;
        background-position: -1568px 0px !important;
        background-repeat: no-repeat !important;
        margin-top: 2px !important;
    }

    .rtBot .rtSp {
        background-image: url('CSS/Images/ResponsiveIcons/16White.png') !important;
        width: 16px !important;
        height: 22px !important;
        margin-left: -3px !important;
        margin-right: -14px !important;
        background-position: -1568px 0px !important;
        background-repeat: no-repeat !important;
        margin-top: 2px !important;
    }

    .trvDocument .rtSp {
        background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
        width: 16px !important;
        height: 22px !important;
        margin-left: -3px !important;
        margin-right: -14px !important;
        background-position: -272px 0px !important;
        background-repeat: no-repeat !important;
        margin-top: 2px !important;
    }

    .trvFolder .rtSp, .trvPBSFolder .rtSp {
        background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
        width: 16px;
        height: 22px;
        margin-left: -3px;
        margin-right: -14px;
        background-position: -1568px 0px;
        background-repeat: no-repeat;
        margin-top: 2px;
    }

    .row {
        padding-right: 24px;
    }

    @media screen and (min-width:844px) {
        .FlyoutFieldTree {
            display: inline-block !important;
        }
    }

    @media screen and (max-width:843px) {
        .PMHeader {
            margin-top: 92px;
        }

        .row {
            padding-right: 16px;
            padding-left: 16px;
        }

        .FlyoutFieldTree {
            position: fixed !important;
            top: 91px;
            height: 80%;
            z-index: 50;
            box-shadow: 10px 10px 10px 0px black;
            left: -16px;
            overflow: auto;
        }

        .Height {
            height: 100% !important;
        }

        .RadTreeView {
            max-height: 100% !important;
        }

        .PMHeader .row .col-4.FlyoutFieldTree {
            width: 90% !important;
        }

        .Block {
            display: block;
        }
    }

    .ToolbarShowHideTree .rtbIcon {
        background-position: -1896px 0;
    }

    @media screen and (max-width: 843px) and (min-width: 320px) {
        .RadTreeView {
            max-height: 100% !important;
        }

        .PMMainPage {
            margin: 0 !important;
        }

        .TreeHeight {
            height: calc(100vh - 135px) !important;
        }

        .HideOnTabletMobile {
            display: none;
        }

        .RequiredFieldsLeftSplitterPane {
            margin-top: 151px !important;
            position: fixed;
            width: 60vw !important;
            top: 0;
            height: calc(100vh - 133px) !important;
            z-index: 996;
            border: 1px solid #999;
        }

        .RequiredFieldsLayoutSplitter {
            position: fixed;
            left: calc(60vw);
            z-index: 3000;
            height: calc(100vh - 134px) !important;
            margin-top: 0px !important;
        }

        .RequiredFieldsSplitterPane {
            height: calc(100vh - 130px) !important;
            width: calc(100vw - 3px) !important;
        }
    }

    * {
        box-sizing: border-box;
    }

    /*.AssetExplorerVerticalSplitter {
        width: 100% !important;*/
     /*   padding-top: 88px;*/
    /*}*/


    body, html, form {
        height: 100%;
        margin: 0px;
        padding: 0px;
    }

    .removeLeft {
        left: 0 !important;
    }

    @media screen and (min-width:844px) {

        .RequiredFieldsSplitterPane {
            height: calc(100vh - 143px) !important;
        }

        .RequiredFieldsLayoutSplitter {
            height: calc(100vh - 143px) !important;
        }

        .RequiredFieldsLeftSplitterPane {
            height: calc(100vh - 171px) !important;
        }

        .TreeHeight {
            height: calc(100vh - 171px);
        }
    }

    .RadCalendar .rcTitlebar .rcPrev, .RadCalendar .rcTitlebar .rcNext, .RadCalendar .rcTitlebar .rcFastPrev, .RadCalendar .rcTitlebar .rcFastNext
    {
            height: 33px;
    }
    .RadCalendar_Default .rcMain .rcRow a, .RadCalendar_Default .rcMain .rcRow span{
        width: 2.5em;
    }
</style>

<table style="width: 100%;  height: 50px; border-bottom: 1px solid black" cellspacing="0" cellpadding="0" border="0" runat="server" id="tblRequiredFields" class="ToolBar">
    <tr>

        <td style="width: 160px; padding-left: 24px;" class="td1">
            <asp:Label ID="lblEntities" runat="server" Text="Entities" meta:resourcekey="lblEntities"></asp:Label>
        </td>
        <td style="max-width: 240px;" class="td2">
            <telerik:RadComboBox ID="ddlEntities" runat="server" AllowCustomText="true" Skin="Default"
                Height="250px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="-- Portfolio --"
                Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" CheckForDirt="True"
                OnItemsRequested="ddl_ItemsRequested">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>

        <td></td>
    </tr>

</table>
<telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default"  SplitBarsSize="" CssClass="RDSplitter">
    <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="RDLeftPane" EnableEmbeddedBaseStylesheet="False" >

        <div style="background-color: #666666;">
            <telerik:RadTreeView ID="trvRecordTypeExplorer" runat="server" MultipleSelect="false" Style="box-sizing: border-box; color: #ffffff; background-color: #666666; padding-top: 24px; padding-left: 24px;" Width="100%" CssClass="WhitePlusMinus TreeHeight"
                EnableDragAndDrop="false" CausesValidation="False">
            </telerik:RadTreeView>
        </div>
    </telerik:RadPane>
    <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter"  CollapseMode="Forward" />
    <telerik:RadPane ID="RadContentPane" CssClass="RDRightPane" runat="server" Width="70%" Index="2" Skin="Default">

        <div class="PMMainPage">
            <div class="row">
                <div class="col-12">
                    <table style="width: 100%">
                        <tr style="height: 40px;">
                            <td style="width: 160px">
                                <asp:Label ID="lblRecordType" runat="server" Text="Record Type" meta:resourcekey="lblRecordType"></asp:Label>
                            </td>
                            <td style="width: 240px;">
                                <asp:TextBox ID="txtRecordType" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                    <fieldset style="width: 100%">
                        <legend>
                            <asp:Label ID="lblFieldSettings" runat="server" Text="Field Settings" meta:resourcekey="lblFieldSettings"></asp:Label></legend>

                        <telerik:RadGrid ID="rdgFieldSettings" runat="server" SetWidth="true" FitPageHeightOffset="24"
                            AutoGenerateColumns="False" ShowStatusBar="True" UseEditFormInMobile="true"
                            Font-Size="8px" ShowGroupPanel="False"
                            AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                            AllowSorting="False" GridLines="None" Width="100%">

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                EditMode="InPlace" EnableHeaderContextMenu="False">

                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="Field Name" UniqueName="FieldName" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("FieldName").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("FieldName").ToString%>&nbsp;
                                        </EditItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Required" UniqueName="Required" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>

                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Required")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chbRequired" runat="server" Checked='<%# CBool(IIf(Eval("Required") Is System.DBNull.Value, 0, Eval("Required")))%>' />
                                        </EditItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="90px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Default Value" UniqueName="DefaultValue" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDefaultValue" runat="server"></asp:Label>&nbsp;

                                             <img id="imgchkRequiredFieldsCheckBox" runat="server"  src='<%#"Images/Global/" + CStr(IIf(Eval("TextValue") = "True", "checked.png", "unchecked.png"))%>'  alt="" visible="false" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="dtpRequiredFieldsDate" Visible="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput5" Skin="Default" runat="server"></DateInput>
                                            </telerik:RadDatePicker>

                                            <telerik:RadTimePicker ID="dtpRquiredFieldsTime" runat="server"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01"
                                                Skin="Default" Width="100%">
                                                <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                    Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar1" runat="server" Skin="Default">
                                                </Calendar>
                                            </telerik:RadTimePicker>
                                            <asp:CheckBox ID="chkRequiredFieldsCheckBox" Visible="false" runat="server" />

                                            <asp:TextBox ID="txtRequiredFieldsInteger" Visible="false" Width="100%" CssClass="PositiveInteger" runat="server" MaxLength="9"></asp:TextBox>

                                            <asp:TextBox ID="txtRequiredFieldsPercentage" Visible="false" CssClass="Percent" MaxNumber="100" MinNumber="0" Width="100%" runat="server"></asp:TextBox>

                                            <asp:TextBox ID="txtRequiredFieldsText" Visible="false" MaxLength="255" runat="server" Width="100%"></asp:TextBox>

                                            <asp:TextBox ID="txtRequiredFieldsDouble" Visible="false" runat="server" CssClass="Double" Width="100%" MaxLength="15"></asp:TextBox>

                                            <telerik:RadComboBox ID="ddlPostAs" Visible="false" runat="server" Width="100%" Skin="Default" Style="font-size: 11px">
                                            </telerik:RadComboBox>

                                            <telerik:RadComboBox ID="ddlRequiredFieldsTasks" Visible="false" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..." NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                                <HeaderTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 275px;">
                                                                <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                            <td style="width: 50px;">
                                                                <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                            <td style="width: 50px;">
                                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 275px;">
                                                                <%# DataBinder.Eval(Container, "Text")%></td>
                                                            <td style="width: 50px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['Start']")%></td>
                                                            <td style="width: 50px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['Finish']")%></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>

                                            <telerik:RadComboBox ID="ddlRequiredFieldsContacts" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="False" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                OnClientDropDownClosed="dllcompClientClosed"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="250px">
                                                <HeaderTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                            <td style="width: 135px;">
                                                                <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>

                                            <telerik:RadComboBox ID="ddlRequiredFieldsWBS" runat="server" Width="100%" AutoPostBack="false"
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                            </telerik:RadComboBox>

                                            <telerik:RadComboBox ID="ddlRequiredFieldsList" runat="server" EmptyMessage="Select..."
                                                Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                                EnableVirtualScrolling="True" OnItemsRequested="ItemsLoadRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>

                                        </EditItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                </Columns>

                                <CommandItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                            SecurityButtonType="ItemMode_Edit"
                                            Visible='<%# rdgFieldSettings.EditIndexes.Count = 0 And (Not rdgFieldSettings.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnEditSelectedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                            SecurityButtonType="AddEditMode_Edit" ValidationGroup="SaveRating"
                                            Visible='<%# rdgFieldSettings.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                            SecurityButtonType="AddEditMode"
                                            Visible='<%# rdgFieldSettings.EditIndexes.Count > 0 Or rdgFieldSettings.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgFieldSettings.EditIndexes.Count = 0 And (Not rdgFieldSettings.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>

                                    </div>
                                </CommandItemTemplate>

                            </MasterTableView>
                            <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="False" ColumnsReorderMethod="Reorder"
                                AllowDragToGroup="False">
                                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>



                    </fieldset>
                </div>
            </div>
        </div>


    </telerik:RadPane>
</telerik:RadSplitter>

