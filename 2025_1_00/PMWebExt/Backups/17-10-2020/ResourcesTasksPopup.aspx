<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourcesTasksPopup.aspx.vb" Inherits="Website.ResourcesTasksPopup" Title="Recources Availability"  meta:resourcekey="Page"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<link href="Utilities/TreeGrid/Modern/Grid.css" rel="stylesheet" type="text/css" />
     
      <telerik:RadCodeBlock ID="CodeBlock1" runat="server">
     <script src="Utilities/TreeGrid/GridE.js" type="text/javascript"> </script>
       <script src="JS/Scheduling/ResourcesTasksPopup.js" type="text/javascript"> </script>
    <script type="text/javascript">
        function onCheckBoxClick(chk) {
            var combo = $find("<%= ddlAllResources.ClientID %>");
            var text = "";
            var values = "";
            var items = combo.get_items();
            for (var i = 0; i < items.get_count(); i++) {
                var item = items.getItem(i);
                var chk1 = $get(combo.get_id() + "_i" + i + "_chkResource");
                if (chk1.checked) {
                    text += item.get_text() + ";";
                    values += item.get_value() + ";";
                }
            }
            text = removeLastSemiColumn(text);
            values = removeLastSemiColumn(values);

            var hdnResourceSelectedValues = $("[id$='hdnResourceSelectedValues']")[0];
            hdnResourceSelectedValues.value = values;

            if (text.length > 0) {
                combo.set_text(text);
            }
            else {
                combo.set_text("");
            }
        }

        function removeLastSemiColumn(str) {
            if (str.lenght >= 1) {
                return str.substring(0, str.lenght - 1);
            } else {
                return str;
            }
        }

      </script>
     </telerik:RadCodeBlock>
<body>
    <form id="form1" runat="server">
       <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
  <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0" class="ToolBar">
     <tr>
            <td class="Padding7 ToolbarTd">
                <b><asp:Label ID="lblRecourcesAvailability" runat="server" meta:resourcekey="lblRecourcesAvailability" Text="Recources Availability"></asp:Label></b>
            </td>
        </tr>
     </table>
        <div class="PMMainPage documentSinglePage PMPopupMainPage R1Col" style="margin-bottom:0 !important;">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblResources" meta:resourcekey="lblResources" Text="Resources"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlAllResources" runat="server" Skin="Default"
                                    DataValueField="Id" DataTextField="Resource" HighlightTemplatedItems="true"
                                    AllowCustomText="true" Width="100%">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkResource" Text='<%#Eval("Resource")%>' onclick="onCheckBoxClick(this)"/>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblFromDate" meta:resourcekey="lblFromDate" Text="From Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDateInput runat="server" ID="rdiFromDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%" Style="text-align:right;"></telerik:RadDateInput>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblToDate" meta:resourcekey="lblToDate" Text="To Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDateInput runat="server" ID="rdiToDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%" Style="text-align:right;"></telerik:RadDateInput>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth">
                                <asp:Button ID="btnSearch" runat="server" meta:resourcekey="btnSearch" Text="Search" />
                            </td>

                        </tr>
                    </table>
                </div>
            </div>
         </div>
         <div style="WIDTH:100%;HEIGHT:400px;padding-top:24px;">
             <treegrid Debug="0"
                  Data_Url="ResourcesTasksPopup.aspx?Req=Data" 
                   Text_Url='<%# IIf(IO.File.Exists(PM.Parameters.PM_WEBSITE_PHYSICAL_PATH + "\Utilities\TreeGrid\Text." & PM.UserInfo.Language & ".xml"), "Utilities/TreeGrid/Text." & PM.UserInfo.Language & ".xml", "Utilities/TreeGrid/Text.xml") %>'             
                  Export_Url="Utilities/TreeGrid/Export.aspx"
                  Export_Data="TGData"
                  Export_Param_File="Table.xls">
              </treegrid>
         </div>
             <asp:HiddenField ID="hdnResourceSelectedValues" runat="server" />
      </form>
</body>
</html>
