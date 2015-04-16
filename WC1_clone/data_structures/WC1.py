#create data structures specifically relevant to WC1
#pilots, briefings, animations, etc.

player_callsign = "Omega"

ranks = []
ranks.append(Rank("Second Lieutennant", insignia=None, "Lieutennant", "2Lt"))
ranks.append(Rank("First Lieutennant", insignia=None, "Lieutennant", "1Lt"))
ranks.append(Rank("Captain", insignia=None, "Captain", "Cpn"))
ranks.append(Rank("Major", insignia=None, "Major", "Maj"))
ranks.append(Rank("Lieutennant Colonel", insignia=None, "Colonel", "Lt. Col."))

#medals
medals = []
medals.append(Medal("Bronze Star", None))
medals.append(Medal("Silver Star", None))
medals.append(Medal("Gold Star", None))
medals.append(Medal("Golden Sun", None))
medals.append(Medal("Pewter Planet", None))

#ribbons
ribbons = []
ribbons.append(Ribbon("ACAD", None))
ribbons.append(Ribbon("FLTS", None))
ribbons.append(Ribbon("VEGA", None))
ribbons.append(Ribbon("HORN", None))
ribbons.append(Ribbon("RPIR", None))
ribbons.append(Ribbon("SCIM", None))
ribbons.append(Ribbon("RAPT", None))
ribbons.append(Ribbon("ACE", None))
ribbons.append(Ribbon("AOFA", None))
ribbons.append(Ribbon("5 M", None))
ribbons.append(Ribbon("10 M", None))
ribbons.append(Ribbon("15 M", None))

#pilots
pilots = []
pilots.append(PilotCharacter("Tanaka", "Mariko", "Spirit", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[1], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Ian", "St. John", "Hunter", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[2], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Chen", "Kien", "Bossman", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[3], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Michael", "Casey", "Iceman", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[3], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Jeannette", "Devereaux", "Angel", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[2], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("James", "Taggart", "Paladin", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[3], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Todd", "Marshall", "Maniac", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[0], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Joseph", "Khumalo", "Knight", mission_count=0, kill_count=0, prev_mission_kills=0, ranks[2], talking_head=None, flight_AI=None))
pilots.append(PilotCharacter("Christopher", "Blair", player_callsign, mission_count=0, kill_count=0, prev_mission_kills=0, ranks[0], talking_head=None, flight_AI=None))
player = pilots[-1]

#aces
aces = []
aces.append(EnemyAce("Bhurak", "Starkiller", None))
aces.append(EnemyAce("Dakhath", "Deathstroke", None))
aces.append(EnemyAce("Khajja", "the Fang", None))
aces.append(EnemyAce("Baron Bakhtosh", "Redclaw", None))

##music

##images

##animations

##killboard
##pin-up
##closet
##simulator

#rooms
rooms = []

#bar
##define images, animations, music, hotspots
rooms.append(RoomScreen())

#barracks
##define images, animations, music, hotspots
rooms.append(Roomscreen())

#missions

#savegames