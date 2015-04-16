CLS






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

INPUT "What's the MODULE file you want to edit (ex: module.000)"; module$
OPEN module$ FOR BINARY AS #1
1 REM Main Menu
CLS

LOCATE 1, 15: PRINT "Welcome to Mario 'HCl' Brito's WC1 mission editor."
LOCATE 5, 8: PRINT "Please Choose:"
LOCATE 7, 10: PRINT "1 - View/Edit ships"
LOCATE 8, 10: PRINT "2 - View/Edit ships' coordinates"
LOCATE 9, 3: PRINT " (these coordinates are relative to the NAV the ships are on)"
LOCATE 10, 10: PRINT "3 - View/Edit what ships will autopilot with you"
LOCATE 11, 10: PRINT "4 - View/Edit a NAV point"
LOCATE 12, 10: PRINT "5 - View/Edit a NAV point description"
LOCATE 16, 10: PRINT "8 - List all ships"
LOCATE 19, 12: PRINT "When you want to awnser <none> to something, type 255"
LOCATE 20, 30: PRINT "Press 9 to exit"
INPUT choice

IF choice = 1 THEN GOTO 4001
IF choice = 2 THEN GOTO 4011
IF choice = 9 THEN CLOSE #1: END
IF choice = 3 THEN GOTO 5000
IF choice = 4 THEN GOTO 8000
IF choice = 8 THEN GOTO 1234
IF choice = 5 THEN GOTO 55555



GOTO 1


4001

REM Ships' Description
CLS
INPUT "What's the ship number"; shipnumber


IF shipnumber = 0 THEN offset = 151325: GOTO 4002
offset = 151325 + 42 * shipnumber



4002

GET #1, offset, shipship$
GET #1, offset + 2, shipiff$
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
GET #1, offset + 28, shipspeed$
GET #1, offset + 29, shipsize$
GET #1, offset + 32, shippilot$
GET #1, offset + 39, shipsectarget$
GET #1, offset + 40, shipformation$
GET #1, offset + 41, shippritarget$
                         

LOCATE 2, 1: PRINT "Ship"; shipnumber; ":";
IF shipship$ = CHR$(0) THEN PRINT "Hornet";
IF shipship$ = CHR$(1) THEN PRINT "Rapier";
IF shipship$ = CHR$(2) THEN PRINT "Scimitar";
IF shipship$ = CHR$(3) THEN PRINT "Raptor";
IF shipship$ = CHR$(4) THEN PRINT "Venture";
IF shipship$ = CHR$(5) THEN PRINT "Dilligent";
IF shipship$ = CHR$(6) THEN PRINT "Drayman";
IF shipship$ = CHR$(7) THEN PRINT "Exeter";
IF shipship$ = CHR$(8) THEN PRINT "Tiger's Claw";
IF shipship$ = CHR$(9) THEN PRINT "Salthi";
IF shipship$ = CHR$(10) THEN PRINT "Dralthi";
IF shipship$ = CHR$(11) THEN PRINT "Krant";
IF shipship$ = CHR$(12) THEN PRINT "Gratha";
IF shipship$ = CHR$(13) THEN PRINT "Jalthi";
IF shipship$ = CHR$(14) THEN PRINT "Hhriss";
IF shipship$ = CHR$(15) THEN PRINT "Dorkir";
IF shipship$ = CHR$(16) THEN PRINT "Lumbari";
IF shipship$ = CHR$(17) THEN PRINT "Ralari";
IF shipship$ = CHR$(18) THEN PRINT "Fralthi";
IF shipship$ = CHR$(19) THEN PRINT "Snakeir";
IF shipship$ = CHR$(20) THEN PRINT "Sivar";
IF shipship$ = CHR$(21) THEN PRINT "Starpost";
IF shipship$ = CHR$(22) THEN PRINT "Asteroid Field";
IF shipship$ = CHR$(23) THEN PRINT "Mine Field";
IF shipship$ = CHR$(255) THEN PRINT "<Unused>";

IF shipiff$ = CHR$(0) THEN PRINT " is Confed";
IF shipiff$ = CHR$(1) THEN PRINT " is Kilrathi";
IF shipiff$ = CHR$(2) THEN PRINT " is IFF 2";

IF shiporders$ = CHR$(2) THEN PRINT " and will attack"; : PRINT " ships"; ASC(shippritarget$); "and"; ASC(shipsectarget$)
IF shiporders$ = CHR$(4) THEN PRINT " and will follow leader"; : PRINT " in ship"; ASC(shippritarget$)
IF shiporders$ = CHR$(7) THEN PRINT ",will jump in"; : PRINT " and head for nav"; ASC(shippritarget$)
IF shiporders$ = CHR$(6) THEN PRINT " and will jump out"; : PRINT " at nav"; ASC(shippritarget$)
IF shiporders$ = CHR$(0) THEN PRINT " and will attack"; : PRINT " ships"; ASC(shippritarget$); "and"; ASC(shipsectarget$)
IF shiporders$ = CHR$(255) THEN PRINT " and is inactive.";

PRINT " It's being flown by ";
IF shippilot$ = CHR$(0) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(1) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(2) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(3) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(4) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(5) THEN PRINT "Spirit"
IF shippilot$ = CHR$(6) THEN PRINT "Hunter"
IF shippilot$ = CHR$(7) THEN PRINT "Bossman (Jazz on sm2)"
IF shippilot$ = CHR$(8) THEN PRINT "Iceman"
IF shippilot$ = CHR$(9) THEN PRINT "Angel"
IF shippilot$ = CHR$(10) THEN PRINT "Paladin (Doomsday in sm2)"
IF shippilot$ = CHR$(11) THEN PRINT "Maniac"
IF shippilot$ = CHR$(12) THEN PRINT "Knight"
IF shippilot$ = CHR$(13) THEN PRINT "Blair"
IF shippilot$ = CHR$(14) THEN PRINT "Bhurak Starkiller (Drakhai on sm2)"
IF shippilot$ = CHR$(15) THEN PRINT "Dakhath Deathstroke (Drakhai on sm2)"
IF shippilot$ = CHR$(16) THEN PRINT "Khajja The Fang (Drakhai on sm2)"
IF shippilot$ = CHR$(17) THEN PRINT "Bakhtosh Redclaw (Drakhai on sm2)"
PRINT "Ship speed: "; (ASC(shipspeed$) * 10); " m/s"


4003 PRINT : PRINT : INPUT "Change it (y/n case sensitive)"; choice$
IF choice$ = "y" THEN GOTO 4004
IF choice$ = "n" THEN GOTO 1
GOTO 4003

4004

INPUT "What ship (see list)"; shipship
INPUT "What IFF code (0=confed; 1=Kilrathi)"; shipiff
INPUT "What orders (0 or 2 - attack; 4 - follow leader; 6 - Jump out; 7 - Jump in;     255 - Inactive)"; shiporders
INPUT "If it's an Asteroid or Mine field, what size will it have"; shipsize
INPUT "Who's flying this ship (see list)"; shippilot
INPUT "What formation (0 = default)"; shipformation
INPUT "What's it's primary target or destination"; shippritarget
INPUT "And it's secondary target or destination"; shipsectarget
INPUT "What's the ship speed"; shipspeed


shipship$ = CHR$(shipship)
shipiff$ = CHR$(shipiff)
shiporders$ = CHR$(shiporders)
shipsize$ = CHR$(shipsize)
shippilot$ = CHR$(shippilot)
shipformation$ = CHR$(shipformation)
shippritarget$ = CHR$(shippritarget)
shipsectarget$ = CHR$(shipsectarget)
shipspeed$ = CHR$((shipspeed / 10))


PUT #1, offset, shipship$
PUT #1, offset + 2, shipiff$
PUT #1, offset + 6, shiporders$
PUT #1, offset + 10, shipxcoordbyte1$
PUT #1, offset + 11, shipxcoordbyte2$
PUT #1, offset + 12, shipxcoordbyte3$
PUT #1, offset + 14, shipycoordbyte1$
PUT #1, offset + 15, shipycoordbyte2$
PUT #1, offset + 16, shipycoordbyte3$
PUT #1, offset + 18, shipzcoordbyte1$
PUT #1, offset + 19, shipzcoordbyte2$
PUT #1, offset + 20, shipzcoordbyte3$
PUT #1, offset + 28, shipspeed$
PUT #1, offset + 29, shipsize$
PUT #1, offset + 32, shippilot$
PUT #1, offset + 39, shipsectarget$
PUT #1, offset + 40, shipformation$
PUT #1, offset + 41, shippritarget$

GOTO 1

4011

REM Ships' Description
CLS
INPUT "What's the ship number"; shipnumber


IF shipnumber = 0 THEN offset = 151325: GOTO 4012
offset = 151325 + 42 * shipnumber
4012
lx = 1: ly = 1: lz = 1


GET #1, offset + 10, shipxcoordbyte1$
GET #1, offset + 11, shipxcoordbyte2$
GET #1, offset + 12, shipxcoordbyte3$
GET #1, offset + 14, shipycoordbyte1$
GET #1, offset + 15, shipycoordbyte2$
GET #1, offset + 16, shipycoordbyte3$
GET #1, offset + 18, shipzcoordbyte1$
GET #1, offset + 19, shipzcoordbyte2$
GET #1, offset + 20, shipzcoordbyte3$


shipxcoordbyte1 = ASC(shipxcoordbyte1$)
shipxcoordbyte2 = ASC(shipxcoordbyte2$)
shipxcoordbyte3 = ASC(shipxcoordbyte3$)

shipycoordbyte1 = ASC(shipycoordbyte1$)
shipycoordbyte2 = ASC(shipycoordbyte2$)
shipycoordbyte3 = ASC(shipycoordbyte3$)

shipzcoordbyte1 = ASC(shipzcoordbyte1$)
shipzcoordbyte2 = ASC(shipzcoordbyte2$)
shipzcoordbyte3 = ASC(shipzcoordbyte3$)

IF shipxcoordbyte3 > 150 THEN lx = -1: shipxcoordbyte3 = 255 - shipxcoordbyte3: shipxcoordbyte2 = 255 - shipxcoordbyte2: shipxcoordbyte1 = 255 - shipxcoordbyte1

x = lx * (shipxcoordbyte1) + ((shipxcoordbyte2) * 256) + ((shipxcoordbyte3) * 65536)

IF shipycoordbyte3 > 150 THEN ly = -1: shipycoordbyte3 = 255 - shipycoordbyte3: shipycoordbyte2 = 255 - shipycoordbyte2: shipycoordbyte1 = 255 - shipycoordbyte1

y = ly * (shipycoordbyte1) + ((shipycoordbyte2) * 256) + ((shipycoordbyte3) * 65536)

IF shipzcoordbyte3 > 150 THEN lz = -1: shipzcoordbyte3 = 255 - shipzcoordbyte3: shipzcoordbyte2 = 255 - shipzcoordbyte2: shipzcoordbyte1 = 255 - shipzcoordbyte1

z = lz * (shipzcoordbyte1) + ((shipzcoordbyte2) * 256) + ((shipzcoordbyte3) * 65536)

LOCATE 2, 1: PRINT "Ship"; shipnumber; "coordinates:";
PRINT "X="; x, "Y="; y, "Z="; z
PRINT : PRINT : INPUT "Change it"; choice$
IF choice$ = "n" THEN GOTO 1

REM Routine to change ships coordinates
lx = 1: ly = 1: lz = 1
INPUT "X axis"; x
INPUT "Y axis"; y
INPUT "Z axis"; z

x$ = HEX$(x)
y$ = HEX$(y)
z$ = HEX$(z)

IF LEN(x$) <= 2 THEN shipxcoordbyte1$ = CHR$(x): shipxcoordbyte2$ = CHR$(0): shipxcoordbyte3$ = CHR$(0)
IF LEN(x$) = 3 THEN xb1$ = RIGHT$(x$, 2): xb2$ = LEFT$(x$, 1): shipxcoordbyte3$ = CHR$(0): shipxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): shipxcoordbyte1$ = CHR$(VAL("&H" + xb1$))
IF LEN(x$) = 4 THEN xb1$ = RIGHT$(x$, 2): xb2$ = LEFT$(x$, 2): shipxcoordbyte3$ = CHR$(0): shipxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): shipxcoordbyte1$ = CHR$(VAL("&H" + xb1$))
IF LEN(x$) = 5 THEN xb1$ = RIGHT$(x$, 2): xb3$ = LEFT$(x$, 1): xb2$ = MID$(x$, 2, 2): shipxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): shipxcoordbyte1$ = CHR$(VAL("&H" + xb1$)): shipxcoordbyte3$ = CHR$(VAL("&H" + xb3$))

IF LEN(y$) <= 2 THEN shipycoordbyte1$ = CHR$(y): shipycoordbyte2$ = CHR$(0): shipycoordbyte3$ = CHR$(0)
IF LEN(y$) = 3 THEN yb1$ = RIGHT$(y$, 2): yb2$ = LEFT$(y$, 1): shipycoordbyte3$ = CHR$(0): shipycoordbyte2$ = CHR$(VAL("&H" + yb2$)): shipycoordbyte1$ = CHR$(VAL("&H" + yb1$))
IF LEN(y$) = 4 THEN yb1$ = RIGHT$(y$, 2): yb2$ = LEFT$(y$, 2): shipycoordbyte3$ = CHR$(0): shipycoordbyte2$ = CHR$(VAL("&H" + yb2$)): shipycoordbyte1$ = CHR$(VAL("&H" + yb1$))
IF LEN(y$) = 5 THEN yb1$ = RIGHT$(y$, 2): yb3$ = LEFT$(y$, 1): yb2$ = MID$(y$, 2, 2): shipycoordbyte2$ = CHR$(VAL("&H" + yb2$)): shipycoordbyte1$ = CHR$(VAL("&H" + yb1$)): shipycoordbyte3$ = CHR$(VAL("&H" + yb3$))

IF LEN(z$) <= 2 THEN shipzcoordbyte1$ = CHR$(z): shipzcoordbyte2$ = CHR$(0): shipzcoordbyte3$ = CHR$(0)
IF LEN(z$) = 3 THEN zb1$ = RIGHT$(z$, 2): zb2$ = LEFT$(z$, 1): shipzcoordbyte3$ = CHR$(0): shipzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): shipzcoordbyte1$ = CHR$(VAL("&H" + zb1$))
IF LEN(z$) = 4 THEN zb1$ = RIGHT$(z$, 2): zb2$ = LEFT$(z$, 2): shipzcoordbyte3$ = CHR$(0): shipzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): shipzcoordbyte1$ = CHR$(VAL("&H" + zb1$))
IF LEN(z$) = 5 THEN zb1$ = RIGHT$(z$, 2): zb3$ = LEFT$(z$, 1): zb2$ = MID$(z$, 2, 2): shipzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): shipzcoordbyte1$ = CHR$(VAL("&H" + zb1$)): shipzcoordbyte3$ = CHR$(VAL("&H" + zb3$))

PUT #1, offset + 10, shipxcoordbyte1$
PUT #1, offset + 11, shipxcoordbyte2$
PUT #1, offset + 12, shipxcoordbyte3$
PUT #1, offset + 14, shipycoordbyte1$
PUT #1, offset + 15, shipycoordbyte2$
PUT #1, offset + 16, shipycoordbyte3$
PUT #1, offset + 18, shipzcoordbyte1$
PUT #1, offset + 19, shipzcoordbyte2$
PUT #1, offset + 20, shipzcoordbyte3$

GOTO 1

5000

REM Ships that autopilot with you
CLS

offset = 131

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

onewing = ASC(onewing$)
twowing = ASC(twowing$)
threewing = ASC(threewing$)
fourwing = ASC(fourwing$)
fivewing = ASC(fivewing$)




PRINT "A total of 5 ships can autopilot with you. These are the current assignments:"

FOR i = 0 TO 31
IF onewing = i THEN PRINT "Ship "; i
IF twowing = i THEN PRINT "Ship "; i
IF threewing = i THEN PRINT "Ship "; i
IF fourwing = i THEN PRINT "Ship "; i
IF fivewing = i THEN PRINT "Ship "; i
NEXT i

PRINT
PRINT
INPUT "Change it"; choice$
IF choice$ = "n" THEN GOTO 1
CLS
PRINT

PRINT "Enter 5 ships to autopilot with you (type 255 to <none>)"

INPUT "1st ship"; onewing
INPUT "2nd ship"; twowing
INPUT "3rd ship"; threewing
INPUT "4th ship"; fourwing
INPUT "5th ship"; fivewing

onewing$ = CHR$(onewing)
twowing$ = CHR$(twowing)
threewing$ = CHR$(threewing)
fourwing$ = CHR$(fourwing)
fivewing$ = CHR$(fivewing)

sep1$ = CHR$(0)
IF onewing = 255 THEN sep1$ = CHR$(255)
sep2$ = CHR$(0)
IF twowing = 255 THEN sep2$ = CHR$(255)
sep3$ = CHR$(0)
IF threewing = 255 THEN sep3$ = CHR$(255)
sep4$ = CHR$(0)
IF fourwing = 255 THEN sep4$ = CHR$(255)
sep5$ = CHR$(0)
IF fivewing = 255 THEN sep5$ = CHR$(255)


PUT #1, offset, onewing$
PUT #1, offset + 1, sep1$
PUT #1, offset + 2, twowing$
PUT #1, offset + 3, sep2$
PUT #1, offset + 4, threewing$
PUT #1, offset + 5, sep3$
PUT #1, offset + 6, fourwing$
PUT #1, offset + 7, sep4$
PUT #1, offset + 8, fivewing$

GOTO 1

8000
REM view a nav point
CLS

INPUT "What's the NAV number (starting with 0)"; navnumber


IF navnumber = 0 THEN offset = 6493: GOTO 8001
offset = 6493 + 77 * navnumber

8001

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
label$ = " "
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

PRINT
PRINT "This NAV label is: "; label$
PRINT
IF ASC(dominant$) = 1 THEN PRINT "This is a 'Dominant' NAV point"
IF ASC(dominant$) > 1 AND ASC(dominant$) < 5 THEN PRINT "This is a 'Follow up' NAV point"
IF ASC(dominant$) = 0 THEN PRINT "This is a 'Manipulated' NAV point"


navxcoordbyte1 = ASC(navxcoordbyte1$)
navxcoordbyte2 = ASC(navxcoordbyte2$)
navxcoordbyte3 = ASC(navxcoordbyte3$)

navycoordbyte1 = ASC(navycoordbyte1$)
navycoordbyte2 = ASC(navycoordbyte2$)
navycoordbyte3 = ASC(navycoordbyte3$)

navzcoordbyte1 = ASC(navzcoordbyte1$)
navzcoordbyte2 = ASC(navzcoordbyte2$)
navzcoordbyte3 = ASC(navzcoordbyte3$)
lx = 1: ly = 1: lz = 1
IF navxcoordbyte3 > 150 THEN lx = -1: navxcoordbyte3 = 255 - navxcoordbyte3: navxcoordbyte2 = 255 - navxcoordbyte2: navxcoordbyte1 = 256 - navxcoordbyte1

x = lx * ((navxcoordbyte1) + ((navxcoordbyte2) * 256) + ((navxcoordbyte3) * 65536))

IF navycoordbyte3 > 150 THEN ly = -1: navycoordbyte3 = 255 - navycoordbyte3: navycoordbyte2 = 255 - navycoordbyte2: navycoordbyte1 = 256 - navycoordbyte1

y = ly * ((navycoordbyte1) + (((navycoordbyte2) * 256)) + ((navycoordbyte3) * 65536))

IF navzcoordbyte3 > 150 THEN lz = -1: navzcoordbyte3 = 255 - navzcoordbyte3: navzcoordbyte2 = 255 - navzcoordbyte2: navzcoordbyte1 = 256 - navzcoordbyte1

z = lz * ((navzcoordbyte1) + ((navzcoordbyte2) * 256) + ((navzcoordbyte3) * 65536))

PRINT "Nav"; navnumber; "coordinates:";
PRINT "X="; x, "Y="; y, "Z="; z
PRINT
PRINT "Nav manipulations:"
IF manip1a$ = CHR$(0) THEN PRINT "Will turn off Nav"; ASC(manip1b$)
IF manip1a$ = CHR$(1) THEN PRINT "Will turn on Nav"; ASC(manip1b$)
IF manip1a$ = CHR$(255) THEN PRINT "Won't do anything to Nav"; ASC(manip1b$)
IF manip2a$ = CHR$(0) THEN PRINT "Will turn off Nav"; ASC(manip2b$)
IF manip2a$ = CHR$(1) THEN PRINT "Will turn on Nav"; ASC(manip2b$)
IF manip2a$ = CHR$(255) THEN PRINT "Won't do anything to Nav"; ASC(manip2b$)
IF manip3a$ = CHR$(0) THEN PRINT "Will turn off Nav"; ASC(manip3b$)
IF manip3a$ = CHR$(1) THEN PRINT "Will turn on Nav"; ASC(manip3b$)
IF manip3a$ = CHR$(255) THEN PRINT "Won't do anything to Nav"; ASC(manip3b$)
IF manip4a$ = CHR$(0) THEN PRINT "Will turn off Nav"; ASC(manip4b$)
IF manip4a$ = CHR$(1) THEN PRINT "Will turn on Nav"; ASC(manip4b$)
IF manip4a$ = CHR$(255) THEN PRINT "Won't do anything to Nav"; ASC(manip4b$)
PRINT
PRINT "This nav will load ship images "; ASC(image1$); "and "; ASC(image2$)
PRINT
PRINT

PRINT "At last: this nav point will 'call' ships: ";

10000 IF ASC(ship1$) = 255 THEN GOTO 20000
PRINT ASC(ship1$);
20000 IF ASC(ship2$) = 255 THEN GOTO 30000
PRINT ASC(ship2$);
30000 IF ASC(ship3$) = 255 THEN GOTO 40000
PRINT ASC(ship3$);
40000 IF ASC(ship4$) = 255 THEN GOTO 50000
PRINT ASC(ship4$);
50000 IF ASC(ship5$) = 255 THEN GOTO 60000
PRINT ASC(ship5$);
60000 IF ASC(ship6$) = 255 THEN GOTO 70000
PRINT ASC(ship6$);
70000 IF ASC(ship7$) = 255 THEN GOTO 80000
PRINT ASC(ship7$);
80000 IF ASC(ship8$) = 255 THEN GOTO 90000
PRINT ASC(ship8$);
90000 IF ASC(ship9$) = 255 THEN GOTO 100000
PRINT ASC(ship9$);
100000 IF ASC(ship10$) = 255 THEN GOTO 110000
PRINT ASC(ship10$);

110000
PRINT : INPUT "Change it"; choice$
IF choice$ = "n" THEN label$ = "": GOTO 1

REM Gonna change Nav point

INPUT "What's the new label"; label$
label$ = label$ + CHR$(0)
label$ = label$ + CHR$(0)
INPUT "What's this nav (0=Manipulated; 1=Dominant; 2 to 4=Follow up)"; dominant
dominant$ = CHR$(dominant)




REM Gonna put coordinates routine here later...
lx = 1: ly = 1: lz = 1
INPUT "X axis"; x
INPUT "Y axis"; y
INPUT "Z axis"; z

x$ = HEX$(x)
y$ = HEX$(y)
z$ = HEX$(z)

IF LEN(x$) <= 2 THEN navxcoordbyte1$ = CHR$(x): navxcoordbyte2$ = CHR$(0): navxcoordbyte3$ = CHR$(0)
IF LEN(x$) = 3 THEN xb1$ = RIGHT$(x$, 2): xb2$ = LEFT$(x$, 1): navxcoordbyte3$ = CHR$(0): navxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): navxcoordbyte1$ = CHR$(VAL("&H" + xb1$))
IF LEN(x$) = 4 THEN xb1$ = RIGHT$(x$, 2): xb2$ = LEFT$(x$, 2): navxcoordbyte3$ = CHR$(0): navxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): navxcoordbyte1$ = CHR$(VAL("&H" + xb1$))
IF LEN(x$) = 5 THEN xb1$ = RIGHT$(x$, 2): xb3$ = LEFT$(x$, 1): xb2$ = MID$(x$, 2, 2): navxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): navxcoordbyte1$ = CHR$(VAL("&H" + xb1$)): navxcoordbyte3$ = CHR$(VAL("&H" + xb3$))
IF LEN(x$) = 8 THEN xb1$ = RIGHT$(x$, 2): xb2$ = MID$(x$, 5, 2): xb3$ = MID$(x$, 3, 2)
IF LEN(x$) = 8 THEN navxcoordbyte1$ = CHR$(VAL("&H" + xb1$)): navxcoordbyte2$ = CHR$(VAL("&H" + xb2$)): navxcoordbyte3$ = CHR$(VAL("&H" + xb3$))

IF LEN(y$) <= 2 THEN navycoordbyte1$ = CHR$(y): navycoordbyte2$ = CHR$(0): navycoordbyte3$ = CHR$(0)
IF LEN(y$) = 3 THEN yb1$ = RIGHT$(y$, 2): yb2$ = LEFT$(y$, 1): navycoordbyte3$ = CHR$(0): navycoordbyte2$ = CHR$(VAL("&H" + yb2$)): navycoordbyte1$ = CHR$(VAL("&H" + yb1$))
IF LEN(y$) = 4 THEN yb1$ = RIGHT$(y$, 2): yb2$ = LEFT$(y$, 2): navycoordbyte3$ = CHR$(0): navycoordbyte2$ = CHR$(VAL("&H" + yb2$)): navycoordbyte1$ = CHR$(VAL("&H" + yb1$))
IF LEN(y$) = 5 THEN yb1$ = RIGHT$(y$, 2): yb3$ = LEFT$(y$, 1): yb2$ = MID$(y$, 2, 2): navycoordbyte2$ = CHR$(VAL("&H" + yb2$)): navycoordbyte1$ = CHR$(VAL("&H" + yb1$)): navycoordbyte3$ = CHR$(VAL("&H" + yb3$))
IF LEN(y$) = 8 THEN yb1$ = RIGHT$(y$, 2): yb2$ = MID$(y$, 5, 2): yb3$ = MID$(y$, 3, 2)
IF LEN(y$) = 8 THEN navycoordbyte1$ = CHR$(VAL("&H" + yb1$)): navycoordbyte2$ = CHR$(VAL("&H" + yb2$)): navycoordbyte3$ = CHR$(VAL("&H" + yb3$))

IF LEN(z$) <= 2 THEN navzcoordbyte1$ = CHR$(z): navzcoordbyte2$ = CHR$(0): navzcoordbyte3$ = CHR$(0)
IF LEN(z$) = 3 THEN zb1$ = RIGHT$(z$, 2): zb2$ = LEFT$(z$, 1): navzcoordbyte3$ = CHR$(0): navzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): navzcoordbyte1$ = CHR$(VAL("&H" + zb1$))
IF LEN(z$) = 4 THEN zb1$ = RIGHT$(z$, 2): zb2$ = LEFT$(z$, 2): navzcoordbyte3$ = CHR$(0): navzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): navzcoordbyte1$ = CHR$(VAL("&H" + zb1$))
IF LEN(z$) = 5 THEN zb1$ = RIGHT$(z$, 2): zb3$ = LEFT$(z$, 1): zb2$ = MID$(z$, 2, 2): navzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): navzcoordbyte1$ = CHR$(VAL("&H" + zb1$)): navzcoordbyte3$ = CHR$(VAL("&H" + zb3$))
IF LEN(z$) = 8 THEN zb1$ = RIGHT$(z$, 2): zb2$ = MID$(z$, 5, 2): zb3$ = MID$(z$, 3, 2)
IF LEN(z$) = 8 THEN navzcoordbyte1$ = CHR$(VAL("&H" + zb1$)): navzcoordbyte2$ = CHR$(VAL("&H" + zb2$)): navzcoordbyte3$ = CHR$(VAL("&H" + zb3$))



REM Gonna put coordinates routine here later...




PRINT "Nav Manipulations: type 1 to turn on and 0 to turn of a nav"
909090 INPUT "1st manipulation (255 to none)"; manip1a
IF manip1a = 255 THEN manip1b = 0: GOTO 909091
INPUT "1st nav"; manip1b

909091 INPUT "2nd manipulation"; manip2a
IF manip2a = 255 THEN manip2b = 0: GOTO 909092
INPUT "2nd nav"; manip2b

909092 INPUT "3rd manipulation"; manip3a
IF manip3a = 255 THEN manip3b = 0: GOTO 909093
INPUT "3rd nav"; manip3b

909093 INPUT "4th manipulation"; manip4a
IF manip4a = 255 THEN manip4b = 0: GOTO 909094
INPUT "4th nav"; manip4b

909094
manip1a$ = CHR$(manip1a)
manip1b$ = CHR$(manip1b)
manip2a$ = CHR$(manip2a)
manip2b$ = CHR$(manip2b)
manip3a$ = CHR$(manip3a)
manip3b$ = CHR$(manip3b)
manip4a$ = CHR$(manip4a)
manip4b$ = CHR$(manip4b)

REM continue
null$ = CHR$(255)
zero$ = CHR$(0)

INPUT "What's the 1st ship image to load"; image1
INPUT "And the 2nd"; image2
image1$ = CHR$(image1)
image2$ = CHR$(image2)
IF image1 = 255 THEN PUT #1, offset + 54, null$
IF image2 = 255 THEN PUT #1, offset + 56, null$

PRINT
PRINT
PRINT "You must now insert the 10 ships that are present in this nav"
INPUT "What's the 1st ship (type 255 to <none>)"; ship1
INPUT "And the 2nd"; ship2
INPUT "And the 3rd"; ship3
INPUT "And the 4th"; ship4
INPUT "And the 5th"; ship5
INPUT "And the 6th"; ship6
INPUT "And the 7th"; ship7
INPUT "And the 8th"; ship8
INPUT "And the 9th"; ship9
INPUT "And the 10th"; ship10

ship1$ = CHR$(ship1)
ship2$ = CHR$(ship2)
ship3$ = CHR$(ship3)
ship4$ = CHR$(ship4)
ship5$ = CHR$(ship5)
ship6$ = CHR$(ship6)
ship7$ = CHR$(ship7)
ship8$ = CHR$(ship8)
ship9$ = CHR$(ship9)
ship10$ = CHR$(ship10)

IF ship1 = 255 THEN PUT #1, offset + 58, null$
IF ship2 = 255 THEN PUT #1, offset + 60, null$
IF ship3 = 255 THEN PUT #1, offset + 62, null$
IF ship4 = 255 THEN PUT #1, offset + 64, null$
IF ship5 = 255 THEN PUT #1, offset + 66, null$
IF ship6 = 255 THEN PUT #1, offset + 68, null$
IF ship7 = 255 THEN PUT #1, offset + 70, null$
IF ship8 = 255 THEN PUT #1, offset + 72, null$
IF ship9 = 255 THEN PUT #1, offset + 74, null$
IF ship10 = 255 THEN PUT #1, offset + 76, null$

IF ship1 <> 255 THEN PUT #1, offset + 58, zero$
IF ship2 <> 255 THEN PUT #1, offset + 60, zero$
IF ship3 <> 255 THEN PUT #1, offset + 62, zero$
IF ship4 <> 255 THEN PUT #1, offset + 64, zero$
IF ship5 <> 255 THEN PUT #1, offset + 66, zero$
IF ship6 <> 255 THEN PUT #1, offset + 68, zero$
IF ship7 <> 255 THEN PUT #1, offset + 70, zero$
IF ship8 <> 255 THEN PUT #1, offset + 72, zero$
IF ship9 <> 255 THEN PUT #1, offset + 74, zero$
IF ship10 <> 255 THEN PUT #1, offset + 76, zero$


REM save nav
PUT #1, offset, label$
PUT #1, offset + 30, dominant$
PUT #1, offset + 32, navxcoordbyte1$
PUT #1, offset + 33, navxcoordbyte2$
PUT #1, offset + 34, navxcoordbyte3$

PUT #1, offset + 36, navycoordbyte1$
PUT #1, offset + 37, navycoordbyte2$
PUT #1, offset + 38, navycoordbyte3$

PUT #1, offset + 40, navzcoordbyte1$
PUT #1, offset + 41, navzcoordbyte2$
PUT #1, offset + 42, navzcoordbyte3$

PUT #1, offset + 45, manip1a$
PUT #1, offset + 46, manip1b$

PUT #1, offset + 47, manip2a$
PUT #1, offset + 48, manip2b$

PUT #1, offset + 49, manip3a$
PUT #1, offset + 50, manip3b$

PUT #1, offset + 51, manip4a$
PUT #1, offset + 52, manip4b$

PUT #1, offset + 53, image1$
PUT #1, offset + 55, image2$

PUT #1, offset + 57, ship1$
PUT #1, offset + 59, ship2$
PUT #1, offset + 61, ship3$
PUT #1, offset + 63, ship4$
PUT #1, offset + 65, ship5$
PUT #1, offset + 67, ship6$
PUT #1, offset + 69, ship7$
PUT #1, offset + 71, ship8$
PUT #1, offset + 73, ship9$
PUT #1, offset + 75, ship10$

GOTO 1

1234

CLS
FOR listships = 0 TO 31


IF listships = 0 THEN offset = 151325: GOTO 2345
offset = 151325 + 42 * listships

IF listships = 7 THEN PRINT : INPUT "Press any key to continue...", lixo: CLS
IF listships = 16 THEN PRINT : INPUT "Press any key to continue...", lixo: CLS
IF listships = 25 THEN PRINT : INPUT "Press any key to continue...", lixo: CLS


2345

GET #1, offset, shipship$
GET #1, offset + 2, shipiff$
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
GET #1, offset + 28, shipspeed$
GET #1, offset + 29, shipsize$
GET #1, offset + 32, shippilot$
GET #1, offset + 39, shipsectarget$
GET #1, offset + 40, shipformation$
GET #1, offset + 41, shippritarget$
                        

PRINT "Ship"; listships; ":";
IF shipship$ = CHR$(0) THEN PRINT "Hornet";
IF shipship$ = CHR$(1) THEN PRINT "Rapier";
IF shipship$ = CHR$(2) THEN PRINT "Scimitar";
IF shipship$ = CHR$(3) THEN PRINT "Raptor";
IF shipship$ = CHR$(4) THEN PRINT "Venture";
IF shipship$ = CHR$(5) THEN PRINT "Dilligent";
IF shipship$ = CHR$(6) THEN PRINT "Drayman";
IF shipship$ = CHR$(7) THEN PRINT "Exeter";
IF shipship$ = CHR$(8) THEN PRINT "Tiger's Claw";
IF shipship$ = CHR$(9) THEN PRINT "Salthi";
IF shipship$ = CHR$(10) THEN PRINT "Dralthi";
IF shipship$ = CHR$(11) THEN PRINT "Krant";
IF shipship$ = CHR$(12) THEN PRINT "Gratha";
IF shipship$ = CHR$(13) THEN PRINT "Jalthi";
IF shipship$ = CHR$(14) THEN PRINT "Hhriss";
IF shipship$ = CHR$(15) THEN PRINT "Dorkir";
IF shipship$ = CHR$(16) THEN PRINT "Lumbari";
IF shipship$ = CHR$(17) THEN PRINT "Ralari";
IF shipship$ = CHR$(18) THEN PRINT "Fralthi";
IF shipship$ = CHR$(19) THEN PRINT "Snakeir";
IF shipship$ = CHR$(20) THEN PRINT "Sivar";
IF shipship$ = CHR$(21) THEN PRINT "Starpost";
IF shipship$ = CHR$(22) THEN PRINT "Asteroid Field";
IF shipship$ = CHR$(23) THEN PRINT "Mine Field";
IF shipship$ = CHR$(255) THEN PRINT "<Unused>";

IF shipiff$ = CHR$(0) THEN PRINT " is Confed";
IF shipiff$ = CHR$(1) THEN PRINT " is Kilrathi";
IF shipiff$ = CHR$(2) THEN PRINT " is IFF 2";

IF shiporders$ = CHR$(2) THEN PRINT " and will attack"; : PRINT " ships"; ASC(shippritarget$); "and"; ASC(shipsectarget$)
IF shiporders$ = CHR$(4) THEN PRINT " and will follow leader"; : PRINT " in ship"; ASC(shippritarget$)
IF shiporders$ = CHR$(7) THEN PRINT ",will jump in"; : PRINT " and head for nav"; ASC(shippritarget$)
IF shiporders$ = CHR$(6) THEN PRINT " and will jump out"; : PRINT " at nav"; ASC(shippritarget$)
IF shiporders$ = CHR$(0) THEN PRINT " and will attack"; : PRINT " ships"; ASC(shippritarget$); "and"; ASC(shipsectarget$)
IF shiporders$ = CHR$(255) THEN PRINT " and is inactive.";

PRINT " It's being flown by ";
IF shippilot$ = CHR$(0) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(1) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(2) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(3) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(4) THEN PRINT "Generic Pilot"
IF shippilot$ = CHR$(5) THEN PRINT "Spirit"
IF shippilot$ = CHR$(6) THEN PRINT "Hunter"
IF shippilot$ = CHR$(7) THEN PRINT "Bossman (Jazz on sm2)"
IF shippilot$ = CHR$(8) THEN PRINT "Iceman"
IF shippilot$ = CHR$(9) THEN PRINT "Angel"
IF shippilot$ = CHR$(10) THEN PRINT "Paladin (Doomsday in sm2)"
IF shippilot$ = CHR$(11) THEN PRINT "Maniac"
IF shippilot$ = CHR$(12) THEN PRINT "Knight"
IF shippilot$ = CHR$(13) THEN PRINT "Blair"
IF shippilot$ = CHR$(14) THEN PRINT "Bhurak Starkiller (Drakhai on sm2)"
IF shippilot$ = CHR$(15) THEN PRINT "Dakhath Deathstroke (Drakhai on sm2)"
IF shippilot$ = CHR$(16) THEN PRINT "Khajja The Fang (Drakhai on sm2)"
IF shippilot$ = CHR$(17) THEN PRINT "Bakhtosh Redclaw (Drakhai on sm2)"
PRINT "Ship speed: "; ASC(shipspeed$) * 10; " m/s"
NEXT listships


INPUT "Press ENTER to return to the main menu", lixo
GOTO 1

55555
REM Nav point description
CLS

INPUT "What's the NAV description number (starting with 0)"; dnumber
icon$ = " ": ship$ = " ": l$ = " "

IF dnumber = 0 THEN offset = 84509: GOTO 55556
offset = 84509 + 64 * dnumber

55556
switch = 0
label$ = " "
FOR i = 0 TO 58
GET #1, offset + 4 + i, l$
IF l$ <> CHR$(0) AND switch = 0 THEN label$ = label$ + l$
IF l$ = CHR$(0) THEN label$ = label$ + CHR$(0): switch = 1
NEXT i

GET #1, offset, icon$
GET #1, offset + 2, ship$

PRINT : PRINT
PRINT "This nav has the following description: "
PRINT "' "; label$; " '"
PRINT : PRINT
PRINT "It's icon in the nav map is ";
IF ASC(icon$) = 0 THEN PRINT "a green square";
IF ASC(icon$) = 1 THEN PRINT "a white triangle (home base icon)";
IF ASC(icon$) = 2 THEN PRINT "a purple cross (friendly ship icon)";
IF ASC(icon$) = 3 THEN PRINT "a green circle (friendly ship icon)";
IF ASC(icon$) = 4 THEN PRINT "a red circle (ememy ship icon)";

IF ASC(icon$) = 0 THEN PRINT " and represents NAV "; ASC(ship$)
IF ASC(icon$) <> 0 THEN PRINT " and represents ship "; ASC(ship$)

INPUT "Change it "; choice$

IF choice$ = "n" THEN GOTO 1

INPUT "Do you want to deactivate this description"; choice$
IF choice$ = "y" THEN null$ = CHR$(255) + CHR$(255) + CHR$(255) + CHR$(0) + CHR$(0) + CHR$(0) + CHR$(0): PUT #1, offset, null$: GOTO 1

CLS
INPUT "What's the description"; label$
label$ = label$ + CHR$(0) + CHR$(0)
CLS
PRINT "You now have 5 icons:"
PRINT "0 - Green Square"
PRINT "1 - White Triangle"
PRINT "2 - Purple Cross"
PRINT "3 - Green Circle"
PRINT "4 - Red Circle"
PRINT
PRINT "The Green Square represents a NAV and all the others represent a ship."
INPUT "What icon do you want (enter number)"; icon
icon$ = CHR$(icon)
PRINT
INPUT "What's the number of the NAV/ship represented"; ship
ship$ = CHR$(ship)

PUT #1, offset, icon$
PUT #1, offset + 2, ship$
PUT #1, offset + 4, label$
GOTO 1

