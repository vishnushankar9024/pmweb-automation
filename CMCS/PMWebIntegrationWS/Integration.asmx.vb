Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.IO
Imports System.Security.AccessControl
Imports System.Xml
Imports System.Xml.XPath
Imports System.Xml.Schema
Imports System.Xml.Serialization
Imports System.Xml.Schema.XmlSchemaSet
Imports System.Type

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class Integration
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function GetFileForImport(ByVal FileName As String, ByVal FileType As String) As DataTable
        Dim dt As New DataTable
        Try
            Dim strDatasource As String = ""
            Dim strDatasource1 As String = ""
            If System.IO.File.Exists(FileName) = False Then
                Throw New Exception("FILENOTFOUND")
            End If
            Select Case CStr(FileType)
                Case "1"
                    Dim FileExtention As String = System.IO.Path.GetExtension(FileName).Remove(0, 1)
                    Try
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                            End If
                            strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                            FillDataTable(dt, strDatasource, strDatasource1, FileName)
                        Catch ex As Exception
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                            End If
                            strDatasource1 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                            FillDataTable(dt, strDatasource, strDatasource1, FileName)
                        End Try
                        Case "2"
                    Dim arrFileName() As String = FileName.Split("\")
                    Dim MyFile As String = ""
                    For i As Integer = 0 To arrFileName.Length - 2
                        MyFile += arrFileName(i) & "\"
                    Next
                    strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    Dim strQuery As String = ""
                    strQuery = "SELECT * FROM [" & arrFileName(arrFileName.Length - 1) & "]"
                    Using conn As New System.Data.OleDb.OleDbConnection(strDatasource)
                        Using conn1 As New System.Data.OleDb.OleDbConnection(strDatasource1)
                            Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                            Dim da1 As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn1)
                            dt.TableName = "ImportTable"
                            Try
                                da.Fill(dt)
                            Catch ex As Exception
                                da1.Fill(dt)
                            End Try
                        End Using
                    End Using
                Case "3"
                    Dim myDataSet As New DataSet()
                    Dim TabTable As New DataTable("ImportTable")
                    myDataSet.Tables.Add(TabTable)
                    Dim Counter As Integer
                    Dim aColumn As DataColumn
                    Dim myReader As New System.IO.StreamReader(FileName)
                    Dim Str As String
                    Dim i As Integer = 0
                    While myReader.Peek <> -1
                        Str = myReader.ReadLine
                        If i = 0 Then
                            Dim FileColumns() As String = Str.Split(vbTab)
                            For K As Integer = FileColumns.Length - 1 To 0 Step -1
                                Dim Num As Integer = 0
                                For j = 0 To K - 1
                                    If FileColumns(j) = FileColumns(K) Then
                                        Num = Num + 1
                                    End If
                                Next
                                If Num > 0 Then
                                    FileColumns(K) = FileColumns(K) & CStr(Num)
                                End If
                            Next
                            For Counter = 0 To FileColumns.Length - 1
                                aColumn = New DataColumn(FileColumns(Counter))
                                myDataSet.Tables("ImportTable").Columns.Add(aColumn)
                            Next
                            i = 1
                        Else
                            myDataSet.Tables("ImportTable").Rows.Add(TrimArrayValaues(Str.Split(vbTab)))
                        End If
                    End While
                    myReader.Close()
                    dt = myDataSet.Tables("ImportTable")
                Case "5"
                    Dim myDataSet As New DataSet()
                    Dim TabTable As New DataTable("ImportTable")
                    myDataSet.Tables.Add(TabTable)
                    Dim Counter As Integer
                    Dim aColumn As DataColumn
                    Dim myReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(FileName)
                    Dim i As Integer = 0
                    Dim strSplit As String() = {"|"}
                    myReader.TextFieldType = FileIO.FieldType.Delimited
                    myReader.Delimiters = New String() {"|"}
                    myReader.HasFieldsEnclosedInQuotes = True
                    Dim CurrData As String()
                    Do While Not myReader.EndOfData
                        CurrData = myReader.ReadFields
                        If i = 0 Then
                            For K As Integer = CurrData.Length - 1 To 0 Step -1
                                Dim Num As Integer = 0
                                For j = 0 To K - 1
                                    If CurrData(j) = CurrData(K) Then
                                        Num = Num + 1
                                    End If
                                Next
                                If Num > 0 Then
                                    CurrData(K) = CurrData(K) & CStr(Num)
                                End If
                            Next
                            For Counter = 0 To CurrData.Length - 1
                                aColumn = New DataColumn(CurrData(Counter))
                                myDataSet.Tables("ImportTable").Columns.Add(aColumn)
                            Next
                            i = 1
                        Else
                            myDataSet.Tables("ImportTable").Rows.Add(TrimArrayValaues(CurrData))
                        End If
                    Loop
                    myReader.Close()
                    dt = myDataSet.Tables("ImportTable")
            End Select
            Return dt
        Catch ex As Exception
            Throw ex
        Finally
        End Try
    End Function

    Private Sub FillDataTable(ByRef dt As DataTable, ByVal strDatasource As String, ByVal strDataSource1 As String, ByVal FileName As String)
        Dim ObjIntegcontroller As New IntegrationController
        Dim strQuery As String = "SELECT * FROM " & ObjIntegcontroller.GetXlsxFirstTableName(FileName)
        Using conn As New System.Data.OleDb.OleDbConnection(strDatasource)
            Using conn1 As New System.Data.OleDb.OleDbConnection(strDataSource1)
                Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                Dim da1 As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn1)
                dt.TableName = "ImportTable"
                Try
                    da.Fill(dt)
                Catch ex As Exception
                    da1.Fill(dt)
                End Try
            End Using
        End Using
    End Sub

    <WebMethod()>
    Public Function GetFileForMiddlewareImport(ByVal FileName As String, ByVal FileType As String) As DataTable
        Dim dt As New DataTable
        Try
            Dim strDatasource As String = ""
            Dim strDatasource1 As String = ""
            If System.IO.File.Exists(FileName) = False Then
                Throw New Exception("FILENOTFOUND")
            End If
            Select Case CStr(FileType)
                Case "1"
                    Dim arrFileName() As String = FileName.Split("\")
                    Dim MyFile As String = ""
                    For i As Integer = 0 To arrFileName.Length - 2
                        MyFile += arrFileName(i) & "\"
                    Next
                    strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    Dim strQuery As String = ""
                    strQuery = "SELECT * FROM [" & arrFileName(arrFileName.Length - 1) & "]"
                    Using conn As New System.Data.OleDb.OleDbConnection(strDatasource)
                        Using conn1 As New System.Data.OleDb.OleDbConnection(strDatasource1)
                            Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                            Dim da1 As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn1)
                            dt.TableName = "ImportTable"
                            Try
                                da.Fill(dt)
                            Catch ex As Exception
                                da1.Fill(dt)
                            End Try
                        End Using
                    End Using
                Case "3"
                    Dim FileExtention As String = System.IO.Path.GetExtension(FileName).Remove(0, 1)
                    Try
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                        End If
                        strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                        FillDataTable(dt, strDatasource, strDatasource1, FileName)
                    Catch ex As Exception
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                        End If
                        strDatasource1 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                        FillDataTable(dt, strDatasource, strDatasource1, FileName)
                    End Try
            End Select
            Return dt
        Catch ex As Exception
            Throw ex
        Finally
        End Try
    End Function
    <WebMethod()>
    Public Function GetFileForImportWithDelimeter(ByVal FileName As String,
                                                  ByVal FileType As String,
                                                  ByVal Delimeter As String) As DataTable
        Dim dt As New DataTable
        Try
            Dim strDatasource As String = ""
            Dim strDatasource1 As String = ""
            If System.IO.File.Exists(FileName) = False Then
                Throw New Exception("FILENOTFOUND")
            End If
            Select Case CStr(FileType)
                Case "1"
                    Dim FileExtention As String = System.IO.Path.GetExtension(FileName).Remove(0, 1)
                    Try
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                        End If
                        strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                        FillDataTable(dt, strDatasource, strDatasource1, FileName)
                    Catch ex As Exception
                        If FileExtention.ToLower = "xlsx" Then
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                        Else
                            strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                        End If
                        strDatasource1 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""HTML Import;HDR=YES;"""
                        FillDataTable(dt, strDatasource, strDatasource1, FileName)
                    End Try
                Case "2"
                    Dim arrFileName() As String = FileName.Split("\")
                    Dim MyFile As String = ""
                    For i As Integer = 0 To arrFileName.Length - 2
                        MyFile += arrFileName(i) & "\"
                    Next
                    strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    strDatasource1 = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + MyFile + ";Extended Properties=Text;"
                    Dim strQuery As String = ""
                      Dim dtSchema As DataTable = New DataTable()
                    strQuery = "SELECT * FROM [" & arrFileName(arrFileName.Length - 1) & "]"
                    Using conn As New System.Data.OleDb.OleDbConnection(strDatasource)
                        Using conn1 As New System.Data.OleDb.OleDbConnection(strDatasource1)
                            Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                            Dim da1 As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn1)
                            Try
                                da.FillSchema(dtSchema, SchemaType.Source)
                                writeSchema(MyFile, arrFileName(arrFileName.Length - 1))
                                dt.TableName = "ImportTable"
                                da.Fill(dt)
                                If System.IO.File.Exists(MyFile & "Schema.ini") Then
                                    System.IO.File.Delete(MyFile & "Schema.ini")
                                End If
                            Catch ex As Exception
                                da1.FillSchema(dtSchema, SchemaType.Source)
                                writeSchema(MyFile, arrFileName(arrFileName.Length - 1))
                                dt.TableName = "ImportTable"
                                da1.Fill(dt)
                                If System.IO.File.Exists(MyFile & "Schema.ini") Then
                                    System.IO.File.Delete(MyFile & "Schema.ini")
                                End If
                            End Try
                        End Using
                    End Using

                Case "3"
                    Dim myDataSet As New DataSet()
                    Dim TabTable As New DataTable("ImportTable")
                    myDataSet.Tables.Add(TabTable)
                    Dim Counter As Integer
                    Dim aColumn As DataColumn
                    Dim myReader As New System.IO.StreamReader(FileName)
                    Dim Str As String
                    Dim i As Integer = 0
                    While myReader.Peek <> -1
                        Str = myReader.ReadLine
                        If i = 0 Then
                            Dim FileColumns() As String = Str.Split(vbTab)
                            For K As Integer = FileColumns.Length - 1 To 0 Step -1
                                Dim Num As Integer = 0
                                For j = 0 To K - 1
                                    If FileColumns(j) = FileColumns(K) Then
                                        Num = Num + 1
                                    End If
                                Next
                                If Num > 0 Then
                                    FileColumns(K) = FileColumns(K) & CStr(Num)
                                End If
                            Next
                            For Counter = 0 To FileColumns.Length - 1
                                aColumn = New DataColumn(FileColumns(Counter))
                                myDataSet.Tables("ImportTable").Columns.Add(aColumn)
                            Next
                            i = 1
                        Else
                            myDataSet.Tables("ImportTable").Rows.Add(TrimArrayValaues(Str.Split(vbTab)))
                        End If
                    End While
                    myReader.Close()
                    dt = myDataSet.Tables("ImportTable")
                Case "4"
                    Dim myDataSet As New DataSet()
                    Dim TabTable As New DataTable("ImportTable")
                    myDataSet.Tables.Add(TabTable)
                    Dim Counter As Integer
                    Dim aColumn As DataColumn
                    Dim myReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(FileName)
                    Dim i As Integer = 0
                    myReader.TextFieldType = FileIO.FieldType.Delimited
                    myReader.Delimiters = New String() {Delimeter}
                    myReader.HasFieldsEnclosedInQuotes = True
                    Dim CurrData As String()
                    Do While Not myReader.EndOfData
                        CurrData = myReader.ReadFields
                        If i = 0 Then
                            For K As Integer = CurrData.Length - 1 To 0 Step -1
                                Dim Num As Integer = 0
                                For j = 0 To K - 1
                                    If CurrData(j) = CurrData(K) Then
                                        Num = Num + 1
                                    End If
                                Next
                                If Num > 0 Then
                                    CurrData(K) = CurrData(K) & CStr(Num)
                                End If
                            Next
                            For Counter = 0 To CurrData.Length - 1
                                aColumn = New DataColumn(CurrData(Counter))
                                myDataSet.Tables("ImportTable").Columns.Add(aColumn)
                            Next
                            i = 1
                        Else
                            myDataSet.Tables("ImportTable").Rows.Add(TrimArrayValaues(CurrData))
                        End If
                    Loop
                    myReader.Close()
                    dt = myDataSet.Tables("ImportTable")
            End Select
            Return dt
        Catch ex As Exception
            Throw ex
        Finally
        End Try
    End Function


    Private Sub writeSchema(ByVal Path As String, ByVal strCSVFile As String)
        Try
            Dim fsOutput As New FileStream(Path & "Schema.ini", FileMode.Create, FileAccess.Write)
            Dim srOutput As New StreamWriter(fsOutput)
            Dim s1 As String, s2 As String, s3 As String, s4 As String, s5 As String
            s1 = "[" + strCSVFile + "]"
            s2 = "ColNameHeader=True"
            s3 = "Format=CSVDelimited"
            s4 = "MaxScanRows=0"
            s5 = "CharacterSet=ANSI"
            srOutput.WriteLine(Convert.ToString((Convert.ToString((Convert.ToString((Convert.ToString(s1 & vbCrLf) & s2) + vbCrLf) & s3) + vbCrLf) & s4) + vbCrLf) & s5)
            srOutput.Close()
            fsOutput.Close()
            fsOutput.Dispose()
            srOutput.Dispose()

        Catch ex As Exception
        End Try
    End Sub

    Public Function TrimArrayValaues(ByVal str() As String) As String()
        For i As Integer = 0 To str.Length - 1
            str(i) = str(i).Trim
        Next
        Return str
    End Function


    <WebMethod()>
    Public Function GetFileSize(ByVal FileName As String) As Decimal
        Try
            Dim MyFile As New FileInfo(FileName)
            Dim FileSize As Decimal = MyFile.Length
            Return (FileSize / 1024)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    <WebMethod()>
    Public Function GenerateFile(ByVal dts As DataSet,
                              ByVal FileType As String,
                              ByVal FilePath As String,
                              ByVal OverWriteFile As Boolean) As DataTable
        Try
            Dim tblFileInfo As New DataTable
            tblFileInfo.Columns.Add("FilePath", GetType(System.String))
            tblFileInfo.Columns.Add("FileSize", GetType(System.String))
            tblFileInfo.TableName = "fileInfo"
            Select Case FileType
                Case "1"
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim tblHeader As DataTable = dts.Tables("Headers")
                    Dim tbldata As DataTable = dts.Tables("File")
                    Header.Append("<Html><Body><table border=1 borderColor=#688CAF style=border-collapse:collapse;Width:435px>")
                    Dim Body As String = ""
                    Header.Append(Body)
                    Dim Colums As String = ""
                    For i As Integer = 0 To tblHeader.Rows.Count - 1
                        If CBool(tblHeader.Rows(i)("Send")) Then
                            Colums = Colums + "<td style=border-top:solid 2px black;><font color=#00156E>" + CStr(tblHeader.Rows(i)("Alias")) + "</font></td>"
                        End If
                    Next
                    Header.Append("<style>.text { mso-number-format:\@; } </style>")
                    Header.Append("<tr style=background-color:#C4D9F2; border-style:solid 1px #688CAF;>" & Colums & "</tr>")
                    Body = ""
                    For i As Integer = 0 To tbldata.Rows.Count - 1
                        Body = Body + "<tr>"
                        For j As Integer = 0 To tbldata.Columns.Count - 1
                            Dim borderStyle As String = "border-bottom-color:#D0D7E5;"
                            If i = tbldata.Columns.Count - 1 Then borderStyle = ""
                            Dim result As String = String.Empty
                            If tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)) IsNot DBNull.Value Then
                                result = tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)).ToString
                            End If
                            If j <> tbldata.Columns.Count - 1 Then
                                Body = Body + "<td style=border-right-color:#D0D7E5;" + borderStyle + IIf(tblHeader.Rows(j)("FieldType") = "FIELDTYPE_DATE", " class=text ", "") + ">" + result + "</td>"
                            Else
                                Body = Body + "<td style=" + borderStyle + IIf(tblHeader.Rows(j)("FieldType") = "FIELDTYPE_DATE", " class=text ", "") + ">" + result + "</td>"
                            End If
                        Next
                        Body = Body + "</tr>"
                        Header.Append(Body)
                        Body = ""
                    Next
                    Header.Append("</table><Html><Body>")

                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "xls")
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".xls", FileMode.Create, FileAccess.Write)

                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".xls")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".xls", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try

                'Dim grdExportedData As New DataGrid
                'grdExportedData.DataSource = dts.Tables("File")
                'grdExportedData.AutoGenerateColumns = True
                ''AddHandler grdExportedData.ItemDataBound, AddressOf grdExportedData_ItemDataBound
                'grdExportedData.DataBind()
                'Dim strw As New System.IO.StringWriter
                'Dim htmlw As New System.Web.UI.HtmlTextWriter(strw)
                'grdExportedData.GridLines = GridLines.Both
                'grdExportedData.Font.Name = "Verdana"
                'grdExportedData.Font.Size = 9
                'grdExportedData.HeaderStyle.Font.Bold = True
                'grdExportedData.HeaderStyle.BackColor = Drawing.Color.FromArgb(153, 204, 255)
                'grdExportedData.ForeColor = Drawing.Color.DarkBlue
                'grdExportedData.ItemStyle.BorderColor = Drawing.Color.DarkBlue
                'grdExportedData.HeaderStyle.BorderColor = Drawing.Color.DarkBlue
                ''grd.ItemStyle.ForeColor = Drawing.ColorTranslator.FromHtml("#333333")
                ''grd.ItemStyle.BorderColor = Drawing.ColorTranslator.FromHtml("#D0D7E5")
                'grdExportedData.RenderControl(htmlw)
                'File.WriteAllText(FilePath & ".xls", strw.ToString)
                Case "2"
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim tblHeader As DataTable = dts.Tables("Headers")
                    Dim tbldata As DataTable = dts.Tables("File")
                    Dim Colums As String = ""
                    For i As Integer = 0 To tblHeader.Rows.Count - 1
                        If CBool(tblHeader.Rows(i)("Send")) Then
                            Colums = Colums + IIf(Colums <> String.Empty, ",", "") _
                            + IIf(CStr(tblHeader.Rows(i)("Alias")).IndexOf(",") <> -1,
                                  """" & CStr(tblHeader.Rows(i)("Alias")) & """", CStr(tblHeader.Rows(i)("Alias")))
                        End If
                    Next
                    Colums = Colums + vbCrLf
                    Header.Append(Colums)
                    Dim Body As String = ""
                    For i As Integer = 0 To tbldata.Rows.Count - 1
                        Body = ""
                        For j As Integer = 0 To tbldata.Columns.Count - 1
                            Dim result As String = String.Empty
                            If tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)) IsNot DBNull.Value Then
                                result = tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)).ToString
                            End If
                            If result.IndexOf(",") <> -1 Or result.IndexOf("""") <> -1 Then
                                result = """" & result.Replace("""", """""") & """"
                            End If
                            If j = 0 Then
                                Body = Body + result
                            Else
                                Body = Body + "," + result
                            End If
                        Next
                        Body = Body + vbCrLf
                        Header.Append(Body)
                    Next
                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "csv")
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".csv", FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".csv")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".csv", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
                Case "3"
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim tblHeader As DataTable = dts.Tables("Headers")

                    Dim tbldata As DataTable = dts.Tables("File")
                    Dim Colums As String = ""
                    For i As Integer = 0 To tblHeader.Rows.Count - 1
                        If CBool(tblHeader.Rows(i)("Send")) Then
                            Colums = Colums + IIf(Colums <> String.Empty, vbTab, "") + CStr(tblHeader.Rows(i)("Alias")).Replace(vbTab, " ")
                        End If
                    Next
                    Colums = Colums + vbCrLf
                    Header.Append(Colums)
                    Dim Body As String = ""
                    For i As Integer = 0 To tbldata.Rows.Count - 1
                        Body = ""
                        For j As Integer = 0 To tbldata.Columns.Count - 1
                            Dim result As String = String.Empty
                            If tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)) IsNot DBNull.Value Then
                                result = tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)).ToString
                            End If
                            If j = 0 Then
                                Body = Body + result.Replace(vbTab, " ")
                            Else
                                Body = Body + vbTab + result.Replace(vbTab, " ")
                            End If
                        Next
                        Body = Body + vbCrLf
                        Header.Append(Body)
                    Next
                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "txt")
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".txt", FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".txt")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".txt", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
                Case "5"
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim tblHeader As DataTable = dts.Tables("Headers")

                    Dim tbldata As DataTable = dts.Tables("File")
                    Dim Colums As String = ""
                    For i As Integer = 0 To tblHeader.Rows.Count - 1
                        If CBool(tblHeader.Rows(i)("Send")) Then
                            Colums = Colums + IIf(Colums <> String.Empty, "|", "") + CStr(tblHeader.Rows(i)("Alias")).Replace("|", " ")
                        End If
                    Next
                    Colums = Colums + vbCrLf
                    Header.Append(Colums)
                    Dim Body As String = ""
                    For i As Integer = 0 To tbldata.Rows.Count - 1
                        Body = ""
                        For j As Integer = 0 To tbldata.Columns.Count - 1
                            Dim result As String = String.Empty
                            If tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)) IsNot DBNull.Value Then
                                result = tbldata.Rows(i)(CStr(tbldata.Columns(j).ColumnName)).ToString
                            End If
                            If j = 0 Then
                                Body = Body + IIf(result.Contains("|") Or result.Contains(""""), """" + result.Replace("""", """""") + """", result)
                            Else
                                Body = Body + "|" + IIf(result.Contains("|") Or result.Contains(""""), """" + result.Replace("""", """""") + """", result)
                            End If
                        Next
                        Body = Body + vbCrLf
                        Header.Append(Body)
                    Next
                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "txt")
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".txt", FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".txt")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".txt", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
                Case "4"
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim tblHeader As DataTable = dts.Tables("Headers")
                    Dim tbldata As DataTable = dts.Tables("File")
                    For Each row As DataRow In tblHeader.Rows
                        If Not CBool(row("send")) Then
                            row.Delete()
                        End If
                    Next
                    tblHeader.AcceptChanges()
                    For Each row As DataRow In tblHeader.Rows
                        If CBool(row("send")) Then
                            Dim count As Integer = 0
                            Dim strAlias As String = row("Alias").ToString
                            For i As Integer = 0 To tblHeader.Rows.IndexOf(row)
                                If tblHeader.Rows(i)("Alias").ToString = row("Alias").ToString And i <> tblHeader.Rows.IndexOf(row) Then
                                    count = count + 1
                                    row("Alias") = strAlias & CStr(count)
                                End If
                            Next

                        End If
                    Next
                    If tbldata.Columns.Count = tblHeader.Rows.Count Then
                        For i As Integer = 0 To tbldata.Columns.Count - 1
                            tbldata.Columns(i).ColumnName = tblHeader.Rows(i)("Alias").ToString
                        Next

                        If OverWriteFile = False Then
                            FilePath = GetFileName(FilePath, "xml")
                        End If
                        dts.Tables.Remove(tblHeader)
                        dts.AcceptChanges()
                        dts.WriteXml(FilePath & ".xml", XmlWriteMode.IgnoreSchema)
                        Try
                            Dim MyFile As New FileInfo(FilePath & ".xml")
                            Dim FileSize As Decimal = MyFile.Length
                            FileSize = (FileSize / 1024)
                            tblFileInfo.Rows.Add(FilePath & ".xml", CStr(FileSize))
                        Catch ex As Exception
                            Throw ex
                        End Try
                    End If
            End Select
            Return tblFileInfo
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Private Sub ReadWriteStream(ByVal readStream As Stream, ByVal writeStream As Stream)
        Dim Length As Integer = 256
        Dim buffer(Length) As Byte
        Dim bytesRead As Integer = readStream.Read(buffer, 0, Length)
        While (bytesRead > 0)
            writeStream.Write(buffer, 0, bytesRead)
            bytesRead = readStream.Read(buffer, 0, Length)
        End While
        readStream.Close()
        writeStream.Close()
    End Sub

    Private Function GetFileName(ByVal FilePath As String, ByVal Extension As String) As String
        Dim count As Integer = 0
        Dim NewFilePath = FilePath
        While System.IO.File.Exists(FilePath & "." & Extension)
            count = count + 1
            FilePath = NewFilePath & CStr(count)
        End While
        Return FilePath
    End Function

    <WebMethod()>
    Public Function GenerateAPIMiddleWareFile(ByVal dt As DataTable,
                              ByVal FileType As String,
                              ByVal RecordType As String,
                              ByVal ProfileName As String,
                              ByVal OverWriteFile As Boolean,
                              ByVal ExportFileName As String) As DataTable
        Try
            Dim FilePath As String = ""
            Dim LogPath As String = HttpContext.Current.Server.MapPath("bin")
            Dim execFile As String = Mid(LogPath, LogPath.LastIndexOf("\") + 1)
            Dim ExportebFilesPath As String = Replace(LogPath, execFile, "\Exported Files")
            If Not Directory.Exists(ExportebFilesPath) Then
                Directory.CreateDirectory(ExportebFilesPath)
            End If
            FilePath = ExportebFilesPath + "\" + ProfileName
            If Not Directory.Exists(FilePath) Then
                Directory.CreateDirectory(FilePath)
            End If
            FilePath = FilePath + "\" + RecordType
            If Not Directory.Exists(FilePath) Then
                Directory.CreateDirectory(FilePath)
            End If
            FilePath = FilePath + "\" + ExportFileName
            Dim tblFileInfo As New DataTable
            tblFileInfo.Columns.Add("FilePath", GetType(System.String))
            tblFileInfo.Columns.Add("FileSize", GetType(System.String))
            tblFileInfo.TableName = "fileInfo"
            Select Case FileType
                Case "3", "2", "5" 'excel file
                    Dim FileExtension As String = "html"
                    If FileType = "3" Then
                        FileExtension = "xlsx"
                    End If
                    If FileType = "5" Then
                        FileExtension = "xls"
                    End If
                    Dim Header As New StringBuilder
                    Header.Append("<Html><Body><table border=1 borderColor=#688CAF style=border-collapse:collapse;Width:435px>")
                    Dim Body As String = ""
                    Header.Append(Body)
                    Dim Colums As String = ""
                    For i As Integer = 0 To dt.Columns.Count - 1
                        Colums = Colums + "<td style=border-top:solid 2px black;><font color=#00156E>" + dt.Columns(i).ColumnName + "</font></td>"
                    Next
                    Header.Append("<tr style=background-color:#C4D9F2; border-style:solid 1px #688CAF;>" & Colums & "</tr>")
                    Body = ""
                    For i As Integer = 0 To dt.Rows.Count - 1
                        Body = Body + "<tr>"
                        For j As Integer = 0 To dt.Columns.Count - 1
                            Dim borderStyle As String = "border-bottom-color:#D0D7E5;"
                            If i = dt.Columns.Count - 1 Then borderStyle = ""
                            Dim result As String = String.Empty
                            If dt.Rows(i)(j) IsNot DBNull.Value Then
                                result = dt.Rows(i)(j).ToString
                            End If
                            If j <> dt.Columns.Count - 1 Then
                                Body = Body + "<td style=border-right-color:#D0D7E5;" + borderStyle + ">" + result + "</td>"
                            Else
                                Body = Body + "<td style=" + borderStyle + ">" + result + "</td>"
                            End If
                        Next
                        Body = Body + "</tr>"
                        Header.Append(Body)
                        Body = ""
                    Next
                    Header.Append("</table><Html><Body>")

                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, FileExtension)
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & "." & FileExtension, FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & "." & FileExtension)
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & "." & FileExtension, CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try

                Case "1" 'comma seperated
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    Dim Colums As String = ""
                    For i As Integer = 0 To dt.Columns.Count - 1
                        Colums = Colums + IIf(Colums <> String.Empty, ",", "") + IIf(dt(0)(i).ToString.IndexOf(",") <> -1, """" & dt(0)(i).ToString & """", dt(0)(i).ToString)
                    Next
                    Colums = Colums + vbCrLf
                    Header.Append(Colums)
                    Dim Body As String = ""
                    For i As Integer = 0 To dt.Rows.Count - 1
                        Body = ""
                        For j As Integer = 0 To dt.Columns.Count - 1
                            Dim result As String = String.Empty
                            If dt(i)(j) IsNot DBNull.Value Then
                                result = dt(i)(j).ToString
                            End If
                            If result.IndexOf(",") <> -1 Or result.IndexOf("""") <> -1 Then
                                result = """" & result.Replace("""", """""") & """"
                            End If
                            If j = 0 Then
                                Body = Body + result
                            Else
                                Body = Body + "," + result
                            End If
                        Next
                        Body = Body + vbCrLf
                        Header.Append(Body)
                    Next
                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "csv")
                    End If
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(Header.ToString))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".csv", FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".csv")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".csv", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
                Case "4" 'xml
                    Dim dtExportedData As New DataTable
                    Dim Header As New StringBuilder
                    If OverWriteFile = False Then
                        FilePath = GetFileName(FilePath, "xml")
                    End If
                    dt.WriteXml(FilePath & ".xml", XmlWriteMode.IgnoreSchema)
                    '------------------CLIENT Customization--------------------------------------
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".xml")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".xml", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
                Case "6" 'json
                    Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer
                    Dim rows As New List(Of Dictionary(Of String, Object))
                    Dim row As Dictionary(Of String, Object) = Nothing
                    For Each dr As DataRow In dt.Rows
                        row = New Dictionary(Of String, Object)
                        For Each col As DataColumn In dt.Columns
                            If dr(col) Is DBNull.Value Then
                                row.Add(col.ColumnName.ToString, Nothing)
                            Else
                                row.Add(col.ColumnName.ToString, dr(col))
                            End If
                        Next
                        rows.Add(row)
                    Next
                    Dim stream As Stream = New MemoryStream(ASCIIEncoding.
                                                            Default.GetBytes(serializer.Serialize(rows)))
                    Dim writeStream As FileStream = New FileStream(FilePath & ".txt", FileMode.Create, FileAccess.Write)
                    ReadWriteStream(stream, writeStream)
                    Try
                        Dim MyFile As New FileInfo(FilePath & ".txt")
                        Dim FileSize As Decimal = MyFile.Length
                        FileSize = (FileSize / 1024)
                        tblFileInfo.Rows.Add(FilePath & ".txt", CStr(FileSize))
                    Catch ex As Exception
                        Throw ex
                    End Try
            End Select
            Return tblFileInfo
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    <WebMethod()>
    Public Function GetExcelFileSheet(ByVal FileName As String, ByVal SheetName As String) As DataTable
        Dim dt As New DataTable
        dt.TableName = SheetName
        Try
            Dim strDatasource As String = ""
            If System.IO.File.Exists(FileName) = False Then
                Throw New Exception("FILENOTFOUND")
            End If
            Dim FileExtention As String = System.IO.Path.GetExtension(FileName).Remove(0, 1)
            If FileExtention.ToLower = "xlsx" Then
                strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 12.0 Xml;HDR=YES;"""
                Dim strQuery As String = ""
                Dim conn As New System.Data.OleDb.OleDbConnection(strDatasource)
                Dim ObjIntegcontroller As New IntegrationController
                Dim TableNames As String = ObjIntegcontroller.GetXlsxAllTableNames(FileName)
                Dim strtblNames() As String = TableNames.Split("|")
                For i As Integer = 0 To strtblNames.Count - 1
                    Dim FileSheetName As String = String.Empty
                    If strtblNames(i) <> String.Empty Then
                        FileSheetName = Mid(strtblNames(i).Replace("'", ""), 2, Len(strtblNames(i).Replace("'", "")) - 3)
                    End If
                    If FileSheetName.ToLower = SheetName.ToLower Then
                        strQuery = "SELECT * FROM " & strtblNames(i)
                        Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                        dt.TableName = SheetName
                        da.Fill(dt)
                        conn.Close()
                        Return dt
                    End If
                Next
                If conn.State = ConnectionState.Open Then conn.Close()
            Else
                strDatasource = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=""Excel 8.0;HDR=YES;"""
                Dim strQuery As String = ""
                Dim conn As New System.Data.OleDb.OleDbConnection(strDatasource)
                Dim ObjIntegcontroller As New IntegrationController
                Dim TableNames As String = ObjIntegcontroller.GetAllTableName(FileName)
                Dim strtblNames() As String = TableNames.Split("|")
                For i As Integer = 0 To strtblNames.Count - 1
                    Dim FileSheetName As String = String.Empty
                    If strtblNames(i) <> String.Empty Then
                        FileSheetName = Mid(strtblNames(i).Replace("'", ""), 2, Len(strtblNames(i).Replace("'", "")) - 3)
                    End If
                    If FileSheetName.ToLower = SheetName.ToLower Then
                        strQuery = "SELECT * FROM " & strtblNames(i)
                        Dim da As New System.Data.OleDb.OleDbDataAdapter(strQuery, conn)
                        dt.TableName = SheetName
                        da.Fill(dt)
                        conn.Close()
                        Return dt
                    End If
                Next
                If conn.State = ConnectionState.Open Then conn.Close()
            End If
            Return dt
        Catch ex As Exception
            Throw ex
        Finally
        End Try
    End Function



    'Private Function ConvertToHtmlFile(ByVal tbldata As DataTable, _
    '                                   ByVal tblHeader As DataTable, ByVal tblDetails As DataTable) As String

    '    Return Header.ToString
    'End Function

    Dim XmlSchemaError As Boolean = False
    Dim XmlErrorMEssage As String = String.Empty
    Dim _FileManagerController As FileManagerController
    Dim _IntegrationController As IntegrationController
    Public Property IntegrationController() As IntegrationController
        Get
            If _IntegrationController Is Nothing Then _IntegrationController = New IntegrationController()
            Return _IntegrationController
        End Get
        Friend Set(ByVal value As IntegrationController)
            _IntegrationController = value
        End Set
    End Property

    Public Property FileManagerController() As FileManagerController
        Get
            If _FileManagerController Is Nothing Then _FileManagerController = New FileManagerController()
            Return _FileManagerController
        End Get
        Friend Set(ByVal value As FileManagerController)
            _FileManagerController = value
        End Set
    End Property
    '<WebMethod()> _
    'Public Function AgcxmlSendRFIToPMWeb(ByVal XMLMessage As String) As String
    '    Dim ErrorMessage As String = String.Empty
    '    Try

    '        If XMLMessage Is Nothing Then
    '            Return "Message empty"
    '        End If


    '        Dim ReceivedXDocument As XDocument = New XDocument
    '        Dim Xmlelement As XElement = XElement.Parse(XMLMessage)

    '        Dim xsdPath As String = Server.MapPath("obj/XMLSchema/org_agcxml/2_0/Model/BODs/ProcessRFI.xsd")
    '        Dim XmlSchema As XmlReader
    '        Dim Settings As New XmlReaderSettings
    '        Settings.Schemas.Add(Nothing, xsdPath)
    '        Settings.ValidationType = ValidationType.Schema

    '        XmlSchema = XmlReader.Create(xsdPath, Settings)

    '        Dim Schemas As XmlSchemaSet = New XmlSchemaSet
    '        Schemas.Add(Nothing, XmlSchema)

    '        ReceivedXDocument.Add(Xmlelement)


    '        ReceivedXDocument.Validate(Schemas, AddressOf SchemaValidation)

    '        If XmlSchemaError Then
    '            XmlSchemaError = False
    '            Return "The Schema of the Xml sent is not supported <br/>" & XmlErrorMEssage
    '        End If

    '        Dim ElementPrefix As String = Xmlelement.GetPrefixOfNamespace(Xmlelement.GetDefaultNamespace)

    '        Dim Axns As XNamespace = Xmlelement.GetNamespaceOfPrefix("a")
    '        Dim Sxns As XNamespace = Xmlelement.GetDefaultNamespace()

    '        Dim XHeader As XElement
    '        Dim xhRFIId As XElement
    '        Dim xhTitle As XElement
    '        Dim XhProjectElements As XElement
    '        Dim XProjectNumber As XElement
    '        Dim xProjectTitle As XElement

    '        ' Dim xhDueDate As XElement
    '        Dim xhIssueDate As XElement



    '        Dim XRFIIssue As XElement
    '        Dim XIssueLineNumber As XElement
    '        Dim XIssueQuestion As XElement
    '        Dim XDocumentReference As XElement
    '        Dim XIssueTitle As XElement
    '        Dim XAssignedTo As XElement
    '        Dim XStageCode As XElement
    '        Dim XIssueCreateBy As XElement
    '        Dim XIssueCreateDate As XElement
    '        Dim XIssueImportanceCode As XElement
    '        Dim XIssueDisciplineCode As XElement
    '        Dim XCategoryCode As XElement
    '        Dim XActionCriteriaXpath As XElement
    '        Dim ReplyXpathRFIReply As XElement



    '        'Selects the Last Occurance  of Header and all its Child Elements 
    '        XHeader = ReceivedXDocument.Descendants().Where(Function(e) e.Name.LocalName = "RFIHeader").LastOrDefault

    '        xhTitle = XHeader.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '        xhRFIId = XHeader.Elements.Where(Function(e) e.Name.LocalName = "ID").FirstOrDefault
    '        xhIssueDate = XHeader.Elements.Where(Function(e) e.Name.LocalName = "IssuedOn").FirstOrDefault


    '        XhProjectElements = XHeader.Descendants.Where(Function(e) e.Name.LocalName = "Project").FirstOrDefault
    '        XProjectNumber = XhProjectElements.Elements.Where(Function(e) e.Name.LocalName = "Number").FirstOrDefault
    '        xProjectTitle = XhProjectElements.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '        ''''RFI ISSUE SECTION
    '        'Selects the Last Occurance  of Issue and all its Child Elements 
    '        XRFIIssue = ReceivedXDocument.Descendants().Where(Function(e) e.Name.LocalName = "RFIIssue").LastOrDefault

    '        XIssueLineNumber = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "LineNumberID").FirstOrDefault
    '        XIssueQuestion = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "Description").FirstOrDefault
    '        XIssueLineNumber = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "LineNumberID").FirstOrDefault
    '        XDocumentReference = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "DocumentReference").FirstOrDefault
    '        XIssueTitle = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '        XAssignedTo = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "AssignedTo").FirstOrDefault
    '        XStageCode = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "Stage").Elements.Where(Function(e) e.Name.LocalName = "Code").FirstOrDefault
    '        XIssueCreateBy = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "CreatedBy").FirstOrDefault
    '        XIssueCreateDate = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "CreatedOn").FirstOrDefault
    '        XIssueImportanceCode = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "ImportanceCode").FirstOrDefault
    '        XIssueDisciplineCode = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "DisciplineCode").FirstOrDefault
    '        XCategoryCode = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "CategoryCode").FirstOrDefault



    '        Dim reader As XmlReader = ReceivedXDocument.CreateReader
    '        Dim nameTable As XmlNameTable = reader.NameTable
    '        Dim NameSpaceManager As XmlNamespaceManager = New XmlNamespaceManager(nameTable)
    '        NameSpaceManager.AddNamespace("a", Axns.ToString)
    '        NameSpaceManager.AddNamespace("d", Sxns.ToString)
    '        XActionCriteriaXpath = ReceivedXDocument.Descendants.Where(Function(e) e.Name.LocalName = "ActionCriteria").Elements.Where(Function(e) e.Name.LocalName = "ActionExpression").FirstOrDefault





    '        Dim XNotes = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "Note")
    '        Dim TempNotes As DataTable = New DataTable("TempNotes")
    '        TempNotes.Columns.Add("NoteDescription")
    '        TempNotes.Columns.Add("Subject")
    '        If Not XNotes Is Nothing Then

    '            For Each NoteElement In XNotes
    '                Dim XRow As DataRow = TempNotes.NewRow
    '                Dim XAuthor As XAttribute = NoteElement.Attribute("author")
    '                Dim AuthorID As String = String.Empty
    '                Dim AuthorName As String = String.Empty
    '                If Not XAuthor Is Nothing Then
    '                    AuthorID = XAuthor.Value
    '                End If
    '                Dim XParticipant As XElement = XHeader.Descendants(Sxns + "Participant").Where(Function(e) e.Element(Sxns + "ID").Value = AuthorID).FirstOrDefault
    '                If Not XParticipant Is Nothing Then
    '                    Dim GivenName As XElement = XParticipant.Descendants.Where(Function(e) e.Name.LocalName = "GivenName").FirstOrDefault
    '                    Dim FamilyName As XElement = XParticipant.Descendants.Where(Function(e) e.Name.LocalName = "FamilyName").FirstOrDefault

    '                    If Not GivenName Is Nothing Then
    '                        AuthorName = GivenName.Value

    '                        If Not FamilyName Is Nothing Then
    '                            AuthorName += " " & FamilyName.Value
    '                        End If
    '                    Else
    '                        AuthorName = AuthorID
    '                    End If

    '                End If
    '                XRow("Subject") = IIf(AuthorName = String.Empty, AuthorID, AuthorName)
    '                XRow("NoteDescription") = NoteElement.Value
    '                TempNotes.Rows.Add(XRow)
    '            Next
    '        End If



    '        Dim XIssueAttachments = XRFIIssue.Elements.Where(Function(e) e.Name.LocalName = "Attachment")
    '        Dim TempIssueAttachments As DataTable = New DataTable
    '        TempIssueAttachments.Columns.Add("AttachmentBinary")
    '        TempIssueAttachments.Columns.Add("FileName")
    '        TempIssueAttachments.Columns.Add("MimeCode")
    '        TempIssueAttachments.Columns.Add("Description")
    '        TempIssueAttachments.Columns.Add("Note")
    '        TempIssueAttachments.Columns.Add("NoteAuthor")
    '        TempIssueAttachments.Columns.Add("Title")
    '        TempIssueAttachments.Columns.Add("FileTypeCode")
    '        If Not XIssueAttachments Is Nothing Then
    '            For Each XAttachment In XIssueAttachments
    '                Dim XRow As DataRow = TempIssueAttachments.NewRow
    '                Dim XAttachmentData = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "EmbeddedDataBinaryObject").FirstOrDefault

    '                Dim XAttachmentFileName As XElement = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "FileName").FirstOrDefault
    '                Dim XAttachmentDescription As XElement = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "Description").FirstOrDefault
    '                Dim XAttachmentMimeCode As XAttribute = Nothing
    '                If Not XAttachmentData Is Nothing Then
    '                    XAttachmentMimeCode = XAttachmentData.Attributes.Where(Function(e) e.Name.LocalName = "mimeCode").FirstOrDefault
    '                End If

    '                Dim XAttachmentTitle As XElement = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '                Dim XAttachmentNote As XElement = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "Note").FirstOrDefault
    '                Dim XAttachmentNoteAuthor As XAttribute = Nothing
    '                If Not XAttachmentNote Is Nothing Then
    '                    XAttachmentNoteAuthor = XAttachmentNote.Attributes.Where(Function(e) e.Name.LocalName = "author").FirstOrDefault
    '                End If
    '                Dim XAttachmentFileTypeCode As XElement = XAttachment.Elements.Where(Function(e) e.Name.LocalName = "FileTypeCode").FirstOrDefault

    '                Try
    '                    XRow("AttachmentBinary") = XAttachmentData.Value
    '                Catch ex As Exception
    '                    XRow("AttachmentBinary") = String.Empty
    '                End Try
    '                Try
    '                    XRow("FileName") = XAttachmentFileName.Value
    '                Catch ex As Exception
    '                    XRow("FileName") = XAttachmentFileName.Value
    '                End Try
    '                Try
    '                    XRow("MimeCode") = XAttachmentMimeCode.Value
    '                Catch ex As Exception
    '                    XRow("MimeCode") = String.Empty
    '                End Try
    '                Try
    '                    XRow("Description") = XAttachmentFileName.Value
    '                Catch ex As Exception
    '                    XRow("Description") = String.Empty
    '                End Try
    '                Try
    '                    XRow("Note") = XAttachmentNote.Value
    '                Catch ex As Exception
    '                    XRow("Note") = String.Empty
    '                End Try
    '                Try
    '                    XRow("NoteAuthor") = XAttachmentNoteAuthor.Value
    '                Catch ex As Exception
    '                    XRow("NoteAuthor") = String.Empty
    '                End Try
    '                Try
    '                    XRow("Title") = XAttachmentTitle.Value
    '                Catch ex As Exception
    '                    XRow("Title") = String.Empty
    '                End Try

    '                Try
    '                    XRow("FileTypeCode") = XAttachmentFileTypeCode.Value
    '                Catch ex As Exception
    '                    XRow("FileTypeCode") = String.Empty
    '                End Try

    '                TempIssueAttachments.Rows.Add(XRow)
    '            Next

    '        End If
    '        ''''''''''Adding Namespace prefix to Xpath elements'''''''''''''''
    '        Dim strElements As String() = XActionCriteriaXpath.Value.Split("/")
    '        Dim StrXPath As String = String.Empty
    '        For Each element In strElements
    '            If Not element = String.Empty AndAlso Not element.IndexOf(":") > 0 Then
    '                element = "/d:" & element
    '            ElseIf Not element = String.Empty Then
    '                If element.StartsWith("a:") Then
    '                    element = "/" & element
    '                Else
    '                    element = "/d:" & element
    '                End If
    '            End If
    '            StrXPath += element
    '        Next

    '        If StrXPath.IndexOf("[") > 0 Then
    '            If Not StrXPath.IndexOf("[a:") Then
    '                StrXPath.Replace("[", "[d:")
    '            End If
    '        End If
    '        ''''''''''''''''
    '        XActionCriteriaXpath.Value = StrXPath
    '        ''''RFI REPLY SECTION
    '        ReplyXpathRFIReply = ReceivedXDocument.Root.XPathSelectElement(XActionCriteriaXpath, NameSpaceManager)
    '        Dim TempReplyAttachments As DataTable = New DataTable
    '        Dim TempReplyNotes As DataTable = New DataTable()

    '        Dim XRFIReplyLine As XElement = Nothing
    '        Dim XRFIReplyTitle As XElement = Nothing
    '        Dim XRFIProposedSolution As XElement = Nothing
    '        Dim XRFIReplyDueDate As XElement = Nothing
    '        ''Getting RFI Reply elements
    '        If ReplyXpathRFIReply.Name.LocalName = "RFIReply" Then


    '            XRFIReplyLine = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "LineNumberID").FirstOrDefault
    '            XRFIReplyTitle = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '            XRFIProposedSolution = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "Description").FirstOrDefault
    '            XRFIReplyDueDate = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "Due").FirstOrDefault

    '            Dim XReplyAttachments = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "Attachment")

    '            TempReplyAttachments.Columns.Add("AttachmentBinary")
    '            TempReplyAttachments.Columns.Add("FileName")
    '            TempReplyAttachments.Columns.Add("MimeCode")
    '            TempReplyAttachments.Columns.Add("Description")
    '            TempReplyAttachments.Columns.Add("Note")
    '            TempReplyAttachments.Columns.Add("NoteAuthor")
    '            TempReplyAttachments.Columns.Add("Title")
    '            TempReplyAttachments.Columns.Add("FileTypeCode")
    '            If Not XReplyAttachments Is Nothing Then
    '                For Each XReplyAttachment In XReplyAttachments
    '                    Dim XRow As DataRow = TempReplyAttachments.NewRow
    '                    Dim XAttachmentData = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "EmbeddedDataBinaryObject").FirstOrDefault

    '                    Dim XAttachmentFileName As XElement = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "FileName").FirstOrDefault
    '                    Dim XAttachmentDescription As XElement = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "Description").FirstOrDefault
    '                    Dim XAttachmentMimeCode As XAttribute = Nothing
    '                    If Not XAttachmentData Is Nothing Then
    '                        XAttachmentMimeCode = XAttachmentData.Attributes.Where(Function(e) e.Name.LocalName = "mimeCode").FirstOrDefault
    '                    End If

    '                    Dim XAttachmentTitle As XElement = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "Title").FirstOrDefault
    '                    Dim XAttachmentNote As XElement = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "Note").FirstOrDefault
    '                    Dim XAttachmentNoteAuthor As XAttribute = Nothing
    '                    If Not XAttachmentNote Is Nothing Then
    '                        XAttachmentNoteAuthor = XAttachmentNote.Attributes.Where(Function(e) e.Name.LocalName = "Author").FirstOrDefault
    '                    End If
    '                    Dim XAttachmentFileTypeCode As XElement = XReplyAttachment.Elements.Where(Function(e) e.Name.LocalName = "FileTypeCode").FirstOrDefault
    '                    Try
    '                        XRow("AttachmentBinary") = XAttachmentData.Value
    '                    Catch ex As Exception
    '                        XRow("AttachmentBinary") = String.Empty
    '                    End Try
    '                    Try
    '                        XRow("Description") = XAttachmentFileName.Value
    '                    Catch ex As Exception
    '                        XRow("Description") = String.Empty
    '                    End Try
    '                    Try
    '                        XRow("FileName") = XAttachmentFileName.Value
    '                    Catch ex As Exception
    '                        XRow("FileName") = String.Empty
    '                    End Try
    '                    Try
    '                        XRow("MimeCode") = XAttachmentMimeCode.Value
    '                    Catch ex As Exception
    '                        XRow("MimeCode") = String.Empty
    '                    End Try

    '                    'Try
    '                    '    XRow("Note") = XAttachmentNote.Value
    '                    'Catch ex As Exception
    '                    '    XRow("Note") = String.Empty
    '                    'End Try
    '                    'Try
    '                    '    XRow("NoteAuthor") = XAttachmentNoteAuthor.Value
    '                    'Catch ex As Exception
    '                    '    XRow("NoteAuthor") = String.Empty
    '                    'End Try
    '                    Try
    '                        XRow("Title") = XAttachmentTitle.Value
    '                    Catch ex As Exception
    '                        XRow("Title") = String.Empty
    '                    End Try

    '                    Try
    '                        XRow("FileTypeCode") = XAttachmentFileTypeCode.Value
    '                    Catch ex As Exception
    '                        XRow("FileTypeCode") = String.Empty
    '                    End Try
    '                    TempReplyAttachments.Rows.Add(XRow)
    '                Next

    '            End If


    '            Dim XReplyNotes = ReplyXpathRFIReply.Elements.Where(Function(e) e.Name.LocalName = "Note")

    '            TempReplyNotes.Columns.Add("NoteDescription")
    '            TempReplyNotes.Columns.Add("Subject")
    '            If Not XNotes Is Nothing Then
    '                For Each ReplyNoteElement In XReplyNotes
    '                    Dim XRow As DataRow = TempReplyNotes.NewRow
    '                    Dim XAuthor As XAttribute = ReplyNoteElement.Attribute("author")
    '                    Dim AuthorID As String = String.Empty
    '                    Dim AuthorName As String = String.Empty
    '                    If Not XAuthor Is Nothing Then
    '                        AuthorID = XAuthor.Value
    '                    End If
    '                    Dim XParticipant As XElement = XHeader.Descendants(Sxns + "Participant").Where(Function(e) e.Element(Sxns + "ID").Value = AuthorID).FirstOrDefault
    '                    If Not XParticipant Is Nothing Then
    '                        Dim GivenName As XElement = XParticipant.Descendants.Where(Function(e) e.Name.LocalName = "GivenName").FirstOrDefault
    '                        Dim FamilyName As XElement = XParticipant.Descendants.Where(Function(e) e.Name.LocalName = "FamilyName").FirstOrDefault

    '                        If Not GivenName Is Nothing Then
    '                            AuthorName = GivenName.Value

    '                            If Not FamilyName Is Nothing Then
    '                                AuthorName += " " & FamilyName.Value
    '                            End If
    '                        Else
    '                            AuthorName = AuthorID
    '                        End If
    '                    End If
    '                    XRow("Subject") = AuthorID
    '                    XRow("NoteDescription") = ReplyNoteElement.Value
    '                    TempReplyNotes.Rows.Add(XRow)
    '                Next
    '            End If

    '        End If
    '        'Insert into Database
    '        Dim ProjectNumber As String = XProjectNumber.Value.ToString
    '        Dim RFIId As String = xhRFIId.Value.ToString
    '        Dim RFILineId As String = If(XRFIReplyLine IsNot Nothing, XRFIReplyLine.Value.ToString, String.Empty)
    '        Dim RFIHeaderTitle As String = xhTitle.Value.ToString
    '        Dim RFIReplyTitle As String = If(XRFIReplyLine IsNot Nothing, XRFIReplyTitle.Value.ToString, String.Empty)
    '        Dim RFIIssuedDate As DateTime = CDate(xhIssueDate.Value.ToString)
    '        Dim RFIQuestion As String = XIssueQuestion.Value.ToString
    '        Dim RFIProposedSolution As String = If(Not RFIReplyTitle = String.Empty OrElse Not XRFIProposedSolution Is Nothing, "<h1>" & RFIReplyTitle & "</h1>" & XRFIProposedSolution.Value.ToString, String.Empty)
    '        Dim RFIReplyDueDate As DateTime = CDate(XRFIReplyDueDate.Value.ToString)
    '        Dim ObjIntegcontroller As New IntegrationController
    '        Dim ExistingRFIRecordId As Integer = 0
    '        ExistingRFIRecordId = ObjIntegcontroller.GetRFIIdIfExists(ProjectNumber, RFIId)

    '        Dim returnId As Integer = ObjIntegcontroller.InsertRFIIntoDatabase(ProjectNumber, RFIId, RFILineId, RFIHeaderTitle, RFIQuestion, RFIProposedSolution, RFIReplyDueDate, RFIIssuedDate)


    '        If Not returnId > 0 Then
    '            If returnId = -1 Then
    '                ErrorMessage = "Project Not Found"
    '            Else
    '                ErrorMessage = "An error occured while storing RFI"
    '            End If
    '        Else
    '            If Not ExistingRFIRecordId > 0 Then

    '                If TempIssueAttachments.Rows.Count > 0 Then
    '                    For Each Row In TempIssueAttachments.Rows
    '                        Dim binaryData As Byte() = Nothing
    '                        If Row("AttachmentBinary") IsNot Nothing Then
    '                            Try
    '                                binaryData = Convert.FromBase64String(Row("AttachmentBinary").ToString)
    '                            Catch ex As Exception
    '                                ErrorMessage = "Error writing Attachment, The attachment is not Base 64"
    '                            End Try
    '                            Dim Memstream As New MemoryStream
    '                            Memstream.Write(binaryData, 0, binaryData.Length)
    '                            Dim stream As Stream = Memstream
    '                            FileManagerController.SaveAttachmentToPMWEb(returnId, "Issue: " & Row("Description").ToString, Row("FileName").ToString, Row("Note").ToString, stream, "RFI")
    '                        End If
    '                    Next
    '                End If

    '                If TempReplyAttachments.Rows.Count > 0 Then
    '                    For Each Row In TempReplyAttachments.Rows
    '                        Dim binaryData As Byte() = Nothing
    '                        If Row("AttachmentBinary") IsNot Nothing Then
    '                            Try
    '                                binaryData = Convert.FromBase64String(Row("AttachmentBinary").ToString)
    '                            Catch ex As Exception
    '                                ErrorMessage = "Error writing Attachment, The attachment is not Base 64"
    '                            End Try
    '                            Dim Memstream As New MemoryStream
    '                            Memstream.Write(binaryData, 0, binaryData.Length)
    '                            Dim stream As Stream = Memstream
    '                            FileManagerController.SaveAttachmentToPMWEb(returnId, "Reply: " & Row("Description").ToString, Row("FileName").ToString, Row("Note").ToString, stream, "RFI")
    '                        End If
    '                    Next
    '                End If


    '                If TempNotes.Rows.Count > 0 Then
    '                    For Each Row In TempNotes.Rows
    '                        Try
    '                            IntegrationController.AddDocumentNoteToPMWeb(returnId, "RFI", "Issue: " & Row("Subject").ToString, Row("NoteDescription".ToString))
    '                        Catch ex As Exception
    '                            ErrorMessage = ex.Message
    '                        End Try
    '                    Next
    '                End If


    '            End If

    '            If TempReplyNotes.Rows.Count > 0 Then
    '                For Each Row In TempReplyNotes.Rows
    '                    Try
    '                        IntegrationController.AddDocumentNoteToPMWeb(returnId, "RFI", "Reply: " & Row("Subject").ToString, Row("NoteDescription".ToString))
    '                    Catch ex As Exception
    '                        ErrorMessage = ex.Message
    '                    End Try
    '                Next
    '            End If
    '        End If

    '        If ErrorMessage = String.Empty Then

    '            Return "RFI has been successfully received"
    '        End If

    '        Return ErrorMessage
    '    Catch ex As Exception
    '        Return ex.Message.ToString
    '    End Try
    'End Function

    '<WebMethod()> _
    'Public Function AgcxmlSendRFIFromPMWeb(ByVal ProjectNumber As String, ByVal RFINumber As String) As String
    '    Dim ns As XNamespace = "http://agcxml.org/2"
    '    Dim ans As XNamespace = "http://www.openapplications.org/oagis/10"
    '    Dim SenderURN As String = "urn:publicid:IDN+WendelJones.com:"

    '    Dim ReturnXml As String = String.Empty
    '    Dim XProcessRFI As XDocument = New XDocument
    '    Dim ObjIntegcontroller As New IntegrationController
    '    If ProjectNumber = String.Empty Then
    '        Return "Project Number cannot  be empty"
    '    End If
    '    If RFINumber = String.Empty Then
    '        Return "RFI Number cannot  be empty"
    '    End If
    '    Dim IsRecordFound As Boolean = ObjIntegcontroller.GetRFIFromDatabase(ProjectNumber, RFINumber)

    '    If IsRecordFound Then
    '        Try


    '            With ObjIntegcontroller.RFIInfo
    '                XProcessRFI = GenerateProcessRFIXml()
    '                Dim Axns As XNamespace = XProcessRFI.Root.GetNamespaceOfPrefix("a")
    '                Dim Sxns As XNamespace = XProcessRFI.Root.GetDefaultNamespace()
    '                XProcessRFI.Descendants(Axns + "ApplicationArea").FirstOrDefault.Descendants(Axns + "Sender").Elements(Axns + "LogicalID").FirstOrDefault().Value = SenderURN + "apps:PMWeb"

    '                XProcessRFI.Descendants(Axns + "Process").FirstOrDefault.Descendants(Axns + "ActionExpression").FirstOrDefault() _
    '                  .Attribute("actionCode").Value = "Add"






    '                XProcessRFI.Descendants("RFIHeader").FirstOrDefault.Element(Axns + "ID").Value = .DocNumber

    '                XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Element(Axns + "LineNumberID").Value = "MainIssue"
    '                XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Element(Axns + "LineNumberID").Value = .Reference

    '                XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Descendants("Stage").FirstOrDefault.Element("Code").Value = "Complete"
    '                XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Descendants("Stage").FirstOrDefault.Element("DateTime").Value = Format(.AnsweredDate, "yyyy-MM-dd")


    '                Me.IntegrationController.GetDocumentNoteFromPMWeb(ObjIntegcontroller.RFIInfo.Id, "RFI")
    '                If Me.IntegrationController.DataSet.tblDocumentNotes.Rows.Count > 0 Then
    '                    For Each row In Me.IntegrationController.DataSet.tblDocumentNotes.Rows
    '                        Dim RFIIssue As XElement = XProcessRFI.Descendants("RFIIssue").FirstOrDefault


    '                        Dim Subject As String = row("Subject").ToString
    '                        Dim Note As String = row("Note").ToString

    '                        If Subject.Trim.StartsWith("Reply:") Then

    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Add(New XElement(ans + "Note", New XAttribute("author", Subject.Replace("Reply:", "").Trim)))
    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Elements.Last.Value = Note
    '                        End If



    '                    Next
    '                End If

    '                Me.FileManagerController.GetDocumentAttachments(ObjIntegcontroller.RFIInfo.Id, "RFI")
    '                If Me.FileManagerController.DataSet.tblDocumentAttachments.Rows.Count > 0 Then
    '                    For Each row In Me.FileManagerController.DataSet.tblDocumentAttachments.Rows
    '                        Dim RFIIssue As XElement = XProcessRFI.Descendants("RFIIssue").FirstOrDefault

    '                        Dim Description As String = row("Description").ToString
    '                        Dim FileName As String = row("FileName").ToString
    '                        Dim Extension As String = row("Extension").ToString
    '                        Dim FileContent As String = Convert.ToBase64String(row("FileContent"))

    '                        If Description.Trim.StartsWith("Reply:") Then

    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Add(GenerateAttachmentElement)
    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Elements.Last.Element(ans + "EmbeddedDataBinaryObject").Value = FileContent
    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Elements.Last.Element(ans + "FileName").Value = FileName + "." + Extension
    '                            XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Elements.Last.Element(ans + "FileTypeCode").Value = FileManagerController.GetContentType(Extension)

    '                        End If
    '                    Next
    '                End If

    '                'This should be changed to dynamically generated the Xpath
    '                If .Answer <> String.Empty Then
    '                    XProcessRFI.Descendants(Axns + "Process").FirstOrDefault.Descendants(Axns + "ActionExpression").FirstOrDefault() _
    '                                  .Value = "/ProcessRFI/DataArea/RFI/RFIIssue/RFIReply/a:Note[@author='ar-todd']"
    '                    XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Add(New XElement(ans + "Note", New XAttribute("author", "")))
    '                    XProcessRFI.Descendants("RFIIssue").FirstOrDefault.Descendants("RFIReply").FirstOrDefault.Elements.Last.Value = .Answer
    '                End If

    '            End With
    '            ReturnXml = XProcessRFI.ToString

    '        Catch ex As Exception
    '            Return ex.Message
    '        End Try

    '    Else
    '        Return "RecordNotFound"
    '    End If



    '    Return ReturnXml
    'End Function
    Private Function GenerateAttachmentElement() As XElement
        Dim ns As XNamespace = "http://agcxml.org/2"
        Dim ans As XNamespace = "http://www.openapplications.org/oagis/10"
        Dim AttachmentElement As XElement


        AttachmentElement = New XElement(ans + "Attachment", New XElement(ans + "EmbeddedDataBinaryObject", ""), New XElement(ans + "FileName", ""), New XElement(ans + "FileTypeCode", ""))

        Return AttachmentElement
    End Function
    Private Sub SchemaValidation(ByVal o As Object, ByVal e As ValidationEventArgs)
        XmlSchemaError = True
        XmlErrorMEssage = e.Message.ToString
    End Sub

    Private Function GenerateProcessRFIXml() As XDocument

        Dim XProcessRFI As XDocument = New XDocument

        Dim ns As XNamespace = "http://agcxml.org/2"
        Dim ans As XNamespace = "http://www.openapplications.org/oagis/10"

        Dim a As XNamespace = "a"


        Dim ProcessRFIXmlElement As XElement = New XElement(New XElement(ns + "ProcessRFI", _
                                            New XAttribute("systemEnvironmentCode", "Production"), _
                                            New XAttribute("releaseID", "2.0"), _
                                            New XAttribute("languageCode", "en-US"), _
                                            New XAttribute(XNamespace.Xmlns + "a", ans), _
                                           New XElement(ans + "ApplicationArea", _
                                            New XElement(ans + "Sender", New XElement(ans + "LogicalID")), _
                                            New XElement(ans + "Receiver", New XElement(ans + "LogicalID"))), _
                                           New XElement("DataArea", New XElement(ans + "Process", New XElement(ans + "ActionCriteria", _
                                            New XElement(ans + "ActionExpression", New XAttribute("actionCode", "")))), _
                                            New XElement("RFI", New XElement("RFIHeader", New XElement(ans + "ID", _
                                            New XAttribute("schemeID", ""), _
                                            New XAttribute("schemeAgencyID", ""))), _
                                            New XElement("RFIIssue", New XElement(ans + "LineNumberID"), New XElement("RFIReply", _
                                            New XElement(ans + "LineNumberID"), _
                                            New XElement("Stage", New XElement("Code"), New XElement("DateTime", New XAttribute("formatCode", _
                                            "YYYY-MM-DD")))))))))

        'New XElement(ans + "Note", New XAttribute("author", "")),



        XProcessRFI.Add(ProcessRFIXmlElement)

        Return XProcessRFI
    End Function

End Class