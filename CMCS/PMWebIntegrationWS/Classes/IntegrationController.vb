Imports System.Data.SqlClient
Imports System.Xml
Imports System.Xml.Serialization
Imports System.Xml.Schema

Public Class IntegrationController
    Inherits System.Web.Services.WebService

    Private _dts As dtsAgcXml

    Public ReadOnly Property DataSet() As dtsAgcXml
        Get
            If (_dts Is Nothing) Then
                _dts = New dtsAgcXml()
            End If
            Return _dts
        End Get
    End Property


    Public Function GetFirstTableName(ByVal FileName As String) As String
        Dim dtSchema As New DataTable
        Dim connectionString As String() = {"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;""",
           "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""",
           "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;""",
           "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
            }

        For Each connString As String In connectionString
            Try
                Using conn As New System.Data.OleDb.OleDbConnection(connString)
                    conn.Open()
                    dtSchema = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    If dtSchema.Rows.Count > 0 Then
                        Return "[" & CStr(dtSchema.Rows(0)("Table_Name")) & "]"
                    End If
                End Using
            Catch ex As Exception
                Throw
            End Try
        Next
        Return ""

    End Function

    Public Function GetXlsxFirstTableName(ByVal FileName As String) As String
        Dim dtSchema As New DataTable
        Dim connectionString As String() = {"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;""",
            "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""",
            "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;""",
            "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
            }

        For Each connString As String In connectionString
            Try
                Using conn As New System.Data.OleDb.OleDbConnection(connString)
                    conn.Open()
                    dtSchema = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    If dtSchema.Rows.Count > 0 Then
                        Return "[" & CStr(dtSchema.Rows(0)("Table_Name")) & "]"
                    End If
                End Using
            Catch ex As Exception
                Throw
            End Try
        Next
        Return ""
    End Function

    Public Function GetXlsxAllTableNames(ByVal FileName As String) As String
        Dim dtSchema As New DataTable

        Try
            Try
                Try
                    Using conn As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;""")
                        conn.Open()
                        dtSchema = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    End Using
                Catch
                    Using conn1 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""")
                        conn1.Open()
                        dtSchema = conn1.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    End Using
                End Try
                Using conn16 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;""")
                    conn16.Open()
                    dtSchema = conn16.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                End Using
            Catch
                Using conn1_16 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""")
                    conn1_16.Open()
                    dtSchema = conn1_16.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                End Using
            End Try
            If dtSchema.Rows.Count = 0 Then Return ""
            Dim TableNames As String = ""
            For i = 0 To dtSchema.Rows.Count - 1
                If TableNames = String.Empty Then
                    TableNames = "[" & CStr(dtSchema.Rows(i)("Table_Name")) & "]"
                Else
                    TableNames = TableNames & "|" & "[" & CStr(dtSchema.Rows(i)("Table_Name")) & "]"
                End If
            Next
            Return TableNames
        Catch ex As Exception
            Throw
        End Try
    End Function

    Public Function GetAllTableName(ByVal FileName As String) As String
        Dim dtSchema As New DataTable
        Try
            Try
                Try
                    Using conn As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;""")
                        conn.Open()
                        dtSchema = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    End Using
                Catch
                    Using conn1 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""")
                        conn1.Open()
                        dtSchema = conn1.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                    End Using
                End Try
                Using conn16 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;""")
                    conn16.Open()
                    dtSchema = conn16.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                End Using
            Catch
                Using conn1_16 As New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;""")
                    conn1_16.Open()
                    dtSchema = conn1_16.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
                End Using
            End Try
            If dtSchema.Rows.Count = 0 Then Return ""
            Dim TableNames As String = ""
            For i = 0 To dtSchema.Rows.Count - 1
                If TableNames = String.Empty Then
                    TableNames = "[" & CStr(dtSchema.Rows(i)("Table_Name")) & "]"
                Else
                    TableNames = TableNames & "|" & "[" & CStr(dtSchema.Rows(i)("Table_Name")) & "]"
                End If
            Next
            Return TableNames
        Catch ex As Exception
            Throw
        End Try
    End Function

#Region "XML WebService"

    Private _RFIInfo As RFIInfo

   
    Public Property RFIInfo() As RFIInfo
        Get
            If _RFIInfo Is Nothing Then _RFIInfo = New RFIInfo()
            Return _RFIInfo
        End Get
        Friend Set(ByVal value As RFIInfo)
            _RFIInfo = value
        End Set
    End Property


    Private Function GetDBConnectionString() As String
        Dim dtsDBConnection = New DataSet

        dtsDBConnection.ReadXml(Me.Server.MapPath("PMWebDatabases.xml"))

        Dim drDatabase As DataRow = dtsDBConnection.Tables(0).Select("ID = '1'")(0)
        Dim DBConnectionString = drDatabase("ConnectionString").ToString

        Return DBConnectionString
    End Function
    Public Function GetRFIIdIfExists(ByVal ProjectID As String, ByVal RFIID As String) As Integer
        Dim ReturnId As Integer
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.Connection = Cnn

        Try


            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.CommandText = "[dbo].[IntegrationWebService_GetRFIIdIfExists]"
            Cmd.Parameters.Clear()
            With Cmd.Parameters
                .AddWithValue("@ProjectNumber", ProjectID)
                .AddWithValue("@RFIXmlNumber", RFIID)
            End With
            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
            ReturnId = CInt(Cmd.ExecuteScalar)


            Return ReturnId
        Catch ex As Exception
            Throw ex
        Finally
            Cmd.Parameters.Clear()
            If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
        End Try
    End Function

    Public Function InsertRFIIntoDatabase(ByVal ProjectID As String, ByVal RFIID As String, ByVal RFIReplyLineId As String, ByVal RFITitle As String, ByVal RFIQuestion As String, ByVal RFIProposedSolution As String, ByVal RFIReplyDueDate As Date?, ByVal RFIIssuedDate As Date?) As Integer
        Dim ReturnId As Integer
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.Connection = Cnn

        Try


            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.CommandText = "[dbo].[IntegrationWebService_AddRFIFromXML]"
            Cmd.Parameters.Clear()
            With Cmd.Parameters
                .AddWithValue("ProjectNumber", ProjectID)
                .AddWithValue("DocNumber", RFIID)
                .AddWithValue("Description", RFITitle)
                .AddWithValue("DocStatusId", 1)
                .AddWithValue("Inactive", 0)
                .AddWithValue("RFIDATE", RFIIssuedDate)
                .AddWithValue("Reference", RFIReplyLineId)
                .AddWithValue("Question", RFIQuestion)
                .AddWithValue("RequiredDate", RFIReplyDueDate)
                .AddWithValue("ProposedSolution", RFIProposedSolution)
            End With
            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
            ReturnId = CInt(Cmd.ExecuteScalar)


            Return ReturnId
        Catch ex As Exception
            Throw ex
        Finally
            Cmd.Parameters.Clear()
            If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
        End Try
    End Function
    Public Shared Function GetDateTimeFromDB(ByVal DatabaseDate As Object) As DateTime?
        If DatabaseDate Is DBNull.Value Then Return Nothing
        Return New DateTime?(Convert.ToDateTime(DatabaseDate))
    End Function

    Public Function GetRFIFromDatabase(ByVal ProjectID As String, ByVal RFIID As String) As Boolean

        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.Connection = Cnn
        Dim rdrResult As SqlDataReader = Nothing
        Try


            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.CommandText = "[dbo].[IntegrationWebService_GetRFIForXML]"
            Cmd.Parameters.Clear()
            With Cmd.Parameters
                .AddWithValue("@ProjectNumber", ProjectID)
                .AddWithValue("@RFIXmlNumber", RFIID)
            End With
            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
            rdrResult = Cmd.ExecuteReader
            If rdrResult.HasRows Then


                While rdrResult.Read
                    With RFIInfo
                        RFIInfo.Id = CInt(rdrResult("Id"))
                        RFIInfo.ProjectNumber = rdrResult("ProjectNumber").ToString
                        RFIInfo.DocNumber = rdrResult("RFINumber").ToString
                        RFIInfo.RFIDATE = GetDateTimeFromDB(rdrResult("RFIDate"))
                        RFIInfo.Description = rdrResult("Description").ToString
                        RFIInfo.RequiredDate = GetDateTimeFromDB(rdrResult("RequiredDate"))
                        RFIInfo.Reference = rdrResult("Reference").ToString
                        RFIInfo.Question = rdrResult("Question").ToString
                        RFIInfo.ProposedSolution = rdrResult("ProposedSolution").ToString
                        RFIInfo.Answer = rdrResult("Answer").ToString
                        RFIInfo.AnsweredDate = GetDateTimeFromDB(rdrResult("AnsweredDate"))
                    End With
                End While

                rdrResult.Close()
                Return True
            Else
                rdrResult.Read()
                Return False
            End If
            '  ReturnId = CInt(Cmd.ExecuteScalar)


        Catch ex As Exception
            Return False
        Finally
            If (rdrResult IsNot Nothing) Then rdrResult.Close()
            Cmd.Parameters.Clear()
            If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
        End Try
    End Function

     
    Public Sub AddDocumentNoteToPMWeb(ByVal DocumentId As Integer, ByVal DocumentType As String, ByVal Subject As String, ByVal Notes As String)

        Dim intID As Integer = 0
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.Connection = Cnn


        Try

            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.CommandText = "[dbo].[IntegrationWebService_AddDocumentNoteFromAGCXml]"
            Cmd.Parameters.Clear()
            With Cmd.Parameters
                .AddWithValue("@UserId", 5)
                .AddWithValue("@DocumentId", DocumentId)
                .AddWithValue("@DocumentType", DocumentType)
                .AddWithValue("@Subject", Subject)
                .AddWithValue("@Notes", Notes)
            End With

            If Cnn.State = ConnectionState.Closed Then Cnn.Open()
            Cmd.ExecuteNonQuery()



        Catch ex As Exception
            Throw ex
        Finally
            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
        End Try

    End Sub

    Public Sub GetDocumentNoteFromPMWeb(ByVal DocumentId As Integer, ByVal DocumentType As String)

        Dim intID As Integer = 0
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.Connection = Cnn


        Try

            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.CommandText = "[dbo].[IntegrationWebService_GetDocumentNoteForAGCXml]"
            Cmd.Parameters.Clear()
            With Cmd.Parameters
                .AddWithValue("@DocumentId", DocumentId)
                .AddWithValue("@DocumentType", DocumentType)
            End With
            Dim drdNotes As SqlDataAdapter = New SqlDataAdapter(Cmd)
            If Cnn.State = ConnectionState.Closed Then Cnn.Open()
            drdNotes.Fill(DataSet, DataSet.tblDocumentNotes.TableName)


        Catch ex As Exception
            Throw ex
        Finally
            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
        End Try

    End Sub
#End Region


End Class
