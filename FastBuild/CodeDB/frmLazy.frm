VERSION 5.00
Begin VB.Form frmLazy 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Transformation tools.."
   ClientHeight    =   5820
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10245
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5820
   ScaleWidth      =   10245
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdSplitBlob 
      Caption         =   "Split Blob"
      Height          =   330
      Left            =   1755
      TabIndex        =   13
      Top             =   5400
      Width           =   915
   End
   Begin VB.CommandButton cmdLockEnumCase 
      Caption         =   "Lock Enum Case"
      Height          =   315
      Left            =   3840
      TabIndex        =   12
      Top             =   5400
      Width           =   1455
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Enum to Text"
      Height          =   375
      Left            =   7500
      TabIndex        =   11
      Top             =   5400
      Width           =   1395
   End
   Begin VB.CommandButton cmdByte 
      Caption         =   "Byte()"
      Height          =   330
      Left            =   45
      TabIndex        =   10
      Top             =   5355
      Width           =   1455
   End
   Begin VB.CommandButton cmdClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   9180
      TabIndex        =   9
      Top             =   5400
      Width           =   1005
   End
   Begin VB.CommandButton cmdCopy 
      Caption         =   "Copy"
      Height          =   420
      Left            =   9180
      TabIndex        =   8
      Top             =   4950
      Width           =   1005
   End
   Begin VB.CommandButton cmdHTML 
      Caption         =   "HTMLize"
      Height          =   420
      Left            =   7425
      TabIndex        =   7
      Top             =   4950
      Width           =   1500
   End
   Begin VB.CheckBox chkStripSpace 
      Caption         =   "StripSpace"
      Height          =   255
      Left            =   5850
      TabIndex        =   6
      Top             =   5400
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "CR -> :"
      Height          =   390
      Left            =   5580
      TabIndex        =   5
      Top             =   4950
      Width           =   1530
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Swap a = b"
      Height          =   375
      Left            =   3825
      TabIndex        =   4
      Top             =   4950
      Width           =   1515
   End
   Begin VB.CheckBox Check1 
      Caption         =   "w/ vbCrLf"
      Height          =   255
      Left            =   2745
      TabIndex        =   3
      Top             =   5355
      Width           =   1155
   End
   Begin VB.CommandButton Command2 
      Caption         =   "MultiLine String"
      Height          =   360
      Left            =   1800
      TabIndex        =   2
      Top             =   4950
      Width           =   1530
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4770
      Left            =   45
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   90
      Width           =   10035
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Chr( ) "
      Height          =   315
      Left            =   45
      TabIndex        =   0
      Top             =   4995
      Width           =   1485
   End
End
Attribute VB_Name = "frmLazy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const BLU = "<FONT COLOR='#000088'>"
Const GRN = "<FONT COLOR='#008800'>"
Const CF = "</FONT>"

Dim RW() As String
Dim Special() As String
    
Private Sub cmdByte_Click()
    
    On Error Resume Next
    
    Dim s As String, i
    Dim ret As String, b As Byte
    Dim decoder As String
    
    Dim xKey
    
again:
    xKey = InputBox("Enter optional xorkey ", , "&h66")
    If Len(xKey) = 0 Then xKey = 0
    
    Err.Clear
    xKey = CByte(CLng(xKey))
    
    If Err.Number <> 0 Then
        MsgBox "Invalid xor byte value, remember &h prefix for hex"
        GoTo again
    End If
    
    s = Text2
    ret = "dim b(" & Len(s) - 1 & ") as byte:"
    For i = 1 To Len(s)
        b = CByte(Asc(Mid(s, i, 1)))
        If xKey = 0 Then
            ret = ret & "b(" & i - 1 & ") = &h" & Hex(b)
        Else
            ret = ret & "b(" & i - 1 & ") = &h" & Hex(b Xor xKey)
        End If
        ret = ret & ": "
    Next
        
    If xKey > 0 Then
        decoder = " XOR key &h" & Hex(xKey) & vbCrLf & _
                  "'For i = 0 To UBound(b): b(i) = b(i) Xor &H" & Hex(xKey) & ": Next"
    End If
    
    Text2 = "'" & s & decoder & vbCrLf & Mid(ret, 1, Len(ret) - 2)
    
End Sub

Private Sub cmdClear_Click()
    Text2 = Empty
End Sub

Private Sub cmdCopy_Click()
    Clipboard.Clear
    Clipboard.SetText Text2.Text
End Sub

Private Sub cmdHTML_Click()

    If AryIsEmpty(RW) Then
        'case & space after word is important !
        RW = Split("Const ,Else ,ElseIf ,If ,Alias ,And , As,Base ,Binary ,Boolean," & _
                    "Byte ,ByVal ,Call ,Case ,CBool ,CByte ,CCur ,CDate ,CDbl ,CDec ," & _
                    "CInt ,CLng ,Close ,Compare ,Const ,CSng ,CStr ,Currency ,CVar ," & _
                    "CVErr ,Decimal ,Declare ,DefBool ,DefByte ,DefCur ,DefDate ," & _
                    "DefDbl ,DefDec ,DefInt ,DefLng ,DefObj ,DefSng ,DefStr ,DefVar ," & _
                    "Dim ,Do ,Double ,Each ,End ,Enum ,Eqv ,Erase ,Error ," & _
                    "Exit ,Explicit ,False ,For ,Function ,Get ,Global ,GoSub ,GoTo ," & _
                    "Imp ,In ,Input ,Input ,Integer ,Is ,LBound ,Let ,Lib ,Like ,Line ,Lock ," & _
                    "Long ,Loop ,LSet ,Name ,New ,Next ,Not ,Object ,Open ,Option ,On ,Or ," & _
                    "Output ,Preserve ,Print ,Private ,Property ,Public ,Put ,Random ," & _
                    "Read ,ReDim ,Resume ,Return ,RSet ,Seek ,Select ,Set ,Single ,Spc ," & _
                    "Static ,String,Stop ,Sub ,Tab ,Then ,True ,UBound ,Variant ,While ," & _
                    "Wend ,With ,Empty " _
              , ",")
              
        'these handle some other common casekeywords that dont fit the word<space> profile
        'necessary because this search is done on a macro scale and not by trying to anlyze
        'each word or character it comes across
        Special = Split("CLng(,CInt(,CBool(,CByte(,CStr(,True),False),Empty),(True,(False,(Empty", ",")
    End If
    

    Dim comment, code, lastDq, lastSq, tmp, i, it
    
    tmp = Split(Text2, vbCrLf)
    For i = 0 To UBound(tmp)
        comment = Empty
        code = parseHTMLChars(tmp(i) & " ")
        lastDq = InStrRev(code, """")
        lastSq = InStrRev(code, "'")
        If lastSq > lastDq Then
            If lastDq = -1 Then lastDq = lastSq
            comment = Mid(code, lastDq)
            code = Mid(code, 1, lastDq)
        End If
        tmp(i) = ParseCode(code) & ParseComment(comment)
    Next
     
    Dim header As String
    
    header = "<div style='background: #ffffff; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;'>" & _
             "<pre style='margin: 0; line-height: 125%'>" & vbCrLf
    
    it = Join(tmp, vbCrLf)
    Text2 = header & RemoveRedundantTags(it) & vbCrLf & "</div></pre>"

    
    
End Sub

Function AryIsEmpty(ary) As Boolean
  On Error GoTo oops
  Dim i As Long
    i = UBound(ary)  '<- throws error if not initalized
    AryIsEmpty = False
  Exit Function
oops: AryIsEmpty = True
End Function

Function parseHTMLChars(it)
    Dim t As String
    t = Replace(it, "&", "&amp;")
    t = Replace(t, "<", "&lt;")
    t = Replace(t, ">", "&gt;")
    parseHTMLChars = t
End Function

Function ParseCode(it)
    Dim i As Long
    If it = Empty Then Exit Function
    For i = 0 To UBound(RW)
        it = Replace(it, RW(i), BLU & RW(i) & CF)
    Next
    For i = 0 To UBound(Special)
        it = Replace(it, Special(i), BLU & Special(i) & CF)
    Next
    ParseCode = it
End Function

Function ParseComment(it)
    If it = Empty Then Exit Function
    ParseComment = GRN & it & CF
End Function

Function RemoveRedundantTags(it)
    'it = Replace(it, CF & BLU, Empty)
    'it = Replace(it, CF & GRN, Empty)
    'it = Replace(it, CF & vbCrLf & BLU, vbCrLf)
    'it = Replace(it, CF & vbCrLf & GRN, vbCrLf)
    RemoveRedundantTags = it
End Function

Private Sub cmdLockEnumCase_Click()
    Dim tmp As String
    If InStr(1, Text2, "Enum", vbTextCompare) < 1 Then
        MsgBox "Paste an enum into textbox to process", vbInformation
        Exit Sub
    End If
    tmp = LockEnumCase(Text2)
    If Len(tmp) = 0 Then
        MsgBox "Failed"
    Else
        Text2 = Text2 & vbCrLf & tmp
    End If
End Sub

 
'Bonnie West Oct 9th, 2014, 06:19 PM #1
'http://www.vbforums.com/showthread.php?778109-VB6-modLockEnumCase-bas-Enforce-Case-of-Enums
Public Function LockEnumCase(enumText As String, Optional ByVal LineLen As Integer = 80) As String  'Adjust length of output lines as desired
    Dim sBlock As String, sLine As String, sText As String, oMatch As Object 'Match

   'See if there's anything to process; quit if no text was copied
    'If Clipboard.GetFormat(vbCFText) Then sText = Clipboard.GetText Else Exit Function
    sText = enumText
    
   'Prepend the conditional compiler directive that is set to False
    sBlock = "#If False Then" & vbNewLine
   'Dimension variables that reuses the Enum members' names
    sLine = "Dim "

    With CreateObject("VBScript.RegExp") 'New RegExp
        .Global = True
        .MultiLine = True

       'Strip all comments
       .Pattern = " +'.*$"
        sText = .Replace(sText, vbNullString)

       'Exclude Enum statements
       .Pattern = "(\b(Private|Public)? Enum [A-Za-z]\w*\b)|(\bEnd Enum\b)"
        sText = .Replace(sText, vbNullString)

       'Split multiple expressions in a single line into their own lines
        If InStrB(sText, ":") Then sText = Replace(sText, ":", vbNewLine)

       'This should match most Enum member names, including those enclosed with []
       .Pattern = "^ *([A-Za-z]\w*|\[.+\]) *(?:=|$)"

        For Each oMatch In .Execute(sText)
            sLine = sLine & (oMatch.SubMatches(0&) & ", ")

           'Check if the string being built is exceeding
           'the *suggested* limit of each output line
            If Len(sLine) >= LineLen Then
               'If so, commit this line to the output string
                sBlock = sBlock & (sLine & "_")
               'Begin anew at the next line
                sLine = vbNewLine
            End If
        Next
    End With

   'Finish the conditional compiler directive block, removing empty lines as needed
    sBlock = sBlock & (IIf(sLine <> vbNewLine, sLine, vbNullString) _
                    & vbNewLine & "#End If" & vbNewLine)
    
    If InStr(sBlock, ",") = 0 Then
        'we failed to do anything
        Exit Function
    Else
        'Overwrite the last comma with a space
         Mid$(sBlock, InStrRev(sBlock, ",")) = " "
    End If
    
   'Try to erase the last underscore on the last line, if present
    On Error Resume Next
    Mid$(sBlock, InStrRev(sBlock, "_" & vbNewLine & "#")) = " "
    On Error GoTo 0

    LockEnumCase = sBlock
End Function



Private Sub cmdSplitBlob_Click()
    
    Dim s As String, tmp() As String, a() As String, x, j
    Dim maxLen As Long
    
    On Error Resume Next
    maxLen = CLng(InputBox("Enter max line length: ", , 50))
    If maxLen = 0 Then Exit Sub
    
    a = Split(Text2.Text, vbCrLf)
    For Each x In a
        If Len(x) > maxLen Then
            j = x
            Do While Len(j) > maxLen
                push tmp, "x = x & """ & Mid(j, 1, maxLen) & """"
                j = Mid(j, maxLen + 1)
            Loop
            If Len(j) > 0 Then
                'push tmp, j & """ & vbcrlf & """
                push tmp, "x = x & """ & j & """"
            End If
        Else
            push tmp, "x = vbcrlf & x & """ & x & """ & vbcrlf "
        End If
    Next
    
    'Text2 = """" & Join(tmp, """ & _ " & vbCrLf & """") & """"
    Text2 = Join(tmp, vbCrLf)
    
End Sub

Private Sub Command1_Click()
    Dim s As String, i, l
    Dim ret As String
    
    s = Text2
    For i = 1 To Len(s)
        l = Mid(s, i, 1)
        ret = ret & "Chr(" & Asc(l) & ") & "
    Next
        
    Text2 = Mid(ret, 1, Len(ret) - 2)
    
End Sub

Private Sub Command2_Click()
    Dim tmp() As String, ret As String, i
    
    ret = Replace(Text2, """", """""")
    tmp() = Split(ret, vbCrLf)
    
    For i = 0 To UBound(tmp)
        tmp(i) = """" & tmp(i) & """ " & IIf(Check1.value = 1, "& vbcrlf ", "") & "& _"
    Next
    
    ret = Join(tmp(), vbCrLf)
    
    Text2 = Mid(ret, 1, Len(ret) - 3)
    
End Sub

 

Private Sub Command3_Click()

Dim tmp, i, e

    tmp = Split(Text2, vbCrLf)
    For i = 0 To UBound(tmp)
        If InStr(tmp(i), "=") > 0 Then
            e = Split(tmp(i), "=", 2)
            tmp(i) = Trim(e(1)) & "=" & Trim(e(0))
        End If
    Next
    Text2 = Join(tmp, vbCrLf)
            
End Sub

Private Sub Command4_Click()
    Dim x, i, ret
    
    x = Split(Text2, vbCrLf)
    For i = 0 To UBound(x)
        If Len(Trim(x(i))) > 0 Then
            ret = ret & x(i) & ": "
        Else
            ret = ret & vbCrLf
        End If
    Next
    
    ret = Replace(ret, ": " & vbCrLf, vbCrLf)
    
    If chkStripSpace.value = 1 Then
        ret = Replace(ret, "  ", "")
    End If
    
    Text2 = ret
End Sub


Private Sub Command5_Click()
    On Error Resume Next
    'CALLBACK_MSG_RULE_MATCHING = 1 -> case 1: m = "CALLBACK_MSG_RULE_MATCHING"
    Dim x() As String, y(), tmp() As String, z, i
    Dim enumName As String, buf As String
    
    tmp = Split(Replace(Text2, vbTab, Empty), vbCrLf)
    push y, "function __ENUMNAME_2Str(e as __ENUMNAME_) as string"
    push y, "   Dim m as string "
    push y, "   select case e"
    For Each z In tmp
        z = Trim(z)
        If Left(z, 5) = "Enum " Then
            enumName = Trim(Mid(z, 6))
        End If
        If InStr(z, "=") > 0 Then
            x = Split(Trim(z), "=")
            push y, vbTab & "   case " & Trim(x(1)) & ": m = """ & Trim(x(0)) & """"
            i = i + 1
        End If
    Next
    push y, "   End select"
    push y, "   __ENUMNAME_2Str = m"
    push y, "end function"
    
    If i = 0 Then
        MsgBox "Expected input: CALLBACK_MSG_RULE_MATCHING = 1 " & vbCrLf & "-> case 1: m = CALLBACK_MSG_RULE_MATCHING"
    Else
        Err.Clear
        buf = Join(y, vbCrLf)
        If Len(enumName) > 0 Then buf = Replace(buf, "__ENUMNAME_", enumName)
        Clipboard.Clear
        Clipboard.SetText buf
        If Err.Number > 0 Then
            MsgBox Err.Description
        Else
            MsgBox i & " lines copied to clipboard"
        End If
    End If
    
End Sub

Private Sub Form_Load()
    Text2 = Clipboard.GetText
End Sub

 

