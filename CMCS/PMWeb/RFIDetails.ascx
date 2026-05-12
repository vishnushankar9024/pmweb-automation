<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RFIDetails.ascx.vb"
    Inherits="Website.RFIDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="LinkedRecordDetails.ascx" TagName="LinkedRecordDetails" TagPrefix="uc1" %>
<table width="100%" cellpadding="2" cellspacing="5" border="0">
    <tr>
        <td width="1%">
            &nbsp;
        </td>
        <td width="24%">
            <asp:Label ID="lblQuestion" meta:resourcekey="lblQuestion" runat="server" Text="Question"></asp:Label>
        </td>
        <td width="24%" align="right">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblDateRequired"  meta:resourcekey="lblDateRequired" runat="server" Text="Date Required"></asp:Label>
                    </td>
                    <td>
                        <span runat="server" id="rmd_dtpDateRequired" style="display:block">
                            <telerik:RadDatePicker ID="dtpDateRequired" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                SelectedDate='<%# Date.Today %>' Width="120px" Skin="Default" Culture="English (United States)"
                                EnableTyping="True">
                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                    runat="server">
                                </DateInput>
                                <Calendar ID="Calendar2"   Skin="Default" runat="server">
                                </Calendar>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
        <td width="1%">
            &nbsp;
        </td>
        <td width="24%">
            <asp:Label ID="lblAnswer" meta:resourcekey="lblAnswer" runat="server" Text="Answer"></asp:Label>
        </td>
        <td width="24%" align="right">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblDateAnswered" meta:resourcekey="lblDateAnswered" runat="server" Text="Date Answered"></asp:Label>
                    </td>
                    <td>
                        <span runat="server" id="rmd_dtpDateAnswered" style="display:block">
                            <telerik:RadDatePicker ID="dtpDateAnswered" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                SelectedDate='<%# Date.Today %>' Width="120px" Skin="Default" Culture="English (United States)"
                                EnableTyping="True">
                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                    runat="server">
                                </DateInput>
                                <Calendar ID="Calendar1"   Skin="Default" runat="server">
                                </Calendar>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
            </table> 
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td colspan="2">
                 <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" Width="99%" Height="200px" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                    ID="edtQuestion" Skin="Default" runat="server" OnClientLoad="Details_OnClientLoad">
                <Content>
                </Content>
                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <TemplateManager ViewPaths="~/Images/Shared"  UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
            </telerik:RadEditor>
        </td>
        <td>
            &nbsp;
        </td>
        <td colspan="2"  >
             <telerik:RadEditor   ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                  Width="99%" Height="200px" DialogsScriptFile="~/JS/RadEditorDialog.js" 
                 ID="edtAnswer" Skin="Default" runat="server" 
                  OnClientLoad="Details_OnClientLoad">
                <Content>
                </Content>
                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <TemplateManager ViewPaths="~/Images/Shared"  UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
            </telerik:RadEditor>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td colspan="2">
       
        </td>
        <td>
            &nbsp;
        </td>
        <td colspan="2">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Label ID="lblEffects" meta:resourcekey="lblEffects"  runat="server" Text="Effects:"></asp:Label>&nbsp;
                        <asp:CheckBox ID="chkScopeofWork" meta:resourcekey="chkScopeofWork"  runat="server" Text="Scope of Work" />&nbsp;
                        <asp:CheckBox ID="chkCost" meta:resourcekey="chkCost" runat="server" Text="Cost" />&nbsp;
                        <asp:CheckBox ID="chkSchedule" meta:resourcekey="chkSchedule" runat="server" Text="Schedule" />&nbsp;
                    </td>
                    <td align="right">
                        <asp:Label ID="lblCENum" meta:resourcekey="lblCENum" runat="server" Text="CE #"></asp:Label>&nbsp;
                        <asp:TextBox ID="txtCENum" runat="server" MaxLength="9" CssClass="PositiveInteger"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
    <td>&nbsp;</td>
     <td colspan="2"> <asp:Label ID="lblProposedSolution" meta:resourcekey="lblProposedSolution" runat="server" Text="Proposed Solution"></asp:Label></td>
    <td>&nbsp;</td>
     <td colspan="2">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Label ID="lblTask" meta:resourcekey="lblTask"  runat="server" Text="Task"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                       &nbsp;&nbsp;
                 
                    <telerik:RadComboBox ID="ddlTasks" runat="server" Width="300px" DropDownWidth="465px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..." 
                            NoWrap="True" AllowCustomText="true" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested" 
                            Style="font-size: 11px" Height="250px" meta:resourcekey="ddlTasks">
                            <HeaderTemplate>
                                <table style="width: 435px" cellspacing="0" cellpadding="0">
                                    <tr>                                                
                                        <td style="width: 275px;">
                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                        <td style="width: 80px;">
                                             <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                        <td style="width: 80px;">
                                             <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                    </tr>
                                </table>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <table style="width: 435px" cellspacing="0" cellpadding="2">
                                    <tr>
                                        <td style="width: 275px;">
                                            <%# DataBinder.Eval(Container, "Text")%>
                                        </td>
                                        <td style="width: 80px;">
                                            <%#DataBinder.Eval(Container, "Attributes['EarlyStartDate']")%>
                                        </td>
                                        <td style="width: 80px;">
                                            <%#DataBinder.Eval(Container, "Attributes['EarlyFinishDate']")%>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                           </td>
                           <td> &nbsp;</td>
                </tr>
            </table>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>

    <tr>
        <td>
            &nbsp;
        </td>
        <td colspan="2" valign="top">
                   <telerik:RadEditor DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml" Width="99%"  Height="200px" ID="edtProposedSolution" Skin="Default" runat="server" OnClientLoad="Details_OnClientLoad">
                <Content>
                </Content>
                <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                <TemplateManager ViewPaths="~/Images/Shared"  UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
                <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                    SearchPatterns="*.*" />
            </telerik:RadEditor>
        </td>
        <td>
            &nbsp;
        </td>
        <td rowspan="2" style="width:100%"  colspan="2" valign="top">
            <fieldset style="width: 98%; height: 100%" runat="server" id="fldsetLinkedRecord" >
                <legend>
                    <asp:Label ID="lblLinkedRecords" meta:resourcekey="lblLinkedRecords" runat="server" Text="Linked Records"></asp:Label>
                </legend>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td width="1%">
                            &nbsp
                        </td>
                        <td style="width: 98%" valign="top">
                            <uc1:LinkedRecordDetails ID="LinkedRecordDetails" runat="server" />
                        </td>
                        <td width="1%">
                            &nbsp
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
        <td rowspan="2">
            &nbsp;
        </td>
    </tr>
</table>