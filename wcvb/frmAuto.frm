VERSION 5.00
Begin VB.Form frmAuto 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ships that Autopilot with you"
   ClientHeight    =   1725
   ClientLeft      =   8190
   ClientTop       =   6255
   ClientWidth     =   3225
   Enabled         =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1725
   ScaleWidth      =   3225
   Visible         =   0   'False
   Begin VB.HScrollBar BarWingFive 
      Height          =   255
      Left            =   1080
      Max             =   32
      TabIndex        =   14
      Top             =   1440
      Width           =   2055
   End
   Begin VB.HScrollBar BarWingFour 
      Height          =   255
      Left            =   1080
      Max             =   32
      TabIndex        =   13
      Top             =   1080
      Width           =   2055
   End
   Begin VB.HScrollBar BarWingThree 
      Height          =   255
      Left            =   1080
      Max             =   32
      TabIndex        =   12
      Top             =   720
      Width           =   2055
   End
   Begin VB.HScrollBar BarWingTwo 
      Height          =   255
      Left            =   1080
      Max             =   32
      TabIndex        =   11
      Top             =   360
      Width           =   2055
   End
   Begin VB.HScrollBar BarWingOne 
      Height          =   255
      Left            =   1080
      Max             =   32
      TabIndex        =   10
      Top             =   0
      Width           =   2055
   End
   Begin VB.Label LblWingFive2 
      Height          =   255
      Left            =   600
      TabIndex        =   9
      Top             =   1440
      Width           =   375
   End
   Begin VB.Label LblWingFour2 
      Height          =   255
      Left            =   600
      TabIndex        =   8
      Top             =   1080
      Width           =   375
   End
   Begin VB.Label LblWingThree2 
      Height          =   255
      Left            =   600
      TabIndex        =   7
      Top             =   720
      Width           =   375
   End
   Begin VB.Label LblWingTwo2 
      Height          =   255
      Left            =   600
      TabIndex        =   6
      Top             =   360
      Width           =   375
   End
   Begin VB.Label LblWingOne2 
      Height          =   255
      Left            =   600
      TabIndex        =   5
      Top             =   0
      Width           =   375
   End
   Begin VB.Label LblWingFive 
      Caption         =   "No. 5:"
      Height          =   255
      Left            =   0
      TabIndex        =   4
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label LblWingFour 
      Caption         =   "No. 4:"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   1080
      Width           =   495
   End
   Begin VB.Label LblWingThree 
      Caption         =   "No. 3:"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   720
      Width           =   495
   End
   Begin VB.Label LblWingTwo 
      Caption         =   "No. 2:"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   360
      Width           =   495
   End
   Begin VB.Label LblWingOne 
      Caption         =   "No. 1:"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   495
   End
End
Attribute VB_Name = "frmAuto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
WingsChange
End Sub
Private Sub barWingOne_Change()
WingOneChange
End Sub
Private Sub barWingTwo_Change()
WingTwoChange
End Sub
Private Sub barWingThree_Change()
WingThreeChange
End Sub
Private Sub BarWingFour_Change()
WingFourChange
End Sub
Private Sub BarWingFive_Change()
WingFiveChange
End Sub
