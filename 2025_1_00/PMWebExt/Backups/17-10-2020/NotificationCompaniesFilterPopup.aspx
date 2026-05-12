<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="NotificationCompaniesFilterPopup.aspx.vb" Inherits="Website.NotificationCompaniesFilterPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="NotificationBiddersFilter.ascx" tagname="NotificationBidders" tagprefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body >
    <form id="form1" runat="server"  >
    <script type="text/javascript">
        function FillOnlineChangeRequestCompanies(sender, eventArgs) {
            var combo = window.opener.$find(querySt('ddlId'));
            var Control = window.opener.document.getElementById(querySt('ControlId'));
            var ddlvalue = eventArgs.getDataKeyValue("Id");
            ddltext = eventArgs.getDataKeyValue("Company");
            if (combo != null && Control != null) {
                Control.value = ddlvalue;
            }
            else {
                Control.value = "0";
            }
            window.close();
            $(window.opener.document).find("input[id$=btnFillCompanies]").click();
            return false;
        }

        function RowClick(sender, eventArgs) {
            var ddlvalue = eventArgs.getDataKeyValue("Id")
            if (querySt('Source') == 'OnlineChangeRequest') {
                return FillOnlineChangeRequestCompanies(sender, eventArgs);
            }
            if (querySt('Source') == 'Notification') {
                var Comp = eventArgs.getDataKeyValue("Company");
                var Cont = eventArgs.getDataKeyValue("Contact");
                var Email = eventArgs.getDataKeyValue("Email");
                var txtFullContact = window.opener.document.getElementById(querySt('txtFullContact'));
                var txtContact = window.opener.document.getElementById(querySt('txtContact'));
                var txtEmail = window.opener.document.getElementById(querySt('txtEmail'));
                var txtIds = window.opener.document.getElementById(querySt('txtIds'));

                if (txtContact != null && txtEmail != null && txtIds != null) {
                    txtFullContact.value = Cont + ' ' + '[' + Comp + ']';
                    txtContact.value = Cont;
                    txtEmail.value = Email;
                    txtIds.value = ddlvalue;
                }
                window.close();
                return false;
            }


            var ddltext = ''
            if (querySt('Type') == 'Companies') {
                ddltext = eventArgs.getDataKeyValue("Company");
            }
            else {
                ddltext = eventArgs.getDataKeyValue("ContactText");
            }
            var combo = window.opener.$find(querySt('ddlId'));
            var Control = window.opener.document.getElementById(querySt('ControlId'));
            if (combo != null && Control != null) {
                combo.trackChanges();
                combo.set_text(ddltext);
                combo.set_value(ddlvalue);
                combo.commitChanges();
                Control.value = ddlvalue;
                window.opener.setdirty();
            }
            window.close();
            return false;
        }


        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }

        var gridId = "RadContentPane";
        function isMouseOverGrid(target) {
            parentNode = target;
            while (parentNode != null) {
                if (parentNode.id == gridId) {
                    return parentNode;
                }
                parentNode = parentNode.parentNode;
            }

            return null;
        }


        function onNodeDragging(sender, args) {
            var target = args.get_htmlElement();

            if (!target) return;

            if (target.tagName == "INPUT") {
                target.style.cursor = "hand";
            }

            var grid = isMouseOverGrid(target);
            if (grid) {
                grid.style.cursor = "hand";
            }
        }


        function droppedOnGrid(args) {
            var target = args.get_htmlElement();

            while (target) {
                if (target.id == gridId) {
                    args.set_htmlElement(target);
                    return;
                }

                target = target.parentNode;
            }
            args.set_cancel(true);
        }


        function onNodeDropping(sender, args) {
            if (droppedOnGrid(args)) return;
        }
        function SaveMergeMultiple(ContactEmails) {
            var txtEmail = window.opener.document.getElementById(querySt('txtEmail'));
            txtEmail.value = ContactEmails;
            window.close();
            return false;
        }


        function SaveNotificationMultiple(ContactIds, ContactNames, ContactEmails) {

            var txtContact = window.opener.document.getElementById(querySt('txtContact'));
            var txtEmail = window.opener.document.getElementById(querySt('txtEmail'));
            var txtIds = window.opener.document.getElementById(querySt('txtIds'));
            var currentIds = ''
            var currentEmail = '';
            var currentComp = '';
            if (txtContact != null && txtEmail != null && txtIds != null) {
                currentIds = txtIds.value;
                currentEmail = txtEmail.value;
                currentComp = txtContact.value;
                if (currentIds != '')
                    currentIds = currentIds + ';' + ContactIds;
                else
                    currentIds = ContactIds;
                if (currentEmail != '')
                    currentEmail = currentEmail + ';' + ContactEmails;
                else
                    currentEmail = ContactEmails;

                if (currentComp != '')
                    currentComp = currentComp + '\n' + ContactNames;
                else
                    currentComp = ContactNames;
                txtEmail.value = currentEmail.replace(/;$/, "");
                txtContact.value = currentComp.replace(/\n$/, "");
                txtIds.value = currentIds.replace(/;$/, "");
            }
            else if (txtContact != null && txtEmail != null) {

                currentEmail = txtEmail.value;
                currentComp = txtContact.value;
                if (currentEmail != '')
                    currentEmail = currentEmail + ';' + ContactEmails;
                else
                    currentEmail = ContactEmails;

                if (currentComp != '')
                    currentComp = currentComp + '\n' + ContactNames;
                else
                    currentComp = ContactNames;
                txtEmail.value = currentEmail.replace(/;$/, "");
                txtContact.value = currentComp.replace(/\n$/, "");
            }
            window.close();
            return false;
        }

        function SaveMultiple(ContactIds, ContactNames) {

            var combo = window.opener.$find(querySt('ddlId'));
            var hdnIds = window.opener.document.getElementById(querySt('hdnIds'));
            var hdnNames = window.opener.document.getElementById(querySt('hdnNames'));
            if (combo != null && hdnIds != null && hdnNames != null) {
                combo.set_text(ContactNames);
                hdnIds.value = ContactIds;
                hdnNames.value = ContactNames;
                window.opener.setdirty();
            }
            window.close();
            return false;
        }



        function pageLoad() {
            CheckParentBox();
            CheckBiddersParentBox();
        }

        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgRights = $("div[id$='rdgContacts']");
            var j = 0;
            var k = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });

            var hdnCount = $("[id$=hdnCount]");
            var Value = parseFloat(hdnCount.val());
            if (iObj.checked) {
                Value = Value + j;
            }
            else {
                if ((Value - k) >= 0)
                    Value = Value - k;
            }
            hdnCount.val(Value);
            document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';
        }
        function SelectParent(chk) {
            var rdgRights = $("div[id$='rdgContacts']");
            if (rdgRights.find("input[type='checkbox']")[0] == null) return;
            var chkPArent = rdgRights.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (chk.checked) {
                        if (!this.checked) isChecked = false;
                    }
                }
                i++;
            });
            var hdnCount = $("[id$=hdnCount]");
            var Value = parseFloat(hdnCount.val());

            if (!chk.checked) {
                chkPArent.checked = false;
                if (Value > 0)
                    Value = Value - 1;


            } else {
                chkPArent.checked = isChecked;
                Value = Value + 1;
            }
            hdnCount.val(Value);
            document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';
            return false;
        }

        function CheckParentBox() {


            var rdgRights = $("div[id$='rdgContacts']");
            var ParentIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkSelect") > 0)
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

        function SetTitle() {
            var hdnCount = $("[id$=hdnCount]");
            var Value = parseFloat(hdnCount.val());
            if (querySt('ddlType') == 'Multiple') {
                document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';

            }

        }


        function AllBiddersCheckClicked(iObj) {


            var i = 0;
            var rdgRights = $("div[id$='rdgBiddersFilter']");
            var j = 0;
            var k = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkSelectBidder") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });

            var hdnBiddersCount = $("[id$=hdnBiddersCount]");
            var Value = parseFloat(hdnBiddersCount.val());
            if (iObj.checked) {
                Value = Value + j;
            }
            else {
                if ((Value - k) >= 0)
                    Value = Value - k;
            }
            hdnBiddersCount.val(Value);

        }
        function BiddersSelectParent(chk) {

            var rdgRights = $("div[id$='rdgBiddersFilter']");
            var chkPArent = rdgRights.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (chk.checked) {
                        if (!this.disabled && !this.checked && this.id.indexOf("chkSelectBidder") > 0) isChecked = false;
                    }
                }
                i++;
            });
            var hdnBiddersCount = $("[id$=hdnBiddersCount]");
            var Value = parseFloat(hdnBiddersCount.val());

            if (!chk.checked) {
                chkPArent.checked = false;
                if (Value > 0)
                    Value = Value - 1;


            } else {
                chkPArent.checked = isChecked;
                Value = Value + 1;
            }
            hdnBiddersCount.val(Value);

            return false;
        }

        function CheckBiddersParentBox() {


            var rdgRights = $("div[id$='rdgBiddersFilter']");
            if (rdgRights.find("input[type='checkbox']")[0] == null) return;
            var ParentIsNotChecked = true;
            var i = 0;
            var d = 1;
            var c = 1;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && !this.checked) {
                        if (this.id.indexOf("chkSelectBidder") > 0)
                            ParentIsNotChecked = false;
                    }
                    if (this.disabled) {
                        d = d + 1;
                    }
                    if (this.id.indexOf("chkSelectBidder") > 0) {

                        c = c + 1;
                    }

                }
                i++;
            });

            if (d == c) {
                ParentIsNotChecked = false;

            }

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;

            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }

            }
        }
        function AddContactsToReminder() {
            window.opener.AddContacts();
            window.close();
            return false;
        }
        function AddContactsToSubscription() {
            window.opener.AddContacts();
            window.close();
            return false;
        }
</script>
    
      <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
 <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
   <ClientEvents OnRequestStart="RequestStart" />
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpItems" />
                      <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpItems" />
                      <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rtvLinkedRecords">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
                <telerik:AjaxSetting AjaxControlID="rdgContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpItems" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
                    <telerik:AjaxSetting AjaxControlID="rdgLinkedRecords">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
    <table style="width:100%" cellpadding="0" cellspacing="0">
<tr>
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1"
                    runat="server" MultiPageID="mlpList" Skin="Default" Width="100%"
                    CausesValidation="False">
                    <Tabs>
                        <telerik:RadTab Value="Bidders" Text="<%$Resources: Tab_Bidders%>"/>
                        <telerik:RadTab Value="CompaniesContact" Text="<%$Resources: Tab_CompaniesContact%>" Selected="true" />
                        <telerik:RadTab Text="<%$Resources: Tab_DistributionList%>" Value="DistributionList"  ></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
 
        <tr>
            <td>
                <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="1" 
                    Width="100%" RenderSelectedPageOnly="True">
                        <telerik:RadPageView ID="pvBiddes" runat="server" >                      
                         <uc1:NotificationBidders ID="Bidders1" runat="server" />
                    </telerik:RadPageView>
                       <telerik:RadPageView ID="pvDetails" runat="server" Selected="true">

                          <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                Width="100%" AutoGenerateColumns="True" AllowFilteringByColumn="true" AllowSorting="true"  ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    ClientDataKeyNames="Id,Company,ContactText,Contact,Email" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                    <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false"  HeaderStyle-Width="50px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn UniqueName="$Bound1$" Display="False"  AllowFiltering="True" DataType="System.String" >
                        </telerik:GridBoundColumn>
                        <telerik:GridDatetimeColumn UniqueName="$Date1$"  Display="False"  AllowFiltering="True" DataType="System.DateTime" >
                        </telerik:GridDatetimeColumn>
                    </Columns>
                    <CommandItemTemplate>

            <div>
           <table>
           <tr>
           <td style="width:150px" class="NoWrap" runat="server" id="tdSpecs">
            <b>
                                        <asp:Label ID="lblSpecification" runat="server" meta:resourcekey="lblSpecification" Visible="True"></asp:Label></b>&nbsp;&nbsp;
                                    <telerik:RadComboBox ID="ddlSpecGroup" runat="server" Width="100px" AutoPostBack="true"
                                          OnSelectedIndexChanged="ddlSpecGroup_SelectedIndexChanged"
                                        Style="font-size: 11px" SecurityButtonType="ItemMode" DropDownWidth="200px"
                                        Visible="true">
                                    </telerik:RadComboBox>
           </td>
           <td style="width:600px">
              <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="SaveContacts" SecurityButtonType="AddEditMode_Edit"
                                 ValidationGroup="DocumentAttachments" CssClass="GridCmdSaveContacts" 
                                Visible="True">
                               <span class="Icon"></span>
                                <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                 <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                    CommandName="SaveState">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </asp:LinkButton>
                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                    CausesValidation="False" CommandName="LoadDefaultState">
                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                </asp:LinkButton>
           </td>
           </tr>
           </table>
                                   
                                
            
                
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" Resizing-AllowColumnResize="True" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="true"  />
                    <ClientEvents  OnRowClick="RowClick" />
                </ClientSettings>
            </telerik:RadGrid>
     </telerik:RadPageView>
                      <telerik:RadPageView ID="RadPageView1" runat="server" >
                       <table width="100%" cellspacing="0px" cellpadding="0px" border="0">
        <tr>
            <td>
            <table style="width:100%" cellpadding="0" cellspacing="0">
            <tr  class="ToolBar">
                        <td>
                         <telerik:RadComboBox ID="ddlEntities" runat="server" AllowCustomText="true" Skin="Default"
                                Height="300px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="-- Portfolio --"
                                Width="258px" DropDownWidth="400px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" 
                                OnItemsRequested="ddl_ItemsRequested">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox> 
                        </td>
                        </tr>
            </table>
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default"
                    Width="100%" Height="540px">
                    <telerik:RadPane ID="rpLinkedRecords" runat="server" CssClass="NormalWhiteBack" Width="300px"
                        Height="560px">
                        <table>
                        <tr>
                        <td>
                      <telerik:RadTreeView ID="rtvLinkedRecords" runat="server" EnableDragAndDrop="True" AllowNodeEditing="false"
                            Skin="Default" MultipleSelect="true" OnClientNodeDropping="onNodeDropping"
                            OnClientNodeDragging="onNodeDragging">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <NodeTemplate>
                                <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                            </NodeTemplate>
                        </telerik:RadTreeView>
                        </td>
                        </tr>
                        
                        
                        </table>
                 
                    </telerik:RadPane>
                    <telerik:RadSplitBar ID="Splitter" runat="server" />
                    <telerik:RadPane ID="RadContentPane" runat="server" Width="100%" Height="560px">
                        <div id="LinkedRecordsPane" style="vertical-align: top;" class="NormalWhiteBack">
                            <telerik:RadGrid ID="rdgLinkedRecords" runat="server"   AutoGenerateColumns="False"
                                ShowStatusBar="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" HeaderStyle-Font-Size="8">
                                <MasterTableView DataKeyNames="Id,ObjectTypeId" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                    <Columns> 
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Company" UniqueName="Company"  HeaderStyle-Width="30%">
                                            <ItemTemplate>
                                              <span><%#IIf(Eval("Company") = String.Empty, "&nbsp;", Eval("Company"))%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                      <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Conatct" UniqueName="Contact"  HeaderStyle-Width="30%">
                                            <ItemTemplate>
                                              <span><%#IIf(Eval("Code") & "-" & Eval("Contact") = "-", "&nbsp;", Eval("Code") & "-" & Eval("Contact"))%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Email" UniqueName="Email"  HeaderStyle-Width="30%">
                                            <ItemTemplate>
                                              <span><%#IIf(Eval("Email") = String.Empty, "&nbsp;", Eval("Email"))%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                   <CommandItemTemplate>
                                   <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                                   CommandName="SaveDistContacts"  CssClass="GridCmdSaveDistContacts"  SecurityButtonType="AddEditMode_Edit"
                                Visible="True">
                                <span class="Icon"></span>
                                <asp:Label runat="server" meta:resourcekey="lblDistributionListSaveAndClose" ID="lblDistributionListSaveAndClose"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="True">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                          &nbsp;&nbsp;
                                        </asp:LinkButton>
                             <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                   <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                      <ClientSettings  AllowColumnHide="false" AllowColumnsReorder="false"
            AllowDragToGroup="false" AllowRowsDragDrop="false">
            <Selecting AllowRowSelect="true" />
            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                AllowColumnResize="True"></Resizing>
        </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </telerik:RadPane>
                </telerik:RadSplitter>
            </td>
        </tr>
        
    </table>       
                        
                              
                    </telerik:RadPageView>
                     
                   
                            
                
                </telerik:RadMultiPage> 
                
     </td>
     </tr>
 
 
 
    </table>
    
    <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
    
    
    </form>
</body>
</html>
