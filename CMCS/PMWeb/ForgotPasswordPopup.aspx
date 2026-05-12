<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ForgotPasswordPopup.aspx.vb" Inherits="Website.ForgotPasswordPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE  html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FORGOT PASSWORD</title>
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" />
   <link href="CSS/MainCss.css?id=123" rel="stylesheet" type="text/css" />
    <link href="CSS/ControlsCSS/Button.css" rel="stylesheet" />
    <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
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

        header {
             font-size: 1.125rem;
             display: flex;
             justify-content: space-between;
             align-items: center;
             padding-inline: 1.5rem;
             padding-block: 0.875rem;
             flex-grow: 0;
         }

        .forgetPass-container {
             display: flex;
             flex-direction: column;
             height: 100dvh;
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

          h1 {
              font-size: 1.125rem;
              line-height: 2rem;
              font-weight: 600;
              color: #101828;
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
               gap: 10px;
               flex-grow: 1;
            } 

           .textContent{
               font-family: InterVariable, sans-serif !important;
               font-size: 14px; 
               margin-bottom: 30px;
               color:#101828;
            }

            input.BtnOK {
                border: none !important;
                width: 44px !important;
                height: 36px !important;
                
                box-sizing: border-box;
                border-radius: 6px;
                font-family:   InterVariable, sans-serif !important;
                font-weight: 600;
                color: #ffffff !important;
                text-align: center !important;
                text-transform: none !important;
                line-height: normal !important;
                font-size: 14px !important;
                background-color:  /*2*/#30788a/*2*/ !important;
                margin-top:16px;
                margin-bottom:16px;
              }

            input.BtnOK:hover{
                  background-color:  /*2*/#30788a/*2*/ !important;
                  box-sizing: border-box !important;
              }

             .BtnCancel {
                    width: 66px !important;
                    height: 36px !important;
                
                    background-color: #ffffff !important;
                    border: 1px solid #d0d5dd !important;
                    border-radius: 4px;
                    box-sizing: border-box !important;
                    font-family:   InterVariable, sans-serif !important;
                    font-weight: 600 !important;
                    color: #344054 !important;
                    text-align: center !important;
                    line-height: normal !important;
                    text-transform: none !important;
                    font-size: 14px !important;
                    margin-top:16px;
                    margin-bottom:16px;
              }

             .BtnCancel:hover {
                     background-color: #f2f4f7;
                     box-sizing: border-box !important;
              }

             .BtnCancel:checked {
                     background-color: #57534e;
                     box-sizing: border-box !important;
                     color: #ffffff;
               }

             .LogInSpanPwnd {
                     background-color: rgba(242, 242, 242, 0);
                     box-sizing: border-box;
                     font-size:12px;
                     font-family: InterVariable, sans-serif !important;
                     color: rgba(127, 127, 127);
                     text-align: left;
                     line-height: normal;
                     display: block;
                     padding-bottom: 2px;
              }





/*        input#txtUserName {
            width: 280px;
            height: 38px;
            outline: none;
            padding: 2px 16px 2px 16px;
            background-color: #ffffff;
            box-sizing: border-box;
            font-family: Roboto, sans-serif;
            color: #000000;
            text-align: left;
            font-size: 14px;
        }*/

      
        td.rcbInputCell.rcbInputCellLeft {
            background-color: #f3f3f3;
        }

      /*  input#txtUserName {
            margin-left: -20px !important;
            width: 335px !important;
            margin-top: 11px;
        }*/

        td.rcbInputCell.rcbInputCellLeft {
           border: 1px solid #d0d5dd !important;
           border-radius:6px
        }

        input#CboUsers_Input {
            border: none;
            width: 361px;
            height: 34px;
            outline: none;
            padding: 2px 16px 2px 16px;
            box-sizing: border-box;
            font-family: Roboto, sans-serif;
            color: #000000;
            text-align: left;
            font-size: 16px;
            background-color: #FFFFFF;
        }

        input#CboUsers_Input {
            box-sizing: border-box;
         
        }

      

        .RadComboBox table td.rcbArrowCell {
            padding: 0px !important;
            border: 0px !important;
        
            width: 24px;
            height: 24px;
        }

            .RadComboBox table td.rcbArrowCell a {
                height: 0 !important;
            }


        div#CboUsers_DropDown {
            background-color: #FFFFFF;
            width: 360px !important;
        }

        .rcbScroll.rcbWidth {
            width: 99% !important;
        }
  

.input-label {
    display: inline-block !important;
    color: #101828;
    margin-bottom: 2px;
    cursor: pointer;
}

    .form-ddl-input input.rcbInput:focus {
        box-sizing: border-box;
        border-bottom-width: 2px;
        border-bottom-style: solid;
        border: 1px solid #30788a    !important;
        outline: none;
        filter:none !important;
    }

.form-ddl-input,
.form-ddl-input table {
    color: var(--input-text-color, black);
    width: 100% !important;
    /*--input-height: 43px;*/
}

    .form-ddl-input * {
        border: none !important;
    }


    .form-ddl-input table tbody {
        display: contents
    }

        .form-ddl-input table tbody tr {
            display: grid;
            /*position: relative;*/
            width: 100%;
            height: var(--input-height);
            align-items: center;
        }

    .form-ddl-input td.rcbInputCellLeft {
        height: 36px;
        background: none;
        border-radius: 6px;
        grid-area: 1 / -1;
    }

    .form-ddl-input input.rcbInput {
        background: white;
        
        border: 1px solid #7f7f7f;
        width: 326px;
        height: var(--input-height);
        outline: none;
        padding-left: 0.75rem !important;
        padding-right: 36px;
        font-size: var(--input-font-size, 14px);
        border-radius: 6px;
        color: var(--input-text-color, black);
        /*padding-block: 0.75rem;*/
    }

        .form-ddl-input input.rcbInput[readonly],
        .form-ddl-input input.rcbInput[readonly]:focus,
        .form-ddl-input input.rcbInput[readonly]:hover,
        .form-ddl-input .rcbHovered .rcbReadOnly input.rcbInput[readonly],
        .form-ddl-input .rcbFocused .rcbReadOnly input.rcbInput[readonly] {
            cursor: pointer;
            color: var(--input-text-color, black);
        }

    .form-ddl-input td.rcbArrowCell {

        /*width: 24px;
        height: 24px;*/
        width: 1.5rem;
        aspect-ratio: 1 / 1;
        background-position: 0px 0px !important;
        background-color: transparent !important;
        background-repeat: no-repeat;
        background-size: cover;
        cursor: pointer !important;
        grid-area: 1 / -1;
        margin-right: 12px;
        justify-self: end;
        z-index: 0;
    }

        .form-ddl-input td.rcbArrowCell a {
            pointer-events: none;
            visibility: hidden;
        }

.rcbSlide {
    display: none;
    position: absolute;
    overflow: hidden;
    margin-block: 7px !important;
 box-shadow:0px 4px 10px 0px rgba(0, 0, 0, 0.3);
     border-radius:9px
}

.rcbSlide,
.form-ddl,
.form-ddl .rcbScroll {
    height: var(--ddl-height) !important;
}

    .form-ddl,
    .form-ddl .rcbScroll {
        border: none;
        border-radius: 6px;
        color: #333;
        background-color: white;
        font-family: InterVariable, sans-serif;
        border-width: 0;
    }
    .form-text-input {
    font-size: var(--input-font-size, 14px) !important;
    border-radius: 6px !important;
    width: 326px !important;
    height: var(--input-height, 43px) !important;
    color: var(--input-text-color, black) !important;
   
    border: 1px solid #7f7f7f !important;
    padding-left: 0.75rem !important;
    /*padding-block: 0.75rem*/
}

    .form-text-input:focus,
    .form-ddl-input input.rcbInput:focus {
        box-sizing: border-box;
        border-bottom-width: 2px;
        border-bottom-style: solid;
        filter: drop-shadow(0px 0px 6.5px rgba(224, 213, 244, 1));
        outline: none;
    }

        .form-ddl .rcbScroll {
            overflow: auto;
        }

.form-ddl {
    overflow-x: hidden;
}

    .form-ddl ul.rcbList {
        list-style: none;
        font-size: var(--input-font-size, 14px)
    }

    .form-ddl li.rcbItem {
        all: unset;
        box-sizing: border-box;
        font-size: var(--input-font-size, 14px);
        display: flex;
        justify-content: space-between;
        width: calc(100);
        height: 2.675rem; /*42px;*/
        align-items: center;
        padding-block: 5px;
        /*background: #f8f9fa;*/
        margin: 4px;
        border-radius: 6px;
        padding-inline: 6px;
        color: var(--input-text-color, black);
        cursor: pointer;
    }


        .form-ddl li.rcbItem span:first-child {
            flex: 1;
        }

        .form-ddl li.rcbItem i {
            margin-right: 8px;
        }

            .form-ddl li.rcbItem i svg {
                width: 0.875rem;
                height: auto;
                stroke: #3654e9;
                stroke-width: 40px;
            }

        .form-ddl li.rcbItem .selected-icon {
            display: none;
        }

        .form-ddl li.rcbItem.rcbSelected {
            color: black;
            background: #f8f9fa;
        }

            .form-ddl li.rcbItem:hover,
            .form-ddl li.rcbItem.rcbSelected:hover,
            .form-ddl li.rcbItem:focus,
            .form-ddl li.rcbItem.rcbSelected:focus {
                background-color: #f0f2f5;
            }

            .form-ddl li.rcbItem.rcbSelected .selected-icon {
                display: block;
            }
       
    </style>

    <script type="text/javascript">
        function ClosePopup() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            var popupElement = $(oWindow.get_popupElement());

            oWindow.close();

        }
     
      

        function getElementId(event) {
            var elementid = event.target.id;
            var spans = document.getElementsByClassName('LogInSpanPwnd');
            for (let i = 0; i <= spans.length - 1; i++) {
                if (!spans[i].classList.contains('highlight'))
                    switch (elementid) {
                        case "cboDatabases_Input":
                            spans[0].classList.add('highlight')
                            break;
                        case "cboUsers_Input":
                        case "txtUser":
                            spans[1].classList.add('highlight')
                            break;
                        case "txtPassword":
                            spans[2].classList.add('highlight')
                            break;

                    }
            }
        }


        document.addEventListener('DOMContentLoaded', function (event) {
            var elements = document.getElementsByClassName('rcbArrowCellRight');

            elements[0].addEventListener('click', function (event) {
                if (event.target.closest('.rcbInputCell')) {
                    //if (!comboBoxDb.get_dropDownVisible()) {
                    //    comboBoxDb.showDropDown();
                    //} else {
                    //    comboBoxDb.hideDropDown();
                    //}
                    return;
                }
                var comboBoxDb = $find('<%= CboUsers.ClientID  %>');
                if (!comboBoxDb.get_dropDownVisible()) {
                    comboBoxDb.showDropDown();
                } else {
                    comboBoxDb.hideDropDown();
                }

            });
       });


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forgetPass-container">
              <header >
                     <h1> Forgot Password</h1>
                     <a href="javascript:void(0);" onclick="ClosePopup()">
                             <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="close-icon">
                                  <path d="M6 6 l 12 12 M 6 18 l 12 -12" />
                              </svg>
                      </a>
              </header>
              <hr />
              <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
         <main style=" margin:23px;">
          <section style="display: flex; flex-wrap: wrap; align-items: center; margin-bottom: 20px;">
                       <div>
                        <telerik:RadComboBox ID="CboUsers" runat="server" Filter="Contains" MarkFirstMatch="true"
        CloseDropDownOnBlur="true" AllowCustomText="true" Visible="false" CssClass="form-ddl-input"
        Height="232px" Style="border-radius: 5px;" TabIndex="2"   
        DropDownCssClass="form-ddl" onclick="getElementId(event)" ExpandAnimation-Type="None"
        ExpandAnimation-Duration="0000" CollapseAnimation-Type="None" CollapseAnimation-Duration="0000"
        Label="User" LabelCssClass="input-label">
        <ItemTemplate>
            <asp:Label runat="server" Text='<%# Eval("Username") %>'></asp:Label>
            <i class="selected-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" viewBox="20 -237.5 356.2 257.5" stroke="#3654e9" stroke-width="40">
                    <path d="m 40 -98.7 l 98.7 98.7 l 217.5 -217.5" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
            </i>
        </ItemTemplate>
    </telerik:RadComboBox>
    <telerik:RadTextBox ID="txtUserName" runat="server" CausesValidation="True" Width="85%" Visible="false"
        Style="height: 40px;" TabIndex="2" CssClass="form-text-input">
    </telerik:RadTextBox>
</div>
                      <%--     <div style="flex: 1;" class="LogInSpanPwnd">
                                   <asp:Label runat="server" AssociatedControlID="txtUserName" class="LogInSpanPwnd">User</asp:Label>
                           </div>
                           <div style="flex: 2;">
                                   <asp:TextBox ID="txtUserName" runat="server" onclick="getElementId(event)"></asp:TextBox>
                                   <telerik:RadComboBox 
                                              ID="CboUsers" 
                                              runat="server" 
                                              Filter="Contains" 
                                              MarkFirstMatch="true" 
                                              Width="100%"  
                                              onclick="getElementId(event)" 
                                              AllowCustomText="true" 
                                              DropDownCssClass="AngularLogInDropDown"></telerik:RadComboBox>
                           </div>--%>
                    </section>

                    <section class="textContent" >
                             <p>If you continue, the current password for the user above will be deleted and a new one will be emailed to the address linked to the account. This process cannot be undone.</p>
                             <p style="padding-top:20px">Do you wish to continue?</p>
                     </section>

                </main>
                 <hr />

                     <section style="text-align: right; margin-right:24px">
                             <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="70px" CssClass="BtnCancel" OnClientClick="return ClosePopup();" />
                     &nbsp;&nbsp;
                             <asp:Button ID="BtnOK" UseSubmitBehavior="false" runat="server" Text="OK"  CssClass="BtnOK" />
                      </section>

                      <section style="position: relative; bottom: 10px; margin-left:24px">
                              <asp:Label ID="lblMessage" runat="server"></asp:Label>
                      </section>

            
 
           
            <%--<div>
                <table width="96%" style="margin: 10px 10px 10px 10px;">
                    <tr>
                        <td style="width: 50%" class="LogInSpanPwnd">
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtUserName" class="LogInSpanPwnd">User</asp:Label>
                                <br />
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtUserName" runat="server" onclick="getElementId(event)"></asp:TextBox>
                            <telerik:RadComboBox ID="CboUsers" runat="server" Filter="Contains" MarkFirstMatch="true" Width="100%" onclick="getElementId(event)" AllowCustomText="true" ></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr class="trtxt">
                        <td colspan="2" style="font-family: 'Roboto', sans-serif; color: rgb(85, 85, 85); font-size: 16px">
                            <br />
                            If you continue, the current password for the user above will be deleted and a new one will be emailed to the address linked to the account. This process cannot be undone.
                        <br />
                            <br />
                            Do you wish to continue?
                        <br />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr class="trBtns">
                        <td align="right" colspan="2">
                            <asp:Button ID="btnOk" UseSubmitBehavior="false" runat="server" Text="OK" Width="70px" CssClass="BtnOK" />
                            &nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="70px" CssClass="BtnCancel" OnClientClick="return ClosePopup();" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="position: relative; bottom: 10px;">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>--%>
       </div>
    </form>
</body>
</html>
