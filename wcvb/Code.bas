Attribute VB_Name = "Code"
Public offset As Long
Public Missoffset As Long
Sub Closefirst()
Dim dialogtype As Integer
Dim response As Integer
Dim prompt As String
Dim title As String
dialogtype = vbOKOnly + vbExclamation
prompt = "You have to close all other windows first."
title = "That ain't gonna work"
response = MsgBox(prompt, dialogtype, title)
End Sub
Sub Finish()
Close #1
End
End Sub
Sub ModLoad()
Open "C:\Kuba\WCSTUFF\Module.000" For Binary Access Read Write As #1
SelectMission
End Sub
Sub SelectMission()
If frmMain.Visible = True Then frmMain.Enabled = False
If frmShips.Visible = True Then frmShips.Enabled = False
If frmAuto.Visible = True Then frmAuto.Enabled = False
frmSelect.Visible = True
frmSelect.SetFocus
End Sub
