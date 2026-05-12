<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MeetingMinuteDetails.ascx.vb"
    Inherits="Website.MeetingMinuteDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript">
        function onSelectedIndexChanging(sender, eventArgs) {
            var HiddenField = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_HiddenField1';
            var HidnDetailsId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_HidnDetailsId';
            var combVal = sender.get_value();
            if (combVal == '' || combVal == '0') {
                var Control = document.getElementById(HiddenField);
                if (Control != null) {
                    Control.value = '';
                }
            }
            if (sender.get_value() == '0') {
                var left = (screen.width - 760) / 2;
                var top = (screen.height - 425) / 2;
                window.open("Contacts.aspx?Type=1&Id=" + document.getElementById(HidnDetailsId).value,
                  'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=760,height=425,top=' + top + ',left=' + left);
            }
        }
        function RowSelected(sender, args) {
            document.getElementById("<%= hdMeetingMinuteDetailsId.ClientID %>").value = args.getDataKeyValue("Id");
        }
        function AddLine() {
            document.getElementById("<%= hdMeetingMinuteDetailsId.ClientID %>").value = "";

        }

        function ColumnResized(sender, args) {

            $(function () {
                $('.scroll-pane').jScrollPane();
            });
        }

        //        function RowResized(sender, args) {
        //            var divScroll = $("div[id*=divScroll_" + args._dataKeyValues.Id + "]")[0];
        //            var newHeight = sender.get_masterTableView().get_dataItems()[args._itemIndexHierarchical]._element.offsetHeight + "px";
        //            divScroll.style.maxHeight = newHeight;
        //            divScroll.style.height = newHeight;
        //            $("div[id*=divScroll_" + args._dataKeyValues.Id + "]").find('span')[0].style.height = newHeight;
        //            $("div[id*=divScroll_" + args._dataKeyValues.Id + "]").jScrollPane();
        //        }
        //        function RowResizing(sender, args) {
        ////                var divScroll = $("div[id*=divScroll_" + args._dataKeyValues.Id + "]")[0];
        ////                divScroll.style.maxHeight = sender.get_masterTableView().get_dataItems()[args._itemIndexHierarchical]._element.offsetHeight + "px"
        ////                divScroll.style.height = sender.get_masterTableView().get_dataItems()[args._itemIndexHierarchical]._element.offsetHeight + "px"
        ////                //$("div[id*=divScroll_" + args._dataKeyValues.Id + "]").jScrollPane();
        //        }
    </script>

</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMeetingMinutes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMeetingMinutes" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshMeetingMinutes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMeetingMinutes" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshMeetingMinutes" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgMeetingMinutes" runat="server" EnableEmbeddedSkins="false" CssClass="WithoutTopBorder"
                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15"
                AllowPaging="True" ShowGroupPanel="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    ClientDataKeyNames="Id" DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                    EnableHeaderContextMenu="true" TableLayout="Fixed" Width="100%">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Item #" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" UniqueName="ItemNumber" CurrentFilterFunction="Contains" SortExpression="ItemNum"
                            DataField="ItemNum" AutoPostBackOnFilter="true" Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <span><%#Eval("ItemNum")%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblItemNum" runat="server" Text='<%# Eval("ItemNum") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Seq #" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="false" CurrentFilterFunction="Contains" SortExpression="SeqNumCode"
                            DataField="SeqNumCode" AutoPostBackOnFilter="true" UniqueName="SeqNumber" Reorderable="true">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(Container.DataItem("SeqNumCode")), "", Container.DataItem("SeqNumCode"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSeqNumCode" MaxLength="50" runat="server" Width="100%" Text='<%# Eval("SeqNumCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="425px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="true" ItemStyle-Wrap="true" CurrentFilterFunction="Contains" SortExpression="HtmlDescription"
                            DataField="HtmlDescription" AutoPostBackOnFilter="true" Groupable="true" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                            Reorderable="true" UniqueName="Description">
                            <ItemTemplate>
                                <div class="scroll-pane" style="max-height: 75px; max-width: 100%" id='<%# "divScroll_" & Eval("Id") %>'>
                                    <asp:LinkButton ID="btnAddDescription" CssClass="FilledDetails" runat="server">
                            <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:Label runat="server" ID="lblDescription" Text='<%# IIf(Eval("HtmlDescription") = "", "&nbsp;", Eval("HtmlDescription"))%>'></asp:Label>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>

                                <telerik:RadEditor Height="200px" EnableResize="true" DialogsScriptFile="~/JS/RadEditorDialog.js"  OnClientLoad="OnClientLoad" Skin="Default" Width="425px" EditModes="Design" ID="edtDescription" 
                                    runat="Server" ToolbarMode="ShowOnFocus" ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Content='<%# Eval("HtmlDescription") %>'>
                                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                                        SearchPatterns="*.*" />
                                </telerik:RadEditor>


                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="425px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assigned To" CurrentFilterFunction="Contains" SortExpression="AssignedContacts"
                            DataField="AssignedContacts" AutoPostBackOnFilter="true" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC"
                            Reorderable="true" UniqueName="AssignedTo">
                            <ItemTemplate>
                                <span><%#Container.DataItem("AssignedContacts")%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlAssignTo" runat="server" Width="90%" DropDownWidth="405px"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                        Style="font-size: 11px" Height="250px">
                                        <HeaderTemplate>

                                            <table style="width: 395px" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 10px;"></td>
                                                    <td style="width: 250px;">
                                                        <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                    <td style="width: 135px;">
                                                        <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <table style="width: 395px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 10px;">
                                                            <asp:CheckBox runat="server" ID="chk"></asp:CheckBox>
                                                        </td>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:HiddenField runat="server" ID="hddnIds" />
                                    <asp:HiddenField runat="server" ID="hddnNames" />
                                    <asp:LinkButton runat="server" ID="imgfilter1"
                                        OnClientClick="return OpenMultipleCompanyFilterPopup(this.id.replace('imgfilter1','hddnIds'),this.id.replace('imgfilter1','ddlAssignTo'),this.id.replace('imgfilter1','hddnNames'),'Contacts')"
                                        CssClass="SearchButton">
                                             <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>

                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="220px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" CurrentFilterFunction="Contains" SortExpression="Category"
                            DataField="Category" AutoPostBackOnFilter="true" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="Category [GridColumn_Category] Group By Category ASC" Reorderable="true" UniqueName="Category">
                            <ItemTemplate>
                                <span><%#Container.DataItem("Category")%></span> &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="true"
                                    CausesValidation="False" Height="250px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Subject" CurrentFilterFunction="Contains" SortExpression="Subject"
                            DataField="Subject" AutoPostBackOnFilter="true" UniqueName="Subject" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" Reorderable="true"
                            GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(Eval("Subject")), "", Eval("Subject"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSubject" MaxLength="1000" runat="server" Width="100%" Text='<%# Eval("Subject") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Due" DataType="System.DateTime" CurrentFilterFunction="EqualTo" SortExpression="Due"
                            DataField="Due" AutoPostBackOnFilter="true" HeaderStyle-Width="125px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="Due [GridColumn_Due] Group By Due ASC" UniqueName="Due" Reorderable="true">
                            <ItemTemplate>
                                <span><%#FormatDate(Eval("Due"))%></span>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default"
                                    EnableTyping="True">
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                        runat="server">
                                    </DateInput>
                                    <Calendar ID="Calendar2" Skin="Default" runat="server">
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Completed" DataType="System.DateTime" CurrentFilterFunction="EqualTo" SortExpression="Completed"
                            DataField="Completed" AutoPostBackOnFilter="true" HeaderStyle-Width="125px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" UniqueName="Completed" Groupable="true" GroupByExpression="Completed [GridColumn_Completed] Group By Completed ASC"
                            Reorderable="true">
                            <ItemTemplate>
                                <span><%#FormatDate(Eval("Completed"))%></span>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpCompleted" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default"
                                    EnableTyping="True">
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                        runat="server">
                                    </DateInput>
                                    <Calendar ID="Calendar2" Skin="Default" runat="server">
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Status" CurrentFilterFunction="Contains" SortExpression="Status"
                            DataField="Status" AutoPostBackOnFilter="true" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                            UniqueName="Status" Reorderable="true">
                            <ItemTemplate>
                                <span><%#Eval("Status")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="true"
                                    CausesValidation="False" Height="250px"
                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Task" CurrentFilterFunction="Contains" SortExpression="Task"
                            DataField="Task" AutoPostBackOnFilter="true" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="Task [GridColumn_Task] Group By Task ASC"
                            UniqueName="Task" Reorderable="true">
                            <ItemTemplate>
                                <span><%#Eval("Task")%></span>&nbsp;
                    &nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTask" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
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
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" CurrentFilterFunction="Contains" SortExpression="HtmlNotes"
                            DataField="HtmlNotes" AutoPostBackOnFilter="true" UniqueName="Notes" HeaderStyle-Width="425px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" Reorderable="true"
                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnAddNote" CssClass="FilledDetails" runat="server">
                        <span class="Icon"></span>
                                </asp:LinkButton>
                                <asp:Label runat="server" ID="lblNotes" Text='<%# Eval("HtmlNotes") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadEditor Height="100%" OnClientLoad="OnClientLoad" Skin="Default" Width="425px" EditModes="Design" ID="edtNotes"
                                    runat="Server" ToolbarMode="ShowOnFocus" DialogsScriptFile="~/JS/RadEditorDialog.js"  ToolsFile="~/ToolsFile.xml"  DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Content='<%# Eval("HtmlNotes") %>'>
                                </telerik:RadEditor>
                                <imagemanager maxuploadfilesize="204000000" viewpaths="~/Images/Shared" uploadpaths="~/Images/Shared" deletepaths="~/Images/Shared" searchpatterns="*.*" />
                                <mediamanager viewpaths="~/Images/Shared" uploadpaths="~/Images/Shared" deletepaths="~/Images/Shared" searchpatterns="*.*" />
                                <flashmanager viewpaths="~/Images/Shared" uploadpaths="~/Images/Shared" deletepaths="~/Images/Shared" searchpatterns="*.*" />
                                <templatemanager viewpaths="~/Images/Shared" uploadpaths="~/Images/Shared" deletepaths="~/Images/Shared"
                                    searchpatterns="*.*" />
                                <documentmanager viewpaths="~/Images/Shared" uploadpaths="~/Images/Shared" deletepaths="~/Images/Shared"
                                    searchpatterns="*.*" />
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="425px"></HeaderStyle>
                            <ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Done" CurrentFilterFunction="Contains" SortExpression="Done"
                            DataField="Done" AutoPostBackOnFilter="true" UniqueName="Done" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                            HeaderStyle-Wrap="false" Groupable="true" Reorderable="true"
                            GroupByExpression="Done [GridColumn_Done] Group By Done ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Done"), "Y", "N")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkDone" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                            CancelImageUrl="Cancel.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgMeetingMinutes.EditIndexes.Count = 0 AND (Not rdgMeetingMinutes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgMeetingMinutes.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgMeetingMinutes.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgMeetingMinutes.EditIndexes.Count > 0 Or rdgMeetingMinutes.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" OnClientClick="AddLine();" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgMeetingMinutes.EditIndexes.Count = 0 AND (Not rdgMeetingMinutes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgMeetingMinutes.EditIndexes.Count = 0 And (Not rdgMeetingMinutes.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" Visible='<%# rdgMeetingMinutes.EditIndexes.Count = 0 And (Not rdgMeetingMinutes.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                            <%--<asp:LinkButton ID="btnSendInvitations" runat="server" CausesValidation="False" CommandName="SendInvitations" OnClientClick="return OpenPOPUp('AssignmentNotification.aspx', 400, 600, false);"
                    SecurityButtonType="ItemMode" Visible='<%# rdgMeetingMinutes.EditIndexes.Count = 0 AND (Not rdgMeetingMinutes.MasterTableView.IsItemInserted) %>'>
                    <asp:Label ID="Label3" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>--%>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true" Resizing-AllowColumnResize="true" EnableRowHoverStyle="false">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                    <ClientEvents OnRowSelected="RowSelected" OnColumnResized="ColumnResized" OnGridCreated="ColumnResized" />

                    <Resizing AllowRowResize="false" AllowColumnResize="true" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"></Resizing>
                </ClientSettings>
            </telerik:RadGrid>
            <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
                MaxDate="12/31/2100" runat="server" Skin="Default">
                <ClientEvents OnDateSelected="dateSelected" />
            </telerik:RadDatePicker>
        </div>
    </div>
</div>
<input type="hidden" id="hdMeetingMinuteDetailsId" runat="server" />
<asp:Button ID="btnRefreshMeetingMinutes" runat="server" CssClass="Hide" />