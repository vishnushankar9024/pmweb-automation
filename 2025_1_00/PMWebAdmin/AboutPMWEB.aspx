<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AboutPMWeb.aspx.vb" Inherits="Website.AboutPMWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    
    <%--<link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />--%>
    <script src="JS/TelerikUtilities.js"></script>
    <title>ABOUT PMWEB</title>
    <style type="text/css">
        * {
            box-sizing: border-box;
            text-rendering: optimizeLegibility;
            margin: 0;
            padding: 0;
        }

        body {
            background: white;
            color: black;
            margin: 0;
            padding: 0;
            font-family: InterVariable, sans-serif;
        }

        .about-container {
            display: flex;
            flex-direction: column;
            height: 100dvh;
        }

        header {
            font-size: 1.125rem;
            /*height: 60px;*/
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-inline: 1.5rem;
            padding-block: 0.875rem;
            flex-grow: 0;
        }

        h1 {
            font-size: 1.125rem;
            line-height: 2rem;
            font-weight: 600;
            color: #101828;
        }

        .close-icon {
            width: 1.5rem;
            aspect-ratio: 1 / 1;
            stroke: #666f85;
            stroke-width: 2px;
            stroke-linecap: round;
            stroke-linejoin: round;
            cursor: pointer;
        }

        hr {
            margin: 0;
            border: none;
            height: 0.0625rem;
            background-color: #eaecf0;
            flex-shrink: 0;
        }

        main {
            margin-block: 24px;
            margin-inline: 50px;
            display: flex;
            flex-direction: column;
            gap: 20px;
            /*height: calc(100% - 48px);*/
            flex-grow: 1;
        }

        section {
            line-height: 1;
            font-size: 0.875rem;
        }

            section label {
                display: inline-block;
                width: 150px;
            }

        .links {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        a {
            text-decoration: none;
            color: #30788a;
            font-size: 0.875rem;
        }

        footer {
            display: flex;
            /*height: 60px;*/
            align-items: center;
            justify-content: end;
            padding-inline: 1.5rem;
            padding-block: 0.875rem;
            flex-grow: 0;
        }

        button {
            all: unset;
            background-color: #30788a;
            border-radius: 6px;
            color: white;
            padding-inline: 1rem;
            padding-block: 0.5rem;
            text-align: center;
            cursor: pointer;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
        }

            button:hover {
                background-color: #30788a;
            }
    </style>

    <script>

        function ClosePopup() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWidow)
                oWindow = window.frameElement.radWindow;
            oWindow.close();
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            var elmnt = window.parent.document.getElementsByName('form1');
            $(elmnt).on('click', function () {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWidow)
                    oWindow = window.frameElement.radWindow;
                oWindow?.close();
            });
        });

    </script>
</head>
<body>


    <form runat="server">
        <div class="about-container">
            <header>
                <h1>About PMWEB</h1>
                <a href="javascript:void(0);" onclick="ClosePopup()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="close-icon">
                        <path d="M6 6 l 12 12 M 6 18 l 12 -12" />
                    </svg>
                </a>
            </header>

            <hr />

            <main>
                <section>
                    <label for="lblClientNumber">Client #</label>
                    <asp:Label runat="server" ID="lblClientNumber" />
                </section>

                <section>
                    <label for="lblClientName">Client Name</label>
                    <asp:Label runat="server" ID="lblClientName" />
                </section>

                <section>
                    <label for="lblVersionNumber">Version</label>
                    <asp:Label runat="server" ID="lblVersionNumber" />
                </section>

                <section>
                    <label for="lblBuild">Build</label>
                    <asp:Label ID="lblBuild" runat="server" />
                </section>

                <section>
                    <label for="lblDllDate">DLL Date</label>
                    <asp:Label ID="lblDllDate" runat="server" />
                </section>

                <section class="links">
                    <a href="https://pmweb.com/technical-support/" target="_blank">Technical Support</a>
                    <a href="http://pmweb.com" target="_blank" style="display: none;">PMWeb.com</a>
                </section>
            </main>

            <hr />

            <footer>
                <button onclick="ClosePopup()">OK</button>
            </footer>
        </div>

    </form>
</body>
</html>
