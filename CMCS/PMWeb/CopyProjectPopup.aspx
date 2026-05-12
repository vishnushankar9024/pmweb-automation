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

        function CheckOthers(chk) {
            if (chk.checked) {
                //$("input[type='checkbox'][Id$=chkPeriod]").attr('checked', true);
                $("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl06_chkRecordType]").attr('checked', true);

                //$("input[type='checkbox'][Id$=chkCostCode]").attr('checked', true);
                $("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl05_chkRecordType]").attr('checked', true);
            }
            SelectPrimaryParent(chk);
            return false;
        }

        function CheckContract(chk) {
            if (chk.checked) {
                //$("input[type='checkbox'][Id$=chkContracts]").attr('checked', true);
                $("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl18_chkRecordType]").attr('checked', true);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function CheckCommitment(chk) {
            if (chk.checked) {
                //$("input[type='checkbox'][Id$=chkCommitment]").attr('checked', true);
                $("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl19_chkRecordType]").attr('checked', true);
            }
            SelectSecondaryParent(chk);
            return false;

        }
        function UnceckContractCO(chk) {
            if (!chk.checked) {
                //$("input[type='checkbox'][Id$=chkContractCo]").attr('checked', false);
                $("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl24_chkRecordType]").attr('checked', false);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function UnceckCommitmentCO(chk) {
            if (!chk.checked) {
                //$("input[type='checkbox'][Id$=chkCommitentCo]").attr('checked', false);
                $("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl25_chkRecordType]").attr('checked', false);
            }
            SelectSecondaryParent(chk);
            return false;
        }

        function UncheckOthers(chk) {
            if (!chk.checked) {
                //$("input[type='checkbox'][Id$=chkBudget]").attr('checked', false);
                $("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl07_chkRecordType]").attr('checked', false);
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
            //            if ($("input[type='checkbox'][Id$=chkFunding]").is(':checked'))
            //                message = message + funding;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl04_chkRecordType]").is(':checked')) //chkProject
                message1 = message1 + ',' + project;

            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl07_chkRecordType]").is(':checked'))  //chkBudget
                message1 = message1 + ',' + budget;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl05_chkRecordType]").is(':checked'))    //chkCostCode
                message1 = message1 + ',' + costCode;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl06_chkRecordType]").is(':checked'))  //chkPeriod
                message1 = message1 + ',' + period;
            //            if ($("input[type='checkbox'][Id$=chkEstimate]").is(':checked'))
            //                message = message + '<br/>' + estimate;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl08_chkRecordType]").is(':checked'))    //chkSchedule
                message1 = message1 + ',' + schedule;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl09_chkRecordType]").is(':checked'))    //chkProjectCodes
                message1 = message1 + ',' + projectcode;
            if ($("input[type='checkbox'][Id$=rdgPrimaryRecords_ctl00_ctl11_chkRecordType]").is(':checked'))  //chkDocumentManagerFolderStructure
                message1 = message1 + ',' + FolderStructure;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl04_chkRecordType]").is(':checked')) //chkRFI
                message1 = message1 + ',' + RFI;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl10_chkRecordType]").is(':checked')) //chkDrawingSets
                message1 = message1 + ',' + DrawingSets;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl16_chkRecordType]").is(':checked'))   //chkBudgetRequest
                message1 = message1 + ',' + BudgetRequest;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl22_chkRecordType]").is(':checked'))  //chkFundingRecords
                message1 = message1 + ',' + FundingRecords;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl05_chkRecordType]").is(':checked'))    //chkOnlineSubmittals
                message1 = message1 + ',' + OnlineSubmittals;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl11_chkRecordType]").is(':checked')) //chkDailyReport
                message1 = message1 + ',' + DailyReport;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl17_chkRecordType]").is(':checked'))  //chkJournalentries
                message1 = message1 + ',' + Journalentries;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl23_chkRecordType]").is(':checked'))  //chkFundingRequest
                message1 = message1 + ',' + FundingRequest;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl06_chkRecordType]").is(':checked'))  //chkSubmittalItems
                message1 = message1 + ',' + SubmittalItems;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl12_chkRecordType]").is(':checked'))   //chkPunchList
                message1 = message1 + '<br/>' + PunchList;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl18_chkRecordType]").is(':checked'))   //chkContracts
                message1 = message1 + ',' + Contracts;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl24_chkRecordType]").is(':checked'))  //chkContractCo
                message1 = message1 + ',' + ContractCo;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl07_chkRecordType]").is(':checked'))    //chkSubmittalSet
                message1 = message1 + ',' + SubmittalSet;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl13_chkRecordType]").is(':checked'))    //chkTransmittals
                message1 = message1 + ',' + Transmittals;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl19_chkRecordType]").is(':checked'))  //chkCommitment
                message1 = message1 + ',' + Commitment;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl25_chkRecordType]").is(':checked')) //chkCommitentCo
                message1 = message1 + ',' + CommitentCo;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl08_chkRecordType]").is(':checked'))  //chkMeetingMinutes
                message1 = message1 + ',' + MeetingMinutes;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl14_chkRecordType]").is(':checked')) //chkActionItems
                message1 = message1 + ',' + ActionItems;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl20_chkRecordType]").is(':checked'))    //chkChangeEvents
                message1 = message1 + ',' + ChangeEvents;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl26_chkRecordType]").is(':checked'))    //chkFundingAuthorization
                message1 = message1 + ',' + FundingAuthorization;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl09_chkRecordType]").is(':checked')) //chkDrawingList
                message1 = message1 + ',' + DrawingList;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl15_chkRecordType]").is(':checked'))  //chkCorrespondence
                message1 = message1 + ',' + Correspondence;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl21_chkRecordType]").is(':checked'))    //chkMiscInvoices
                message1 = message1 + ',' + MiscInvoices;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl28_chkRecordType]").is(':checked'))    //chkActivityBoard
                message1 = message1 + ',' + ActivityBoard;
            if ($("input[type='checkbox'][Id$=rdgSecondaryRecords_ctl00_ctl28_chkRecordType]").is(':checked'))    //chkEstimates
                message1 = message1 + ',' + Estimates;

            if (message1.indexOf(",") == 0) {
                message1 = '<br/>' + message1.substring(1);
            }
            message = message + message1 + '<br/><br/>' + conclusion;

            radconfirm(message, function (arg) { if (arg) { $("[id$=btnSave]").click(); } }, 400, 300, null, confirmTitle);



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
      <%--  <script type="text/javascript">
            window.blockConfirm = function (text, mozEvent, oWidth, oHeight, callerObj, oTitle) {
                var ev = mozEvent ? mozEvent : window.event; //Moz support requires passing the event argument manually 
                //Cancel the event 
                ev.cancelBubble = true;
                ev.returnValue = false;
                if (ev.stopPropagation) ev.stopPropagation();
                if (ev.preventDefault) ev.preventDefault();
                //Determine who is the caller 
                var callerObj = $("[id$=btnSave]")// ev.srcElement ? ev.srcElement : ev.target;
                if (callerObj) {
                    //Show the confirm, then when it is closing, if returned value was true, automatically call the caller's click method again. 
                    var callBackFn = function (arg) {
                        if (arg) {
                            callerObj["onclick"] = "";
                            if (callerObj.click) callerObj.click(); //Works fine every time in IE, but does not work for links in Moz 
                            else if (callerObj.tagName == "A") //We assume it is a link button! 
                            {
                                try {
                                    eval(callerObj.href)
                                }
                                catch (e) { }
                            }
                        }
                    }

                    radconfirm(text, callBackFn, oWidth, oHeight, callerObj, oTitle);
                }
                return false;
            }
            //         function confirmCallBackFn(arg) {
            //  
            //             if (arg) {

            //                 __doPostBack($("[id$=btnSave]")[0].id);
            //                
            //             }
            //             
            //         }

        </script>--%>


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
