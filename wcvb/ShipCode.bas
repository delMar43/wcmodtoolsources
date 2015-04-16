Attribute VB_Name = "ShipCode"
Public ShipNo As Integer
Public ShipType As String * 1
Public ShipIFF As String * 1
Public ShipFollowShip As String * 1
Public ShipOrders As String * 1
Public ShipXcoordByte1 As String * 1
Public ShipXcoordByte2 As String * 1
Public ShipXcoordByte3 As String * 1
Public ShipYcoordByte1 As String * 1
Public ShipYcoordByte2 As String * 1
Public ShipYcoordByte3 As String * 1
Public ShipZcoordByte1 As String * 1
Public ShipZcoordByte2 As String * 1
Public ShipZcoordByte3 As String * 1
Public ShipOnWing As String * 1
Public ShipSpeed As String * 1
Public ShipSize As String * 1
Public ShipPilot As String * 1
Public ShipTarget2 As String * 1
Public ShipFormation As String * 1
Public ShipTarget1 As String * 1

Public Coord As String
Public Byte1 As String
Public Byte2 As String
Public Byte3 As String
Sub ShipSelectShip()
ShipNo = frmShips.barShipNo.Value
If ShipNo = 0 Then
    offset = ((Missoffset - 1) * 1344) + 151325
    Else: offset = ((Missoffset - 1) * 1344) + 151325 + 42 * ShipNo
End If

Get #1, offset, ShipType
Get #1, offset + 2, ShipIFF
Get #1, offset + 4, ShipFollowShip
Get #1, offset + 6, ShipOrders
Get #1, offset + 10, ShipXcoordByte1
Get #1, offset + 11, ShipXcoordByte2
Get #1, offset + 12, ShipXcoordByte3
Get #1, offset + 14, ShipYcoordByte1
Get #1, offset + 15, ShipYcoordByte2
Get #1, offset + 16, ShipYcoordByte3
Get #1, offset + 18, ShipZcoordByte1
Get #1, offset + 19, ShipZcoordByte2
Get #1, offset + 20, ShipZcoordByte3
Get #1, offset + 27, ShipOnWing
Get #1, offset + 28, ShipSpeed
Get #1, offset + 29, ShipSize
Get #1, offset + 32, ShipPilot
Get #1, offset + 39, ShipTarget2
Get #1, offset + 40, ShipFormation
Get #1, offset + 41, ShipTarget1

If ShipType = Chr$(255) Then
    frmShips.lstShip.ListIndex = 24
    Else: frmShips.lstShip.ListIndex = Asc(ShipType)
End If
frmShips.lblShipNo2.Caption = ShipNo
frmShips.barIFF.Value = Asc(ShipIFF)
frmShips.lblIFF2.Caption = frmShips.barIFF.Value
Select Case frmShips.barIFF.Value
    Case 0: frmShips.lblIFF3 = "(Friendly)"
    Case 1: frmShips.lblIFF3 = "(Hostile)"
    Case 2: frmShips.lblIFF3 = "(Neutral)"
End Select
If ShipFollowShip = Chr$(255) Then
    frmShips.LblFollowTarget = "No"
    Else: frmShips.LblFollowTarget = Asc(ShipFollowShip)
End If
If ShipOrders = Chr$(255) Then
    frmShips.lstOrders.ListIndex = 11
    Else: frmShips.lstOrders.ListIndex = Asc(ShipOrders)
End If
frmShips.LblTType2.Caption = "And:"
Select Case frmShips.lstOrders.ListIndex
    Case 5: frmShips.LblTType = "Ship/Nav:"
    Case 6: frmShips.LblTType = "At Nav:"
    Case 7: frmShips.LblTType = "Ship/Nav:"
    Case 8: frmShips.LblTType = "Ship/Nav:"
    Case 9: frmShips.LblTType = "Ship/Nav:"
    Case 10: frmShips.LblTType = "Ship/Nav:"
    Case 11: frmShips.LblTType = "No target Required:"
    Case Else: frmShips.LblTType = "Ship(s):" 'For 0,1,2,3,4
End Select

ShipXcoord1 = Asc(ShipXcoordByte1)
ShipXcoord2 = Asc(ShipXcoordByte2)
ShipXcoord3 = Asc(ShipXcoordByte3)
ShipYcoord1 = Asc(ShipYcoordByte1)
ShipYcoord2 = Asc(ShipYcoordByte2)
ShipYcoord3 = Asc(ShipYcoordByte3)
ShipZcoord1 = Asc(ShipZcoordByte1)
ShipZcoord2 = Asc(ShipZcoordByte2)
ShipZcoord3 = Asc(ShipZcoordByte3)
LX = 1
LY = 1
LZ = 1

If ShipXcoord3 > 150 Then
    LX = -1
    ShipXcoord3 = 255 - ShipXcoord3
    ShipXcoord2 = 255 - ShipXcoord2
    ShipXcoord1 = 256 - ShipXcoord1
End If
Xcoord = LX * (ShipXcoord1 + (ShipXcoord2 * 256) + (ShipXcoord3 * 65536))
frmShips.BarXcoord.Value = Xcoord
frmShips.LblXcoord2.Caption = frmShips.BarXcoord.Value

If ShipYcoord3 > 150 Then
    LY = -1
    ShipYcoord3 = 255 - ShipYcoord3
    ShipYcoord2 = 255 - ShipYcoord2
    ShipYcoord1 = 256 - ShipYcoord1
End If
Ycoord = LY * (ShipYcoord1 + (ShipYcoord2 * 256) + (ShipYcoord3 * 65536))
frmShips.BarYcoord.Value = Ycoord
frmShips.LblYcoord2.Caption = frmShips.BarYcoord.Value

If ShipZcoord3 > 150 Then
    LZ = -1
    ShipZcoord3 = 255 - ShipZcoord3
    ShipZcoord2 = 255 - ShipZcoord2
    ShipZcoord1 = 256 - ShipZcoord1
End If
Zcoord = LZ * (ShipZcoord1 + (ShipZcoord2 * 256) + (ShipZcoord3 * 65536))
frmShips.BarZcoord.Value = Zcoord
frmShips.LblZcoord2.Caption = frmShips.BarZcoord.Value

frmShips.barOnWing.Value = Asc(ShipOnWing)
frmShips.LblOnWing2 = frmShips.barOnWing.Value
frmShips.barSpeed.Value = Asc(ShipSpeed)
frmShips.lblSpeed2.Caption = frmShips.barSpeed.Value * 10
frmShips.barSize.Value = Asc(ShipSize)
frmShips.lblSize2.Caption = frmShips.barSize.Value
If ShipType = Chr$(22) Or ShipType = Chr$(23) Then
    frmShips.barSize.Enabled = True
    Else
    frmShips.barSize.Enabled = False
    frmShips.barSize.Value = 0
    ShipChangeSize
End If
frmShips.lstPilot.ListIndex = Asc(ShipPilot)
frmShips.LblTarget2 = Asc(ShipTarget2)
If Asc(ShipTarget2) < 32 Then
    frmShips.barTarget2.Value = Asc(ShipTarget2)
    Else: frmShips.barTarget2.Value = 32
End If
frmShips.BarFormation.Value = Asc(ShipFormation)
frmShips.lblFormation2.Caption = frmShips.BarFormation.Value
frmShips.LblTarget1 = Asc(ShipTarget1)
If Asc(ShipTarget1) < 32 Then
    frmShips.barTarget1.Value = Asc(ShipTarget1)
    Else: frmShips.barTarget1.Value = 32
End If
End Sub
Sub ShipChangeShip()
If frmShips.lstShip.ListIndex = 24 Then
    ShipType = Chr$(255)
    Else: ShipType = Chr$(frmShips.lstShip.ListIndex)
End If
Put #1, offset, ShipType
If ShipType = Chr$(255) Then
    Put #1, offset + 1, ShipType
    Else: Put #1, offset + 1, Chr$(0)
End If
If ShipType = Chr$(22) Or ShipType = Chr$(23) Then
    frmShips.barSize.Enabled = True
    Else
    frmShips.barSize.Enabled = False
    frmShips.barSize.Value = 0
    ShipChangeSize
End If
End Sub
Sub ShipChangeIFF()
frmShips.lblIFF2.Caption = frmShips.barIFF.Value
Select Case frmShips.barIFF.Value
    Case 0: frmShips.lblIFF3 = "(Friendly)"
    Case 1: frmShips.lblIFF3 = "(Hostile)"
    Case 2: frmShips.lblIFF3 = "(Neutral)"
End Select
ShipIFF = Chr$(frmShips.barIFF.Value)
Put #1, offset + 2, ShipIFF
End Sub
Sub ShipChangeFollowShip()
If ShipFollowShip = Chr$(255) Then
    frmShips.LblFollowTarget = "No"
    Else: frmShips.LblFollowTarget = Asc(ShipFollowShip)
End If
If ShipOrders = Chr$(4) Or ShipOrders = Chr$(3) Then
    ShipFollowShip = ShipTarget1
    Else: ShipFollowShip = Chr$(255)
End If
Put #1, offset + 4, ShipFollowShip
End Sub
Sub ShipChangeOrders()
If frmShips.lstOrders.ListIndex = 11 Then
    ShipOrders = Chr$(255)
    Else: ShipOrders = Chr$(frmShips.lstOrders.ListIndex)
End If
Put #1, offset + 6, ShipOrders
If ShipOrders = Chr$(255) Then
    Put #1, offset + 7, ShipOrders
    Else: Put #1, offset + 7, Chr$(0)
End If
ShipChangeFollowShip
End Sub
Sub ShipChangeXcoord()
LX = 1
frmShips.LblXcoord2.Caption = frmShips.BarXcoord.Value
Coord = frmShips.LblXcoord2.Caption
Select Case Len(Coord)
    Case 0: ShipXcoord1 = Chr$(frmShips.BarXcoord.Value)
        ShipXcoord2 = Chr$(0)
        ShipXcoord3 = Chr$(0)
    Case 1: ShipXcoord1 = Chr$(frmShips.BarXcoord.Value)
        ShipXcoord2 = Chr$(0)
        ShipXcoord3 = Chr$(0)
    Case 2: ShipXcoord1 = Chr$(frmShips.BarXcoord.Value)
        ShipXcoord2 = Chr$(0)
        ShipXcoord3 = Chr$(0)
    Case 3: Byte1 = Right$(Coord, 2)
        Byte2 = Left$(Coord, 1)
        ShipXcoord1 = Val("&H" + Byte1)
        ShipXcoord2 = Val("&H" + Byte2)
        ShipXcoord3 = Chr$(0)
    Case 4: Byte1 = Right$(Coord, 2)
        Byte2 = Left$(Coord, 2)
        ShipXcoord1 = Val("&H" + Byte1)
        ShipXcoord2 = Val("&H" + Byte2)
        ShipXcoord3 = Chr$(0)
    Case 5: Byte1 = Right$(Coord, 2)
        Byte2 = Mid$(Coord, 2, 2)
        Byte3 = Left$(Coord, 1)
        ShipXcoord1 = Val("&H" + Byte1)
        ShipXcoord2 = Val("&H" + Byte2)
        ShipXcoord3 = Val("&H" + Byte3)
    Case 8: Byte1 = Right$(Coord, 2)
        Byte2 = Mid$(Coord, 5, 2)
        Byte3 = Mid$(Coord, 3, 2)
        ShipXcoord1 = Val("&H" + Byte1)
        ShipXcoord2 = Val("&H" + Byte2)
        ShipXcoord3 = Val("&H" + Byte3)
End Select
'Now I have to put the ShipXcoords back into the file.
'Afterwards, cut and past for Y and Z

End Sub
Sub ShipChangeYcoord()
LY = 1
frmShips.LblYcoord2.Caption = frmShips.BarYcoord.Value

    
End Sub
Sub ShipChangeZcoord()
LZ = 1
frmShips.LblZcoord2.Caption = frmShips.BarZcoord.Value
End Sub
Sub ShipChangeOnWing()
frmShips.LblOnWing2 = frmShips.barOnWing.Value
ShipOnWing = Chr$(frmShips.barOnWing.Value)
Put #1, offset + 27, ShipOnWing
End Sub
Sub ShipChangeSpeed()
frmShips.lblSpeed2.Caption = frmShips.barSpeed.Value * 10
ShipSpeed = Chr$(frmShips.barSpeed.Value)
Put #1, offset + 28, ShipSpeed
End Sub
Sub ShipChangeSize()
frmShips.lblSize2.Caption = frmShips.barSize.Value
ShipSize = Chr$(frmShips.barSize.Value)
Put #1, offset + 29, ShipSize
End Sub
Sub ShipChangePilot()
ShipPilot = Chr$(frmShips.lstPilot.ListIndex)
Put #1, offset + 32, ShipPilot
End Sub
Sub ShipChangeTarget2()
ShipTarget2 = Chr$(frmShips.barTarget2.Value)
If ShipTarget2 = Chr$(32) Then ShipTarget2 = Chr$(255)
frmShips.LblTarget2 = Asc(ShipTarget2)
Put #1, offset + 39, ShipTarget2
End Sub
Sub ShipChangeFormation()
ShipFormation = Chr$(frmShips.BarFormation.Value)
frmShips.lblFormation2 = Asc(ShipFormation)
Put #1, offset + 40, ShipFormation
End Sub
Sub ShipChangeTarget1()
ShipTarget1 = Chr$(frmShips.barTarget1.Value)
If ShipTarget1 = Chr$(32) Then ShipTarget1 = Chr$(255)
frmShips.LblTarget1 = Asc(ShipTarget1)
Put #1, offset + 41, ShipTarget1
ShipChangeFollowShip
End Sub
