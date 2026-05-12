<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DocuSignConnect.aspx.vb" Inherits="Website.DocuSignConnect" %>
<%@ Import  Namespace="System.Data.SqlClient" %>
<%@ Import  Namespace="System.Data" %>
<%@ Import  Namespace="System.IO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script runat="server">

            Public _tmpPM As Object
            Public ReadOnly Property tmpPM() As Library.PM
                Get
                    If Me._tmpPM Is Nothing Then
                        _tmpPM = Session("tmpPM")
                    End If
                    Return Me._tmpPM
                End Get
            End Property


            Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
                Dim reader = New StreamReader(Request.InputStream)
                Dim strJsonRequest = reader.ReadToEnd()
                If strJsonRequest.Trim.Length = 0 Then Exit Sub
                Dim jObj = Newtonsoft.Json.Linq.JObject.Parse(strJsonRequest)
                Dim strEnvelopeStatus As String = jObj.GetValue("status").ToString
                Dim strEnvelopeId As Guid = Guid.Parse(jObj.GetValue("envelopeId").ToString)


                Dim UserId As Integer = 5
                Dim Cnn As New SqlConnection
                Dim Cmd As New SqlCommand
                Dim tblDatabases As DataTable = New DataTable("tblPMWebDatabases")
                tblDatabases.ReadXmlSchema(Server.MapPath("PMWebDatabases.xml"))
                tblDatabases.ReadXml(Server.MapPath("PMWebDatabases.xml"))
                For Each row As DataRow In tblDatabases.Rows
                    Dim tmpCnnStr As String = row("ConnectionString")
                    Dim tmpId As String = row("Id")
                    Dim tmpDatabaseName As String = row("DatabaseName")

                    Try
                        Cnn.ConnectionString = tmpCnnStr
                        Cmd.Connection = Cnn
                        If Cnn.State <> ConnectionState.Open Then Cnn.Open()
                        Cmd.CommandText = "dbo.Workflow_UpdateDocuSignEnvelopeStatus"
                        Cmd.CommandType = CommandType.StoredProcedure
                        Cmd.Parameters.Clear()
                        Cmd.Parameters.AddWithValue("@EnvelopeGUID", strEnvelopeId)
                        Cmd.Parameters.AddWithValue("@Status", strEnvelopeStatus)
                        Cmd.ExecuteNonQuery()
                    Catch ex As Exception
                        Throw
                    Finally
                        If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
                    End Try
                Next
            End Sub
        </script>
    <div>
    
    </div>
    </form>
</body>
</html>
