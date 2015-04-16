; PROJECT : WCE Restructured
; AUTHOR  : Michael Gillman
; CREATED : 29/06/2009
; EDITED  : 20/10/2010
; ---------------------------------------------------------------------
OpenScreen 1000,700,256,1
TitleScreen "Wing Commander I Mission editor v0.1 (View only)"
;loadimages
loadimage"interface.bmp",2
loadimage"hornet.bmp",3
loadimage"rapier.bmp",4
loadimage"scimitar.bmp",5
loadimage"raptor.bmp",6
loadimage"venture.bmp",7
loadimage"dilligent.bmp",8
loadimage"drayman.bmp",9
loadimage"exeter.bmp",10
loadimage"bengal.bmp",11
loadimage"salthi.bmp",12
loadimage"dralthi.bmp",13
loadimage"krant.bmp",14
loadimage"gratha.bmp",15
loadimage"jalthi.bmp",16
loadimage"hhriss.bmp",17
loadimage"dorkir.bmp",18
loadimage"lumbari.bmp",19
loadimage"ralari.bmp",20
loadimage"fralthi.bmp",21
loadimage"snakeir.bmp",22
loadimage"sivar.bmp",23
loadimage"starpost.bmp",24
loadimage"ships.bmp",25
loadimage"navmap1.bmp",26
loadimage"navpoint.bmp",27
loadimage"navTigersclaw.bmp",28
loadimage"hiddennav.bmp",29
loadimage"cross.bmp",30
loadimage"greencircle.bmp",31
loadimage"redcircle.bmp",32
loadimage"navinfo.bmp",33
DrawImage 2,0,0,0

	;initialise
Mouse on
Cls 0
SetCursorY 0
Dim navnum(10)
Dim z As Integer
Dim mapoffset As Integer
Dim mapmission As Integer
Dim mapx As Integer
Dim mapy As Integer
Dim editor As Integer
Dim control As Integer
Dim missionship As Integer
Dim mission As Integer
Dim navamount As Integer
Dim navchr As Integer
Dim missship(255)
Dim missshipname$(32)
Dim shipinkr(32)
Dim shipinkg(32)
Dim shipinkb(32)
Dim shiptype$(255)
Dim side$(3)
Dim pilotname$(17)
Dim pritarget(30)
Dim sectarget(30)
Dim orders$(255)
Dim mission$(255)
Dim system$(13)
Dim selectedship As Integer
Dim redraw As Integer
Dim debris(10)

;;;;;;ship data;;;;;;;
Dim shipx(40);;;ship x coord
Dim shipxa(40)
Dim shipxb(40)
Dim shipy(40);;;ship y coord
Dim shipya(40)
Dim shipyb(40)
Dim shipz(40);;;ship z coord
Dim shipza(40)
Dim shipzb(40)
Dim shipname(255);;;ship type
Dim allegience(40);;;ship iff
Dim pilot(40);;;pilot
Dim speed(40);;;ship speed
Dim cursx As Integer
Dim cursy As Integer

;;;;;;NAV Data;;;;;;;
Dim navxa(10)
Dim navxb(10)
Dim navxtotal(10)
Dim dispnavx(10)
;Dim xc(10)
Dim navya(10)
Dim navyb(10)
Dim navytotal(10)
Dim dispnavy(10)
;	Dim yc(10)
Dim navza(10)
Dim navzb(10)
Dim navztotal(10)
Dim dispnavz(10)
	;Dim zc(10)
Dim navname$(10)
dim navtype(10)
dim navinf as integer
Dim system As Integer
Dim coords As Integer
Dim mx As Integer
Dim my As Integer
Dim mz As Integer
Dim xz As Integer
Dim yz As Integer
Dim zz As Integer
Dim lx As Integer
Dim ly As Integer
Dim zy As Integer
Dim xt As Integer
Dim yt As Integer
Dim zt As Integer
Dim ytext As Integer
Dim ytextoff As Integer
Dim offset As Integer
Dim shipnum As Integer
Dim n As Integer
Dim m As Integer
Dim t As Integer
Dim na As Integer
Dim ma As Integer
Dim oa As Integer
Dim missionfile As String
Dim shipoffset As Integer
Dim currentship As Integer
Dim totaloffset As Integer
Dim currentname As Integer 
Dim vduship As Integer
Dim currentnav As Integer
;nav variables
Dim navxa As Integer
Dim navxb As Integer
Dim navxtotal As Integer
Dim navya As Integer
Dim navyb As Integer
Dim navytotal As Integer
Dim navza As Integer
Dim navzb As Integer
Dim navztotal As Integer
Dim dispnavx As Integer
Dim dispnavy As Integer
Dim dispnavz As Integer
dim labelnav as integer
dim navtype$(5)
dim manipulation$(255)
dim loadship as integer
dim callship(10)
;populate arrays
for n=32 to 255
	shipname(n)=255
next n
manipulation$(0)="Turns off Nav "
manipulation$(1)="Turns on Nav "
manipulation$(255)="Does nothing to Nav "
navtype$(0)="Manipulated"
navtype$(1)="Dominant"
navtype$(2)="Follow up"
navtype$(3)="Follow up"
navtype$(4)="Follow up"
navtype$(5)="Follow up"
ytextoff = 14
ytext=100
shiptype$(0)="Hornet"
shiptype$(1)="Rapier"
shiptype$(2)="Scimitar"
shiptype$(3)="Raptor"
shiptype$(4)="Venture"
shiptype$(5)="Dilligent"
shiptype$(6)="Drayman"
shiptype$(7)="Exeter"
shiptype$(8)="Tiger's Claw"
shiptype$(9)="Salthi"
shiptype$(10)="Dralthi"
shiptype$(11)="Krant"
shiptype$(12)="Gratha"
shiptype$(13)="Jalthi"
shiptype$(14)="Hhriss"
shiptype$(15)="Dorkir"
shiptype$(16)="Lumbari"
shiptype$(17)="Ralari"
shiptype$(18)="Fralthi"
shiptype$(19)="Snakeir"
shiptype$(20)="Sivar"
shiptype$(21)="Starpost"
shiptype$(22)="Asteroids"
shiptype$(23)="Mines"
shiptype$(24)="--NONE--"
shiptype$(255)="--NONE--"
side$(0)="Confed"
side$(1)="Kilrathi"
side$(2)="IFF 2"
pilotname$(0) ="Generic Pilot"
pilotname$(1) ="Generic Pilot"
pilotname$(2) ="Generic Pilot"
pilotname$(3) ="Generic Pilot"
pilotname$(4) ="Generic Pilot"
pilotname$(5) ="Spirit"
pilotname$(6) ="Hunter"
pilotname$(7) ="Bossman"
pilotname$(8) ="Iceman"
pilotname$(9) ="Angel"
pilotname$(10) ="Paladin"
pilotname$(11) ="Maniac"
pilotname$(12) ="Knight"
pilotname$(13) ="Blair (YOU)"
pilotname$(14) ="Bhurak Starkiller"
pilotname$(15) ="Dakhath Ddeathstroke"
pilotname$(16) ="Khajja The Fang"
pilotname$(17) ="Bakhtosh Redclaw"
mission$(1)="Enyo 1"
mission$(2)="Enyo 2"
mission$(3)="Space for Enyo 3"
mission$(4)="Space for Enyo 4"
mission$(5)="McAuliffe 1"
mission$(6)="McAuliffe 2"
mission$(7)="McAuliffe 3"
mission$(8)="Space for McAuliffe 4"
system$(0)="Enyo"
system$(1)="McAuliffe"
system$(2)="Gateway"
system$(3)="Gimle"
system$(4)="Brimstone"
system$(5)="Cheng-Du"
system$(6)="Dakota"
system$(7)="Port Hedland"
system$(8)="Kurasawa"
system$(9)="Rostov"
system$(10)="Hubble's Star"
system$(11)="Venice"
system$(12)="Hell's Kitchen"
orders$(0) ="Will Attack"
orders$(2) ="Will Attack"
orders$(4) ="Will follow leader"
orders$(6) ="Will jump out at NAV"
orders$(7) ="Will jump in AT NAV"
orders$(1) ="Is inactive"
offset=151324
mapoffset=6492
mapmission=0
currentnav=0
shipoffset=42
currentship=0
mission=0
system=0
missionship=1
coords=0
vduship=8
editor=1
mapx=150
mapy=150
selectedship=0
redraw=0
;	gosub shipcoords ;;;;populate shipcoordinates for first mission
totaloffset = (currentship*shipoffset)+offset
	;preparing to open file
mission=GetFreeFile()
missionfile$="Module.000"	
mission=0
navinf=0
	
	
Inc a
Print "Wing Commander mission editor v1 (display only)"
Print "Loading '" + missionfile$ + "'"
		;cd "C:\pbasic\wce"
Print CurrentDrive$()
If FileExist (missionfile$)
	Print "File exists - Loading"
		//module1bank= newbank(237,568)
	ReadFile missionfile$,1
Else
	Print "File not found"
EndIf

;;;;;;;;;;;;;;;;;;;;
;;;;;main loop;;;;;;
;;;;;;;;;;;;;;;;;;;;	

	;;map editor
	;;offset is 6492;mission offset is 1232
	;;each mission steps by 77 bytes
	;;navs are offset +32,36,40
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;NEW CODE;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Newcode:
Do
	If editor=1 Then Gosub ships
 	If editor=2 Then Gosub navpoints
	If editor=3 Then Gosub map
	If screencoords=1 Then Gosub screencoord
	;; navamount=5
	dim cursx as integer: dim cursy as integer
	setcursorx 20: setcursory 500: print mousex() :setcursorx 100:setcursory 500:print mousey()
	SetCursorX 20:SetCursorY 520: Print navname$(0):SetCursorX 150:SetCursorY 520: Print dispnavx(0):SetCursorX 250:SetCursorY 520: Print dispnavz(0)
	SetCursorX 20:SetCursorY 540: Print navname$(1):SetCursorX 150:setcursory 540: print dispnavx(1):setcursorx 250:setcursory 540: print dispnavz(1):setcursorx 350:setcursory 540: print navxb(1):setcursorx 400:setcursory 540: print navzb(1) :setcursorx 450:setcursory 540: print navxa(1):setcursorx 550:setcursory 540: print navza(1):setcursorx 600:setcursory 540: print navtype(1)
	setcursorx 20:setcursory 560: print navname$(2):setcursorx 150:setcursory 560: print dispnavx(2):setcursorx 250:setcursory 560: print dispnavz(2):setcursorx 350:setcursory 560: print navxb(2):setcursorx 400:setcursory 560: print navzb(2):setcursorx 450:setcursory 560: print navxa(2):setcursorx 550:setcursory 560: print navza(2):setcursorx 600:setcursory 560: print navtype(2)
	setcursorx 20:setcursory 580: print navname$(3):setcursorx 150:setcursory 580: print dispnavx(3):setcursorx 250:setcursory 580: print dispnavz(3):setcursorx 350:setcursory 580: print navxb(3):setcursorx 400:setcursory 580: print navzb(3):setcursorx 450:setcursory 580: print navxa(3):setcursorx 550:setcursory 580: print navza(3):setcursorx 600:setcursory 580: print navtype(3)
	setcursorx 20:setcursory 600: print navname$(4):setcursorx 150:setcursory 600: print dispnavx(4):setcursorx 250:setcursory 600: print dispnavz(4):setcursorx 350:setcursory 600: print navxb(4):setcursorx 400:setcursory 600: print navzb(4):setcursorx 450:setcursory 600: print navxa(4):setcursorx 550:setcursory 600: print navza(4):setcursorx 600:setcursory 600: print navtype(4)
	setcursorx 20:setcursory 620: print navname$(5):setcursorx 150:setcursory 620: print dispnavx(5):setcursorx 250:setcursory 620: print dispnavz(5):setcursorx 350:setcursory 620: print navxb(5):setcursorx 400:setcursory 620: print navzb(5):setcursorx 450:setcursory 620: print navxa(5):setcursorx 550:setcursory 620: print navza(5):setcursorx 600:setcursory 620: print navtype(5)
	;  setcursorx 20:setcursory 600: print (mapoffset+(system*4928)+(mission*1232))
	;  setcursorx 20:setcursory 620: print system
	;  setcursorx 20:setcursory 640: print mission
	;  setcursorx 20:setcursory 660: print navamount
 	If (MouseButton()=1)
		Gosub mouseclicked
   	repeat
      	flushkeys
 		until mousebutton()=0
	;   inc control
	endif
;endif
	sync
loop	

ships:
;;;eventually these sections will need to be referenced only after a screen ;;;;;;;;
;;;update is needed;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if redraw=0
cls 0
drawimage 2,0,0,0
DrawImage 25,19,78,0
If (shipname(selectedship)+3)<22 Then	DrawImage (shipname(selectedship)+3),466,133,0
SetCursorX 780: SetCursorY 24:Print system$(system)
SetCursorX 780: SetCursorY 57:Print mission+1
Gosub shipdata
SetCursorX 280:SetCursorY 340: Print shipx(selectedship)
SetCursorX 396:SetCursorY 340: Print shipy(selectedship)
SetCursorX 514:SetCursorY 340: Print shipz(selectedship)
SetCursorY 123:SetCursorX 253: Print shiptype$(shipname(selectedship))
setCursorY 278:SetCursorX 253: Print side$(allegience(selectedship))
setCursorY 154:SetCursorX 253: Print pilotname$(pilot(selectedship))
SetCursorY 248:SetCursorX 253: Print (speed(selectedship)*10)
;   SetCursorY 310:SetCursorX 253: Print orders$(<variable>(selectedship)):SetCursorY (ytext+(ytextoff*11)-2):SetCursorX 550:Print(ReadByteAt(1,totaloffset+6))
;	SetCursorY 310:SetCursorX 410: Print ReadByteAt(1,(totaloffset+41))+1	  
;  redraw=1
Return

shipdata:
For n=0 To 32
	;   setcursorx 20:setcursory 480:print((offset)+((system+mission)+(shipoffset*n))):waitkey:flushkeys:wait 10:sync
	shipxa(n)=ReadWordAt(1,(offset+10)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	shipxb(n)=ReadbyteAt(1,(offset+12)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	shipya(n)=ReadWordAt(1,(offset+14)+(((system*5376)+(mission*1344))+(shipoffset*n)))
   shipyb(n)=ReadbyteAt(1,(offset+16)+(((system*5376)+(mission*1344))+(shipoffset*n)))
   shipza(n)=ReadWordAt(1,(offset+18)+(((system*5376)+(mission*1344))+(shipoffset*n)))
   shipzb(n)=ReadbyteAt(1,(offset+20)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	;   shipx(n)=
	;   shipy(n)=
	;   shipz(n)=
   if shipxb(n)<5
      shipx(n)=((shipxb(n)*65536)+shipxa(n));might need to change to 65536
   else
      shipx(n)=(((shipxb(n)-256)*65536)+shipxa(n))
   endif
	;  
   if shipyb(n)<5
      shipy(n)=((shipyb(n)*65536)+shipya(n));might need to change to 65536
   else
      shipy(n)=(((shipyb(n)-256)*65536)+shipya(n))
   endif 
	;	
	;	  if shipyb(n)<5
	;   	 shipy(n)=neg((shipya(n)-neg((shipyb(n)*65536))));might need to change to 65536
	;   else
	;      shipy(n)=neg((((shipyb(n)-256)*65536)+shipya(n)));;;;this works
	;   endif
   
	if shipzb(n)<5
   	shipz(n)=neg((shipza(n)-neg((shipzb(n)*65536))));might need to change to 65536
   else
      shipz(n)=neg((((shipzb(n)-256)*65536)+shipza(n)));;;;this works
   endif
   shipname(n)=ReadByteAt(1,(offset)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	allegience(n)=readbyteat(1,(offset+2)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	pilot(n)=readbyteat(1,(offset+32)+(((system*5376)+(mission*1344))+(shipoffset*n)))
	speed(n)=readbyteat(1,(offset+28)+(((system*5376)+(mission*1344))+(shipoffset*n)))
next n
gosub missionpopulate
return

navpoints:
return

map:
cls 0
drawimage 2,0,0,0
SetCursorX 780: SetCursorY 24:Print system$(system)
SetCursorX 780: SetCursorY 57:Print mission+1
;mapx=185
;mapy=230
mapx=175-(((dispnavx(1)+dispnavx(2)+dispnavx(3)+dispnavx(4)+dispnavx(5))/350)/navamount)
mapy=230-(((dispnavz(1)+dispnavz(2)+dispnavz(3)+dispnavz(4)+dispnavz(5))/350)/navamount)
DrawImage 26,30,90,0
for n=0 to navamount-1
   if navname$(n)="Tiger's Claw"
   	DrawImage 28,((dispnavx(n)/350)+mapx),((dispnavz(n)/350)+mapy),0
   else
   	if navtype(n)=0
      	drawImage 29,((dispnavx(n)/350)+mapx),((dispnavz(n)/350)+mapy),0
      endif
      if navtype(n)=1
      	DrawImage 27,((dispnavx(n)/350)+mapx),((dispnavz(n)/350)+mapy),0
      endif
      if navtype(n)>1
      	DrawImage 30,((dispnavx(n)/350)+mapx),((dispnavz(n)/350)+mapy),0
      endif
   endif
   SetCursorX ((dispnavx(n)/350)+(mapx+12)) :SetCursorY ((dispnavz(n)/350)+(mapy-2)):Print navname$(n)
next n
debris=0
;for n=0 to 40
;	if shipname(n)=22
;		inc debris
;		ellipse ((shipx(n)/350)+mapx),((shipz(n)/350)+mapy),10,10,0
;		cursy=620+(debris*20)
;   	if debris = 1
;			setcursorx 20:setcursory 640: print shipx(n):setcursorx 70:setcursory 640: print shipz(n)
;		endif
;		if debris = 2
;			setcursorx 20:setcursory 660: print shipx(n):setcursorx 70:setcursory 660: print shipz(n)
;		endif
;		if debris = 3
;			setcursorx 20:setcursory 680: print shipx(n):setcursorx 70:setcursory 680: print shipz(n)
;		endif
;		if debris = 4
;			setcursorx 20:setcursory 700: print shipx(n):setcursorx 70:setcursory 700: print shipz(n)
;		endif
;		if debris = 5
;		setcursorx 20:setcursory 720: print shipx(n):setcursorx 70:setcursory 720: shipz(n)
;		endif		
;	endif
;next n
drawimage 33,432,80,0
gosub missionpopulate
Gosub readnavdata
return

screencoord:
return

missionpopulate:
totaloffset = (currentship*shipoffset)+offset;;;;probably don't need this
For n = 0 To 32
   if allegience(n)=0 then:shipinkr(n)=10:shipinkg(n)=100:shipinkb(n)=255
   if shipname(n)=255 then:shipinkr(n)=255:shipinkg(n)=255:shipinkb(n)=255
   if allegience(n)=1 then:shipinkr(n)=255:shipinkg(n)=0:shipinkb(n)=0
   if allegience(n)=2 then:shipinkr(n)=140:shipinkg(n)=140:shipinkb(n)=140
   If allegience(n)=255 Then:shipinkr(n)=255:shipinkg(n)=255:shipinkb(n)=255
Next n

SetCursorX 720:SetCursorY 102:Ink RGB(shipinkr(0),shipinkg(0),shipinkb(0)):Print shiptype$(shipname(0))
SetCursorX 720:SetCursorY 134:Ink RGB(shipinkr(1),shipinkg(1),shipinkb(1)):Print shiptype$(shipname(1))
SetCursorX 720:SetCursorY 166:Ink RGB(shipinkr(2),shipinkg(2),shipinkb(2)):Print shiptype$(shipname(2))
SetCursorX 720:SetCursorY 198:Ink RGB(shipinkr(3),shipinkg(3),shipinkb(3)):Print shiptype$(shipname(3))
SetCursorX 720:SetCursorY 230:Ink RGB(shipinkr(4),shipinkg(4),shipinkb(4)):Print shiptype$(shipname(4))
SetCursorX 720:SetCursorY 262:Ink RGB(shipinkr(5),shipinkg(5),shipinkb(5)):Print shiptype$(shipname(5))
SetCursorX 720:SetCursorY 294:Ink RGB(shipinkr(6),shipinkg(6),shipinkb(6)):Print shiptype$(shipname(6))
SetCursorX 720:SetCursorY 326:Ink RGB(shipinkr(7),shipinkg(7),shipinkb(7)):Print shiptype$(shipname(7))
SetCursorX 720:SetCursorY 358:Ink RGB(shipinkr(8),shipinkg(8),shipinkb(8)):Print shiptype$(shipname(8))
SetCursorX 720:SetCursorY 390:Ink RGB(shipinkr(9),shipinkg(9),shipinkb(9)):Print shiptype$(shipname(9))
SetCursorX 720:SetCursorY 422:Ink RGB(shipinkr(10),shipinkg(10),shipinkb(10)):Print shiptype$(shipname(10))
SetCursorX 720:SetCursorY 454:Ink RGB(shipinkr(11),shipinkg(11),shipinkb(11)):Print shiptype$(shipname(11))
SetCursorX 720:SetCursorY 486:Ink RGB(shipinkr(12),shipinkg(12),shipinkb(12)):Print shiptype$(shipname(12))
SetCursorX 720:SetCursorY 518:Ink RGB(shipinkr(13),shipinkg(13),shipinkb(13)):Print shiptype$(shipname(13))
SetCursorX 720:SetCursorY 550:Ink RGB(shipinkr(14),shipinkg(14),shipinkb(14)):Print shiptype$(shipname(14))
SetCursorX 720:SetCursorY 582:Ink RGB(shipinkr(15),shipinkg(15),shipinkb(15)):Print shiptype$(shipname(15))
SetCursorX 868:SetCursorY 102:Ink RGB(shipinkr(16),shipinkg(16),shipinkb(16)):Print shiptype$(shipname(16))
SetCursorX 868:SetCursorY 134:Ink RGB(shipinkr(17),shipinkg(17),shipinkb(17)):Print shiptype$(shipname(17))
SetCursorX 868:SetCursorY 166:Ink RGB(shipinkr(18),shipinkg(18),shipinkb(18)):Print shiptype$(shipname(18))
SetCursorX 868:SetCursorY 198:Ink RGB(shipinkr(19),shipinkg(19),shipinkb(19)):Print shiptype$(shipname(19))
SetCursorX 868:SetCursorY 230:Ink RGB(shipinkr(20),shipinkg(20),shipinkb(20)):Print shiptype$(shipname(20))
SetCursorX 868:SetCursorY 262:Ink RGB(shipinkr(21),shipinkg(21),shipinkb(21)):Print shiptype$(shipname(21))
SetCursorX 868:SetCursorY 294:Ink RGB(shipinkr(22),shipinkg(22),shipinkb(22)):Print shiptype$(shipname(22))
SetCursorX 868:SetCursorY 326:Ink RGB(shipinkr(23),shipinkg(23),shipinkb(23)):Print shiptype$(shipname(23))
SetCursorX 868:SetCursorY 358:Ink RGB(shipinkr(24),shipinkg(24),shipinkb(24)):Print shiptype$(shipname(24))
SetCursorX 868:SetCursorY 390:Ink RGB(shipinkr(25),shipinkg(25),shipinkb(25)):Print shiptype$(shipname(25))
SetCursorX 868:SetCursorY 422:Ink RGB(shipinkr(26),shipinkg(26),shipinkb(26)):Print shiptype$(shipname(26))
SetCursorX 868:SetCursorY 454:Ink RGB(shipinkr(27),shipinkg(27),shipinkb(27)):Print shiptype$(shipname(27))
SetCursorX 868:SetCursorY 486:Ink RGB(shipinkr(28),shipinkg(28),shipinkb(28)):Print shiptype$(shipname(28))
SetCursorX 868:SetCursorY 518:Ink RGB(shipinkr(29),shipinkg(29),shipinkb(29)):Print shiptype$(shipname(29))
SetCursorX 868:SetCursorY 550:Ink RGB(shipinkr(30),shipinkg(30),shipinkb(30)):Print shiptype$(shipname(30))
SetCursorX 868:SetCursorY 582:Ink RGB(shipinkr(31),shipinkg(31),shipinkb(31)):Print shiptype$(shipname(31))
Ink RGB(255,255,255)
redraw=1
Return	

mouseclicked:
;change system   
If (MouseX() >908) And (MouseX()<938) And (MouseY() >17) And (MouseY() <42) And (MouseButton()=1)
	Inc system:navinf=0
	if system>12 then system=12
   	Gosub shipdata
      gosub readnavdata
   EndIf   	
   If (MouseX()) >730 And (MouseX()<761) And (MouseY() >17) And (MouseY() <42) And (MouseButton() =1)
   	Dec system:navinf=0
   	if system<0 then system=0
   	Gosub shipdata 
   	gosub readnavdata
   EndIf  
   ;change mission
   If (MouseX() >908) And (MouseX()<938) And (MouseY() >50) And (MouseY() <74) And (MouseButton()=1)
      Inc mission:navinf=0
      if mission>3 then mission=3
      Gosub shipdata
      gosub readnavdata  	 
   EndIf   	
   If (MouseX() >730) And (MouseX()<761) And (MouseY() >50) And (MouseY() <74) And (MouseButton() =1)
      Dec mission:navinf=0
      if mission<0 then mission=0 
      Gosub shipdata 
      gosub readnavdata
   EndIf  
   If (MouseX() >686) And (MouseX()<827)
   	If (MouseY() >94) And (MouseY() <119) And (MouseButton() =1):selectedship=0 : EndIf
      If (MouseY() >(94+(32*1))) And (MouseY() <(119+(32*1))) And (MouseButton() =1):selectedship=1 : EndIf
      If (MouseY() >(94+(32*2))) And (MouseY() <(119+(32*2))) And (MouseButton() =1):selectedship=2 : EndIf
      If (MouseY() >(94+(32*3))) And (MouseY() <(119+(32*3))) And (MouseButton() =1):selectedship=3 : EndIf
      If (MouseY() >(94+(32*4))) And (MouseY() <(119+(32*4))) And (MouseButton() =1):selectedship=4 : EndIf
      If (MouseY() >(94+(32*5))) And (MouseY() <(119+(32*5))) And (MouseButton() =1):selectedship=5 : EndIf
      If (MouseY() >(94+(32*6))) And (MouseY() <(119+(32*6))) And (MouseButton() =1):selectedship=6 : EndIf
      If (MouseY() >(94+(32*7))) And (MouseY() <(119+(32*7))) And (MouseButton() =1):selectedship=7 : EndIf
      If (MouseY() >(94+(32*8))) And (MouseY() <(119+(32*8))) And (MouseButton() =1):selectedship=8 : EndIf
      If (MouseY() >(94+(32*9))) And (MouseY() <(119+(32*9))) And (MouseButton() =1):selectedship=9 : EndIf
      If (MouseY() >(94+(32*10))) And (MouseY() <(119+(32*10))) And (MouseButton() =1):selectedship=10 : EndIf
      If (MouseY() >(94+(32*11))) And (MouseY() <(119+(32*11))) And (MouseButton() =1):selectedship=11 : EndIf
      If (MouseY() >(94+(32*12))) And (MouseY() <(119+(32*12))) And (MouseButton() =1):selectedship=12 : EndIf
      If (MouseY() >(94+(32*13))) And (MouseY() <(119+(32*13))) And (MouseButton() =1):selectedship=13 : EndIf
      If (MouseY() >(94+(32*14))) And (MouseY() <(119+(32*14))) And (MouseButton() =1):selectedship=14 : EndIf
      If (MouseY() >(94+(32*15))) And (MouseY() <(119+(32*15))) And (MouseButton() =1):selectedship=15 : EndIf
   EndIf
   If (MouseX() >833) And (MouseX()<973)
   	If (MouseY() >94) And (MouseY() <119) And (MouseButton() =1):selectedship=16: EndIf
      If (MouseY() >(94+(32*1))) And (MouseY() <(119+(32*1))) And (MouseButton() =1):selectedship=17: EndIf
      If (MouseY() >(94+(32*2))) And (MouseY() <(119+(32*2))) And (MouseButton() =1):selectedship=18: EndIf
      If (MouseY() >(94+(32*3))) And (MouseY() <(119+(32*3))) And (MouseButton() =1):selectedship=19: EndIf
      If (MouseY() >(94+(32*4))) And (MouseY() <(119+(32*4))) And (MouseButton() =1):selectedship=20: EndIf
      If (MouseY() >(94+(32*5))) And (MouseY() <(119+(32*5))) And (MouseButton() =1):selectedship=21: EndIf
      If (MouseY() >(94+(32*6))) And (MouseY() <(119+(32*6))) And (MouseButton() =1):selectedship=22: EndIf
      If (MouseY() >(94+(32*7))) And (MouseY() <(119+(32*7))) And (MouseButton() =1):selectedship=23: EndIf
      If (MouseY() >(94+(32*8))) And (MouseY() <(119+(32*8))) And (MouseButton() =1):selectedship=24: EndIf
      If (MouseY() >(94+(32*9))) And (MouseY() <(119+(32*9))) And (MouseButton() =1):selectedship=25: EndIf
      If (MouseY() >(94+(32*10))) And (MouseY() <(119+(32*10))) And (MouseButton() =1):selectedship=26: EndIf
      If (MouseY() >(94+(32*11))) And (MouseY() <(119+(32*11))) And (MouseButton() =1):selectedship=27: EndIf
      If (MouseY() >(94+(32*12))) And (MouseY() <(119+(32*12))) And (MouseButton() =1):selectedship=28: EndIf
      If (MouseY() >(94+(32*13))) And (MouseY() <(119+(32*13))) And (MouseButton() =1):selectedship=29: EndIf
      If (MouseY() >(94+(32*14))) And (MouseY() <(119+(32*14))) And (MouseButton() =1):selectedship=30: EndIf
      If (MouseY() >(94+(32*15))) And (MouseY() <(119+(32*15))) And (MouseButton() =1):selectedship=31: EndIf

   EndIf
   If (MouseX() >686) And (MouseX()<776) And (MouseY()>607)And (MouseY()<647)And (MouseButton()=1)
   	editor=1
   EndIf
   If (MouseX() >790) And (MouseX()<873) And (MouseY()>607)And (MouseY()<647)And (MouseButton()=1)
   	editor=2
   EndIf
   If (MouseX() >887) And (MouseX()<972) And (MouseY()>607)And (MouseY()<647)And (MouseButton()=1)
   	editor=3
   EndIf
   	redraw=1
Return

Readnavdata:
gosub asteroids
;;;;;;;read amount of navs and label them and get coordinates;;;;;;;;;;;  	
navamount =0;;;counts how many navs there are
For n=0 To 10
	dim navinfoffset as integer: navinfoffset=6492
   navname$(n)="";;;is resetting the label to blank before creating the label
   navtemp=ReadByteAt(1,((mapoffset+(system*4928)+(mission*1232))+(n*77)))
	;   navnum(n)=(mapoffset+(mission*1232))+(n*77)
   If (navtemp>0) And (navtemp<255) Then Inc navamount
   navtype(n)=readbyteat(1,(mapoffset+(((system*4928)+(mission*1232))+30)+(n*77)))
   ;;;;;get base coordinates
   navxa(n)= ReadWordAt(1,(mapoffset+(((system*4928)+(mission*1232))+32)+(n*77)))     
   navxb(n)= ReadByteAt(1,(mapoffset+(((system*4928)+(mission*1232))+34)+(n*77)))
   navya(n)= ReadWordAt(1,(mapoffset+(((system*4928)+(mission*1232))+36)+(n*77)))     
   navyb(n)= ReadByteAt(1,(mapoffset+(((system*4928)+(mission*1232))+38)+(n*77)))
   navza(n)= ReadWordAt(1,(mapoffset+(((system*4928)+(mission*1232))+40)+(n*77)))     
   navzb(n)= ReadByteAt(1,(mapoffset+(((system*4928)+(mission*1232))+42)+(n*77)))
;;;;;;;put base coordinates together to create a 3 byte integer
   If navxb(n)<5
   	dispnavx(n)=((navxb(n)*65536)+navxa(n));might need to change to 65536
   Else
      dispnavx(n)=(((navxb(n)-256)*65536)+navxa(n))
   EndIf
	
	If navzb(n)<5
   	dispnavz(n)=Neg((navza(n)-Neg((navzb(n)*65536))));might need to change to 65536
   Else
      dispnavz(n)=Neg((((navzb(n)-256)*65536)+navza(n)));;;;this works
   EndIf
		

   z=0
   
   Repeat	   	   
      navtemp=ReadByteAt(1,((mapoffset+(system*4928)+(mission*1232))+((n*77)+z)))	
      navname$(n)=navname$(n)+Chr$(navtemp)
      Inc z
   Until navtemp=0
Next n
If (MouseY() >412) And (MouseY() <438)
  	If (MouseX()>438) And (MouseX()<458)And(MouseButton() =1)
     	Dec navinf
     	If navinf<0 Then navinf=0
  	EndIf
  	If (MouseX()>505) And (MouseX()<528)And(MouseButton() =1)
     	Inc navinf
     	If navinf>10 Then navinf=10
  	EndIf
EndIf
SetCursorX 500:SetCursorY 120:Print navname$(navinf)
SetCursorX 500:SetCursorY 140:Print navtype$(ReadByteAt(1,(((navinfoffset+30)+(navinf*77))+(system*4928)+(mission*1232))))
SetCursorX 500:SetCursorY 160:Print dispnavx(navinf)
SetCursorX 560:SetCursorY 160:Print dispnavy(navinf)
SetCursorX 620:SetCursorY 160:Print dispnavz(navinf)
;  setcursorx 500:setcursory 180:Print "Manipulation"
SetCursorX 500:SetCursorY 190:Print manipulation$(ReadByteAt(1,(((navinfoffset+45)+(navinf*77))+(system*4928)+(mission*1232))))+Str$(ReadByteAt(1,(((navinfoffset+46)+(navinf*77))+(system*4928)+(mission*1232))))
SetCursorX 500:SetCursorY 200:Print manipulation$(ReadByteAt(1,(((navinfoffset+47)+(navinf*77))+(system*4928)+(mission*1232))))+Str$(ReadByteAt(1,(((navinfoffset+48)+(navinf*77))+(system*4928)+(mission*1232))))
SetCursorX 500:SetCursorY 210:Print manipulation$(ReadByteAt(1,(((navinfoffset+49)+(navinf*77))+(system*4928)+(mission*1232))))+Str$(ReadByteAt(1,(((navinfoffset+50)+(navinf*77))+(system*4928)+(mission*1232))))
SetCursorX 500:SetCursorY 220:Print manipulation$(ReadByteAt(1,(((navinfoffset+51)+(navinf*77))+(system*4928)+(mission*1232))))+Str$(ReadByteAt(1,(((navinfoffset+52)+(navinf*77))+(system*4928)+(mission*1232))))
;  setcursorx 500:setcursory 240:Print "Loads"
SetCursorX 500:SetCursorY 250:Print shiptype$(ReadByteAt(1,(((navinfoffset+53)+(navinf*77))+(system*4928)+(mission*1232))))
SetCursorX 500:setcursory 260:Print shiptype$(readbyteat(1,(((navinfoffset+55)+(navinf*77))+(system*4928)+(mission*1232))))
;  setcursorx 500:setcursory 280:Print "Calls Ships"
setcursorx 500:setcursory 290:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+57)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+57)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 300:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+59)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+59)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 310:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+61)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+61)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 320:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+63)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+63)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 330:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+65)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+65)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 340:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+67)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+67)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 350:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+69)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+69)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 360:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+71)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+71)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 370:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+73)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+73)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
setcursorx 500:setcursory 380:Print shiptype$(shipname((readbyteat(1,(((navinfoffset+75)+(navinf*77))+(system*4928)+(mission*1232))))))+"("+str$((readbyteat(1,( ((navinfoffset+75)+(navinf*77)) + (system*4928)+(mission*1232) )))+1)+")"
;  setcursorx 500:setcursory 390:print shipname(255)
return
  
asteroids:
;dim debristemp(10)

;for n=0 to 10
;	inc n
	;   debristemp(n)=readbyteat(1,(((navinfoffset+(57+(n*2))+(n*77))+(system*4928)+(mission*1232)))
	;   debristempb=readbyteat(1,(((navinfoffset+55)+(n*77))+(system*4928)+(mission*1232)))
	;   if shipname(debristemp(n))=22
	;   	ellipse ((dispx(n)+shipx())/350)+mapx),dispz,10,10,0      ;((shipx(n)/350)+mapx),((shipz(n)/350)+mapy),10,10,0
	;   endif
	;   if (debristempb>21) and (debristempb<24)
	;   endif
;next n
return