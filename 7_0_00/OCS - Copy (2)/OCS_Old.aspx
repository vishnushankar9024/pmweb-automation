<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OCS_Old.aspx.cs" Inherits="SyosysWap.OCS_Old" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-horizontal {
            padding-left: 30px;
        }

        .form-group label {
            padding-top: 6px;
            font-weight: bold;
        }
        .form-horizontal input, .form-horizontal select, .form-horizontal textarea{
            width:90%;
        }
        span.red{
            color:#FF0000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <img src="App_Themes/Site/HomeTheme/images/hmc_logo124.png" alt="" class='retina-ready' style="float: right !important;">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="server">
    <asp:ToolkitScriptManager ID="scriptmanger" runat="server"></asp:ToolkitScriptManager>


    <div class="col-sm-12">

        <div class="box">
            <div class="box-title">

                <div style="text-align: center; text-decoration: underline; font-size: large; font-weight: bolder;">Observations & Comments Sheet (OCS) </div>

            </div>
            <div class="box-content nopadding">
                <div class="form-horizontal">

                    <br />
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <label for="exampleInputEmail1" style="font-weight: bold;">Project Code/No.: </label>&nbsp;<asp:Label ID="lblProjectNumber" runat="server"></asp:Label><br />
                            <label for="exampleInputEmail1" style="font-weight: bold;">Project Title: </label>&nbsp;<asp:Label ID="lblProjectName" runat="server"></asp:Label>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <label for="exampleInputEmail1" style="font-weight: bold;">Record No.: </label>&nbsp;<asp:Label ID="lblRecordNumber" runat="server"></asp:Label><br />
                            <label for="exampleInputEmail1" style="font-weight: bold;">OCS Date: </label>&nbsp;<asp:Label ID="lblOcsDate" runat="server"></asp:Label>
                        </div>
                    </div>


                    <%--<table class="table table-hover table-nomargin table-bordered">
									<thead>
										<tr>
                                            <th style="background: #25a0da;color:white;font-weight: 500">Project Code/No.</th>
                                            <th style="background: #25a0da;color:white;font-weight: 500">Project Title</th>
                                            <th style="background: #25a0da;color:white;font-weight: 500">Record No.</th>
                                            <th style="background: #25a0da;color:white;font-weight: 500">OCS Date</th>
                                            
										</tr>
									</thead>
									<tbody>
										
                                        </tbody>
                        <tr>
                                             <td><asp:Label ID="lblProjectNumber" runat="server"></asp:Label></td>
                                             <td><asp:Label ID="lblProjectName" runat="server"></asp:Label></td>
                                             <td><asp:Label ID="lblRecordNumber" runat="server"></asp:Label></td>
                                             <td><asp:Label ID="lblOcsDate" runat="server"></asp:Label></td>
										</tr>
                                        </table>--%>
                </div>
            </div>

        </div>

        <div class="box box-bordered">
            <div class="box-title">
                The document(s) reviewed under this OCS, were issued "For Review and Comments" and are hereby return to the issuer with the following return code and actions request:
                            <div style="width: 120px; float: right">
                                <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="btn ui-wizard-content ui-formwizard-button" OnClick="btnCancel2_Click" />
                                <asp:Button ID="Button2" runat="server" Text="Save" CssClass="btn btn-primary ui-wizard-content ui-formwizard-button" ValidationGroup="ocs"
                                    OnClick="btnSave_Click" />
                            </div>
            </div>
            <div class="box-content nopadding">
                <div class="form-horizontal">

                    <br />
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtDocumentTitle">Document Title: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtDocumentTitle" runat="server" CssClass="form-control" required ValidationGroup="ocs" TabIndex="0"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtDocReferenceNumber">Ref. No.: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtDocReferenceNumber" runat="server" CssClass="form-control" required ValidationGroup="ocs" TabIndex="2"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="ddlAssessCode">Assessment Code: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="ddlAssessCode" runat="server" class="form-control" placeholder="Project" ValidationGroup="ocs" TabIndex="4">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtRevNo">Rev.No.: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtRevNo" runat="server" CssClass="form-control" required ValidationGroup="ocs" TabIndex="1"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtDisciplineEng">Discipline Engineer: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtDisciplineEng" runat="server" CssClass="form-control" required ValidationGroup="ocs" TabIndex="3"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                             <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtConsultantComments">Consultant Comments: <span class="red">*</span></label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtConsultantComments" runat="server" CssClass="form-control" TextMode="MultiLine" ValidationGroup="ocs" TabIndex="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                         <label for="txtFinalComments">Final Comments:</label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtFinalComments" runat="server" CssClass="form-control" TextMode="MultiLine" TabIndex="7"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtHFDComments">HFD Comments:</label>
                                    </div>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtHFDComments" runat="server" CssClass="form-control" TextMode="MultiLine" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-md-3 text-right">
                                        <label for="txtContractorResponse">Contractor Response:</label>
                                    </div>
                                    <div class="col-md-9">
                                       <asp:TextBox ID="txtContractorResponse" runat="server" CssClass="form-control" TextMode="MultiLine" TabIndex="8"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <h6></h6>
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

        <div class="box box-color box-bordered">
            <div class="box-title">
                <h3>
                    <i class="fa fa-table"></i>
                    Log
                </h3>
            </div>
            <div class="box-content nopadding">
                <asp:ListView ID="lvwListing" runat="server" DataKeyNames="Row" OnItemCommand="lvwListing_ItemCommand"
                    OnItemDataBound="lvwListing_ItemDataBound" OnItemEditing="lvwListing_ItemEditing" OnItemDeleting="lvwListing_ItemDeleting">
                    <LayoutTemplate>
                        <table class="table table-hover table-nomargin dataTable table-bordered">
                            <thead>
                                <tr>
                                    <th>Document Title</th>
                                    <th>Rev.No.</th>
                                    <th>Document Ref. No.</th>
                                    <th>Discipline Engineer</th>
                                    <th>HFD / Consultant Comments</th>
                                    <th>Consultant/Contractor Response</th>
                                    <th>HFD Comments</th>
                                    <th>Final Comments</th>
                                    <th>Created Date</th>
                                    <th>Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="ItemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="width: 10% !important;"><%#Eval("Document_Title")%></td>
                            <td style="width: 5% !important;"><%#Eval("Rev_No")%></td>
                            <td style="width: 13% !important;"><%#Eval("Document_Ref_No")%></td>
                            <td style="width: 10% !important;"><%#Eval("Discipline_Engineer")%></td>
                            <td style="width: 25% !important;"><%#Eval("Comments")%></td>
                            <td style="width: 25% !important;"><%#Eval("Response")%></td>
                            <td style="width: 25% !important;"><%#Eval("HFD Comments")%></td>
                            <td style="width: 25% !important;"><%#Eval("Final Comments")%></td>
                            <td style="width: 7% !important;"><%#Eval("CreatedDate")%></td>
                            <td style="width: 6% !important;">
                                <asp:LinkButton ID="lbtnEdit" runat="server" CommandName="edit" CommandArgument='<%#Eval("Row") %>'>Edit</asp:LinkButton></td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>




            </div>
        </div>

    </div>

</asp:Content>
