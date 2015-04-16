Attribute VB_Name = "AutoCode"
Public WingOne As String * 1
Public WingTwo As String * 1
Public WingThree As String * 1
Public WingFour As String * 1
Public WingFive As String * 1
Sub WingsChange()
offset = ((Missoffset - 1) * 24) + 131
Get #1, offset, WingOne
Get #1, offset + 2, WingTwo
Get #1, offset + 4, WingThree
Get #1, offset + 6, WingFour
Get #1, offset + 8, WingFive

frmAuto.LblWingOne2.Caption = Asc(WingOne)
If WingOne = Chr$(255) Then WingOne = Chr$(32)
frmAuto.barWingOne.Value = Asc(WingOne)

frmAuto.lblWingTwo2.Caption = Asc(WingTwo)
If WingTwo = Chr$(255) Then WingTwo = Chr$(32)
frmAuto.barWingTwo.Value = Asc(WingTwo)

frmAuto.LblWingthree2.Caption = Asc(WingThree)
If WingThree = Chr$(255) Then WingThree = Chr$(32)
frmAuto.barWingThree.Value = Asc(WingThree)

frmAuto.LblWingFour2.Caption = Asc(WingFour)
If WingFour = Chr$(255) Then WingFour = Chr$(32)
frmAuto.BarWingFour.Value = Asc(WingFour)

frmAuto.LblWingFive2.Caption = Asc(WingFive)
If WingFive = Chr$(255) Then WingFive = Chr$(32)
frmAuto.BarWingFive.Value = Asc(WingFive)
End Sub
Sub WingOneChange()
WingOne = Chr$(frmAuto.barWingOne.Value)
If WingOne = Chr$(32) Then
    WingOne = Chr$(255)
    Put #1, offset + 1, Chr$(255)
    Else: Put #1, offset + 1, Chr$(0)
End If
frmAuto.LblWingOne2.Caption = Asc(WingOne)
Put #1, offset, WingOne
End Sub
Sub WingTwoChange()
WingTwo = Chr$(frmAuto.barWingTwo.Value)
If WingTwo = Chr$(32) Then
    WingTwo = Chr$(255)
    Put #1, offset + 3, Chr$(255)
    Else: Put #1, offset + 3, Chr$(0)
End If
frmAuto.lblWingTwo2.Caption = Asc(WingTwo)
Put #1, offset + 2, WingTwo
End Sub
Sub WingThreeChange()
WingThree = Chr$(frmAuto.barWingThree.Value)
If WingThree = Chr$(32) Then
    WingThree = Chr$(255)
    Put #1, offset + 5, Chr$(255)
    Else: Put #1, offset + 5, Chr$(0)
End If
frmAuto.LblWingthree2.Caption = Asc(WingThree)
Put #1, offset + 4, WingThree
End Sub
Sub WingFourChange()
WingFour = Chr$(frmAuto.BarWingFour.Value)
If WingFour = Chr$(32) Then
    WingFour = Chr$(255)
    Put #1, offset + 7, Chr$(255)
    Else: Put #1, offset + 7, Chr$(0)
End If
frmAuto.LblWingFour2.Caption = Asc(WingFour)
Put #1, offset + 6, WingFour
End Sub
Sub WingFiveChange()
WingFive = Chr$(frmAuto.BarWingFive.Value)
If WingFive = Chr$(32) Then WingFive = Chr$(255)
frmAuto.LblWingFive2.Caption = Asc(WingFive)
Put #1, offset + 8, WingFive
End Sub
