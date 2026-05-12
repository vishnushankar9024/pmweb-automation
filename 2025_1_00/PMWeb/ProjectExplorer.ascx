  <%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectExplorer.ascx.vb" Inherits="Website.ProjectExplorer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

 <iframe runat="server" id="ProjectExplorerngFrame"  class="ProjectExplorerngFrame"></iframe>
<style>
                    .ProjectExplorerngFrame{
                    height: Calc(100vh - 126px);
                    visibility:hidden;
                    border: solid 1px !important;
                    border-color: #e5e5e5 !important;
                    border-radius: 9px;
                    padding: 0px;
                    margin: 0px;
                    border:0;
                    z-index:7000;
                    position:relative;
                    background-color: white;
                    overflow:hidden;
                    min-width:401px;
                    max-width:calc(100vw - 133px);
                    }
</style>


