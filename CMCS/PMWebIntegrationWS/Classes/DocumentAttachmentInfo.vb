Public Class DocumentAttachmentInfo



#Region "Constructor"

    Friend Sub New()
        '      Me.PM = Parent
    End Sub

#End Region

#Region "Properties"


    Private _Id As Integer
    Private _DocumentTypeId As Integer
    Private _DocumentType As String
    Private _DocumentId As Integer
    Private _EntityId As Integer
    Private _EntityTypeId As Integer
    Private _FileId As Integer
    Private _Description As String = String.Empty
    Private _Notes As String
    Private _IsInRotator As Boolean
    Private _IsLastRevision As Boolean = True

    Private _FileName As String
    Private _FileGuid As Guid
    Private _FileExtension As String
    Private _ContentType As String
    Private _FileSize As Integer
    Private _RealFileName As String
    Private _URL As String
    Private _SelectedOption As String
    Private _IsLastInvoice As Boolean = False
    Private _EmailId As String = String.Empty
    Private _EnableMultipleDownload As Boolean = False
    Private _dts As dtsAgcXml
    Public Enum [Options]
        [URL] = 1
        [UPLOAD] = 2
        [FILEMANAGER] = 3
        [WSS] = 4
        [EMAIL] = 5
        [LinkToPMWebRecord] = 6
        [PMWebWord] = 7
        [Aconex] = 8
    End Enum


    Public Property RealFileName() As String
        Get
            Return _RealFileName
        End Get
        Set(ByVal value As String)
            _RealFileName = value
        End Set
    End Property

    Public Property EmailId() As String
        Get
            Return _EmailId
        End Get
        Set(ByVal value As String)
            _EmailId = value
        End Set
    End Property

    Public Property Id() As Integer
        Get
            Return _Id
        End Get
        Set(ByVal value As Integer)
            _Id = value
        End Set
    End Property


    Public Property DocumentTypeId() As Integer
        Get
            Return _DocumentTypeId
        End Get
        Set(ByVal value As Integer)
            _DocumentTypeId = value
        End Set
    End Property


    Public Property IsLastInvoice() As Boolean
        Get
            Return _IsLastInvoice
        End Get
        Set(ByVal value As Boolean)
            _IsLastInvoice = value
        End Set
    End Property


    Public Property DocumentType() As String
        Get
            Return _DocumentType
        End Get
        Set(ByVal value As String)
            _DocumentType = value
        End Set
    End Property


    Public Property DocumentId() As Integer
        Get
            Return _DocumentId
        End Get
        Set(ByVal value As Integer)
            _DocumentId = value
        End Set
    End Property


    Public Property EntityId() As Integer
        Get
            Return _EntityId
        End Get
        Set(ByVal value As Integer)
            _EntityId = value
        End Set
    End Property


    Public Property EntityTypeId() As Integer
        Get
            Return _EntityTypeId
        End Get
        Set(ByVal value As Integer)
            _EntityTypeId = value
        End Set
    End Property


    Public Property FileId() As Integer
        Get
            Return _FileId
        End Get
        Set(ByVal value As Integer)
            _FileId = value
        End Set
    End Property


    Public Property Description() As String
        Get
            Return _Description
        End Get
        Set(ByVal value As String)
            _Description = value
        End Set
    End Property


    Public Property Notes() As String
        Get
            Return _Notes
        End Get
        Set(ByVal value As String)
            _Notes = value
        End Set
    End Property


    Public Property IsInRotator() As Boolean
        Get
            Return _IsInRotator
        End Get
        Set(ByVal value As Boolean)
            _IsInRotator = value
        End Set
    End Property


    Public Property IsLastRevision() As Boolean
        Get
            Return _IsLastRevision
        End Get
        Set(ByVal value As Boolean)
            _IsLastRevision = value
        End Set
    End Property



    'Public Property FileName() As String
    '    Get
    '        Return _FileName
    '    End Get
    '    Set(ByVal value As String)
    '        _FileName = value
    '    End Set
    'End Property


    Public Property URL() As String
        Get
            Return _URL
        End Get
        Set(ByVal value As String)
            _URL = value
        End Set
    End Property


    ''' <summary>
    ''' Gets or sets the selected option.
    ''' </summary>
    ''' <value>The selected option.</value>
    Public Property SelectedOption() As String
        Get
            Return _SelectedOption
        End Get
        Set(ByVal value As String)
            _SelectedOption = value
        End Set
    End Property


    Public Property FileGuid() As Guid
        Get
            Return _FileGuid
        End Get
        Set(ByVal value As Guid)
            _FileGuid = value
        End Set
    End Property


    'Public Property FileExtension() As String
    '    Get
    '        Return _FileExtension
    '    End Get
    '    Set(ByVal value As String)
    '        _FileExtension = value
    '    End Set
    'End Property


    'Public Property ContentType() As String
    '    Get
    '        Return _ContentType
    '    End Get
    '    Set(ByVal value As String)
    '        _ContentType = value
    '    End Set
    'End Property


    'Public Property FileSize() As Integer
    '    Get
    '        Return _FileSize
    '    End Get
    '    Set(ByVal value As Integer)
    '        _FileSize = value
    '    End Set
    'End Property



    ''' <summary>
    ''' Gets the data set.
    ''' </summary>
    ''' <value>The data set.</value>
    Public ReadOnly Property DataSet() As dtsAgcXml
        Get
            If (_dts Is Nothing) Then
                _dts = New dtsAgcXml()
            End If
            Return _dts
        End Get
    End Property


    Public ReadOnly Property EnableMultipleDownload() As Boolean
        Get
            If ConfigurationManager.AppSettings("EnableMultipleDownload") IsNot Nothing Then
                _EnableMultipleDownload = CBool(IIf(ConfigurationManager.AppSettings("EnableMultipleDownload").ToString = String.Empty, False, ConfigurationManager.AppSettings("EnableMultipleDownload")))
            End If
            Return _EnableMultipleDownload
        End Get
    End Property

#End Region

End Class




