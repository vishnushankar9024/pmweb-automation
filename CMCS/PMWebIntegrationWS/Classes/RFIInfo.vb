Public Class RFIInfo


    Private _Id As Integer
    Private _ProjectId As Integer
    Private _PhaseId As Integer
    Private _DocNumber As String
    Private _ProjectNumber As String

    Private _Description As String = String.Empty
    Private _DocStatusId As Integer
    Private _DocumentDate As Date
    Private _CreatedDate As Date?
    Private _Inactive As Boolean
    Private _RecordDescription As String = String.Empty
    Private _RFIDATE As Date? = Nothing
    Private _Question As String = String.Empty
    Private _RequiredDate As Date? = Nothing
    Private _Answer As String = String.Empty
    Private _AnsweredDate As DateTime? = Nothing
    Private _ProposedSolution As String = String.Empty
    Private _Reference As String = String.Empty
    Private _RecordExists As Boolean = False

    Public Property Id() As Integer
        Get
            Return _Id
        End Get
        Set(ByVal value As Integer)
            _Id = value
        End Set
    End Property
    Public Property RecordExists() As String
        Get
            Return _RecordExists
        End Get
        Set(ByVal value As String)
            _RecordExists = value
        End Set
    End Property
    Public Property ProjectNumber() As String
        Get
            Return _ProjectNumber
        End Get
        Set(ByVal value As String)
            _ProjectNumber = value
        End Set
    End Property
    Public Property Reference() As String
        Get
            Return _Reference
        End Get
        Set(ByVal value As String)
            _Reference = value
        End Set
    End Property
    Public Property RFIDATE() As Date?
        Get
            Return _RFIDATE
        End Get
        Set(ByVal value As Date?)
            _RFIDATE = value
        End Set
    End Property

    Public Property Question() As String
        Get
            Return _Question
        End Get
        Set(ByVal value As String)
            _Question = value
        End Set
    End Property


    Public Property RequiredDate() As Date?
        Get
            Return _RequiredDate
        End Get
        Set(ByVal value As Date?)
            _RequiredDate = value
        End Set
    End Property


    Public Property Answer() As String
        Get
            Return _Answer
        End Get
        Set(ByVal value As String)
            _Answer = value
        End Set
    End Property


    Public Property AnsweredDate() As DateTime?
        Get
            Return _AnsweredDate
        End Get
        Set(ByVal value As DateTime?)
            _AnsweredDate = value
        End Set
    End Property

    Public Property ProjectId() As Integer
        Get
            Return _ProjectId
        End Get
        Set(ByVal value As Integer)
            _ProjectId = value
        End Set
    End Property
    Public Property RecordDescription() As String
        Get
            Return _RecordDescription
        End Get
        Set(ByVal value As String)
            _RecordDescription = value
        End Set
    End Property

    Public Property ProposedSolution() As String
        Get
            Return _ProposedSolution
        End Get
        Set(ByVal value As String)
            _ProposedSolution = value
        End Set
    End Property


    Public Property DocNumber() As String
        Get
            Return _DocNumber
        End Get
        Set(ByVal value As String)
            _DocNumber = value
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
    Public Property Inactive() As Boolean
        Get
            Return _Inactive
        End Get
        Set(ByVal value As Boolean)
            _Inactive = value
        End Set
    End Property




    Public Property DocumentDate() As Date
        Get
            Return _DocumentDate
        End Get
        Set(ByVal value As Date)
            _DocumentDate = value
        End Set
    End Property

    Public Property DocStatusId() As Integer
        Get
            Return _DocStatusId
        End Get
        Set(ByVal value As Integer)
            _DocStatusId = value
        End Set
    End Property
End Class
