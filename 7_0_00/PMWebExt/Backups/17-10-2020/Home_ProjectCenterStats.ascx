<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_ProjectCenterStats.ascx.vb" Inherits="Website.Home_ProjectCenterStats" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="DocumentSpecifications.ascx" tagname="DocumentSpecifications" tagprefix="uc1" %>
<style type="text/css">
      .fldSpecs
      {border: 1px solid transparent;
      	
      	}
      .EditButton .Icon {
    background-image:  url(Css/Skins/Metro/Images/MetroSmall.png);
    background-position: -576px 0px !important;
    width: 16px !important;
    height: 16px !important;
    display: inline-block;
    vertical-align: middle !important;
}
</style>
 

  <telerik:RadCodeBlock ID="CodeBlock" runat="server">
   <script type="text/javascript">
       function BudgetRedirect() {
           var ProjectId = '<%= PM.ProjectInfo.Id %>';
           if (ProjectId == 0)
               return false;
           RedirectPage('CostWorksheet.aspx?ProjectId=' + ProjectId);
           return false;
       }
       function ScheduleRedirect() {
           var ProjectId = '<%= PM.ProjectInfo.Id %>';
           if (ProjectId == 0)
               return false;
           RedirectPage('Tasks.aspx?ProjectId=' + ProjectId);
           return false;
       }

   </script>
  </telerik:RadCodeBlock>

<table style="width:100%;" cellpadding="0" cellspacing="0" >
 <tr>
    <td>
     <asp:Panel runat ="server" ID = "pnlSchedule" > 
      <table>           
        <tr> 
           <td valign="middle" style="padding:5px 0px 5px 0px; "  >
             <img alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleNavigatorSection(this,'tblTarget');" />
             <span  ><asp:Label ID="lblSchedule" style="color:#0169aa;font-size:16px" runat="server" Text="Schedule" meta:resourcekey="lblSchedule"></asp:Label></span> 
               

<asp:LinkButton runat="server" ID="imgbtnSchedule"  OnClientClick="return ScheduleRedirect();" style=" cursor:pointer;" CssClass="EditButton">
    					<span class="Icon"></span>
				</asp:LinkButton>
         </td>
        </tr>
        <tr>
          <td>
            <table style="width:400px; padding-left:20px; padding-top:0px!important"  cellpadding="0" cellspacing="0" id="tblTarget">
                <tr>
                    <td style="width:200px;" class="NoWrap">
                        <asp:Label ID="lblTargetschedule" runat="server" Text="Target:" meta:resourcekey="lblTargetschedule"></asp:Label>
                        <asp:Label runat="server" NoWrap="True"  ID="lblTargetValue" Style="text-align: left;" ></asp:Label>
                    </td>
                    <td style="width:200px;">
                    <asp:Panel style="width:0px;background:#4f81bc;" ID = "pnlTarget"  runat ="server" >
                    &nbsp</asp:Panel>
                    </td>              
            </tr>
                <tr>
                <td >
                    <asp:Label ID="lblProjected" class= "NoWrap" runat="server" Text="Projected:" meta:resourcekey="lblProjected"></asp:Label><asp:Label runat="server" NoWrap="True"  ID="lblProjectedValue" Style="text-align: left;" ></asp:Label>
                </td>
                    <td style="width:200px;padding-top:1px">
                <asp:Panel ID = "pnlProjected" style="width:0px;background:#f79647;" runat ="server">
                &nbsp</asp:Panel>
                </td>  
                </tr>
            </table>
          </td>
        </tr>
     </table> 
    </asp:Panel>
   </td>
 </tr>
 <tr>
    <td>
     <asp:Panel runat ="server" ID = "pnlBudget" >  
       <table>  
            <tr>
                 <td valign="middle" style="padding:5px 0px 5px 0px; "  >
                  <img alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleNavigatorSection(this,'tblBudget');" />
                  <span ><asp:Label ID="lblBudget" runat="server" style="color:#0169aa;font-size:16px" Text="Budget" meta:resourcekey="lblBudget"></asp:Label></span> 
                 <asp:LinkButton runat="server" ID="imgbtnBudget"  OnClientClick="return BudgetRedirect();" style=" cursor:pointer;" CssClass="EditButton">
    					<span class="Icon"></span>
				</asp:LinkButton>
                       </td>
           </tr>
          <tr>
             <td>
                 <table  style="width:400px; padding-left:20px; padding-top:0px!important"  cellpadding="0" cellspacing="0" id="tblBudget">
                    <tr>
                        <td style="width:200px;"  class= "NoWrap">
                            <asp:Label ID="lblTargetBudget" runat="server" Text="Target:"  meta:resourcekey="lblTargetBudget"></asp:Label>
                               <asp:Label runat="server"   ID="lblTargetBudgetValue" NoWrap="True" Style="text-align: left;" ></asp:Label>
                        </td>
 
                         <td  style="width:200px;">
                        <asp:Panel  style="width:0px;background:#4f81bc;margin-left: -5px;" ID = "pnlTargetBudget"  runat ="server">
                        &nbsp</asp:Panel>
                        </td>  
                     </tr>
                     <tr>
                         <td class= "NoWrap">
                            <asp:Label ID="lblAnticipatedCost" runat="server"   NoWrap="True" Text="Anticipated Cost:" meta:resourcekey="lblAnticipatedCost"></asp:Label>
                        <asp:Label runat="server"   ID="lblAnticipatedCostValue" class = "NoWrap" Style="text-align: left;" ></asp:Label>
                        </td>
   
                         <td  style="width:200px;padding-top:1px">
                           <asp:Panel style="width:0px;background:#f79647;margin-left: -5px;"   ID = "pnlAnticipatedCost" runat ="server" >
                            &nbsp</asp:Panel>
                       </td>  
                  </tr>
              </table>
         </td>
     </tr>
      </table> 
     </asp:Panel>
  </td>
</tr>



<tr>
    <td>
     <asp:Panel runat ="server" ID = "pnlCustomFields" >  
       <table>  

       <tr>
           <td valign="middle" style="padding:5px 0px 5px 0px; "  >
         <img alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleNavigatorSection(this,'tblSpecifications');" />
         <span ><asp:Label ID="lblCustomFields" runat="server" style="color:#0169aa;font-size:16px" Text="Custom Fields" meta:resourcekey="lblCustomFields"></asp:Label></span>    
      </td>
      </tr>
       <tr>
        <td>
         <table  style="width:100%; padding-top:0px!important"cellpadding="0" cellspacing="0" id="tblSpecifications">
            <tr>
                <td>
                    <uc1:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
                </td> 
             </tr>
          </table>
      </td>
    </tr>
      </table> 
     </asp:Panel>
  </td>
</tr>
</table>


