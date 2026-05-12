<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MailSettings.aspx.cs" Inherits="SyosysWap.MailSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<h1>Mail Settings</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="server">

    <div class="row">
                <div class="col-lg-12">
                    <h6>
                    </h6>
                    <div class="alert alert-success alert-dismissable" id="successId" visible="false"
                        runat="server">
                        <button type="button" class="close" data-dismiss="alert">
                            &times;</button>
                        <strong>Success! </strong>
                        <asp:Label ID="lblSuccessmsg" runat="server"></asp:Label>
                    </div>
                    <div class="alert alert-danger alert-dismissable" id="failureId" visible="false"
                        runat="server">
                        <button type="button" class="close" data-dismiss="alert">
                            &times;</button>
                        <strong>Error! </strong>
                        <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
                    </div>
                </div>
            </div>


<div class="col-sm-12">
						<div class="box box-color box-bordered">
							<div class="box-title">
								<h3>
									<i class="fa fa-magic"></i>
									Mail Settings
								</h3>
                              <%--<span class="balanceleave">Annual Balance Leave</span>--%> <asp:Label ID="lblBalnceLeave" runat="server" CssClass="btn btn-warning pull-right _mkbalance" Visible="false"></asp:Label>
                                
							</div>
							<div class="box-content nopadding">
								<div class="form-horizontal">
									
                                    <br />
                                   <div class="col-sm-12 ">
                                                <div class="form-group col-lg-4 col-lg-offset-1">
                                                   <label for="exampleInputEmail1">Email<span class="red"></span></label>
                                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtUserName"
                                    Font-Bold="false" Font-Size="Small" ValidationGroup="Mail" ForeColor="Red"
                                    ErrorMessage="*" ></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtUserName"
                                ErrorMessage="Invalid email." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="Mail"></asp:RegularExpressionValidator>
                                                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                                   </div>

                                                    <div class="form-group col-lg-4">
                                                        <label for="exampleInputEmail1">Password<span class="red"></span></label> 
                                                        <asp:RequiredFieldValidator ID="rfvMailPassword" runat="server" ControlToValidate="txtPassword"
                                    ValidationGroup="Mail" ForeColor="Red"
                                    ErrorMessage="*"></asp:RequiredFieldValidator> 
                                                       
                                                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                                       
                                                        </div>
                                                  <div class="form-group col-lg-4">
                                                        <label for="exampleInputEmail1">Host<span class="red"></span></label> 
                                                        <asp:RequiredFieldValidator ID="rfvHost" runat="server" ControlToValidate="txtHost"
                                    ValidationGroup="Mail" ForeColor="Red"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                                         <asp:TextBox ID="txtHost" runat="server" CssClass="form-control"></asp:TextBox>
                                                       
                                                        </div>


                                                        <div class="form-group col-lg-4 col-lg-offset-1">
                                                   <label for="exampleInputEmail1">Port<span class="red"></span></label>
                                                    <asp:RequiredFieldValidator ID="rfvPort" runat="server" ControlToValidate="txtPort"
                                    Font-Bold="false" Font-Size="Small" ValidationGroup="Mail" ForeColor="Red"
                                    ErrorMessage="*" ></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revPort" runat="server" ControlToValidate="txtPort"
                                ErrorMessage="Invalid number." ValidationGroup="Mail" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                          
                                    
                                                        <asp:TextBox ID="txtPort" runat="server" CssClass="form-control"></asp:TextBox>
                                                   </div>

                                                    <div class="form-group col-lg-4">
                                                        <label for="exampleInputEmail1">CC<span class="red"></span></label> 
                                                       
                                                       
                                                        <asp:TextBox ID="txtSales" runat="server" CssClass="form-control"></asp:TextBox>
                                                       
                                                        </div>
                                                  <div class="form-group col-lg-4">
                                                  <label for="file_name">
                                                         Enable Ssl
                                                   </label>
                                                  <asp:CheckBox ID="chkEnableSsl" runat="server" CssClass="checkbox" />
                                                       <br />
                                                        </div>
                                                     
                                                        <div class="form-group col-lg-4 col-lg-offset-1">
                                                         <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="btn ui-wizard-content ui-formwizard-button" OnClick="btnCancel2_Click" />
                                                        <asp:Button ID="Button4" runat="server" Text="Update" CssClass="btn btn-primary ui-wizard-content ui-formwizard-button" ValidationGroup="Mail" OnClick="btnSave_Click"/>
                                                        </div>

                                                      
                                                  </div>
									
							
									</div>
									
									
								</div>
							
						</div>
					</div>
</asp:Content>
