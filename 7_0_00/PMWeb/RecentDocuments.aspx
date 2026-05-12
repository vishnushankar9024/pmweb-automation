<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RecentDocuments.aspx.vb" Inherits="Website.RecentDocuments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title></title>
    <style type="text/css">
        .RecentGrid{min-width:100%;}
        .RecentGrid .rgRow > td, .RecentGrid .rgAltRow > td, .RecentGrid .rgEditRow > td, .RecentGrid .rgFooter > td {
    border: none !important;
}
        .RadGrid_Default.RecentGrid .rgHeader, .RadGrid_Default.RecentGrid th.rgResizeCol {
    border: none !important;
    border-width: 0 0 0px 0px !important;
    background: #FFF !important;
    color: rgb(117,117,117) !important;
       text-align: left !important;
}
        
        .RadGrid_Default.RecentGrid .rgHeader.AlignRight, .RadGrid_Default.RecentGrid th.rgResizeCol.AlignRight {
       text-align: right !important;
}


        .RecentGrid.RadGrid_Default {
    border: none !important;
}

        .RecentGrid.RadGrid_Default .rgRow a, .RecentGrid.RadGrid_Default .rgAltRow a, .RecentGrid.RadGrid_Default .rgEditRow a {
    /* color: #666666; */
    color: #316888 !important;
    font-size: 13px!important;
        margin-top: -20px;
    display: block;
}

        .RecentGrid span {
    font-size: 10px;
    color: #999999;
}

        .CloseButton .Icon {
background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png) !important;
    background-position: -208px 0px !important;
    display: inline-block !important;
    width: 16px !important;
    height: 16px !important;
    margin-right: 8px !important;
    position: absolute;
    right: 0px;
    top: 8px;
    cursor:pointer;
}

        .RecentGrid .rgHeader, .RecentGrid th.rgResizeCol, .RecentGrid .rgHeaderWrapper{border-bottom:none !important;}

    </style>
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function GoToRecord(url) {
            window.parent.location.href = url;
            self.close();
        }

        function CloseWindow() {
            self.close();
        }

        function goToFile(sender,args)
        {
            var fileId = args.getDataKeyValue("DocumentNumber");
            window.parent.location = "PmwebRecord.aspx?Id=" + fileId;
        }
        function goToFileFromButton(sender, args)
        {
            debugger;
            var fileId = sender.getAttribute("DocumentNumber");
            window.parent.location = "PmwebRecord.aspx?Id=" + fileId;
        }
        $(document).ready(function () {
            $(".lnkPage").click(function () {
                $(parent.document).find("[id=DisableAllControlsOnPostback]").removeClass("Hide");
            })
        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
           
            <table style="width:100%; padding-left:24px; padding-top:24px; box-sizing:border-box;table-layout:fixed;" >
                <tr>
                    <td class="tdProgramprojectLogin">
                        <asp:Label ID="lblRecentRecordType" runat="server" meta:Resourcekey="lblRecentRecordType" Text="Recent"></asp:Label>
                    </td>
                </tr>
            </table>
                  <asp:LinkButton runat="server" ID="btnClose" OnClientClick="return CloseWindow()" CssClass="CloseButton">
                <span class="Icon"></span>
              </asp:LinkButton>
 <div class="PMHeader">
    <div class="row" style="display: block;">
        <div class="col-12 ">
              <telerik:RadGrid ID="rdgrecords" MasterTableView-ClientDataKeyNames="DocumentNumber" runat="server" ShowGroupPanel="false" AllowPaging="False" RenderMode="Lightweight" CssClass="RecentGrid" FitPageHeightOffset="0"
                            GroupingEnabled="false" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" ClientSettings-Scrolling-UseStaticHeaders="true" ClientSettings-Scrolling-AllowScroll="true"
                            ShowStatusBar="false" ShowHeader="true" ShowFooter="false">
                            <PagerStyle Visible="false" AlwaysVisible="false"></PagerStyle>
                            <MasterTableView HierarchyLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" TableLayout="Fixed"  CommandItemDisplay="none" ShowFooter="false"  BorderWidth="0" BorderStyle="None" ItemStyle-BorderWidth="0" GridLines="None">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Location" Groupable="false" UniqueName="Location" DataField="Location">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("Entity")%>' CssClass="Link lnkPage" style="margin-top: 5px;"
                                                ID="lbtLocation" runat="server" Target="_parent"></asp:HyperLink> <br />
                                            <asp:Label runat="server" ID="lblAction" Text='<%# Container.DataItem("Action")%>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px" HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Record #" Groupable="false" UniqueName="RecordNumber" DataField="RecordNumber">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("DocumentNumber")%>' CssClass="Link lnkPage"
                                                ID="lbtRecordNumber" runat="server" Target="_parent"></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="170px" HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" Groupable="false" UniqueName="Description" DataField="Description">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("Description")%>' CssClass="Link lnkPage"
                                                ID="lbtDescription" runat="server" Target="_parent" ></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="300px" HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                     <telerik:GridTemplateColumn HeaderText="Record Type" Groupable="false" UniqueName="RecordType" DataField="RecordType">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("RecordType")%>' CssClass="Link lnkPage"
                                                ID="lbtRecordType" runat="server" Target="_parent" ></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="170px" HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Status" Groupable="false" UniqueName="Status" DataField="Status">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("Status")%>' CssClass="Link lnkPage"
                                                ID="lbtStatus" runat="server" Target="_parent" ></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="120px" HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Revision" Groupable="false" UniqueName="Revision" DataField="Revision">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%# Container.DataItem("RevisionNumber")%>' CssClass="Link lnkPage"
                                                ID="lbtRevision" runat="server" Target="_parent" ></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="100px"  HorizontalAlign="Right" CssClass="AlignRight"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Date" Groupable="false" UniqueName="Date" DataField="Date">
                                        <ItemTemplate>
                                            <asp:HyperLink Text='<%#FormatDate(Container.DataItem("RevisionDate"))%>' CssClass="Link lnkPage"
                                                ID="lbtDate" runat="server" Target="_parent" ></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="False" Width="120px" HorizontalAlign="Right" CssClass="AlignRight"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
               
                            <ItemStyle BackColor="#F0F0F0" Height="60px" />
                            <AlternatingItemStyle BackColor="#FFFFFF" Height="60px" />
                        </telerik:RadGrid></div></div></div>
        </div>
    </form>
</body>
</html>
