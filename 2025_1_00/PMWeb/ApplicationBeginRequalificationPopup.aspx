<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ApplicationBeginRequalificationPopup.aspx.vb" Inherits="Website.ApplicationBeginRequalificationPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Begin Requalification</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
     
        <script type="text/javascript" language="javascript">
            function CancelNewApplication() {
                window.parent.location.href = "Application_AccountDetails.aspx";
                self.close();
            }

            function OpenNewApplication() {
                window.parent.location.href = "Application_Applications.aspx?Id=0";
                self.close();
            }

            function OpenApplicationRequalification(Id) {
                window.parent.location.href = "Application_Applications.aspx?Id=" + Id ;
                self.close();
            }

            function UncheckOther(chk) {
                var status = chk.checked;
                var checkBoxes = $("input[id*='chkSelect']");

                $.each(checkBoxes, function () {
                    $(this).attr('checked', false);
                });
                chk.checked = status;
            }


        </script>
    <style type="text/css">
        #txtClipboardValue{
            visibility:hidden;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
          <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <link href="CSS/MainCss.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
        <link href="CSS/ControlsCSS/Button.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/Combobox.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/Grid.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/Toolbar.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/Calendar.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/Input.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/ControlsCSS/AjaxLoadingPanel.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
    </telerik:RadCodeBlock>
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
              <div class="PMHeader">
            <div class="row documentSinglePage" style="margin:0 !important;">
                <div class="col-12" style="max-width: calc(100% - 48px) !important;margin-left: 24px;margin-top: 24px;">
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;table-layout:fixed">
            <tr><td></td></tr>
            <tr>
                <td>
                    <asp:Label ID="lblSubTitle" runat="server" meta:resourcekey="lblSubTitle" Text="" ></asp:Label>
                </td>
            </tr>
            <tr style="height:20px;"><td></td></tr>
            <tr>
                <td >
                    <asp:Label ID="lblExplanation" runat="server" meta:resourcekey="lblExplanation" Text="" ></asp:Label>
                </td>
            </tr>
            <tr style="height:24px;"><td></td></tr>
            <tr>
                <td>
                    <fieldset style="width:100%" >
                        <legend><asp:Label ID="lblPriorApplications" runat="server" meta:resourcekey="lblPriorApplications" Text="Prior Applications" style="margin-left:10px;"></asp:Label></legend>
                        <telerik:RadGrid ID="rdgPriorApplications" runat="server"   AutoGenerateColumns="False" setwidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                      HeaderStyle-Font-Size="8" PageSize="250" AllowPaging="true" AllowMultiRowSelection="true" 
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" >
                            <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                                                EditMode="InPlace" EnableHeaderContextMenu="true" ClientDataKeyNames="Id">
                                        <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="70px"   ItemStyle-Wrap="false"  HeaderText="Select" UniqueName="Select" >
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>    
                                        <telerik:GridTemplateColumn UniqueName="ApplicationID"  ItemStyle-Wrap="false" HeaderText="Application ID" > 
                                            <ItemTemplate> 
                                                <asp:Label ID="lblApplicationID" runat="server" Text='<%# iif(Eval("ApplicationID")=string.empty,"&nbsp;",Eval("ApplicationID")) %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="75px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Application Year" ItemStyle-HorizontalAlign="Right"  ItemStyle-Wrap="false" UniqueName="ApplicationYear" > 
                                            <ItemTemplate> 
                                                <asp:Label ID="lblYear" runat="server" Text='<%# Eval("Year") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="75px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Submitted"  ItemStyle-Wrap="false" UniqueName="Submitted" >
                                            <ItemTemplate> 
                                                <asp:Label ID="lblSubmitted" runat="server" Text='<%# If(Eval("Submitted") Is DBNull.Value, "", FormatDate(Eval("Submitted")))%>'></asp:Label>
                                                </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <HeaderStyle Width="75px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="75px"   ItemStyle-Wrap="false"  HeaderText="Status" UniqueName="Status" >
                                            <ItemTemplate> 
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("WorkflowStatus") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="75px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="220px"   ItemStyle-Wrap="false"  HeaderText="Approval Starts" UniqueName="ApprovalStarts" >
                                            <ItemTemplate> 
                                                <asp:Label ID="lblApprovalStarts" runat="server" Text='<%# if(Eval("ApprovalStarts") Is DBNull.value, "", FormatDate(Eval("ApprovalStarts"))) %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px" />
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="220px"   ItemStyle-Wrap="false"  HeaderText="Approval Expires" UniqueName="ApprovalExpires" >
                                            <ItemTemplate> 
                                                <asp:Label ID="lblApprovalExpires" runat="server" Text='<%# if(Eval("ApprovalExpires") Is DBNull.value, "", FormatDate(Eval("ApprovalExpires"))) %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            <HeaderStyle Width="100px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                               
                            </MasterTableView>
                            <ClientSettings Resizing-AllowColumnResize="true">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </fieldset>
                </td>
            </tr>
            <tr style="height:30px;"><td></td></tr>
            <tr>
                <td>
                     <asp:Button ID="btnCancel" Width="100px" runat="server" meta:resourcekey="btnCancel" Text="Cancel" style="float:right;" />
                      <asp:Button ID="btnOk" Width="100px" runat="server" meta:resourcekey="btnOk" Text="" style="float:right;margin-right:10px;" />
                </td>
            </tr>
        </table>
                </div>
                </div></div>    
    </form>
</body>
</html>
