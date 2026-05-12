<%@ Page Language="vb" meta:Resourcekey="Page" Title="Copy Project" AutoEventWireup="false" CodeBehind="CopyProjectPopup.aspx.vb" Inherits="Website.CopyProjectPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script language="javascript" type="text/javascript">

        function ValidateCombo(source, args) {

            args.IsValid = false;
            var combo = $find(source.controltovalidate);
            if (combo != null) {
                var text = combo.get_text();
                if (text.length < 1) {
                    args.IsValid = false;
                }
                else {
                    var value = combo.get_value();
                    if (value >= 0 && value != '') {
                        args.IsValid = true;
                    }
                    else {
                        args.IsValid = false;
                    }
                }
            }
            else
                args.IsValid = true;
        }

        function getPrimaryCheckbox(RecordName) {
          return  $("[id$=rdgPrimaryRecords] .rgDataDiv tr").filter(function () {
                var recordCell = $(this).find("[id$=hdnCheckId]");
              return recordCell.length && recordCell.val().trim() === RecordName;
            }).find("input[type='checkbox'][id$='chkRecordType']")
        }

        function getSecondaryCheckbox(RecordName) {
            return $("[id$=rdgSecondaryRecords] .rgDataDiv tr").filter(function () {
                var recordCell = $(this).find("[id$=hdnCheckId]");
                return recordCell.length && recordCell.val().trim() === RecordName;
            }).find("input[type='checkbox'][id$='chkRecordType']")
        }

        function CheckOthers(chk) {
            if (chk.checked) {
                getPrimaryCheckbox('chkPeriod').prop("checked", true);
                getPrimaryCheckbox('chkCostCode').prop("checked", true);
            }
            SelectPrimaryParent(chk);
            return false;
        }

        function CheckContract(chk) {
            if (chk.checked) {
                getSecondaryCheckbox('chkContracts').prop("checked", true);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function CheckCommitment(chk) {
            if (chk.checked) {
                getSecondaryCheckbox('chkCommitment').prop("checked", true);
            }
            SelectSecondaryParent(chk);
            return false;

        }
        function UnceckContractCO(chk) {
            if (!chk.checked) {
                getSecondaryCheckbox('chkContractCo').prop("checked", false);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function UnceckCommitmentCO(chk) {
            if (!chk.checked) {
                getSecondaryCheckbox('chkCommitentCo').prop("checked", false);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function UncheckOthers(chk) {
            if (!chk.checked) {
                getPrimaryCheckbox('chkBudget').prop("checked", false);
            }
            SelectPrimaryParent(chk);
            return false;
        }

        function CreateRecords() {
            var comboBox = $find("<%=ddlProject.ClientID%>");// $find($("[id$=ddlProject]")[0].id);
            var validate = true;
            if (comboBox != null) {
                if (comboBox.get_value() != "0" && comboBox.get_value() != "") {
                    validate = true;
                }
                else
                    validate = false;

                if (validate == false) {
                    alert(ProjectRequired)
                    return false;
                }

            }

            var introduction = varContinue + '<br/><br/>' + ifContinue;

            var message = introduction + '<br/><br/>';
            var message1 = '';

          

            $("[id$=rdgPrimaryRecords] input[type='checkbox'][id$=chkRecordType]:checked").each(function () {
                var recordName = $(this).closest("tr").find("[id$=hdnCheckId]").val().trim();
                message1 = appendMessage(message1, recordName);
            });

            $("[id$=rdgSecondaryRecords] input[type='checkbox'][id$=chkRecordType]:checked").each(function () {
                var recordName = $(this).closest("tr").find("[id$=hdnCheckId]").val().trim();
                message1 = appendMessage(message1, recordName);
            });
           
            if (message1.indexOf(",") == 0) {
                message1 = '<br/>' + message1.substring(1);
            }
            message = message + message1 + '<br/><br/>' + conclusion;

            radconfirm(message, function (arg) { if (arg) { $("[id$=btnSave]").click(); } }, 400, 300, null, confirmTitle);



        }


        function appendMessage(message1,recordName) {
            switch (recordName) {
                case "chkProject":
                    message1 = message1 + ',' + project;
                    break;
                case "chkBudget":
                    message1 = message1 + ',' + budget;
                    break;
                case "chkCostCode":
                    message1 = message1 + ',' + costCode;
                    break;
                case "chkPeriod":
                    message1 = message1 + ',' + period;
                    break;
                case "chkSchedule":
                    message1 = message1 + ',' + schedule;
                    break;
                case "chkProjectCodes":
                    message1 = message1 + ',' + projectcode;
                    break;
                case "chkDocumentManagerFolderStructure":
                    message1 = message1 + ',' + FolderStructure;
                    break;
                case "chkRFI":
                    message1 = message1 + ',' + RFI;
                    break;
                case "chkDrawingSets":
                    message1 = message1 + ',' + DrawingSets;
                    break;
                case "chkBudgetRequest":
                    message1 = message1 + ',' + BudgetRequest;
                    break;
                case "chkFundingRecords":
                    message1 = message1 + ',' + FundingRecords;
                    break;
                case "chkOnlineSubmittals":
                    message1 = message1 + ',' + OnlineSubmittals;
                    break;
                case "chkDailyReport":
                    message1 = message1 + ',' + DailyReport;
                    break;
                case "chkJournalentries":
                    message1 = message1 + ',' + Journalentries;
                    break;
                case "chkFundingRequest":
                    message1 = message1 + ',' + FundingRequest;
                    break;
                case "chkSubmittalItems":
                    message1 = message1 + ',' + SubmittalItems;
                    break;
                case "chkPunchList":
                    message1 = message1 + '<br/>' + PunchList;
                    break;
                case "chkContracts":
                    message1 = message1 + ',' + Contracts;
                    break;
                case "chkContractCo":
                    message1 = message1 + ',' + ContractCo;
                    break;
                case "chkSubmittalSet":
                    message1 = message1 + ',' + SubmittalSet;
                    break;
                case "chkTransmittals":
                    message1 = message1 + ',' + Transmittals;
                    break;
                case "chkCommitment":
                    message1 = message1 + ',' + Commitment;
                    break;
                case "chkCommitentCo":
                    message1 = message1 + ',' + CommitentCo;
                    break;
                case "chkMeetingMinutes":
                    message1 = message1 + ',' + MeetingMinutes;
                    break;
                case "chkActionItems":
                    message1 = message1 + ',' + ActionItems;
                    break;
                case "chkChangeEvents":
                    message1 = message1 + ',' + ChangeEvents;
                    break;
                case "chkFundingAuthorization":
                    message1 = message1 + ',' + FundingAuthorization;
                    break;
                case "chkDrawingList":
                    message1 = message1 + ',' + DrawingList;
                    break;
                case "chkCorrespondence":
                    message1 = message1 + ',' + Correspondence;
                    break;
                case "chkMiscInvoices":
                    message1 = message1 + ',' + MiscInvoices;
                    break;
                case "chkActivityBoard":
                    message1 = message1 + ',' + ActivityBoard;
                    break;
                case "chkEstimates":
                    message1 = message1 + ',' + Estimates;
                    break;
                default:
                    // Optional: handle unknown recordName
                    break;
            }
            return message1;
        }
        function maintoolbarClick(sender, args) {
            args.set_cancel(true);
            if ((args.get_item().get_commandName() == 'Save')) {
                CreateRecords();
            } else if ((args.get_item().get_commandName() == 'Cancel')) {
                close();
            }
            return false;
        }


        function pageLoad() {
            //CheckParentBox();
        }

        function CheckParentBox() {
            var rdgRights = $("div[id$='rdgSecondaryRecords']");
            var ParentIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkRecordType") > 0)
                            ParentIsNotChecked = false;
                    }
                }
                i++;
            });

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;

            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }

            }
        }

        function SelectPrimaryParent(chk) {
            var rdgRights = $("div[id$='rdgPrimaryRecords']");
            var chkPArent;
            chkPArent = rdgRights.find("input[type='checkbox']")[0];
            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i != 0) {
                    if (chk.checked) {
                        if (!this.checked && !this.disabled) {
                            if (this.id.indexOf('chkRecordType') > 0)
                                isChecked = false;
                        }
                    }
                }
                i++;
            });

            if (!chk.checked) {
                chkPArent.checked = false;

            } else {
                chkPArent.checked = isChecked;
            }

            return false;
        }

        function AllPrimaryRecordsCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgPrimaryRecords']");
            var j = 0;
            var k = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkRecordType") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });

        }

        function SelectSecondaryParent(chk) {
            var rdgRights = $("div[id$='rdgSecondaryRecords']");
            var chkPArent;
            chkPArent = rdgRights.find("input[type='checkbox']")[0];
            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i != 0) {
                    if (chk.checked) {
                        if (!this.checked && !this.disabled) {
                            if (this.id.indexOf('chkRecordType') > 0)
                                isChecked = false;
                        }
                    }
                }
                i++;
            });

            if (!chk.checked) {
                chkPArent.checked = false;

            } else {
                chkPArent.checked = isChecked;
            }

            return false;
        }

        function AllSecondaryRecordsCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgSecondaryRecords']");
            var j = 0;
            var k = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkRecordType") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });

        }
    </script>

</telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar"  OnClientButtonClicking="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDone" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row R3Cols">
                <div class="col-4 col-4-left">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblFrom" Text="From"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="Label1" runat="server" meta:resourcekey="lblFromDatabase" Text="Database"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtFromDatabase" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProgram" runat="server" meta:resourcekey="lblProgram" Text="Program"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProgram" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProjectId" runat="server" meta:resourcekey="lblProjectId" Text="Project ID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProjectId" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName" Text="Name"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtName" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrency" Text="Currency"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCurrency" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblToProjectDa" runat="server" Text="To" meta:Resourcekey="lblToProjectDa"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblToDatabase" runat="server" meta:resourcekey="lblToDatabase" Text="Database"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox Skin="Default" AutoPostBack="true" ID="ddlToDatabase" runat="server">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdleftOptions" runat="server" class="labelWidth">&nbsp;</td>
                                <td runat="server" id="tdOptions" class="controlWidth">
                                    <asp:RadioButtonList ID="rblNewProjectOption" AutoPostBack="true" CssClass="RadioCss RadioPadding"
                                        runat="server" RepeatLayout="Table">
                                        <asp:ListItem Selected="True" Text="Create New Project" Value="NewProject" meta:resourcekey="rblCreateNewProjectOption_NewProject"></asp:ListItem>
                                        <asp:ListItem meta:resourcekey="rblAppendNewProjectOption_ExistingProject" Text="Append To Existing Project" Value="ExistingProject"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" ID="lblToProjectID" meta:resourcekey="lblID" Text="ID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtToProjectId" ReadOnly="true" runat="server" Text="" Width="100%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" ID="lblToProjectName" meta:resourcekey="lblToProjectName" Text="Name"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtToProjectName" ReadOnly="true" runat="server" Text="" Width="100%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" Visible="false" ID="lblToProject" Text="To Project"></asp:Label>
                                </td>
                                <td align="right" class="controlWidth">
                                    <telerik:RadComboBox ID="ddlProject" runat="server" EmptyMessage="<%$Resources:CostManagement, WarningMsg_RequiredProject %>"
                                        Skin="Default" Width="200px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                        DropDownWidth="300px" CausesValidation="False" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>

                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <table class="colTable">
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnSave" CssClass="Hide" runat="server" ValidationGroup="Save" Text="<%$ Resources:PMWeb, CopyRecords %>"></asp:Button>
                                
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblPrimaryRecords" runat="server" meta:resourcekey="lblPrimaryRecords" Text="Primary Records"></asp:Label>
                        </legend>
                        <telerik:RadGrid ID="rdgPrimaryRecords" runat="server" Height="100%" AllowPaging="false" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="false"
                            AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="CheckId, RecordType, Resource" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="48px">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" onClick="AllPrimaryRecordsCheckClicked(this)" runat="server" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRecordType" onclick="SelectPrimaryParent(this)" CssClass="mobile-switch" Checked="true" runat="server" />
                                            <asp:HiddenField ID="hdnCheckId" runat="server"  Value='<%# Eval("CheckId") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Height="20px" />
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Record Type" UniqueName="RecordType" Groupable="False">
                                        <ItemTemplate>
                                            <%#  PM.LanguagesInfo.GlobalResource(Eval("Resource"))%>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ItemStyle Wrap="false" />
                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                    <table class="colTable" border="0" style="padding-top: 5px;">
                        <tr>
                            <td class="labelWidthChkBox">
                                <asp:Label ID="lblBudgetDates" runat="server" Text="Copy Schedule Dates To Budget" meta:Resourcekey="chkDatesBudget" ></asp:Label>
                                <div style="float:right">
                                    <asp:CheckBox CssClass="mobile-switch" Checked="true" runat="server" ID="chkBudgetDates"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <asp:Label ID="lblBudgetTasks" runat="server" Text="Copy Schedule Tasks To Budget" meta:Resourcekey="chkTaskBudget" ></asp:Label>
                                <div style="float:right">
                                    <asp:CheckBox CssClass="mobile-switch" Checked="true" runat="server" ID="chkBudgetTasks"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblSecondaryRecords" runat="server" meta:resourcekey="lblSecondaryRecords" Text="Secondary Records"></asp:Label>
                        </legend>
                        <telerik:RadGrid ID="rdgSecondaryRecords" runat="server" Height="100%" AllowPaging="false" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="48"
                            AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="CheckId, RecordType, Resource" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="48px">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" onClick="AllSecondaryRecordsCheckClicked(this)" runat="server" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRecordType" onclick="SelectSecondaryParent(this)" CssClass="mobile-switch" Checked="false" runat="server" />
                                            <asp:HiddenField ID="hdnCheckId" runat="server"  Value='<%# Eval("CheckId") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Height="20px" />
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Record Type" UniqueName="RecordType" Groupable="False">
                                        <ItemTemplate>
                                            <%#  GetLocalResourceObject(Eval("Resource"))%>&nbsp;
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ItemStyle Wrap="false" />
                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </div>

            </div>
        </div>




        <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
