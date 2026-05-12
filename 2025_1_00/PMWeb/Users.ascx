<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Users.ascx.vb" Inherits="Website.Users" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlLicenses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
 

                        <asp:Panel ID="pnlLicenses" runat="server" Style="vertical-align: top">
                            <div class="PMMainPage JustifyContent" style="padding-top:40.81px !important">
                                <div class="row">
                                    <div class="col-4 col-4-left">
                                       
                                                    <fieldset>
                                                        <legend>
                                                            <asp:Label ID="lblLicensedModulesAndTools" runat="server" Text="Licensed Modules & Tools" meta:resourcekey="lblLicensedModulesAndTools" />
                                                        </legend>
                                                        <div style="height: 218px; max-height: 218px; display: block; overflow: auto; border: 1px solid silver;">
                                                            <table style="width: 100%; vertical-align: top; text-align: left;" border="0">
                                                                <tr>
                                                                    <td class="CheckLicense" style="width: 20px">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsEstimatingEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblPlanning" runat="server" meta:resourcekey="lblPlans" CssClass="Bold" Text="Plans"></asp:Label>
                                                                    </td>

                                                                </tr>
                                                                <tr id="trProcurement">
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsProcurementEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblProcurement" runat="server" meta:resourcekey="lblBidPackages" Text="Bid Packages"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsProjectManagementEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>
                                                                    <td >
                                                                        <asp:Label ID="lblProjectManagement" runat="server" meta:resourcekey="lblForms" CssClass="Bold" Text="Forms"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsCostManagementEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblCostManagement" runat="server" meta:resourcekey="lblCosts" CssClass="Bold" Text="Costs"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsSchedulingEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblScheduling" runat="server" meta:resourcekey="lblSchedules" CssClass="Bold" Text="Schedules"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsAssetManagementEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblAssetManagement" runat="server" meta:resourcekey="lblAssets" CssClass="Bold" Text="Assets"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr id="trAssetExplorer">
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsAssetExplorerEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblAssetExplorer" runat="server" meta:resourcekey="lblAssetSearch" Text="Assets Search"></asp:Label>
                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsWorkflowEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblWorkflow" runat="server" meta:resourcekey="lblWorkflows" CssClass="Bold" Text="Workflows"></asp:Label>
                                                                    </td>

                                                                </tr>

                                                                <tr>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsToolboxEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblToolbox" runat="server" meta:resourcekey="lblTools" CssClass="Bold" Text="Tools"></asp:Label>
                                                                    </td>

                                                                </tr>

                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsActivityBoardEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblActivityBoards" runat="server" meta:resourcekey="lblActivityBoards" Text="Activity Boards"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsBIMEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblBIM" runat="server" meta:resourcekey="lblBIM" Text="BIM"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsPMWebViewerEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblDocumentManager" runat="server" meta:resourcekey="lblDocumentManager" Text="Document Manager"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsCustomFormEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblFormBuilder" runat="server" meta:resourcekey="lblFormBuilder" Text="Form Builder"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsIntegrationEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblIntegrations" runat="server" meta:resourcekey="lblIntegrations" Text="Integrations"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsIntegrationEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblIntegrationManager" runat="server" meta:resourcekey="lblIntegrationManager" Text="Integration Manager"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                 <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsLDAPEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblLDAPIntegration" runat="server" meta:resourcekey="lblLDAPIntegration" Text="LDAP Integration"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                  <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsMultiFactorEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblIsMultiFactorEnabled" runat="server" meta:resourcekey="lblIsMultiFactorEnabled" Text="Multi Factor Authentication"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsPMWebViewerEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblPMWebViewer" runat="server" meta:resourcekey="lblPMWebViewer" Text="PMWeb Viewer"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsResourceManagementEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblResourceManagement" runat="server" meta:resourcekey="lblResourceManagement" Text="Resource Management"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsRiskEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblRiskAnalysis" runat="server" meta:resourcekey="lblRiskAnalysis" Text="Risk Analysis"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsSAMLEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblSAMLIntegration" runat="server" meta:resourcekey="lblSAMLIntegration" Text="SAML Integration"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsSTAGEGATEEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblStageGatesManagement" runat="server" meta:resourcekey="lblStageGatesManagement" Text="Stage Gates Management"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsSTAGEGATEEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblStageGate" runat="server" meta:resourcekey="lblStageGate" Text="Stage Gate"></asp:Label>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsTimesheetEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblTimesheets" runat="server" meta:resourcekey="lblTimesheets" Text="Timesheets"></asp:Label>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td ></td>
                                                                    <td class="CheckLicense">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsVendorApproverEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                        <asp:Label ID="lblVendorPrequalification" runat="server" meta:resourcekey="lblVendorPrequal" Text="Vendor Prequal"></asp:Label>
                                                                    </td>
                                                                </tr>                    

                                                                <tr>
                                                                    <td  class="CheckLicense" style="width: 20px">
                                                                        <span class="<%=CStr(IIf(PM.LicenseInfo.IsREVITAPIEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="Label2" runat="server" meta:resourcekey="lblRevit" CssClass="Bold" Text="Revit"></asp:Label>
                                                                    </td>

                                                                </tr>

                                                               



                                                                <%--<tr>
                                        <td class="CheckBox">
                                            <span class="<%=CStr(IIf(PM.LicenseInfo.IsFileBrowserEnabled, "Icon", ""))%>" alt="" style="vertical-align: bottom"></span>
                                        </td>

                                        <td>
                                            <asp:Label ID="lblFileBrowser" runat="server" meta:resourcekey="lblFileBrowser" CssClass="Bold" Text="File Browser"></asp:Label>
                                        </td>
                                    </tr>--%>
                                                            </table>
                                                        </div>
                                                    </fieldset>
                                          
                                                    <fieldset>
                                                <legend>
                                                    <asp:Label ID="lblNbOfProjects" runat="server" Text="Number of Projects" meta:resourcekey="lblNbOfProjects"></asp:Label></legend>
                                                <table style="width: 100%; vertical-align: top;">
                                                    <tr>
                                                        <td style="width: 80px;">
                                                            <asp:Label ID="lblTotalProjects" runat="server" meta:resourcekey="lblTotalProjects" Text="11"></asp:Label>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                        <td style="width: 50px; text-align: left">
                                                            <asp:Label ID="lblTotalProjectsValue" runat="server"></asp:Label>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                        <td style="width: 80px;">
                                                            <asp:Label ID="lblCreatedProjects" runat="server" meta:resourcekey="lblCreatedProjects" Text="11"></asp:Label>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                        <td style="width: 50px; text-align: left">
                                                            <asp:Label ID="lblCreatedProjectsValue" runat="server"></asp:Label>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                        <td style="width: 80px;">
                                                            <asp:Label ID="lblAvailableProjects" runat="server" meta:resourcekey="lblAvailableProjects" Text="11s"></asp:Label>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                        <td style="width: 50px; text-align: left">
                                                            <asp:Label ID="lblAvailableProjectsValue" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                      
                                    </div>
                                    <div class="col-4 col-4-middle">
                                        <table class="colTable">
                                            <tr>
                                                <td>
                                                    <fieldset style="width: 100%;">
                                                        <legend>
                                                            <asp:Label ID="lblNamedUsers" runat="server" Text="Full Users (Named)" meta:resourcekey="lblNamedUsers"></asp:Label></legend>
                                                        <table class="colTable">
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblMaxNamedUsers" runat="server" meta:resourcekey="lblMaxNamedUsers" Text="Total Licenses"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblMaxNamedUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAssignedNamedUsers" runat="server" meta:resourcekey="lblAssignedNamedUsers" Text="lblAssignedNamedUsers"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAssignedNamedUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAvailableNamedUsers" runat="server" meta:resourcekey="lblAvailableNamedUsers" Text="lblAvailableNamedUsers"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAvailableNamedUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td runat="server" id="tdConcurrentUsers">
                                                    <fieldset style="width: 100%;">
                                                        <legend>
                                                            <asp:Label ID="lblConcurrentUsers" runat="server" Text="Full Users (Concurrent)" meta:resourcekey="lblConcurrentUsers"></asp:Label></legend>
                                                        <table class="colTable">
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblMaxConcurrentUsers" runat="server" meta:resourcekey="lblMaxConcurrentUsers" Text="Total Licenses"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblMaxConcurrentUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAssignedConcurrentUsers" runat="server" meta:resourcekey="lblAssignedConcurrentUsers" Text="lblAssignedConcurrentUsers"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAssignedConcurrentUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAvailableConcurrentUsers" runat="server" meta:resourcekey="lblAvailableConcurrentUsers" Text="lblAvailableConcurrentUsers"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAvailableConcurrentUsersValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <fieldset style="width: 100%;">
                                                        <legend>
                                                            <asp:Label ID="lblNamedGuests" runat="server" Text="Guest Users (Named)" meta:resourcekey="lblNamedGuests"></asp:Label></legend>
                                                        <table class="colTable">
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblMaxNamedGuests" runat="server" meta:resourcekey="lblMaxNamedGuests" Text="Total Licenses"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblMaxNamedGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAssignedNamedGuests" runat="server" meta:resourcekey="lblAssignedNamedGuests" Text="lblAssignedNamedGuests"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAssignedNamedGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAvailableNamedGuests" runat="server" meta:resourcekey="lblAvailableNamedGuests" Text="lblAvailableNamedGuests"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAvailableNamedGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <fieldset style="width: 100%;">
                                                        <legend>
                                                            <asp:Label ID="lblConcurrentGuests" runat="server" Text="Guest Users (Concurrent)" meta:resourcekey="lblConcurrentGuests"></asp:Label></legend>
                                                        <table class="colTable">
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblMaxConcurrentGuests" runat="server" meta:resourcekey="lblMaxConcurrentGuests" Text="Total Licenses"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblMaxConcurrentGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAssignedConcurrentGuests" runat="server" meta:resourcekey="lblAssignedConcurrentGuests" Text="lblAssignedConcurrentGuests"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAssignedConcurrentGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblAvailableConcurrentGuests" runat="server" meta:resourcekey="lblAvailableConcurrentGuests" Text="lblAvailableConcurrentGuests"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth" style="text-align: right;">
                                                                    <asp:Label ID="lblAvailableConcurrentGuestsValue" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-4 col-4-right">
                                     
                                                    <fieldset>
                                                        <legend>
                                                            <asp:Label ID="lblLicenses" runat="server" Text="Assigned Licenses By Database" meta:resourcekey="lblLicenses"></asp:Label></legend>
                                                        <telerik:RadGrid ID="rdgLicenses" runat="server" setwidth="true"
                                                            AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8"
                                                             AllowSorting="true" ShowGroupPanel="false">
                                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                                DataKeyNames="DatabaseId" CommandItemDisplay="None" TableLayout="Fixed" >
                                                                <Columns>

                                                                    <telerik:GridTemplateColumn HeaderText="Database" SortExpression="DatabaseName" UniqueName="Database">
                                                                        <ItemTemplate>
                                                                            <%#IIf(Container.DataItem("DatabaseName") = String.Empty, "&nbsp;", Container.DataItem("DatabaseName"))%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                        <HeaderStyle Width="20px" />
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="FullNamed" SortExpression="FullNamed" UniqueName="FullNamed">
                                                                        <ItemTemplate>
                                                                            <%#If(Container.DataItem("FullNamed") Is DBNull.Value, "0", If(Container.DataItem("FullNamed") = "-1", "---", Container.DataItem("FullNamed")))%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        <HeaderStyle Width="20px" />
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="GuestNamed" SortExpression="GuestNamed" UniqueName="GuestNamed">
                                                                        <ItemTemplate>
                                                                            <%#If(Container.DataItem("GuestNamed") Is DBNull.Value, "0", If(Container.DataItem("GuestNamed") = "-1", "---", Container.DataItem("GuestNamed")))%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        <HeaderStyle Width="20px" />
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="FullConcurrent" SortExpression="FullConcurrent" UniqueName="FullConcurrent" Visible="false">
                                                                        <ItemTemplate>
                                                                            <%#If(Container.DataItem("FullConcurrent") Is DBNull.Value, "0", If(Container.DataItem("FullConcurrent") = "-1", "---", Container.DataItem("FullConcurrent")))%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle  HorizontalAlign="Right" />
                                                                        <HeaderStyle Width="20px" />
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="GuestConcurrent" SortExpression="GuestConcurrent" UniqueName="GuestConcurrent">
                                                                        <ItemTemplate>
                                                                            <%#If(Container.DataItem("GuestConcurrent") Is DBNull.Value, "0", If(Container.DataItem("GuestConcurrent") = "-1", "---", Container.DataItem("GuestConcurrent")))%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle  HorizontalAlign="Right" />
                                                                        <HeaderStyle Width="20px" />
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                                <ItemStyle Wrap="false" />
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                                <SortExpressions>
                                                                    <telerik:GridSortExpression FieldName="DatabaseName"></telerik:GridSortExpression>
                                                                </SortExpressions>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <%--  <Scrolling AllowScroll="True" UseStaticHeaders="True" 
                                                 ScrollHeight="90px">
                                            </Scrolling>--%>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </fieldset>
                                         
                                                <fieldset id="apiKeysFieldset" runat="server">
                                                    <legend>
                                                        <asp:Label ID="lblAPIKeys" runat="server" Text="lblAPIKeys" meta:resourcekey="lblAPIKeys"></asp:Label>
                                                    </legend>
                                                    <asp:Repeater ID="rprKeys" runat="server" ItemType="System.string">
                                                        <SeparatorTemplate>
                                                            <br />
                                                        </SeparatorTemplate>
                                                        <ItemTemplate>
                                                            <%# Item %>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </fieldset>
                                      

                                             
                                     
                                                <fieldset style="visibility:hidden">
                                                    <legend>
                                                        <asp:Label ID="lblLicenseExpires" runat="server" Text="lblLicenseExpires" meta:resourcekey="lblLicenseExpires"></asp:Label></legend>
                                                    <span runat="server" id="rmd_dtpDate" style="display: block" oncontextmenu="OpenReminderPropupFromUser()">
                                                        <telerik:RadDatePicker ID="dtpExpiryDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            SelectedDate='<%# Date.Today %>' Width="80px" Skin="Default" Culture="English (United States)"
                                                            EnableTyping="False" DatePopupButton-Visible="false">
                                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                ReadOnly="true" runat="server">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                                </fieldset>
                                 
                                    </div>
                                    
                                    <%--    <td style="width: 180px; height: 165px;" valign="top"></td>
                            <td style="width: 180px; height: 165px;" valign="top"></td>--%>
                               
                                  

                                    
                                </div>
                            </div>
                        </asp:Panel>




<div class="PMHeader" style="padding-top:24px">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgUsers" runat="server" AutoGenerateColumns="False" ShowStatusBar="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                HeaderStyle-Font-Size="8" PageSize="250" AllowPaging="true" AllowFilteringByColumn="true" AllowMultiRowEdit="false" AllowMultiRowSelection="True" allow-scroll="true" ClientSettings-Scrolling-AllowScroll="true"
                AllowSorting="true" ShowGroupPanel="true" UseEditFormInMobile="true" Width="100%" setwidth="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ClientDataKeyNames="Id" DataKeyNames="Id" CommandItemDisplay="Top"
                    InsertItemDisplay="Top" AllowMultiColumnSorting="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image" AllowFiltering="false" Groupable="false">
                            <ItemTemplate>
                                <asp:Image ID="imgImage" runat="server" Height="45px" Width="45px" />
                                &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:FileUpload ID="FileToUploadImage" runat="server" Width="100%" />
                                <telerik:RadUpload ID="FileToUploadImage1" runat="server" CssClass="Hide" Skin="Default" ControlObjectsVisibility="none"
                                    MaxFileInputsCount="1" Visible="true" Width="300px">
                                    <Localization Add="<%$ Resources:PMWeb, RadUploadAdd %>" Clear="<%$ Resources:PMWeb, RadUploadClear %>"
                                        Delete="<%$ Resources:PMWeb, RadUploadDelete %>" Remove="<%$ Resources:PMWeb, RadUploadRemove %>"
                                        Select="<%$ Resources:PMWeb, RadUploadSelect %>" />
                                </telerik:RadUpload>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="ID*" CurrentFilterFunction="Contains" SortExpression="UserName" UniqueName="UserName" DataField="UserName" AutoPostBackOnFilter="true"
                            GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("UserName") = String.Empty, "&nbsp;", Container.DataItem("UserName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUserId" MaxLength="50" runat="server" Text='<%#Eval("UserName")%>' Width="99%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvUserId" runat="server" ControlToValidate="txtUserId" ValidationGroup="Users"
                                        CssClass="Validator" meta:resourcekey="rfv_UserId" ErrorMessage="Required" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revUserName" CssClass="Validator" ValidationGroup="Users" Display="Dynamic" meta:resourcekey="revUserName"
                                        ControlToValidate="txtUserId" runat="server" ValidationExpression="^([A-Za-z0-9]+[A-Za-z0-9@._-]*[A-Za-z0-9]+)$"
                                        ErrorMessage="User ID is not valid">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Contact" CurrentFilterFunction="Contains" SortExpression="Contact" UniqueName="Contact" DataField="FullContact" AutoPostBackOnFilter="true"
                            GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#Container.DataItem("FullContact")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlContacts" runat="server" Width="100%" Filter="Contains"
                                    OnClientSelectedIndexChanged="ddlContact_SelectedIndexChanged" 
                                    MarkFirstMatch="True" Skin="Default" Style="font-size: 11px" OnItemDataBound="ddlContacts_ItemDataBound"
                                    NoWrap="True" Height="150px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Contact..." AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                                <%--<asp:ImageButton ID="btnAddContact" runat="server" ImageUrl="~/Images/Global/AddLine.png" />--%>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="First Name*" CurrentFilterFunction="Contains" SortExpression="FirstName" UniqueName="FirstName" DataField="FirstName" AutoPostBackOnFilter="true"
                            GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("FirstName") = String.Empty, "&nbsp;", Container.DataItem("FirstName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFirstName" MaxLength="50" runat="server" Text='<%#Eval("FirstName")%>' Width="99%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ValidationGroup="Users"
                                        CssClass="Validator" meta:resourcekey="rfv_FirstName" ErrorMessage="Required" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Last Name" CurrentFilterFunction="Contains" SortExpression="LastName" UniqueName="LastName" DataField="LastName" AutoPostBackOnFilter="true"
                            GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("LastName") = String.Empty, "&nbsp;", Container.DataItem("LastName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLastName" MaxLength="50" runat="server" Text='<%#Eval("LastName")%>' Width="99%"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ValidationGroup="Users"
                                CssClass="Validator" ErrorMessage="<br>Enter The LAst Name" Display="Dynamic" ></asp:RequiredFieldValidator>--%>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Company" CurrentFilterFunction="Contains" SortExpression="Company" UniqueName="Company" DataField="Company" AutoPostBackOnFilter="true"
                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#Container.DataItem("Company")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" Filter="Contains" OnItemsRequested="ddl_ItemsRequested" AllowCustomText="true"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..." NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Style="font-size: 11px" Height="250px" DropDownWidth="420px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="License Type*" CurrentFilterFunction="Contains" SortExpression="LicenseType" UniqueName="LicenseType"
                            DataField="LicenseType" AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType"
                            GroupByExpression="LicenseType [GridColumn_LicenseType] Group By LicenseType ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("LicenseType") = String.Empty, "&nbsp;", Container.DataItem("LicenseType"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLicenseTypes" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="false" OnClientSelectedIndexChanged="ResetCombos" OnClientLoad="ddlLicenseTypesLoad" Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:CompareValidator ID="cmpLicenseTypes" runat="server" ControlToValidate="ddlLicenseTypes" ValueToCompare="0" CssClass="Validator"
                                        ErrorMessage="Required" meta:resourcekey="cmp_LicenseTypes" Display="Dynamic" ForeColor="" Operator="GreaterThan" ValidationGroup="Users">
                                    </asp:CompareValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Named License*" CurrentFilterFunction="Contains" SortExpression="TranslatedNamedLic"
                            UniqueName="TransatedNamedLic" DataField="TranslatedNamedLic" DataType="System.String"
                            FilterListOptions="VaryByDataType" GroupByExpression="TranslatedNamedLic [GridColumn_TranslatedNamedLic] Group By TranslatedNamedLic ASC">
                            <ItemTemplate>
                                <asp:Label ID="lblIsNamedLic" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlIsNamedLic" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" Style="font-size: 11px" Height="100px">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:CompareValidator ID="cmpIsNamedLic" runat="server" ControlToValidate="ddlIsNamedLic"
                                        ValueToCompare="0" CssClass="Validator" ErrorMessage="ddlIsNamedLic" meta:resourcekey="cmp_IsNamedLic"
                                        Display="Dynamic" ForeColor="" Operator="GreaterThan" ValidationGroup="Users"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="rfvIsNamedLic" runat="server" ControlToValidate="ddlIsNamedLic"
                                        CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:resourcekey="rfv_IsNamedLic"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Users"></asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="120px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Group Name*" CurrentFilterFunction="Contains" SortExpression="GroupName" UniqueName="GroupName" DataField="GroupName" AutoPostBackOnFilter="true"
                            DataType="System.String" FilterListOptions="VaryByDataType" GroupByExpression="GroupName [GridColumn_Group] Group By GroupName ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("GroupName") = String.Empty, "&nbsp;", Container.DataItem("GroupName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlGroups" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvGroups" runat="server" ControlToValidate="ddlGroups"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources: Warning_Msg_GroupRequired%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Users"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="csvGroups" runat="server" ControlToValidate="ddlGroups"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Users" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources: Warning_Msg_GroupRequired%>">
                                    </asp:CustomValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Password" Groupable="false" UniqueName="Password"
                            AllowFiltering="false">
                            <ItemTemplate>
                               <%# IIf(Container.DataItem("PasswordLength") = 0, "***", CStr(Microsoft.VisualBasic.Strings.StrDup(CInt(Container.DataItem("PasswordLength")), "*")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPassword" MaxLength="128" runat="server" TextMode="Password" onfocus="this.removeAttribute('readonly');"></asp:TextBox>
                                <!--readonly to prevent browser autosaved logins -->
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Email" CurrentFilterFunction="Contains" SortExpression="Email" UniqueName="Email"
                            DataField="Email" AutoPostBackOnFilter="true"
                            GroupByExpression="Email [GridColumn_Email] Group By Email ASC" DataType="System.String">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Email") = String.Empty, "&nbsp;", Container.DataItem("Email"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" MaxLength="50" runat="server" Text='<%#Eval("Email")%>'></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="Users"
                                        CssClass="Validator" ErrorMessage="Required" Display="Dynamic" meta:resourcekey="rfv_Email">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" CssClass="Validator" ErrorMessage="Not valid email"
                                        ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Users" Display="Dynamic" meta:resourcekey="revEmail">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cell" CurrentFilterFunction="Contains" SortExpression="Cell" UniqueName="Cell" DataField="Cell" AutoPostBackOnFilter="true"
                            GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Cell") = String.Empty, "&nbsp;", Container.DataItem("Cell"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCell" MaxLength="50" runat="server" Text='<%#Eval("Cell")%>' Width="99%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="140px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Signature" UniqueName="Signature" AllowFiltering="false" Groupable="false">
                            <ItemTemplate>
                                <asp:Image ID="imgSignature" Height="22px" Width="130px" runat="server" />
                                &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:FileUpload ID="FileToUpload" runat="server" Width="100%" />
                                <telerik:RadUpload ID="FileToUpload1" runat="server" CssClass="Hide" Skin="Default" ControlObjectsVisibility="none"
                                    MaxFileInputsCount="1" Visible="true" Width="300px">
                                    <Localization Add="<%$ Resources:PMWeb, RadUploadAdd %>" Clear="<%$ Resources:PMWeb, RadUploadClear %>"
                                        Delete="<%$ Resources:PMWeb, RadUploadDelete %>" Remove="<%$ Resources:PMWeb, RadUploadRemove %>"
                                        Select="<%$ Resources:PMWeb, RadUploadSelect %>" />
                                </telerik:RadUpload>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="PMWeb Admin" DataField="CanUsePMWebAdmin" AutoPostBackOnFilter="true" SortExpression="CanUsePMWebAdmin" UniqueName="CanUsePMWebAdmin"
                            GroupByExpression="CanUsePMWebAdmin [GridColumn_CanUsePMWebAdmin] Group By CanUsePMWebAdmin ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("CanUsePMWebAdmin"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkCanUsePMWebAdmin" runat="server" Checked='<%#CBool(IIf(Eval("CanUsePMWebAdmin") Is System.DBNull.Value, 0, Eval("CanUsePMWebAdmin")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Inactive" DataField="IsDisabled" AutoPostBackOnFilter="true" SortExpression="IsDisabled" UniqueName="IsDisabled"
                            GroupByExpression="IsDisabled [GridColumn_IsDisabled] Group By IsDisabled ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("IsDisabled"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkInActive" runat="server" Checked='<%#CBool(IIf(Eval("IsDisabled") Is System.DBNull.Value, 0, Eval("IsDisabled")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Activity Boards" DataField="CanUseActivityBoards" AutoPostBackOnFilter="true" SortExpression="CanUseActivityBoards" UniqueName="CanUseActivityBoards"
                            GroupByExpression="CanUseActivityBoards [GridColumn_CanUseActivityBoards] Group By CanUseActivityBoards ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("CanUseActivityBoards"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkCanUseActivityBoards" runat="server" Checked='<%#CBool(IIf(Eval("CanUseActivityBoards") Is System.DBNull.Value, 0, Eval("CanUseActivityBoards")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Microsoft Account Email" CurrentFilterFunction="Contains" SortExpression="MicrosoftAccountEmail" UniqueName="MicrosoftAccountEmail"
                            DataField="MicrosoftAccountEmail" AutoPostBackOnFilter="true"
                            GroupByExpression="MicrosoftAccountEmail [GridColumn_MicrosoftAccountEmail] Group By MicrosoftAccountEmail ASC" DataType="System.String">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("MicrosoftAccountEmail") = String.Empty, "&nbsp;", Container.DataItem("MicrosoftAccountEmail"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMicrosoftAccountEmail" MaxLength="50" runat="server" Text='<%#Eval("MicrosoftAccountEmail")%>'></asp:TextBox>
                                <div>
                                 <%--   <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="Users"
                                        CssClass="Validator" ErrorMessage="Required" Display="Dynamic" meta:resourcekey="rfv_Email">
                                    </asp:RequiredFieldValidator>--%>
                                    <asp:RegularExpressionValidator ID="revMicrosoftAccountEmail" runat="server" ControlToValidate="txtMicrosoftAccountEmail" CssClass="Validator" ErrorMessage="Not valid Microsoft Account email"
                                        ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Users" Display="Dynamic" meta:resourcekey="MicrosoftAccountEmail">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="LDAP User" DataField="IsLDAPUser" AutoPostBackOnFilter="true" SortExpression="IsLDAPUser" UniqueName="IsLDAPUser"
                            GroupByExpression="IsLDAPUser [GridColumn_IsLDAPUser] Group By IsLDAPUser ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("IsLDAPUser"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsLDAPUser" runat="server" Checked='<%#CBool(IIf(Eval("IsLDAPUser") Is System.DBNull.Value, 0, Eval("IsLDAPUser")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Reset MFA" DataField="ResetMFA" AutoPostBackOnFilter="true" SortExpression="ResetMFA" UniqueName="ResetMFA"
                            GroupByExpression="ResetMFA [GridColumn_ResetMFA] Group By ResetMFA ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                               <asp:Button ID="btnResetMFA" runat="server" width="80px" Height="20px" Text="Reset MFA" Visible='<%#IIf(Eval("IsMultiFactorEnabled") And Eval("ResetMFA"), "True", "False")%>' OnClick="btnClick_ResetMFA" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnResetMFA" runat="server" width="80px" Height="20px" Text="Reset MFA" Visible='<%#CBool(Eval("IsMultiFactorEnabled") And IIf(Eval("ResetMFA") Is System.DBNull.Value, 0, Eval("ResetMFA")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                           <telerik:GridTemplateColumn HeaderText="Multi Factor" DataField="IsMultiFactorEnabled" AutoPostBackOnFilter="true" SortExpression="IsMultiFactorEnabled" UniqueName="IsMultiFactorEnabled"
                            GroupByExpression="IsMultiFactorEnabled [GridColumn_IsMultiFactorEnabled] Group By IsMultiFactorEnabled ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("IsMultiFactorEnabled"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsMultiFactorEnabled" runat="server" Checked='<%#CBool(IIf(Eval("IsMultiFactorEnabled") Is System.DBNull.Value, 0, Eval("IsMultiFactorEnabled")))%>' class="mobile-switch" OnCheckedChanged="btnClick_ResetMFA" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="LDAP Path" DataField="LDAPPath" AutoPostBackOnFilter="true" SortExpression="LDAPPath" UniqueName="LDAPPath"
                            GroupByExpression="LDAPPath [GridColumn_LDAPPath] Group By LDAPPath ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("LDAPPath") = String.Empty, "&nbsp;", Container.DataItem("LDAPPath"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLDAPPath" MaxLength="1000" runat="server" Text='<%#Eval("LDAPPath")%>' Width="99%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="LDAP Auth" DataField="LDAPAuthenticationId" AutoPostBackOnFilter="true" SortExpression="LDAPAuthenticationId" UniqueName="LDAPAuthentication"
                            GroupByExpression="LDAPAuthenticationId [GridColumn_LDAPAuthentication] Group By LDAPAuthenticationId ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(GetAuthenticationMethod(Container.DataItem("LDAPAuthenticationId")) = String.Empty, "&nbsp;", GetAuthenticationMethod(Container.DataItem("LDAPAuthenticationId")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlAuthentication" runat="server" Style="width: 99%" AllowCustomText="true">
                                    <Items>
                                    <%--<telerik:RadComboBoxItem Text="--Select--" Value="-1"></telerik:RadComboBoxItem>--%>
                                    <telerik:RadComboBoxItem Text="Anonymous" Value="16"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Delegation" Value="256"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Encryption" Value="2"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="FastBind" Value="32"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="None" Value="0"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="ReadonlyServer" Value="4"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Sealing" Value="128"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Secure" Value="1"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="SecureSocketsLayer" Value="2"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="ServerBind" Value="512"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Signing" Value="64"></telerik:RadComboBoxItem>
                                    </Items>
                       
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="SAML User" DataField="IsSAMLAuthenticated" AutoPostBackOnFilter="true" SortExpression="IsSAMLAuthenticated" UniqueName="IsSAMLAuthenticated"
                            GroupByExpression="IsSAMLAuthenticated [GridColumn_IsSAMLAuthenticated] Group By IsSAMLAuthenticated ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("IsSAMLAuthenticated"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsSAMLAuthenticated" runat="server" Checked='<%#CBool(IIf(Eval("IsSAMLAuthenticated") Is System.DBNull.Value, 0, Eval("IsSAMLAuthenticated")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Password Does Not Expire" DataField="PasswordDoesNotExpire" AutoPostBackOnFilter="true" SortExpression="PasswordDoesNotExpire" UniqueName="PasswordDoesNotExpire"
                            GroupByExpression="PasswordDoesNotExpire [GridColumn_PasswordDoesNotExpire] Group By PasswordDoesNotExpire ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("PasswordDoesNotExpire"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkPasswordDoesNotExpire" runat="server" Checked='<%#CBool(IIf(Eval("PasswordDoesNotExpire") Is System.DBNull.Value, 0, Eval("PasswordDoesNotExpire")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Can Edit Expired Password" DataField="CanEditExpiredPassword" AutoPostBackOnFilter="true" SortExpression="CanEditExpiredPassword" UniqueName="CanEditExpiredPassword"
                            GroupByExpression="CanEditExpiredPassword [GridColumn_CanEditExpiredPassword] Group By CanEditExpiredPassword ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("CanEditExpiredPassword"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkCanEditExpiredPassword" runat="server" Checked='<%#CBool(IIf(Eval("CanEditExpiredPassword") Is System.DBNull.Value, 0, Eval("CanEditExpiredPassword")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="PMWeb app" DataField="CanUsePMWebApp" AutoPostBackOnFilter="true" SortExpression="CanUsePMWebApp" UniqueName="PMWebApp"
                            GroupByExpression="CanUsePMWebApp [GridColumn_PMWebApp] Group By CanUsePMWebApp ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType" ItemStyle-Width="145px">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("CanUsePMWebApp"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkCanUsePMWebApp" runat="server" Checked='<%#CBool(IIf(Eval("CanUsePMWebApp") Is System.DBNull.Value, 0, Eval("CanUsePMWebApp")))%>' class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="145px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                      
                    </Columns>
                    <%--                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="UserName"></telerik:GridSortExpression>
                    </SortExpressions>--%>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Users"
                                SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgUsers.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Users"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgUsers.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgUsers.EditIndexes.Count > 0 Or rdgUsers.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnInactive" CausesValidation="false" CssClass="Hide"
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="Inactive">
                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCopyUser" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmCopyUsers();"
                                SecurityButtonType="ItemMode_Add" CommandName="CopyUser" CssClass="GridCmdCopyUser" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCopyUser" runat="server" Text="Copy Users"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:Button runat="server" ID="btnAddContact" CommandName="NewContact" CausesValidation="false"
                                CssClass="Hide" />
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowDblClick="RowDblClick"
                    AllowDragToGroup="True" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="true" />
                    <ClientEvents OnRowSelected="Users_OnRowSelected" />
                </ClientSettings>

                <%-- <ValidationSettings ValidationGroup="Users" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />--%>
            </telerik:RadGrid>

</div>
        </div>
    </div>
