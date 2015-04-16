CLS
null$ = CHR$(255)
zero$ = CHR$(0)
small$ = CHR$(12)
med$ = CHR$(13)
large$ = CHR$(14)
p$ = CHR$(4) + CHR$(0) + CHR$(4)





REM Mission editing routine for WC1 (may or may not work with KS)

4000
CLS
PRINT "Loading..."

shipship$ = " "
shipiff$ = " "
shiporders$ = " "
shipxcoordbyte1$ = " "
shipxcoordbyte2$ = " "
shipxcoordbyte3$ = " "
shipycoordbyte1$ = " "
shipycoordbyte2$ = " "
shipycoordbyte3$ = " "
shipzcoordbyte1$ = " "
shipzcoordbyte2$ = " "
shipzcoordbyte3$ = " "
shipsize$ = " "
shipspeed$ = " "
shippilot$ = " "
shipsectarget$ = " "
shipformation$ = " "
shippritarget$ = " "
shiponwing$ = " "
shipfollowship$ = " "

dominant$ = " "
l$ = " ": mainbyte$ = " ": navxcoordbyte1$ = " ": navxcoordbyte2$ = " ": navxcoordbyte3$ = " "
navycoordbyte1$ = " ": navycoordbyte2$ = " ": navycoordbyte3$ = " "
navzcoordbyte1$ = " ": navzcoordbyte2$ = " ": navzcoordbyte3$ = " "
manip1a$ = " ": manip1b$ = " ": manip2a$ = " ": manip2b$ = " "
manip3a$ = " ": manip3b$ = " ": manip4a$ = " ": manip4b$ = " "
image1$ = " ": image2$ = " "
ship1$ = " ": ship2$ = " ": ship3$ = " ": ship4$ = " ": ship5$ = " "
ship6$ = " ": ship7$ = " ": ship8$ = " ": ship9$ = " ": ship10$ = " "



module$ = "input.000"
module2$ = "module.000"

INPUT "What's the serie number"; xsn
INPUT "What's the mission number"; ymn
mn = 4 * (xsn - 1) + ymn

OPEN module$ FOR BINARY AS #1
OPEN module2$ FOR BINARY AS #2

1 REM Main Menu
CLS
FOR shipnumber = 0 TO 15







REM ' This is the ship conversion routine
mark = 0

IF shipnumber = 0 THEN offset = ((mn - 1) * 1344) + 151325
offset = ((mn - 1) * 1344) + 151325 + 42 * shipnumber

IF shipnumber = 0 THEN offset2 = 102817
offset2 = 102817 + 60 * shipnumber



GET #1, offset, shipship$
GET #1, offset + 2, shipiff$
GET #1, offset + 4, shipfollowship$
GET #1, offset + 6, shiporders$
GET #1, offset + 10, shipxcoordbyte1$
GET #1, offset + 11, shipxcoordbyte2$
GET #1, offset + 12, shipxcoordbyte3$
GET #1, offset + 14, shipycoordbyte1$
GET #1, offset + 15, shipycoordbyte2$
GET #1, offset + 16, shipycoordbyte3$
GET #1, offset + 18, shipzcoordbyte1$
GET #1, offset + 19, shipzcoordbyte2$
GET #1, offset + 20, shipzcoordbyte3$
GET #1, offset + 27, shiponwing$
GET #1, offset + 28, shipspeed$
GET #1, offset + 29, shipsize$
GET #1, offset + 32, shippilot$
GET #1, offset + 39, shipsectarget$
GET #1, offset + 40, shipformation$
GET #1, offset + 41, shippritarget$
                        
IF shipship$ = CHR$(2) THEN shipship$ = CHR$(3): GOTO 2
IF shipship$ = CHR$(3) THEN shipship$ = CHR$(4): GOTO 2
IF shipship$ = CHR$(4) THEN shipship$ = CHR$(16): GOTO 2
IF shipship$ = CHR$(5) THEN shipship$ = CHR$(11): GOTO 2
IF shipship$ = CHR$(6) THEN shipship$ = CHR$(12): GOTO 2
IF shipship$ = CHR$(7) THEN shipship$ = CHR$(17): GOTO 2
IF shipship$ = CHR$(8) THEN shipship$ = CHR$(18): GOTO 2
IF shipship$ = CHR$(9) THEN shipship$ = CHR$(5): GOTO 2
IF shipship$ = CHR$(10) THEN shipship$ = CHR$(6): GOTO 2
IF shipship$ = CHR$(11) THEN shipship$ = CHR$(8): GOTO 2
IF shipship$ = CHR$(12) THEN shipship$ = CHR$(41): GOTO 2
IF shipship$ = CHR$(13) THEN shipship$ = CHR$(7): GOTO 2
IF shipship$ = CHR$(14) THEN shipship$ = CHR$(50): GOTO 2
IF shipship$ = CHR$(15) THEN shipship$ = CHR$(13): GOTO 2
IF shipship$ = CHR$(17) THEN shipship$ = CHR$(20): GOTO 2
IF shipship$ = CHR$(18) THEN shipship$ = CHR$(21): GOTO 2
IF shipship$ = CHR$(20) THEN shipship$ = CHR$(18): GOTO 2
IF shipship$ = CHR$(21) THEN shipship$ = CHR$(26): GOTO 2

IF shipship$ = CHR$(22) THEN shipship$ = CHR$(21): mark = 1: class$ = CHR$(5): GOTO 3
IF shipship$ = CHR$(23) THEN shipship$ = CHR$(22): mark = 1: class$ = CHR$(6): GOTO 3

2

IF shipship$ = CHR$(0) THEN class$ = CHR$(48): shipname$ = "Ferret" + CHR$(0)
IF shipship$ = CHR$(1) THEN class$ = CHR$(49): shipname$ = "Rapier" + CHR$(0)
IF shipship$ = CHR$(2) THEN class$ = CHR$(51): shipname$ = "Broadsword" + CHR$(0)
IF shipship$ = CHR$(3) THEN class$ = CHR$(48): shipname$ = "Epee" + CHR$(0)
IF shipship$ = CHR$(4) THEN class$ = CHR$(50): shipname$ = "Sabre" + CHR$(0)
IF shipship$ = CHR$(5) THEN class$ = CHR$(48): shipname$ = "Sartha" + CHR$(0)
IF shipship$ = CHR$(6) THEN class$ = CHR$(49): shipname$ = "Drakhri" + CHR$(0)
IF shipship$ = CHR$(7) THEN class$ = CHR$(50): shipname$ = "Jalkehi" + CHR$(0)
IF shipship$ = CHR$(8) THEN class$ = CHR$(50): shipname$ = "Grikath" + CHR$(0)
IF shipship$ = CHR$(9) THEN class$ = CHR$(49): shipname$ = "Strakha" + CHR$(0)
IF shipship$ = CHR$(10) THEN class$ = CHR$(49): shipname$ = "Bloodfang" + CHR$(0)
IF shipship$ = CHR$(11) THEN class$ = CHR$(55): shipname$ = "Clydesdale" + CHR$(0)
IF shipship$ = CHR$(12) THEN class$ = CHR$(55): shipname$ = "Free Trader" + CHR$(0)
IF shipship$ = CHR$(13) THEN class$ = CHR$(55): shipname$ = "Dorkathi" + CHR$(0)
IF shipship$ = CHR$(15) THEN class$ = CHR$(51): shipname$ = "Crossbow" + CHR$(0)
IF shipship$ = CHR$(16) THEN class$ = CHR$(52): shipname$ = "Kamekh" + CHR$(0)
IF shipship$ = CHR$(17) THEN class$ = CHR$(56): shipname$ = "Waterloo" + CHR$(0)
IF shipship$ = CHR$(18) THEN class$ = CHR$(58): shipname$ = "Carrier" + CHR$(0)
IF shipship$ = CHR$(19) THEN class$ = CHR$(53): shipname$ = "Gilgamesh" + CHR$(0)
IF shipship$ = CHR$(20) THEN class$ = CHR$(53): shipname$ = "Ralatha" + CHR$(0)
IF shipship$ = CHR$(21) THEN class$ = CHR$(56): shipname$ = "Fralthra" + CHR$(0)
IF shipship$ = CHR$(23) THEN class$ = CHR$(59): shipname$ = "H Starbase" + CHR$(0)
IF shipship$ = CHR$(24) THEN class$ = CHR$(59): shipname$ = "H Depot" + CHR$(0)
IF shipship$ = CHR$(25) THEN class$ = CHR$(59): shipname$ = "K Depot" + CHR$(0)
IF shipship$ = CHR$(26) THEN class$ = CHR$(59): shipname$ = "Starpost" + CHR$(0)
IF shipship$ = CHR$(41) THEN class$ = CHR$(50): shipname$ = "Morningstar" + CHR$(0)
IF shipship$ = CHR$(48) THEN class$ = CHR$(59): shipname$ = "Asteroid Base" + CHR$(0)
IF shipship$ = CHR$(50) THEN class$ = CHR$(50): shipname$ = "Gothri" + CHR$(0)

3

PUT #2, offset2, shipname$

PUT #2, offset2 + 19, zero$
PUT #2, offset2 + 20, shipship$
PUT #2, offset2 + 21, class$
PUT #2, offset2 + 23, shipiff$
PUT #2, offset2 + 27, shiporders$
PUT #2, offset2 + 28, zero$: IF shiporders$ = CHR$(255) THEN PUT #2, offset + 28, null$

PUT #2, offset2 + 31, shipxcoordbyte1$
PUT #2, offset2 + 32, shipxcoordbyte2$
PUT #2, offset2 + 33, shipxcoordbyte3$
PUT #2, offset2 + 35, shipycoordbyte1$
PUT #2, offset2 + 36, shipycoordbyte2$
PUT #2, offset2 + 37, shipycoordbyte3$
PUT #2, offset2 + 39, shipzcoordbyte1$
PUT #2, offset2 + 40, shipzcoordbyte2$
PUT #2, offset2 + 41, shipzcoordbyte3$

PUT #2, offset2 + 48, shiponwing$
PUT #2, offset2 + 49, shipspeed$
PUT #2, offset2 + 50, shipsize$
PUT #2, offset2 + 51, p$
PUT #2, offset2 + 56, shipsectarget$
PUT #2, offset2 + 57, shipformation$
PUT #2, offset2 + 58, shippritarget$
IF ASC(shipiff$) = 1 THEN shippilot$ = CHR$(26)
IF ASC(shipiff$) = 0 THEN shippilot$ = CHR$(20)

PUT #2, offset2 + 59, shippilot$




REM "Ships that autopilot with you" conversion
CLS

offset = ((mn - 1) * 24) + 131
offset2 = 137

onewing$ = " ": twowing$ = " ": threewing$ = " ": fourwing$ = " ": fivewing$ = " "
sep1$ = " ": sep2$ = " ": sep3$ = " ": sep4$ = " "


GET #1, offset, onewing$
GET #1, offset + 1, sep1$
GET #1, offset + 2, twowing$
GET #1, offset + 3, sep2$
GET #1, offset + 4, threewing$
GET #1, offset + 5, sep3$
GET #1, offset + 6, fourwing$
GET #1, offset + 7, sep4$
GET #1, offset + 8, fivewing$

PUT #2, offset2, onewing$
PUT #2, offset2 + 1, sep1$
PUT #2, offset2 + 2, twowing$
PUT #2, offset2 + 3, sep2$
PUT #2, offset2 + 4, threewing$
PUT #2, offset2 + 5, sep3$
PUT #2, offset2 + 6, fourwing$
PUT #2, offset2 + 7, sep4$
PUT #2, offset2 + 8, fivewing$







REM Nav point conversion
CLS
IF shipnumber > 9 THEN GOTO 1000
navnumber = shipnumber

IF navnumber = 0 THEN offset = ((mn - 1) * 1232) + 6493
offset = ((mn - 1) * 1232) + 6493 + 77 * navnumber

IF navnumber = 0 THEN offset2 = 5609
offset2 = 5609 + 101 * navnumber


dominant$ = " "
l$ = " ": mainbyte$ = " ": navxcoordbyte1$ = " ": navxcoordbyte2$ = " ": navxcoordbyte3$ = " "
navycoordbyte1$ = " ": navycoordbyte2$ = " ": navycoordbyte3$ = " "
navzcoordbyte1$ = " ": navzcoordbyte2$ = " ": navzcoordbyte3$ = " "
manip1a$ = " ": manip1b$ = " ": manip2a$ = " ": manip2b$ = " "
manip3a$ = " ": manip3b$ = " ": manip4a$ = " ": manip4b$ = " "
image1$ = " ": image2$ = " "
ship1$ = " ": ship2$ = " ": ship3$ = " ": ship4$ = " ": ship5$ = " "
ship6$ = " ": ship7$ = " ": ship8$ = " ": ship9$ = " ": ship10$ = " "


REM Get the NAV label, label$
label$ = ""
switch = 0

FOR i = 0 TO 30
GET #1, offset + i, l$
IF l$ <> CHR$(0) AND switch = 0 THEN label$ = label$ + l$
IF l$ = CHR$(0) THEN label$ = label$ + CHR$(0): switch = 1
NEXT i

REM Get the more info about that specific nav point


GET #1, offset + 30, dominant$
GET #1, offset + 32, navxcoordbyte1$
GET #1, offset + 33, navxcoordbyte2$
GET #1, offset + 34, navxcoordbyte3$

GET #1, offset + 36, navycoordbyte1$
GET #1, offset + 37, navycoordbyte2$
GET #1, offset + 38, navycoordbyte3$

GET #1, offset + 40, navzcoordbyte1$
GET #1, offset + 41, navzcoordbyte2$
GET #1, offset + 42, navzcoordbyte3$

GET #1, offset + 45, manip1a$
GET #1, offset + 46, manip1b$

GET #1, offset + 47, manip2a$
GET #1, offset + 48, manip2b$

GET #1, offset + 49, manip3a$
GET #1, offset + 50, manip3b$

GET #1, offset + 51, manip4a$
GET #1, offset + 52, manip4b$

GET #1, offset + 53, image1$
GET #1, offset + 55, image2$

GET #1, offset + 57, ship1$
GET #1, offset + 59, ship2$
GET #1, offset + 61, ship3$
GET #1, offset + 63, ship4$
GET #1, offset + 65, ship5$
GET #1, offset + 67, ship6$
GET #1, offset + 69, ship7$
GET #1, offset + 71, ship8$
GET #1, offset + 73, ship9$
GET #1, offset + 75, ship10$

REM save nav
PUT #2, offset2, label$
PUT #2, offset2 + 30, dominant$
PUT #2, offset2 + 32, navxcoordbyte1$
PUT #2, offset2 + 33, navxcoordbyte2$
PUT #2, offset2 + 34, navxcoordbyte3$

PUT #2, offset2 + 36, navycoordbyte1$
PUT #2, offset2 + 37, navycoordbyte2$
PUT #2, offset2 + 38, navycoordbyte3$
              
PUT #2, offset2 + 40, navzcoordbyte1$
PUT #2, offset2 + 41, navzcoordbyte2$
PUT #2, offset2 + 42, navzcoordbyte3$

PUT #2, offset2 + 47, manip1a$
PUT #2, offset2 + 48, manip1b$
     
PUT #2, offset2 + 49, manip2a$
PUT #2, offset2 + 50, manip2b$

PUT #2, offset2 + 51, manip3a$
PUT #2, offset2 + 52, manip3b$

PUT #2, offset2 + 53, manip4a$
PUT #2, offset2 + 54, manip4b$


IF image1$ = CHR$(2) THEN i1$ = CHR$(3)
IF image1$ = CHR$(3) THEN i1$ = CHR$(4)
IF image1$ = CHR$(4) THEN i1$ = CHR$(16)
IF image1$ = CHR$(5) THEN i1$ = CHR$(11)
IF image1$ = CHR$(6) THEN i1$ = CHR$(12)
IF image1$ = CHR$(7) THEN i1$ = CHR$(17)
IF image1$ = CHR$(8) THEN i1$ = CHR$(18)
IF image1$ = CHR$(9) THEN i1$ = CHR$(5)
IF image1$ = CHR$(10) THEN i1$ = CHR$(6)
IF image1$ = CHR$(11) THEN i1$ = CHR$(8)
IF image1$ = CHR$(12) THEN i1$ = CHR$(41)
IF image1$ = CHR$(13) THEN i1$ = CHR$(7)
IF image1$ = CHR$(14) THEN i1$ = CHR$(50)
IF image1$ = CHR$(15) THEN i1$ = CHR$(13)
IF image1$ = CHR$(17) THEN i1$ = CHR$(20)
IF image1$ = CHR$(18) THEN i1$ = CHR$(21)
IF image1$ = CHR$(20) THEN i1$ = CHR$(18)
IF image1$ = CHR$(21) THEN i1$ = CHR$(26)
IF image1$ = CHR$(22) THEN i1$ = CHR$(21): mark = 1: class$ = CHR$(5): GOTO 4
IF image1$ = CHR$(23) THEN i1$ = CHR$(22): mark = 1: class$ = CHR$(6): GOTO 4

IF image1$ = CHR$(255) THEN i1$ = CHR$(255)

IF i1$ = CHR$(0) THEN class$ = CHR$(48)
IF i1$ = CHR$(1) THEN class$ = CHR$(49)
IF i1$ = CHR$(2) THEN class$ = CHR$(51)
IF i1$ = CHR$(3) THEN class$ = CHR$(48)
IF i1$ = CHR$(4) THEN class$ = CHR$(50)
IF i1$ = CHR$(5) THEN class$ = CHR$(48)
IF i1$ = CHR$(6) THEN class$ = CHR$(49)
IF i1$ = CHR$(7) THEN class$ = CHR$(50)
IF i1$ = CHR$(8) THEN class$ = CHR$(50)
IF i1$ = CHR$(9) THEN class$ = CHR$(49)
IF i1$ = CHR$(10) THEN class$ = CHR$(49)
IF i1$ = CHR$(11) THEN class$ = CHR$(55)
IF i1$ = CHR$(12) THEN class$ = CHR$(55)
IF i1$ = CHR$(13) THEN class$ = CHR$(55)
IF i1$ = CHR$(15) THEN class$ = CHR$(51)
IF i1$ = CHR$(16) THEN class$ = CHR$(52)
IF i1$ = CHR$(17) THEN class$ = CHR$(56)
IF i1$ = CHR$(18) THEN class$ = CHR$(58)
IF i1$ = CHR$(19) THEN class$ = CHR$(53)
IF i1$ = CHR$(20) THEN class$ = CHR$(53)
IF i1$ = CHR$(21) THEN class$ = CHR$(56)
IF i1$ = CHR$(23) THEN class$ = CHR$(59)
IF i1$ = CHR$(24) THEN class$ = CHR$(59)
IF i1$ = CHR$(25) THEN class$ = CHR$(59)
IF i1$ = CHR$(41) THEN class$ = CHR$(50)
IF i1$ = CHR$(48) THEN class$ = CHR$(59)
IF i1$ = CHR$(50) THEN class$ = CHR$(50)
IF i1$ = CHR$(255) THEN class$ = CHR$(0)
4
PUT #2, offset2 + 75, class$
PUT #2, offset2 + 69, large$
IF ASC(class$) < 52 THEN PUT #2, offset2 + 69, small$
IF ASC(class$) >= 52 AND ASC(class$) <= 58 THEN PUT #2, offset2 + 69, med$

PUT #2, offset2 + 63, i1$
PUT #2, offset2 + 64, zero$
IF i1$ = CHR$(255) THEN PUT #2, offset2 + 64, null$





IF image2$ = CHR$(2) THEN i2$ = CHR$(3)
IF image2$ = CHR$(3) THEN i2$ = CHR$(4)
IF image2$ = CHR$(4) THEN i2$ = CHR$(16)
IF image2$ = CHR$(5) THEN i2$ = CHR$(11)
IF image2$ = CHR$(6) THEN i2$ = CHR$(12)
IF image2$ = CHR$(7) THEN i2$ = CHR$(17)
IF image2$ = CHR$(8) THEN i2$ = CHR$(18)
IF image2$ = CHR$(9) THEN i2$ = CHR$(5)
IF image2$ = CHR$(10) THEN i2$ = CHR$(6)
IF image2$ = CHR$(11) THEN i2$ = CHR$(8)
IF image2$ = CHR$(12) THEN i2$ = CHR$(41)
IF image2$ = CHR$(13) THEN i2$ = CHR$(7)
IF image2$ = CHR$(14) THEN i2$ = CHR$(50)
IF image2$ = CHR$(15) THEN i2$ = CHR$(13)
IF image2$ = CHR$(17) THEN i2$ = CHR$(20)
IF image2$ = CHR$(18) THEN i2$ = CHR$(21)
IF image2$ = CHR$(20) THEN i2$ = CHR$(18)
IF image2$ = CHR$(21) THEN i2$ = CHR$(26)
IF image2$ = CHR$(22) THEN i2$ = CHR$(21): mark = 1: class$ = CHR$(5): GOTO 5
IF image2$ = CHR$(23) THEN i2$ = CHR$(22): mark = 1: class$ = CHR$(6): GOTO 5


IF image2$ = CHR$(255) THEN i2$ = CHR$(255)



IF i2$ = CHR$(0) THEN class$ = CHR$(48)
IF i2$ = CHR$(1) THEN class$ = CHR$(49)
IF i2$ = CHR$(2) THEN class$ = CHR$(51)
IF i2$ = CHR$(3) THEN class$ = CHR$(48)
IF i2$ = CHR$(4) THEN class$ = CHR$(50)
IF i2$ = CHR$(5) THEN class$ = CHR$(48)
IF i2$ = CHR$(6) THEN class$ = CHR$(49)
IF i2$ = CHR$(7) THEN class$ = CHR$(50)
IF i2$ = CHR$(8) THEN class$ = CHR$(50)
IF i2$ = CHR$(9) THEN class$ = CHR$(49)
IF i2$ = CHR$(10) THEN class$ = CHR$(49)
IF i2$ = CHR$(11) THEN class$ = CHR$(55)
IF i2$ = CHR$(12) THEN class$ = CHR$(55)
IF i2$ = CHR$(13) THEN class$ = CHR$(55)
IF i2$ = CHR$(15) THEN class$ = CHR$(51)
IF i2$ = CHR$(16) THEN class$ = CHR$(52)
IF i2$ = CHR$(17) THEN class$ = CHR$(56)
IF i2$ = CHR$(18) THEN class$ = CHR$(58)
IF i2$ = CHR$(19) THEN class$ = CHR$(53)
IF i2$ = CHR$(20) THEN class$ = CHR$(53)
IF i2$ = CHR$(21) THEN class$ = CHR$(56)
IF i2$ = CHR$(23) THEN class$ = CHR$(59)
IF i2$ = CHR$(24) THEN class$ = CHR$(59)
IF i2$ = CHR$(25) THEN class$ = CHR$(59)
IF i2$ = CHR$(41) THEN class$ = CHR$(50)
IF i2$ = CHR$(48) THEN class$ = CHR$(59)
IF i2$ = CHR$(50) THEN class$ = CHR$(50)
IF i2$ = CHR$(255) THEN class$ = CHR$(0)
5
PUT #2, offset2 + 65, i2$
PUT #2, offset2 + 66, zero$
IF i2$ = CHR$(255) THEN PUT #2, offset2 + 66, null$


PUT #2, offset2 + 77, class$
PUT #2, offset2 + 71, large$
IF ASC(class$) < 52 THEN PUT #2, offset2 + 71, small$
IF ASC(class$) >= 52 AND ASC(class$) <= 58 THEN PUT #2, offset2 + 71, med$


PUT #2, offset2 + 81, ship1$
PUT #2, offset2 + 82, zero$
IF ship1$ = CHR$(255) THEN PUT #2, offset2 + 82, null$
PUT #2, offset2 + 83, ship2$
PUT #2, offset2 + 84, zero$
IF ship2$ = CHR$(255) THEN PUT #2, offset2 + 84, null$
PUT #2, offset2 + 85, ship3$
PUT #2, offset2 + 86, zero$
IF ship3$ = CHR$(255) THEN PUT #2, offset2 + 86, null$
PUT #2, offset2 + 87, ship4$
PUT #2, offset2 + 88, zero$
IF ship4$ = CHR$(255) THEN PUT #2, offset2 + 88, null$
PUT #2, offset2 + 89, ship5$
PUT #2, offset2 + 90, zero$
IF ship5$ = CHR$(255) THEN PUT #2, offset2 + 90, null$
PUT #2, offset2 + 91, ship6$
PUT #2, offset2 + 92, zero$
IF ship6$ = CHR$(255) THEN PUT #2, offset2 + 92, null$
PUT #2, offset2 + 93, ship7$
PUT #2, offset2 + 94, zero$
IF ship7$ = CHR$(255) THEN PUT #2, offset2 + 94, null$
PUT #2, offset2 + 95, ship8$
PUT #2, offset2 + 96, zero$
IF ship8$ = CHR$(255) THEN PUT #2, offset2 + 96, null$
PUT #2, offset2 + 97, ship9$
PUT #2, offset2 + 98, zero$
IF ship9$ = CHR$(255) THEN PUT #2, offset2 + 98, null$
PUT #2, offset2 + 99, ship10$
PUT #2, offset2 + 100, zero$
IF ship10$ = CHR$(255) THEN PUT #2, offset2 + 100, null$
              


1000


REM Nav point description
CLS
IF shipnumber > 7 THEN GOTO 2000
dnumber = shipnumber


icon$ = " ": ship$ = " ": l$ = " "

IF dnumber = 0 THEN offset = ((mn - 1) * 1024) + 84509
offset = ((mn - 1) * 1024) + 84509 + 64 * dnumber

IF dnumber = 0 THEN offset2 = 68257
offset2 = 68257 + 64 * dnumber


55556
switch = 0
label$ = ""
FOR i = 0 TO 58
GET #1, offset + 4 + i, l$
IF l$ <> CHR$(0) AND switch = 0 THEN label$ = label$ + l$
IF l$ = CHR$(0) THEN label$ = label$ + CHR$(0): switch = 1
NEXT i

GET #1, offset, icon$
GET #1, offset + 2, ship$

PUT #2, offset2, icon$
PUT #2, offset2 + 1, zero$
PUT #2, offset2 + 2, ship$
PUT #2, offset2 + 3, zero$
PUT #2, offset2 + 4, label$



2000
NEXT shipnumber

SYSTEM

