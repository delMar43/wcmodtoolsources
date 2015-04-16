VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Wing Commander 1 Mission Editor"
   ClientHeight    =   4215
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5835
   ControlBox      =   0   'False
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   4215
   ScaleWidth      =   5835
   Visible         =   0   'False
   Begin VB.CommandButton cmdAuto 
      Caption         =   "&Autopilot"
      Height          =   375
      Left            =   1080
      TabIndex        =   4
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton cmdChange 
      Caption         =   "Select &Mission"
      Height          =   375
      Left            =   4440
      TabIndex        =   3
      Top             =   3360
      Width           =   1335
   End
   Begin VB.CommandButton cmdShips 
      Caption         =   "&Ships"
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "Closefirst"
      Height          =   375
      Left            =   4800
      TabIndex        =   1
      Top             =   2880
      Width           =   975
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   375
      Left            =   4800
      TabIndex        =   0
      Top             =   3840
      Width           =   975
   End
   Begin VB.Label lbl255Info 
      Caption         =   "Remember, the value 255 stands for <none>"
      Height          =   495
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   1695
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdExit_click()
Finish
End Sub
Private Sub cmdClose_click()
Closefirst
End Sub
Private Sub cmdChange_click()
SelectMission
End Sub
Private Sub cmdShips_click()
frmShips.Visible = True
frmShips.Enabled = True
frmShips.SetFocus
End Sub
Private Sub cmdAuto_Click()
frmAuto.Visible = True
frmAuto.Enabled = True
frmAuto.SetFocus
End Sub

