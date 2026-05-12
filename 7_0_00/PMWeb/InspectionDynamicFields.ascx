<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InspectionDynamicFields.ascx.vb" Inherits="Website.InspectionDynamicFields" %>

       
            <asp:Repeater runat="server" ID="rptInspectionDynamicFields">
                <ItemTemplate>
                    <tr runat="server" style='<%# "order:" + DataBinder.Eval(Container.DataItem, "order") %>'>
                        <td class="labelWidth" style="width:160px !important;">
<%--                            <div class='<%# IIf(Container.DataItem("FieldTypeId") = 10, "lblMemo floatLeft", "floatLeft")%>'>--%>
                                <asp:Label ID="lblMeasure" runat="server" Visible="false"  />
                            </div>
                            <div class="floatRight">
                                <asp:LinkButton runat="server" ID="imgMemo" Visible="false" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtMemo'))" CssClass="SearchButton">
                                       <span class="Icon"></span>
                                </asp:LinkButton>
                            </div>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtMeasure" Visible="false" MaxLength="4000"  runat="server"></asp:TextBox>
                            <asp:CheckBox ID="chkMeasure" Visible="false" runat="server" />
                            <asp:TextBox ID="txtDate" MaxLength="100" Style="text-align: right"  Visible="false" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                            <telerik:RadDatePicker ID="rdpMeasure" MinDate="01/01/1901" Visible="false" 
                                MaxDate="12/31/2100" runat="server" Skin="Default" >
                                <Calendar Width="200px"></Calendar>
                                <ClientEvents OnDateSelected="dateSelected" />
                            </telerik:RadDatePicker>
                            <telerik:RadComboBox MarkFirstMatch="True" Filter="Contains" AllowCustomText="True"
                                sNoWrap="true" ID="ddlMeasure" runat="server" Width="100%" Height="400px" Visible="false" Skin="Default"
                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            </telerik:RadComboBox>
                        
                            <asp:TextBox runat="server" Visible="false" TextMode="MultiLine" ID="txtMemo" ></asp:TextBox>
                  <%--          <asp:RequiredFieldValidator ID="rfvMeasure" runat="server" ControlToValidate="" Enabled="false"
                                CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                             <asp:CustomValidator ID="csvMeasure" runat="server" ControlToValidate="ddlMeasure"
                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, INVALID_DATA%>">
                        </asp:CustomValidator>--%>

                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
       
  