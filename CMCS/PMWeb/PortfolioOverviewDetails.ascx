<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PortfolioOverviewDetails.ascx.vb" Inherits="Website.PortfolioOverviewDetails" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    /*.RadGrid_PM TABLE .rgCommandRow TD TD {	BORDER-TOP-WIDTH: 0px;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BORDER-LEFT-WIDTH: 0px;	BORDER-BOTTOM-WIDTH: 0px;	PADDING-BOTTOM: 0px;	PADDING-TOP: 0px;	BORDER-RIGHT-WIDTH: 0px}
    .RadGrid_PM THEAD .rgCommandRow TD {	BORDER-BOTTOM: #688caf 1px solid} 
        body:nth-of-type(1) img[src*="Blank.gif"]{display:none;}
    .RadGrid_PM .rgCommandRow TD {	BORDER-TOP-WIDTH: 0px;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BORDER-LEFT-WIDTH: 0px;	BORDER-BOTTOM-WIDTH: 0px;	PADDING-BOTTOM: 0px;	PADDING-TOP: 0px;	BORDER-RIGHT-WIDTH: 0px}*/
    #ctl00_CPH1_PortfolioOverviewDetails_rdbAssetList {
        display: inline-block;
    }
    
    @media screen and (max-width: 843px) {
        /*.TopMargin {
            padding-top: 67px;
        }*/
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMultipleProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMultipleProjects" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <%-- <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdbAssetList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdbAssetList" />
                    <telerik:AjaxUpdatedControl ControlID="pnlresults" LoadingPanelID="ldpPM"  />
                   
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
</telerik:RadAjaxManagerProxy>

<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr class="ToolBar">
        <td>
          
                <%-- <asp:Label ID="lblSearchAssets" runat="server" Text=" Search Assets" meta:resourcekey="lblSearchAssets"></asp:Label>--%>
                <asp:RadioButtonList ID="rdbAssetList" runat="server" AutoPostBack="true" RepeatDirection="Horizontal" CssClass="RadioCss RadioPadding">
                    <asp:ListItem Text="Portfolio" meta:resourcekey="rdbProjects" Value="Projects"
                        Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Map View" class="NoWrap" meta:resourcekey="rdbMapView" Value="Map"></asp:ListItem>
                </asp:RadioButtonList>
        </td>
        <td>
            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                <Items>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>

<div style="width: 100%;" class="PortfolioView">
    <asp:Panel runat="server" ID="pnlresults">
        <iframe src="ProjectsMapViewFrame.aspx" runat="server" id="ProjectsFrame" visible="false" width="100%" class="PortfolioOverviewIframe" style="background-image: none !important; border: 0px;"></iframe>
        <div class="PMHeader">
            <div class="row" >
                <div class="col-12 ResponsiveMargin TopMargin">
                    <telerik:RadGrid ID="rdgMultipleProjects" Visible="false" runat="server" allow-scroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250"
                        ShowFooter="true" AllowPaging="True" ShowGroupPanel="True" AllowSorting="True" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        GridLines="None">

                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <HeaderContextMenu EnableAutoScroll="true" EnableScreenBoundaryDetection="true" EnableViewState="false"></HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true"
                            DataKeyNames="ProjectId" CommandItemDisplay="Top" UseAllDataFields="true" EnableHeaderContextMenu="true"
                            TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Project Full Name" UniqueName="ProjectName"
                                    SortExpression="ProjectFullName" Groupable="False" DataField="ProjectFullName">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProjectName" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("ProjectFullName") = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Manager" UniqueName="ProjectManager" DataField="ProjectManager"
                                    SortExpression="ProjectManager" GroupByExpression="ProjectManager [GridColumn_ProjectManager] Group By ProjectManager ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProjectManager" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("ProjectManager") = String.Empty, "&nbsp;", Container.DataItem("ProjectManager"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Executive" UniqueName="ProjectExecutive"
                                    SortExpression="ProjectExecutive" DataField="ProjectExecutive" GroupByExpression="ProjectExecutive [GridColumn_ProjectExecutive]  Group By ProjectExecutive ASC">
                                    <%--,SUM(OriginalBudget) TOriginalBudget,SUM(BudgetChanges) TBudgetChanges,SUM(AnticipatedBudget) TAnticipatedBudget,SUM(OriginalCosts) TOriginalCost,SUM(CostsRevisions) TCostRevisions,SUM(AnticipatedCost) TAnticipatedCost,SUM(Variance) TVariance,SUM(Forecasts) TForecast,SUM(ForecastsVariance) TForecastVariance --%>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProjectExecutive" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("ProjectExecutive") = String.Empty, "&nbsp;", Container.DataItem("ProjectExecutive"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Superintendent" UniqueName="Superintendent" DataField="Superintendent"
                                    SortExpression="Superintendent" GroupByExpression="Superintendent [GridColumn_Superintendent] Group By Superintendent ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliSuperintendent" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("Superintendent") = String.Empty, "&nbsp;", Container.DataItem("Superintendent"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Type" UniqueName="ProjectType" SortExpression="ProjectType"
                                    GroupByExpression="ProjectType [GridColumn_ProjectType]  Group By ProjectType ASC" DataField="ProjectType">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProjectType" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("ProjectType") = String.Empty, "&nbsp;", Container.DataItem("ProjectType"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Program" UniqueName="Program" SortExpression="Program" DataField="Program"
                                    GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProgram" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("Program") = String.Empty, "&nbsp;", Container.DataItem("Program"))%>'
                                            NavigateUrl='<%# "~/Programs.aspx?Id=" & CStr(Container.DataItem("ProgramId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Property" UniqueName="Property" DataField="Property"
                                    SortExpression="Property" GroupByExpression="Property [GridColumn_Property] Group By Property ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliProperty" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Country" UniqueName="Country" DataField="Country"
                                    SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliCountry" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="City" UniqueName="City" DataField="City"
                                    SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliCity" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="State" UniqueName="StateKey" SortExpression="StateKey" DataField="StateKey"
                                    GroupByExpression="StateKey [GridColumn_StateKey] Group By StateKey ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliState" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("StateKey") = String.Empty, "&nbsp;", Container.DataItem("StateKey"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="40px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Status" UniqueName="StatusKey" DataField="Status" SortExpression="Status"
                                    GroupByExpression="Status [GridColumn_StatusKey] Group By Status ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliStatus" runat="server" CssClass="NoWrap"
                                            Text='<%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>'
                                            NavigateUrl='<%# "~/Projects.aspx?Id=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <HeaderStyle Width="40px"></HeaderStyle>
                                    <ItemStyle BackColor="White" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Original Budget" UniqueName="OriginalBudget" DataField="OriginalBudget" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="OriginalBudget" GroupByExpression="OriginalBudget [GridColumn_OriginalBudget] Group By OriginalBudget ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliOriginalBudget" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>

                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Budget Changes" UniqueName="BudgetChanges" DataField="BudgetChanges" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="BudgetChanges" GroupByExpression="BudgetChanges [GridColumn_BudgetChanges] Group By BudgetChanges ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliBudgetChanges" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Anticipated Budget" UniqueName="AnticipatedBudget" DataField="AnticipatedBudget" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="AnticipatedBudget" GroupByExpression="AnticipatedBudget [GridColumn_AnticipatedBudget] Group By AnticipatedBudget ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliAnticipatedBudget" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Original Costs" UniqueName="OriginalCosts" DataField="OriginalCommitments" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="OriginalCommitments" GroupByExpression="OriginalCommitments [GridColumn_OriginalCosts] Group By OriginalCommitments ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliOriginalCosts" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Costs Revisions" UniqueName="CostsRevisions" DataField="CommitmentsRevisions" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="CommitmentsRevisions" GroupByExpression="CommitmentsRevisions [GridColumn_CostsRevisions] Group By CommitmentsRevisions ASC">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliCostsRevisions" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Non Commitment Costs" UniqueName="NonCommitmentCosts" DataField="NonCommitmentCosts" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="NonCommitmentCosts" GroupByExpression="NonCommitmentCosts [GridColumn_NonCommitmentCosts] Group By NonCommitmentCosts">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliNonCommitmentCosts" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="115px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Forecasts" UniqueName="Forecasts" DataField="Forecasts" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="Forecasts" GroupByExpression="Forecasts [GridColumn_Forecasts] Group By Forecasts">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliForecasts" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                  <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Anticipated Cost" UniqueName="AnticipatedCost" DataField="AnticipatedCost" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="AnticipatedCost" GroupByExpression="AnticipatedCost [GridColumn_AnticipatedCost] Group By AnticipatedCost">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliAnticipatedCost" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Variance" UniqueName="Variance" SortExpression="Variance" DataField="Variance" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    GroupByExpression="Variance [GridColumn_Variance] Group By Variance">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliVariance" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="95px"></HeaderStyle>
                                </telerik:GridTemplateColumn>



                                <%--   <telerik:GridTemplateColumn HeaderText="Forecasts Variance" UniqueName="ForecastsVariance" DataField="ForecastsVariance" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                    SortExpression="ForecastsVariance" GroupByExpression="ForecastsVariance [GridColumn_ForecastsVariance] Group By ForecastsVariance">
                    <ItemTemplate>
                       <asp:HyperLink ID="hliForecastsVariance" runat="server" CssClass="NoWrap"
                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                    </ItemTemplate>
                    <FooterStyle HorizontalAlign="Right" />
                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                    <HeaderStyle Width="115px"></HeaderStyle>
                </telerik:GridTemplateColumn>--%>

                                <telerik:GridTemplateColumn HeaderText="Actual Costs" UniqueName="ActualCosts" DataField="ActualCosts" Aggregate="Sum" FooterAggregateFormatString="{0:N}"
                                    SortExpression="ActualCosts" GroupByExpression="ActualCosts [GridColumn_ActualCosts] Group By ActualCosts">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliActualCosts" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Cost % <br />Complete" UniqueName="CostPctComplete" DataField="CostPctComplete"
                                    SortExpression="CostPctComplete" GroupByExpression="CostPctComplete [GridColumn_CostPctComplete] Group By CostPctComplete">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliCostPctComplete" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/CostWorksheet.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" BackColor="#edf8fe" BorderColor="#9ab5d0"></ItemStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Physical % <br />Complete" UniqueName="PhysicalPctComplete" DataField="PhysicalPctComplete"
                                    SortExpression="PhysicalPctComplete" GroupByExpression="PhysicalPctComplete [GridColumn_PhysicalPctComplete] Group By PhysicalPctComplete">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliPhysicalPctComplete" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" BackColor="#fefc75" BorderColor="#eec126" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Baseline Start" UniqueName="BaselineStartDate" DataField="BaselineStartDate" Aggregate="Min" FooterAggregateFormatString="{0:ddMMMyy}"
                                    SortExpression="BaselineStartDate" GroupByExpression="BaselineStartDate [GridColumn_BaselineStartDate] Group By BaselineStartDate">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliBaselineStartDate" runat="server" CssClass="NoWrap"
                                            Text='<%#FormatDate(Container.DataItem("BaselineStartDate"))%>'
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="85px"></HeaderStyle>
                                    <ItemStyle BackColor="#fefc75" BorderColor="#eec126" />
                                    <FooterStyle HorizontalAlign="left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Baseline Finish" UniqueName="BaselineFinishDate" DataField="BaselineFinishDate" Aggregate="Max" FooterAggregateFormatString="{0:ddMMMyy}"
                                    SortExpression="BaselineFinishDate" GroupByExpression="BaselineFinishDate [GridColumn_BaselineFinishDate] Group By BaselineFinishDate">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliBaselineFinishDate" runat="server" CssClass="NoWrap"
                                            Text='<%#FormatDate(Container.DataItem("BaselineFinishDate"))%>'
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                    <ItemStyle BackColor="#fefc75" BorderColor="#eec126" />
                                    <FooterStyle HorizontalAlign="left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate" SortExpression="StartDate" DataField="StartDate" Aggregate="Min" FooterAggregateFormatString="{0:ddMMMyy}"
                                    GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliStart" runat="server" CssClass="NoWrap"
                                            Text='<%#FormatDate(Container.DataItem("StartDate"))%>'
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle BackColor="#fefc75" BorderColor="#eec126" />
                                    <FooterStyle HorizontalAlign="left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="FinishDate" SortExpression="FinishDate" DataField="FinishDate" Aggregate="Max" FooterAggregateFormatString="{0:ddMMMyy}"
                                    GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliFinish" runat="server" CssClass="NoWrap"
                                            Text='<%#If(System.Convert.IsDBNull(Container.DataItem("FinishDate")), "&nbsp;",  FormatDate(Container.DataItem("FinishDate")))%>'
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle BackColor="#fefc75" BorderColor="#eec126" />
                                    <FooterStyle HorizontalAlign="left" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Duration" UniqueName="Duration" SortExpression="Duration" DataField="Duration" Aggregate="Sum" FooterAggregateFormatString="{0:D}"
                                    GroupByExpression="Duration [GridColumn_Duration] Group By Duration">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliDuration" runat="server" CssClass="NoWrap"
                                            Text='<%#If(System.Convert.IsDBNull(Container.DataItem("Duration")), "&nbsp;", CStr(Container.DataItem("Duration")))%>'
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" BackColor="#fefc75" BorderColor="#eec126" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Days Late +/-" UniqueName="Days" SortExpression="Days" DataField="Days" Aggregate="Sum" FooterAggregateFormatString="{0:D}"
                                    GroupByExpression="Days [GridColumn_Days] Group By Days">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliDays" runat="server" CssClass="NoWrap"
                                            NavigateUrl='<%# "~/Tasks.aspx?ProjectId=" & CStr(Container.DataItem("ProjectId"))%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" BackColor="#fefc75" BorderColor="#eec126" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn Aggregate="SUM" DataField="OriginalBudget" Visible="False" />
                            </Columns>
                            <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                            <ItemStyle Wrap="false" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <b>
                                        <asp:Label ID="lblProgram" Text="Program" runat="server" meta:ResourceKey="lblProgram"></asp:Label></b>
                                    <telerik:RadComboBox ID="ddlPrograms" Width="205px" runat="server" Height="250px" Style="font-size: 11px"
                                        AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                        NoWrap="True">
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <asp:CheckBox runat="server" ID="chkApply" />
                                                <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply"></asp:Label>
                                                <%#DataBinder.Eval(Container, "Text")%>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <b>
                                        <asp:Label ID="lblProject" Text="Project" meta:ResourceKey="lblProject" runat="server"></asp:Label></b>
                                    <telerik:RadComboBox ID="ddlProjects" Width="205px" runat="server" Height="250px" Style="font-size: 11px"
                                        AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                        NoWrap="True">
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <asp:CheckBox runat="server" ID="chkApply" />
                                                <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply"></asp:Label>
                                                <%#DataBinder.Eval(Container, "Text")%>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <b>
                                        <asp:Label ID="lblCurrency" Text="Currency" runat="server" meta:ResourceKey="lblCurrency"></asp:Label></b>
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100px" AutoPostBack="true"
                                        EmptyMessage="Select Currency" Height="300px" Style="font-size: 11px"
                                        OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        SecurityButtonType="ItemMode" Visible='True'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                        EnableShadows="true" CausesValidation="false"
                                        Visible="true">
                                    </telerik:RadMenu>

                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>

                        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True"></Resizing>
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlSqlReport" Visible="false" runat="server">
            <telerik:RadDockZone runat="server" ID="RadDockZone3" Orientation="vertical" Style="border: 0px; width: 100%;">
                <telerik:RadDock runat="server" meta:resourceKey="rdkSQLReport" ID="rdkSQLReport" Width="100%" EnableAnimation="true" DockMode="Docked" Height="800px">
                    <ContentTemplate>
                        <rsweb:ReportViewer ID="rvSqlReport2" runat="server" ShowParameterPrompts="true" ShowBackButton="true" ShowDocumentMapButton="true"
                            DocumentMapWidth="200" Width="100%" Height="800px" ShowZoomControl="true" AsyncRendering="false" ShowFindControls="true"
                            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" KeepSessionAlive="true">
                        </rsweb:ReportViewer>
                    </ContentTemplate>
                </telerik:RadDock>
            </telerik:RadDockZone>


        </asp:Panel>
        <asp:Panel ID="pnlError" Visible="false" runat="server">
            <table width="100%" cellpadding="2" border="0" style="padding: 5px">
                <tr>
                    <td>
                        <asp:Label ID="lblError" runat="server" meta:resourceKey="lblError" Text="Report could not be loaded" CssClass="Validator"></asp:Label></td>
                </tr>
            </table>

        </asp:Panel>

    </asp:Panel>
</div>
