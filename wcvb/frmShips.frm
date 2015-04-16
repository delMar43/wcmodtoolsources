VERSION 5.00
Begin VB.Form frmShips 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ships"
   ClientHeight    =   4170
   ClientLeft      =   5970
   ClientTop       =   330
   ClientWidth     =   6045
   Enabled         =   0   'False
   Icon            =   "frmShips.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4170
   ScaleWidth      =   6045
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.HScrollBar BarZcoord 
      Height          =   255
      LargeChange     =   1000
      Left            =   1440
      Min             =   -32767
      SmallChange     =   100
      TabIndex        =   36
      Top             =   3840
      Width           =   3015
   End
   Begin VB.HScrollBar BarYcoord 
      Height          =   255
      LargeChange     =   1000
      Left            =   1440
      Min             =   -32767
      SmallChange     =   100
      TabIndex        =   35
      Top             =   3480
      Width           =   3015
   End
   Begin VB.HScrollBar BarXcoord 
      Height          =   255
      LargeChange     =   1000
      Left            =   1440
      Min             =   -32767
      SmallChange     =   100
      TabIndex        =   34
      Top             =   3120
      Width           =   3015
   End
   Begin VB.HScrollBar BarFormation 
      Height          =   255
      Left            =   2040
      Max             =   255
      TabIndex        =   33
      Top             =   2520
      Width           =   1095
   End
   Begin VB.HScrollBar barOnWing 
      Height          =   255
      Left            =   2040
      Max             =   255
      TabIndex        =   29
      Top             =   2160
      Width           =   1095
   End
   Begin VB.HScrollBar barTarget2 
      Height          =   255
      Left            =   5520
      Max             =   32
      TabIndex        =   23
      Top             =   1440
      Width           =   495
   End
   Begin VB.HScrollBar barTarget1 
      Height          =   255
      Left            =   5520
      Max             =   32
      TabIndex        =   22
      Top             =   1080
      Width           =   495
   End
   Begin VB.ComboBox lstOrders 
      Height          =   315
      ItemData        =   "frmShips.frx":000C
      Left            =   1080
      List            =   "frmShips.frx":0037
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   1080
      Width           =   2175
   End
   Begin VB.ComboBox lstPilot 
      Height          =   315
      ItemData        =   "frmShips.frx":00D1
      Left            =   1080
      List            =   "frmShips.frx":0113
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   720
      Width           =   2655
   End
   Begin VB.ComboBox lstShip 
      Height          =   315
      ItemData        =   "frmShips.frx":0248
      Left            =   1080
      List            =   "frmShips.frx":02A7
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   360
      Width           =   2655
   End
   Begin VB.HScrollBar barSize 
      Height          =   255
      Left            =   5520
      Max             =   255
      TabIndex        =   14
      Top             =   720
      Width           =   495
   End
   Begin VB.HScrollBar barSpeed 
      Height          =   255
      Left            =   5520
      Max             =   255
      TabIndex        =   11
      Top             =   360
      Width           =   495
   End
   Begin VB.HScrollBar barIFF 
      Height          =   255
      Left            =   5520
      Max             =   2
      TabIndex        =   5
      Top             =   0
      Width           =   495
   End
   Begin VB.HScrollBar barShipNo 
      Height          =   255
      Left            =   1440
      Max             =   31
      TabIndex        =   2
      Top             =   0
      Width           =   1215
   End
   Begin VB.Label LblCoords 
      Alignment       =   2  'Center
      Caption         =   "Ship Coordinates (at its Nav point)"
      Height          =   255
      Left            =   720
      TabIndex        =   43
      Top             =   2880
      Width           =   2535
   End
   Begin VB.Label LblZcoord2 
      Caption         =   "999999"
      Height          =   255
      Left            =   720
      TabIndex        =   42
      Top             =   3840
      Width           =   615
   End
   Begin VB.Label LblYcoord2 
      Caption         =   "999999"
      Height          =   255
      Left            =   720
      TabIndex        =   41
      Top             =   3480
      Width           =   615
   End
   Begin VB.Label LblXcoord2 
      Caption         =   "999999"
      Height          =   255
      Left            =   720
      TabIndex        =   40
      Top             =   3120
      Width           =   615
   End
   Begin VB.Label LblZcoord 
      Caption         =   "Z axis"
      Height          =   255
      Left            =   0
      TabIndex        =   39
      Top             =   3840
      Width           =   615
   End
   Begin VB.Label lblYcoord 
      Caption         =   "Y axis"
      Height          =   255
      Left            =   0
      TabIndex        =   38
      Top             =   3480
      Width           =   615
   End
   Begin VB.Label LblXcoord 
      Caption         =   "X axis"
      Height          =   255
      Left            =   0
      TabIndex        =   37
      Top             =   3120
      Width           =   615
   End
   Begin VB.Label lblFormation2 
      Height          =   255
      Left            =   1440
      TabIndex        =   32
      Top             =   2520
      Width           =   375
   End
   Begin VB.Label lblFormation 
      Caption         =   "Flight Formation:"
      Height          =   255
      Left            =   0
      TabIndex        =   31
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Label LblOnWing3 
      Caption         =   "(0 is Wing Leader)"
      Height          =   255
      Left            =   3240
      TabIndex        =   30
      Top             =   2160
      Width           =   1335
   End
   Begin VB.Label LblOnWing2 
      Height          =   255
      Left            =   1440
      TabIndex        =   28
      Top             =   2160
      Width           =   375
   End
   Begin VB.Label lblOnWing 
      Caption         =   "Position on Wing:"
      Height          =   255
      Left            =   0
      TabIndex        =   27
      Top             =   2160
      Width           =   1335
   End
   Begin VB.Label LblFollowTarget 
      Height          =   255
      Left            =   1440
      TabIndex        =   26
      Top             =   1800
      Width           =   375
   End
   Begin VB.Label lblFollow 
      Caption         =   "Will Follow Ship:"
      Height          =   255
      Left            =   0
      TabIndex        =   25
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label LblTType2 
      Alignment       =   2  'Center
      Caption         =   "And:"
      Height          =   255
      Left            =   4320
      TabIndex        =   24
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label LblTarget2 
      Height          =   255
      Left            =   5040
      TabIndex        =   21
      Top             =   1440
      Width           =   375
   End
   Begin VB.Label LblTarget1 
      Height          =   255
      Left            =   5040
      TabIndex        =   20
      Top             =   1080
      Width           =   375
   End
   Begin VB.Label LblTType 
      Alignment       =   2  'Center
      Height          =   255
      Left            =   3360
      TabIndex        =   19
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label lblOrders 
      Caption         =   "Orders:"
      Height          =   255
      Left            =   0
      TabIndex        =   17
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label lblSize2 
      Height          =   195
      Left            =   5040
      TabIndex        =   13
      Top             =   720
      Width           =   270
   End
   Begin VB.Label lblSize 
      Caption         =   "Field Size:"
      Height          =   195
      Left            =   4080
      TabIndex        =   12
      Top             =   720
      Width           =   720
   End
   Begin VB.Label lblSpeed2 
      Height          =   195
      Left            =   5040
      TabIndex        =   10
      Top             =   360
      Width           =   360
   End
   Begin VB.Label lblSpeed 
      Caption         =   "Ship Speed:"
      Height          =   195
      Left            =   3960
      TabIndex        =   9
      Top             =   360
      Width           =   870
   End
   Begin VB.Label lblShipPilot 
      Caption         =   "Flown by:"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   720
      Width           =   975
   End
   Begin VB.Label lblIFF3 
      Height          =   255
      Left            =   4200
      TabIndex        =   7
      Top             =   0
      Width           =   1215
   End
   Begin VB.Label lblIFF2 
      Height          =   255
      Left            =   3840
      TabIndex        =   6
      Top             =   0
      Width           =   255
   End
   Begin VB.Label lblIFF 
      Caption         =   "IFF Code:"
      Height          =   255
      Left            =   2880
      TabIndex        =   4
      Top             =   0
      Width           =   855
   End
   Begin VB.Label lblShipType 
      Caption         =   "Ship Type:"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   360
      Width           =   975
   End
   Begin VB.Label lblShipNo2 
      Height          =   255
      Left            =   1080
      TabIndex        =   1
      Top             =   0
      Width           =   255
   End
   Begin VB.Label lblShipNo 
      Caption         =   "Ship Number:"
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   975
   End
End
Attribute VB_Name = "frmShips"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
ShipSelectShip
End Sub
Private Sub barShipNo_Change()
ShipSelectShip
End Sub
Private Sub lstShip_Click()
ShipChangeShip
End Sub
Private Sub barIFF_Change()
ShipChangeIFF
End Sub
Private Sub lstOrders_Click()
ShipChangeOrders
End Sub
Private Sub BarXcoord_Change()
ShipChangeXcoord
End Sub
Private Sub BarYcoord_Change()
ShipChangeYcoord
End Sub
Private Sub BarZcoord_Change()
ShipChangeZcoord
End Sub
Private Sub barOnWing_Change()
ShipChangeOnWing
End Sub
Private Sub barSpeed_Change()
ShipChangeSpeed
End Sub
Private Sub barSize_Change()
ShipChangeSize
End Sub
Private Sub lstPilot_Click()
ShipChangePilot
End Sub
Private Sub barTarget2_Change()
ShipChangeTarget2
End Sub
Private Sub BarFormation_Change()
ShipChangeFormation
End Sub
Private Sub barTarget1_Change()
ShipChangeTarget1
End Sub
