VERSION 5.00
Begin VB.Form frmSelect 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Select a mission"
   ClientHeight    =   1245
   ClientLeft      =   2220
   ClientTop       =   1425
   ClientWidth     =   3315
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1245
   ScaleWidth      =   3315
   Begin VB.CommandButton cmdDone 
      Caption         =   "Done"
      Height          =   375
      Left            =   1080
      TabIndex        =   6
      Top             =   840
      Width           =   975
   End
   Begin VB.HScrollBar BarMission 
      Height          =   135
      Left            =   1200
      Max             =   4
      Min             =   1
      TabIndex        =   5
      Top             =   360
      Value           =   1
      Width           =   2055
   End
   Begin VB.HScrollBar barSeries 
      Height          =   135
      Left            =   1200
      Max             =   13
      Min             =   1
      TabIndex        =   2
      Top             =   0
      Value           =   1
      Width           =   2055
   End
   Begin VB.Label lblMisNo 
      Caption         =   "1"
      Height          =   255
      Left            =   720
      TabIndex        =   4
      Top             =   360
      Width           =   375
   End
   Begin VB.Label lblMission 
      Caption         =   "Mission:"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   360
      Width           =   615
   End
   Begin VB.Label lblSerNo 
      Caption         =   "1"
      Height          =   255
      Left            =   720
      TabIndex        =   1
      Top             =   0
      Width           =   375
   End
   Begin VB.Label lblSeries 
      Caption         =   "Series:"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   615
   End
End
Attribute VB_Name = "frmSelect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
ModLoad
End Sub
Private Sub barSeries_change()
lblSerNo.Caption = barSeries.Value
End Sub
Private Sub barMission_change()
lblMisNo.Caption = BarMission.Value
End Sub
Private Sub cmdDone_click()
frmSelect.Visible = False
frmMain.Visible = True
frmMain.Enabled = True
frmMain.SetFocus
Missoffset = 4 * (barSeries.Value - 1) + BarMission.Value
frmShips.Enabled = True
frmAuto.Enabled = True
ShipSelectShip
WingsChange
End Sub
