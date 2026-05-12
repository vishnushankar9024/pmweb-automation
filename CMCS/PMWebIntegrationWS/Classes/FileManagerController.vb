Imports System.IO
Imports System.Data.SqlClient
Public Class FileManagerController
    Inherits System.Web.Services.WebService
    Dim traAttach As SqlTransaction
    Private _DocumentAttachmentInfo As DocumentAttachmentInfo
    Private _dts As dtsAgcXml
    Public Property DocumentAttachmentInfo() As DocumentAttachmentInfo
        Get
            If _DocumentAttachmentInfo Is Nothing Then _DocumentAttachmentInfo = New DocumentAttachmentInfo()
            Return _DocumentAttachmentInfo
        End Get
        Friend Set(ByVal value As DocumentAttachmentInfo)
            _DocumentAttachmentInfo = value
        End Set
    End Property


    Public ReadOnly Property DataSet() As dtsAgcXml
        Get
            If (_dts Is Nothing) Then
                _dts = New dtsAgcXml()
            End If
            Return _dts
        End Get
    End Property

    Private Function GetDBConnectionString() As String
        Dim dtsDBConnection = New DataSet

        dtsDBConnection.ReadXml(Server.MapPath("PMWebDatabases.xml"))

        Dim drDatabase As DataRow = dtsDBConnection.Tables(0).Select("ID = '1'")(0)
        Dim DBConnectionString = drDatabase("ConnectionString").ToString

        Return DBConnectionString
    End Function
    Public Sub SaveAttachmentToPMWEb(ByVal DocumentId As Integer, ByVal Description As String, ByVal FullName As String, ByVal Notes As String, ByVal stream As Stream, ByVal DocumentType As String)
        With DocumentAttachmentInfo
            .Id = 0
            .DocumentType = DocumentType
            .URL = "http://"
            .Description = Description
            .Notes = Notes
            .IsInRotator = True
            .SelectedOption = "UPLOAD"
            .DocumentId = DocumentId
            .EmailId = ""
        End With
        AddDocumentAttachment(stream, FullName)
    End Sub


    Private Function SaveFileAttachement(ByVal stream As Stream, ByVal FullFileName As String, ByRef transact As SqlTransaction) As Integer
        ' Dim DBConnectionString As String = GetDBConnectionString()
        'Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.CommandType = CommandType.StoredProcedure
        'Dim traAttach As SqlTransaction
        Dim intFileId As Integer = 0
        Try

            '  Cmd.Connection = Cnn

            '   If Cnn.State <> ConnectionState.Open Then Cnn.Open()
            'transact = Cnn.BeginTransaction
            Cmd.Transaction = transact
            Cmd.Connection = transact.Connection
            Dim NewGuid As Guid = Guid.NewGuid
            '--- add the new one

            Dim FileNameWithoutExtention As String = Path.GetFileNameWithoutExtension(FullFileName)
            Dim FileExtention As String = GetFileExtension(FullFileName)
            Dim FileContentType As String = GetContentType(Path.GetExtension(FullFileName).Replace(".", ""))
            Dim FileSize As Double = CDbl(stream.Length)

            Dim strNewFileName As String = FileNameWithoutExtention & "." & NewGuid.ToString & "." & FileExtention

            'Save to db or physically
            If FileSize = 0 Then Throw New Exception("File could not be uploaded. Please check file integrity.")
            Me.SaveFileContentToDatabase(strNewFileName, stream)

            Cmd.CommandText = "dbo.AddFile"
            Cmd.Parameters.AddWithValue("@FileName", FileNameWithoutExtention)
            Cmd.Parameters.AddWithValue("@FileGuid", NewGuid)
            Cmd.Parameters.AddWithValue("@Extension", FileExtention)
            Cmd.Parameters.AddWithValue("@ContentType", FileContentType)
            Cmd.Parameters.AddWithValue("@IsphysicallyExists", False)
            Cmd.Parameters.AddWithValue("@Size", FileSize)


            intFileId = CInt(Cmd.ExecuteScalar())
        Catch ex As Exception
            Throw
        End Try

        Return intFileId
    End Function

    Public Sub UpdateFileContent(ByVal FileGUID As Guid, ByVal inStream As Stream, ByVal Extension As String)
        Dim cmdLng As New SqlCommand()
        Dim cnnLng As New SqlClient.SqlConnection(GetDBConnectionString())
        cmdLng.Connection = cnnLng
        cmdLng.CommandTimeout = 1000
        cmdLng.CommandType = CommandType.StoredProcedure
        If cnnLng.State <> ConnectionState.Open Then cnnLng.Open()
        Dim traFile As SqlTransaction = cnnLng.BeginTransaction
        cmdLng.Transaction = traFile

        Dim serverPath As String
        Dim serverTxn As Byte()

        Try
            Try
                cmdLng.CommandText = "[dbo].[FileManager_ClearFileContent]"
                cmdLng.Parameters.Clear()
                With cmdLng.Parameters
                    .AddWithValue("@FileGUID", FileGUID)
                    .AddWithValue("@Extension", Extension)
                End With
                If cnnLng.State <> ConnectionState.Open Then cnnLng.Open()
                Using rdr As SqlDataReader = cmdLng.ExecuteReader()
                    rdr.Read()
                    serverPath = rdr.GetSqlString(0).Value
                    serverTxn = rdr.GetSqlBinary(1).Value
                    rdr.Close()
                End Using
            Catch ex1 As Exception
                Throw
            Finally
                cmdLng.Parameters.Clear()
            End Try

            Dim dblSQLChunkSize As Integer = 512000
            Dim arrData(dblSQLChunkSize) As Byte
            Dim DataLen As Double = inStream.Length
            If DataLen > dblSQLChunkSize Then
                Array.Resize(arrData, dblSQLChunkSize)
            Else
                Array.Resize(arrData, CInt(DataLen))
            End If
            inStream.Seek(0, SeekOrigin.Begin)
            Using dest As New SqlTypes.SqlFileStream(serverPath, serverTxn, FileAccess.Write)
                While DataLen > 0
                    inStream.Read(arrData, 0, arrData.Length)
                    dest.Write(arrData, 0, arrData.Length)
                    dest.Flush()
                    DataLen -= arrData.Length
                    If DataLen > dblSQLChunkSize Then
                        Array.Resize(arrData, dblSQLChunkSize)
                    Else
                        Array.Resize(arrData, CInt(DataLen))
                    End If
                End While
                dest.Close()
            End Using

            inStream.Close()
            traFile.Commit()


        Catch ex As Exception
            traFile.Rollback()
            Throw
        Finally
            If cnnLng.State <> ConnectionState.Closed Then cnnLng.Close()
            If IsNothing(inStream) = False Then inStream.Close()
        End Try

    End Sub



    Protected Sub SaveFileContentToDatabase(ByVal FullFileName As String, ByVal stream As Stream)
        Dim FileGuid As Guid = New Guid(GetFileGUID(FullFileName))
        UpdateFileContent(FileGuid, stream, GetFileExtension(FullFileName))
    End Sub

    Private Function GetFileGUID(ByVal FullFileName As Object) As String
        Dim arrFullFileName = FullFileName.ToString.Split(CChar("."))
        If String.IsNullOrEmpty(arrFullFileName(0)) Then Return ""
        Return arrFullFileName(arrFullFileName.Length - 2)
    End Function

    Private Function GetFileExtension(ByVal FullFileName As Object) As String
        If String.IsNullOrEmpty(Path.GetExtension(HttpUtility.UrlEncode(FullFileName.ToString))) Then Return ""
        Return Path.GetExtension(FullFileName.ToString).Trim("."c)
    End Function
    Public Function GetContentType(ByVal Extension As String) As String
        Dim contentType As String
        Select Case Extension.ToLower
            Case "txt" : contentType = "text/plain"
            Case "htm", "html" : contentType = "text/html"
            Case "rtf" : contentType = "text/richtext"
            Case "jpg", "jpeg" : contentType = "image/jpeg"
            Case "gif" : contentType = "image/gif"
            Case "bmp" : contentType = "image/bmp"
            Case "png" : contentType = "image/png"
            Case "mpg", "mpeg" : contentType = "video/mpeg"
            Case "avi" : contentType = "video/avi"
            Case "pdf" : contentType = "application/pdf"
            Case "doc", "dot" : contentType = "application/msword"
            Case "csv", "xls", "xlt", "xlsx" : contentType = "application/x-msexcel"
            Case "docx" : contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            Case Else : contentType = "application/octet-stream"
        End Select
        Return contentType
    End Function

    Private Sub AddDocumentAttachment(ByVal stream As Stream, ByVal FullFileName As String)
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.CommandType = CommandType.StoredProcedure
        Try

            Cmd.Connection = Cnn

            If Cnn.State <> ConnectionState.Open Then Cnn.Open()
            traAttach = Cnn.BeginTransaction
            Cmd.Transaction = traAttach
            Dim objDoc As DocumentAttachmentInfo = DocumentAttachmentInfo
            DocumentAttachmentInfo.FileId = Me.SaveFileAttachement(stream, FullFileName, traAttach)
            Dim intID As Integer = 0

            With objDoc
                Cmd.CommandText = "dbo.AddDocumentAttachment"
                Cmd.Parameters.AddWithValue("@DocumentType", .DocumentType)
                Cmd.Parameters.AddWithValue("@DocumentId", .DocumentId)
                Cmd.Parameters.AddWithValue("@FileId", .FileId)
                Cmd.Parameters.AddWithValue("@Url", .URL)
                Cmd.Parameters.AddWithValue("@Option", .SelectedOption)
                Cmd.Parameters.AddWithValue("@Description", .Description)
                Cmd.Parameters.AddWithValue("@Notes", .Notes)
                Cmd.Parameters.AddWithValue("@IsInRotator", .IsInRotator)
                Cmd.Parameters.AddWithValue("@ItemId", 0)
                Cmd.Parameters.AddWithValue("@EmailId", .EmailId)
                Cmd.Parameters.AddWithValue("@UserId", 5)

                intID = CInt(Cmd.ExecuteScalar)

            End With
            DocumentAttachmentInfo.Id = intID
            traAttach.Commit()
        Catch ex As Exception
            traAttach.Rollback()
            Throw ex
        Finally
            If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
        End Try
    End Sub

    Public Sub GetDocumentAttachments(ByVal DocumentId As Integer, ByVal DocumentType As String)
        Dim DBConnectionString As String = GetDBConnectionString()
        Dim Cnn As SqlConnection = New SqlConnection(DBConnectionString)
        Dim Cmd As SqlCommand = New SqlCommand
        Cmd.CommandType = CommandType.StoredProcedure

        Try

            Cmd.Connection = Cnn

            If Cnn.State <> ConnectionState.Open Then Cnn.Open()


            Cmd.CommandText = "dbo.[IntegrationWebService_GetDocumentAttachmentsFromAGCXml]"
            Cmd.Parameters.AddWithValue("@DocumentType", DocumentType)
            Cmd.Parameters.AddWithValue("@DocumentId", DocumentId)

            Dim SqlAdapter As SqlDataAdapter = New SqlDataAdapter(Cmd)

            SqlAdapter.Fill(DataSet, DataSet.tblDocumentAttachments.TableName)

        Catch ex As Exception
            Throw ex
        Finally
            If Cnn.State <> ConnectionState.Closed Then Cnn.Close()
        End Try
    End Sub

End Class
