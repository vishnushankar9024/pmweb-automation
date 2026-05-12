<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Companies_Import.aspx.vb" Inherits="Website.Companies_Import" Title="Import Companies" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .rfdSkinnedButton {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="scPM" runat="server" EnablePageHeadUpdate="False">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="pnl2">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnl2" LoadingPanelID="ldpPM2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="pnl3">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnl3" LoadingPanelID="ldpPM2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM2" runat="server" Skin="Default" />


        <asp:Panel ID="pnlMain" runat="server">
            <asp:Panel ID="pnl1" runat="server">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblfile" Text="File" runat="server" meta:resourcekey="lblfile"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFileName" Text="File Name" runat="server" meta:resourcekey="lblFileName"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPath" ReadOnly="True" Width="100%" runat="server"></asp:TextBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:FileUpload ID="FileToUpload" runat="server" Width="100%"></asp:FileUpload>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload"
                                                meta:resourcekey="btnUpload" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 Margins">
                            <telerik:RadGrid ID="RDG1" Width="100%" runat="server" setwidth="true"
                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>

                                        <telerik:GridTemplateColumn DataField="TableName" HeaderText="PMWeb Table"
                                            UniqueName="PMWebTableName">
                                            <ItemTemplate>
                                                <%#Container.DataItem("TableName")%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="300px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="FieldName" HeaderText="PMWeb Field" UniqueName="PMWebFieldName">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("FieldName") = String.Empty, "&nbsp;", Container.DataItem("FieldName") & IIf(Container.DataItem("Required") = True, "&nbsp; *", ""))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="300px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Import File Field" UniqueName="FieldName">
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlExcelFields" runat="server" Width="200px" AllowCustomText="true">
                                                </telerik:RadComboBox>


                                                <asp:RequiredFieldValidator ID="cmvExcelField" meta:Resourcekey="rfvExcelField" runat="server" Style="float: unset !important"
                                                    ControlToValidate="ddlExcelFields" CssClass="Validator" InitialValue=""
                                                    Display="Dynamic" ForeColor="" Enabled='<%#Container.DataItem("Required")%>'>
                                                </asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <HeaderStyle Width="300px" />

                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="SaveMapping" CssClass="GridCmdSaveMapping">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Save" meta:resourcekey="lblUpdateRecords"></asp:Label>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelImport" CssClass="GridCmdCancelImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancel"></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnl2" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 Margins">

                            <telerik:RadGrid ID="RDG3" runat="server" AllowPaging="true" PageSize="20" setwidth="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="ImportRows" CssClass="GridCmdImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblImportRecords" runat="server" Text="Import" meta:resourcekey="lblImportRecords"></asp:Label>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelImport" CssClass="GridCmdCancelImport">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancel"></asp:Label>
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>

                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnl3" runat="server">

                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblImportResults" Text="Import Results" runat="server" meta:resourcekey="lblImportResults"></asp:Label>
                                </legend>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCompanies" Text="Companies" runat="server" meta:resourcekey="lblCompanies"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedCompanies" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf1" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumCompanies" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddresses" Text="Addresses" runat="server" meta:resourcekey="lblAddresses"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedAddresses" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf2" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumAddresses" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContacts" Text="Contacts" runat="server" meta:resourcekey="lblContacts"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:Label ID="lblTotalNumImportedContacts" Text="" runat="server"></asp:Label>&nbsp;
                                                  <asp:Label ID="lblOf3" Text="Of" runat="server" meta:resourcekey="lblOf"></asp:Label>&nbsp;
                                                   <asp:Label ID="lblTotalNumContacts" Text="" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>

                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="RDG4" runat="server" AllowPaging="true" PageSize="10" setwidth="true"
                                AutoGenerateColumns="True" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="none" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                            </telerik:RadGrid>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnFinish" runat="server" CausesValidation="False" Text="Finish"
                                            meta:resourcekey="btnFinish" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

            </asp:Panel>
        </asp:Panel>
    </form>
</body>
</html>
