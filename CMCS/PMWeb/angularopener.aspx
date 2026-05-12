<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="angularopener.aspx.vb" Inherits="Website.angularopener" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <iframe id="ngFrame" style="width:100%; height:100%; z-index:7000; position:relative; background-color: white" frameborder="0" allow="clipboard-write; clipboard-read"></iframe>
  
    <script type="text/javascript">
        window.addEventListener('message', async (event) => {
            if (event.data?.type === 'getClipboard') {
                try {
                    debugger;
                    const text = await navigator.clipboard.readText();
                    event.source.postMessage({ type: 'clipboardContent', text }, event.origin);
                } catch (err) {
                    console.error('Clipboard read failed in parent:', err);
                    event.source.postMessage({ type: 'clipboardContent', text: '' }, event.origin);
                }
            }
        });

        (function () {
            var appPath = '<%= Request.ApplicationPath %>';

            // Extract page name from URL (e.g. "rfi.aspx")
            var fullPath = window.location.pathname;
            var pageName = fullPath.substring(fullPath.lastIndexOf('/')).toLowerCase();

            var pageMap = <%= GetPageMapJson() %>;

            // Parse query string
            var queryString = new URLSearchParams(window.location.search);
            var id = "";
            var hasWorkflowTab = false;
            const toDelete = [];

            // Case-insensitive search for "id"
            for (const [key, value] of queryString.entries()) {
                if (key.toLowerCase() === "id") {
                    id = value;
                    toDelete.push(key);
                }
                if (key.toLowerCase() === "workflow") {
                    hasWorkflowTab = true;
                    toDelete.push(key);
                }
            }
            toDelete.forEach(k => queryString.delete(k));
            // Convert remaining query params into a single wrapped param
            var otherParams = queryString.toString();
            var wrappedQuery = otherParams ? ("?q=" + encodeURIComponent(otherParams)) : "";
            if (wrappedQuery.length > 0 && hasWorkflowTab) {
                wrappedQuery += "&tab=14"
            }
            if (wrappedQuery.length == 0 && hasWorkflowTab) {
                wrappedQuery += "?tab=14"
            }

            // Get Angular route path
            var angularPage = pageMap[pageName] || "";
            if (!angularPage) {
                console.error("No Angular route mapped for", pageName);
                return;
            }

            // Build Angular iframe URL: /app/#/rfi/100?q=foo%3Dbar
            var angularUrl = appPath + "/app" + angularPage;
            if (id) {
                angularUrl += "/" + encodeURIComponent(id);
            }
            angularUrl += wrappedQuery;

            // Set iframe source
            document.getElementById("ngFrame").src = angularUrl;
        })();
    </script>
</asp:Content>

