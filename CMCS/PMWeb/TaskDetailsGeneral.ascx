<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TaskDetailsGeneral.ascx.vb" Inherits="Website.TaskDetailsGeneral" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style>
    @media screen and (max-width: 843px) and (min-width: 320px) {
        .VerticalTabs {
            margin-top: 0px !important;
        }
    }

</style>
<table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
    <tr class="ToolBar" style="position: relative !important; top: 0px !important; z-index: 1;">
        <td class="ToolbarTd" style="height: 25px; border-left: 1px solid #999999; border-bottom: 1px solid #999999;">
            <telerik:RadToolBar ID="DetailsToolBar" runat="server" AutoPostBack="true" CssClass="taskDetailToolbar" Width="100%" OnClientButtonClicking="click_handler_Details">
                <Items>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarNew" CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" Text="Add Task"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" CssClass="ToolbarSave" Text="Save Task"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDelete" CausesValidation="false"
                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" Text="Delete Task">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>
<div class="PMMainPage JustifyContent">
    <div class="row" style="padding-top: 16px">
        <div class="col-4-left col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSelect" meta:resourcekey="lblSelect" runat="server" Text="ID"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlTasks" runat="server" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="True" AllowCustomText="true"
                            CausesValidation="False" Height="400px" NoWrap="true"
                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblCode" meta:resourcekey="lblCode" runat="server" Text="Code"></asp:Label></td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtCode" runat="server" Width="100%" MaxLength="250"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblTask" meta:resourcekey="lblTask" runat="server" Text="Task"></asp:Label></td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtTask" runat="server" Width="100%" MaxLength="250"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSummary" meta:resourcekey="lblSummary" runat="server" Text="Summary"></asp:Label></td>
                    <td class="controlWidth">
                        <telerik:RadComboBox MarkFirstMatch="False" Filter="Contains" AllowCustomText="True" Width="100%"
                            ID="ddlSummaries" runat="server" Height="400px">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label></td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlTaskTypes" runat="server" Width="100%" OnClientSelectedIndexChanged="TypeChanged"
                            AllowCustomText="false" Filter="Contains">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblCurve" meta:resourcekey="lblCurve" runat="server" Text="Curve"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlCurves" runat="server" Width="100%" AllowCustomText="True"></telerik:RadComboBox>
                    </td>

                </tr>
            </table>
        </div>
        <div class="col-4-middle col-4">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblConstraint" runat="server" Text="Constraint" meta:resourcekey="lblConstraint"></asp:Label></td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlConstraints" runat="server" Width="100%"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblConstraintDate" meta:resourcekey="lblConstraintDate" runat="server" Text="ConstraintDate"></asp:Label></td>
                    <td class="controlWidth"><span runat="server" id="rmd_dtpConstraintDate" style="display: block; width: 100%;">
                        <telerik:RadDatePicker Width="100%" ID="dtpConstraintDate" runat="server" MinDate="1901-01-01" MaxDate="2200-01-01"
                            EnableTyping="True" Culture="English (United States)">
                            <DateInput ID="DateInput2" runat="server">
                            </DateInput>
                        </telerik:RadDatePicker>
                    </span></td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblPercentComplete" meta:resourcekey="lblPercentComplete" runat="server" Text="% Complete"></asp:Label></td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtPercentComplete" runat="server" CssClass="Percent" Width="100%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRemDuration" meta:resourcekey="lblRemDuration" runat="server" Text="Remaining Duration"></asp:Label></td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtRemDuration" runat="server" CssClass="Double" Width="100%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="Status"></asp:Label></td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlStatuses" runat="server" Width="100%"></telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4-right col-4" style="width: 400px !important; padding-left: 0">

            <fieldset>
                <legend class="Legend">
                    <asp:Label ID="lblRecap" meta:resourcekey="lblRecap" runat="server" Text="RECAP"></asp:Label></legend>
                <table class="colTable" runat="server" id="tblRecap">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEarlyStart" meta:resourcekey="lblEarlyStart" runat="server" Text="Early Start"></asp:Label>
                        </td>
                        <td class="controlWidth" style="text-align: right">
                            <asp:TextBox ID="txtEarlyStartValue" runat="server" CssClass="Percent" Width="100%" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="height: 28px">
                        <td class="labelWidth">
                            <asp:Label ID="lblEarlyFinish" meta:resourcekey="lblEarlyFinish" runat="server" Text="Early Finish"></asp:Label>
                        </td>
                        <td class="controlWidth" style="text-align: right">
                            <asp:TextBox ID="txtEarlyFinishValue" runat="server" CssClass="Percent" Width="100%" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLateStart" meta:resourcekey="lblLateStart" runat="server" Text="Late Start"></asp:Label>
                        </td>
                        <td class="controlWidth" style="text-align: right">
                            <asp:TextBox ID="txtLateStartValue" runat="server" CssClass="Percent" Width="100%" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLateFinish" meta:resourcekey="lblLateFinish" runat="server" Text="Late Finish"></asp:Label>
                        </td>
                        <td class="controlWidth" style="text-align: right">
                            <asp:TextBox ID="txtLateFinishValue" runat="server" CssClass="Percent" Width="100%" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTotalFloat" meta:resourcekey="lblTotalFloat" runat="server" Text="Total Float"></asp:Label>
                        </td>
                        <td class="controlWidth" style="text-align: right">
                            <asp:TextBox ID="txtTotalFloatValue" runat="server" CssClass="Percent" Width="100%" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>


            <asp:LinkButton runat="server" ID="lbtAttachments" Width="100%" Font-Size="12px" CssClass="Link"></asp:LinkButton>

        </div>
    </div>

  
        <div class="row row-8-4">
            <div class="col-8" style="padding-left:0 !important">
                <telerik:RadGrid ID="rdgTaskGeneral" runat="server" CssClass="rdgTaskGeneral ResponsiveMargin" SetWidth="true" FitParentContainer="true"
                    Height="100%" AllowPaging="False" AutoGenerateColumns="False" ClientSettings-Scrolling-AllowScroll="true"
                    HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
                    ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                    <MasterTableView CommandItemDisplay="None" Width="100%" TableLayout="Fixed" UseAllDataFields="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText=""
                                UniqueName="Type">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("Type")%></span>&nbsp;                                          
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Start"
                                UniqueName="StartDate">
                                <ItemTemplate>
                                    <telerik:RadDatePicker Width="145px" ID="dtpStartDate" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2200-01-01"
                                        EnableTyping="True">
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Finish"
                                UniqueName="FinishDate">
                                <ItemTemplate>
                                    <telerik:RadDatePicker Width="145px" ID="dtpFinishDate" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2200-01-01"
                                        EnableTyping="True">
                                    </telerik:RadDatePicker>
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Duration Days"
                                UniqueName="DurationDays">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDurationDays" Width="100%" runat="server" CssClass="Double" Text='<%#Eval("DurationDays").ToString%>'></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <%--                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Duration Hours"
                                        UniqueName="DurationHours">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDurationhours" Width="100%" runat="server" CssClass="Double" Text='<%#Eval("DurationHours").ToString%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>--%>
                            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Cost"
                                UniqueName="Cost">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCost" Width="100%" runat="server" CssClass="Double" Text='<%#Eval("Cost").ToString%>'></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Revenue"
                                UniqueName="Revenue">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRevenue" Width="100%" runat="server" CssClass="Double" Text='<%#Eval("Revenue").ToString%>'></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnGridCreated="GridCreated" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
            <div class="col-4"></div>
        </div>
    
</div>
<asp:Button runat="server" ID="btnRefreshTask" CssClass="Hide" />