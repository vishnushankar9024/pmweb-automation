<%@ Page Language="vb" AutoEventWireup="false"
    CodeBehind="NewLanguage.aspx.vb" Inherits="Website.NewLanguage" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Languages</title>
    <style type="text/css">
        body {
            background: white none !important;
            color: #333333 !important;
            font-family: 'Work Sans' !important;
        }
        .RadGrid_Default {
            width:100% !important;
        }
    </style>
    <link href="CSS/PMCss.css" rel="stylesheet" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" />
    <link href="CSS/window.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <script type="text/javascript" src="JS/Language/Language.js"></script>
        <script language="javascript" type="text/javascript">
            $(document).ready(function () {
                $("[id$=ddlCultures]").change(function () {
                    var row = $(this).parents("tr:first");
                    var lblCode = row.find("[id$='lblCode']");
                    var txtDescription = row.find("[id$='txtDescription']");
                    txtDescription.val($(this).find("option:selected").text());
                    lblCode.html($(this).val());
                });
            });
        </script>

        <div style="padding:24px;">
            <telerik:RadGrid ID="rdgLanguage" Width="99%" runat="server" EnableEmbeddedSkins="False"
                Skin="Default" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                AllowSorting="True" GridLines="None" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true">
                <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    UseAllDataFields="True" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                    EnableHeaderContextMenu="false">
                    <Columns>
                        <telerik:GridTemplateColumn DataField="ImagePath" SortExpression="ImagePath" UniqueName="TemplateColumn2"
                            HeaderText="Flag">
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkUpload" OnClientClick="return TriggerUpload();" runat="server" CssClass="SearchButton1">
                                     <span class="Icon"></span>     
                                </asp:LinkButton>
                                <asp:TextBox runat="server" ID="txtFileName" ClientIDMode="Static" CssClass="LanguagetxtFileName"></asp:TextBox>
                                <asp:FileUpload ID="fluImage" runat="server" ClientIDMode="Static" Width="99%" Style="display: none;" />
                                <%--                                <telerik:RadUpload ID="fluImage" runat="server" ControlObjectsVisibility="None" MaxFileInputsCount="1"
                                                Width="250px">
                                            </telerik:RadUpload>--%>
                                <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                    Text='<%# IIf(Eval("ImagePath") Is System.DBNull.Value, "", Eval("ImagePath")) %>'
                                    ToolTip="Download"></asp:HyperLink>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <img id="imgLang" style="width: 30px; height: 13px" runat="server" />
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle HorizontalAlign="Left" Width="300px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Language (Country)">
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="lblLanguage" Text=""></asp:Label>
                                <asp:DropDownList runat="server" Width="230px" ID="ddlCultures" Visible="<%# rdgLanguage.EditIndexes.Count = 0 And (rdgLanguage.MasterTableView.IsItemInserted) %>">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCulture" runat="server" ControlToValidate="ddlCultures"
                                    CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLanguage" Width="230px" Text=""></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="250px" />
                            <ItemStyle HorizontalAlign="Left" Width="250px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn SortExpression="Description" HeaderText="Description">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Width="185px" MaxLength="50" Text='<%# Eval("Description") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                    CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%# Container.DataItem("Description") %>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                            <ItemStyle HorizontalAlign="Left" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="Code" SortExpression="Code" UniqueName="TemplateColumn"
                            HeaderText="Code">
                            <EditItemTemplate>
                                <%--<asp:TextBox ID="txtCode" runat="server" MaxLength="50" Text='<%# Eval("Code") %>'></asp:TextBox>--%>
                                <asp:Label runat="server" ID="lblCode" Text="" Width="40px"></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%# Eval("Code") %>
                            </ItemTemplate>
                            <HeaderStyle Width="50px" />
                            <ItemStyle HorizontalAlign="Left" Width="50px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn SortExpression="NumDigitsAfterDecimal" HeaderText="Number of digits after the decimal" Visible="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNumDigitsAfterDecimal" maxnumber="5" minnumber="1" runat="server" Width="185px" MaxLength="1" CssClass="PositiveInteger" Text='<%# Eval("NumDigitsAfterDecimal") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNumDigitsAfterDecimal" runat="server" ControlToValidate="txtNumDigitsAfterDecimal"
                                    CssClass="Validator" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#ParseInt(Container.DataItem("NumDigitsAfterDecimal"), 2)%>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                            <ItemStyle HorizontalAlign="Left" Width="200px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="Direction" SortExpression="Direction" UniqueName="TemplateColumn3"
                            HeaderText="Direction">
                            <EditItemTemplate>
                                <asp:RadioButton ID="rdoLTR" runat="server" GroupName="Direction" Checked='<%# If(Eval("Direction") Is System.DBNull.Value, True, If(Eval("Direction") = "LTR", True, False)) %>'
                                    Text="LTR" />
                                <asp:RadioButton ID="rdoRTL" runat="server" GroupName="Direction" Checked='<%# If(Eval("Direction") Is System.DBNull.Value, False, If(Eval("Direction") = "RTL", True, False)) %>'
                                    Text="RTL" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Container.DataItem("Direction")%>
                            </ItemTemplate>
                            <HeaderStyle Width="120px" />
                            <ItemStyle HorizontalAlign="Left" Width="120px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn DataField="isDefault" SortExpression="isDefault" HeaderText="Default"
                            UniqueName="TemplateColumn4">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkDefault" runat="server" Checked='<%# IIf(Eval("isDefault") Is System.DBNull.Value, False, Eval("isDefault")) %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("isDefault") = True, "Default", "Not Default")%>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Left" Width="100px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                        Visible="<%# rdgLanguage.EditIndexes.Count = 0 And (Not rdgLanguage.MasterTableView.IsItemInserted) %>" CssClass="GridCmdEdit">
                                        <%--<img src="Images/Global/EditLine.gif" style="border: 0px; vertical-align: middle;" />--%>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit"></asp:Label>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    </asp:LinkButton>
                            <asp:LinkButton ID="btnDeleteSelected" runat="server" CausesValidation="False" OnClientClick="Javascript:return confirm('Are you sure you want to delete this language?')"
                                CommandName="DeleteRows" Visible="<%# rdgLanguage.EditIndexes.Count = 0 And (Not rdgLanguage.MasterTableView.IsItemInserted) %>" CssClass="GridCmdDelete">
                                <%--<img src="Images/Global/DeleteLine.gif" style="border: 0px; vertical-align: middle;" />--%>
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited"
                                Visible="<%# rdgLanguage.EditIndexes.Count > 0 %>" CssClass="GridCmdUpdate">
                                <%--<img alt="" src="Images/Global/save.gif" style="border: 0px; vertical-align: middle;" />--%>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert"
                                Visible="<%# rdgLanguage.MasterTableView.IsItemInserted %>" CssClass="GridCmdSave">
                                <%--<img alt="" src="Images/Global/save.gif" style="border: 0px; vertical-align: middle;" />--%>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                Visible="<%# rdgLanguage.EditIndexes.Count > 0 Or rdgLanguage.MasterTableView.IsItemInserted %>" CssClass="GridCmdCancel">
                                <%--<img alt="" src="Images/Global/cancel.gif" style="border: 0px; vertical-align: middle;" />--%>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow"
                                Visible="<%# rdgLanguage.EditIndexes.Count = 0 And (Not rdgLanguage.MasterTableView.IsItemInserted) %>" CssClass="GridCmdInitNewRecord">
                                <%--<img alt="" src="Images/Global/AddLine.gif" style="border: 0px; vertical-align: middle;" />--%>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add Line"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>
                            <%-- <asp:LinkButton ID="btnBackResource" runat="server" CausesValidation="False" CommandName="BackResource" 
                                            Visible="false">
                                            <asp:Label ID="lblBacktoResource" runat="server" Text="Back to Language Management"></asp:Label>
                                         
                                        </asp:LinkButton>--%>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <FilterMenu Skin="Office2007" EnableTheming="True" EnableEmbeddedSkins="False">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </FilterMenu>
                <HeaderContextMenu EnableEmbeddedSkins="False">
                </HeaderContextMenu>
                <ClientSettings AllowColumnHide="False" Selecting-AllowRowSelect="True" AllowColumnsReorder="False"
                    AllowDragToGroup="False" Resizing-AllowColumnResize="False">
                    <Resizing AllowColumnResize="False"></Resizing>
                    <Selecting AllowRowSelect="True"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
            <asp:Label ID="lblMessage" CssClass="Validator" runat="server"></asp:Label>
        </div>
    </form>
</body>

</html>
