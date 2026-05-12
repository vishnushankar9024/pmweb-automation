<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BidderClauses.ascx.vb" Inherits="Website.BidderClauses" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgClauses">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>    
                              <telerik:AjaxSetting AjaxControlID="rdgOnlineBidUserDefinedFields">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOnlineBidUserDefinedFields" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>     
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMMainPage">
<div class="PMHeader">
    <div class="row">
        <div class="col-6">

                        <fieldset><legend><asp:Label ID="lblClauses" runat="server" meta:resourcekey="lblClauses" Text="Clauses" ></asp:Label></legend>
                <telerik:RadGrid ID="rdgClauses" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus = "true" FitParentContainer="true"
                                ShowGroupPanel="True" AllowMultiRowEdit="True" AllowPaging="true" PageSize="15" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
                                
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"   
                                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                                                EnableHeaderContextMenu="true">

                                <Columns>    
                          
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Line #"  ItemStyle-Wrap="false" UniqueName="LineNumber" DataField="LineNumber"
                                                                SortExpression="LineNumber" Groupable="false"> 
                                        <ItemTemplate> 
                                            <span><%#Container.DataItem("LineNumber").ToString%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span><%#Eval("LineNumber").ToString%></span>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Paragraph"  ItemStyle-Wrap="false" UniqueName="Paragraph" DataField="Paragraph"
                                                                SortExpression="Paragraph" GroupByExpression="Paragraph [GridColumn_Paragraph] Group By Paragraph ASC">
                                        <ItemTemplate> 
                                            <span><%#IIf(Container.DataItem("Paragraph").ToString = String.Empty, "&nbsp;", Container.DataItem("Paragraph").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtParagraph" MaxLength="500" runat="server" Text='<%# Eval("Paragraph") %>' Width="100%" ></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Category" UniqueName="Category" DataField="Category"
                                                                SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                                        <ItemTemplate> 
                                            <span><%#IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>              
                                            <asp:DropDownList ID="ddlCategory" runat="server" Width="100%"></asp:DropDownList>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px"  ItemStyle-Wrap="false"  HeaderText="Type" UniqueName="Type" DataField="Type"
                                                                SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                        <ItemTemplate> 
                                            <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>              
                                            <asp:DropDownList ID="ddlType" runat="server" Width="100%"></asp:DropDownList>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description"  ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                                                SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                        <ItemTemplate> 
                                            <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Text" ItemStyle-Wrap="false" UniqueName="Text" DataField="Text"
                                                                SortExpression="Text" GroupByExpression="Text [GridColumn_Text] Group By Text ASC">
                                        <ItemTemplate>                                       
                           
                                            <asp:LinkButton runat="server" ID="imgReadText" CssClass="SearchButton" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText','lblText'),this)" >
    					                        <span class="Icon"></span>
				                            </asp:LinkButton>



                                        <asp:Label runat="server" ID="lblText" Text='<%#IIf(Container.DataItem("Text") = String.Empty, "&nbsp;", Container.DataItem("Text"))%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtText" runat="server" Text='<%#Eval("Text")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                                            
                                       <asp:LinkButton runat="server" ID="imgText" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgText','txtText'))">
    					                    <span class="Icon"></span>
				                        </asp:LinkButton>
                                            
                                            
                                             </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn> 
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px"   ItemStyle-Wrap="false"  HeaderText="Responsible" UniqueName="Responsible" DataField="Responsible"
                                                                SortExpression="Responsible" GroupByExpression="Responsible [GridColumn_Responsible] Group By Responsible ASC">
                                        <ItemTemplate> 
                                            <span><%#IIf(Container.DataItem("Responsible").ToString = String.Empty, "&nbsp;", Container.DataItem("Responsible").ToString)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlResponsible" runat="server" Width="100%"></asp:DropDownList>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Start" UniqueName="Start" DataField="Start"
                                                                SortExpression="Start" GroupByExpression="Start [GridColumn_Start] Group By Start ASC">
                                        <ItemTemplate>
                                            <span><%#FormatDate(Eval("Start"))%></span>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="dtpStart"  AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                                   <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                                   <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                   <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                        <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>

                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false"  HeaderText="Days To Start" UniqueName="DaysToStart" Groupable="false">
                                        <ItemTemplate> 
                                            <asp:Label ID="lblDaysToStart" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblEditDaysToStart" runat="server"></asp:Label>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="100px" />
                                             <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="End" UniqueName="End" DataField="End"
                                                                SortExpression="End" GroupByExpression="End [GridColumn_End] Group By End ASC">
                                        <ItemTemplate>
                                            <span><%#FormatDate(Eval("End"))%></span>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="dtpEnd"  AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                                   <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                                   <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                   <DateInput ID="DateInput2"  LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                        <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false"  HeaderText="Days To End" UniqueName="DaysToEnd" Groupable="false">
                                        <ItemTemplate> 
                                            <asp:Label ID="lblDaysToEnd" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblEditDaysToEnd" runat="server"></asp:Label>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="100px" />
                                             <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                                                SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                        <ItemTemplate>
                                        

                                        <asp:LinkButton runat="server" ID="imgReadText2" CssClass="SearchButton" OnClientClick="return OpenViewNoteDetailPopup(this.id.replace('imgReadText2','lblNotes'),this)" >
    					                    <span class="Icon"></span>
				                        </asp:LinkButton>
                                            
                                            <asp:Label runat="server" ID="lblNotes" Text='<%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>'></asp:Label>
                                            
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" ></asp:TextBox>
                                            
                                        <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                        
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    
                             
    
                                </Columns>

                               
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                </telerik:RadGrid>
            </fieldset>
        </div>
        <div class="col-6">
                        <fieldset><legend><asp:Label ID="lblOnlineBidUserDefinedFields" runat="server" meta:resourcekey="lblOnlineBidUserDefinedFields" Text="Online Bid User Defined Fields"></asp:Label></legend>
                <telerik:RadGrid ID="rdgOnlineBidUserDefinedFields" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus = "true" FitParentContainer="true"
                                ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None" UseEditFormInMobile="true" >
                                <HeaderContextMenu  EnableViewState="false" ></HeaderContextMenu>
                
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"    
                                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                                                EnableHeaderContextMenu="true">

                    
                <Columns>
                
                          
                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Field"  ItemStyle-Wrap="false" UniqueName="Field" DataField="Field" Groupable="false"
                                                SortExpression="Header">
                        <ItemTemplate> 
                            <span><%#IIf(Container.DataItem("Header").ToString = String.Empty, "&nbsp;", Container.DataItem("Header").ToString)%></span>
                        </ItemTemplate>
                    <ItemTemplate> 
                            <span><%#IIf(Eval("Header").ToString = String.Empty, "&nbsp;", Eval("Header").ToString)%></span>
                        </ItemTemplate>
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                        
                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Data"  ItemStyle-Wrap="false" UniqueName="Data" DataField="Value"  Groupable="false">
                     <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUDF" runat="server" />
                </ItemTemplate>
                      <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUDF" runat="server" />
                </EditItemTemplate>
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>    
                     
                </Columns>
                <ItemStyle Wrap="false" />  
                <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                
                   <CommandItemTemplate>
                        <div style="padding: 2px">
                             
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" SecurityButtonType="ItemMode_Edit"
                                            Visible='<%# rdgOnlineBidUserDefinedFields.EditIndexes.Count = 0 And (Not rdgOnlineBidUserDefinedFields.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnEditSelectedResource1">
                                           <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" SecurityButtonType="AddEditMode_Edit"
                                            Visible='<%# rdgOnlineBidUserDefinedFields.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" SecurityButtonType="AddEditMode"
                                            Visible='<%# rdgOnlineBidUserDefinedFields.EditIndexes.Count > 0 %>' meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                            Visible='<%# rdgOnlineBidUserDefinedFields.EditIndexes.Count = 0%>' meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                            &nbsp;&nbsp;
                            </asp:LinkButton>
                              
                        </div>
                    </CommandItemTemplate>
                
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="false" >                        
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
</div>
    </div>