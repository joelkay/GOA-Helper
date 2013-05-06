mob
	var
		clevel
		stamina
		staminaregen=17

		chakra
		chakraregen=50

		wounds=100

		str
		strbuff
		strneg

		con
		conbuff
		conneg

		rfx
		rfxbuff
		rfxneg

		int
		intbuff
		intneg

		skillpoints=0
		maxskillpoints
		supplies=100

	Stat()
		var/regenmult=1

		if(skillspassive[3])
			regenmult*=0.03*skillspassive[3] + 1

		var/chakramult=1
		if(skillspassive[22])
			chakramult*=0.04*skillspassive[22] + 1

		stat("Clan",":[clan]")

		stat("Level","[clevel]/100")

		stat("Stamina","[stamina]/[stamina] (+[round(staminaregen*regenmult)] regen/s")

		stat("Chakra","[chakra*chakramult]/[chakra*chakramult] (+[round(chakraregen*regenmult)] regen/s)")

		stat("Wounds","[round(wounds/100*100)]%")

		stat("Strength","[round(str+strbuff-strneg)]")

		stat("Control", "[round(con+conbuff-conneg)]")

		stat("Reflex", "[round(rfx+rfxbuff-rfxneg)]")

		stat("Intelligence", "[round(int+intbuff-intneg)]")

		stat("SkillPoints", "[skillpoints]")


		stat("-DAMAGE- ","-INFORMATION-")

		var/critmult
		if(usr.skillspassive[2])//BETTER CRITS
			critmult=1+(usr.skillspassive[2]/10)

		var/mult
		if(usr.skillspassive[16])//BLINDSIDE
			mult=1+(usr.skillspassive[16]/10)

		var/suppmult
		if(usr.skillspassive[15])//SUPPLY PASSIVE
			suppmult=20*usr.skillspassive[15]

		stat("Supplies", "[supplies+suppmult]%")

		var/strmult=str/150
		var/normalhitmin=75 * strmult
		var/normalhitmax=150 * strmult
		stat("Taijutsu Normal", "[normalhitmin] - [normalhitmax]")
		var/criticalhitmin=round((str*(15/10))*critmult)
		var/criticalhitmax=round((str*(40/10))*critmult)
		stat("Taijutsu Critical", "[normalhitmin+criticalhitmin] - [normalhitmax+criticalhitmax]")
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		if(usr.skillspassive[16])//BLINDSIDE
			stat("Normal Blindside", "[normalhitmin*mult] - [normalhitmax*mult]")
			stat("Critical Blindside", "[normalhitmin+criticalhitmin*mult] - [normalhitmax+criticalhitmax*mult]")
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		var/kunaimin=rfx*10/10
		var/kunaimax=rfx*14/10
		stat("Kunai Melee", "[kunaimin] - [kunaimax]")
		/////////////////////////////////////////////////////
		if(usr.skillspassive[16])//BLINDSIDE
			stat("Kunai Blindside", "[kunaimin*mult] - [kunaimax*mult]")






/////////////////////////////////////////////////////////////////////////////////////
var/griditems

mob/proc/UpdateSkills()
	var/items = 0
	for(var/Jutsu/O in src.contents)
		//if(equipment && O.slot && equipment[O.slot]==O)
		//continue   // don't show equipped items
		winset(src, "skills", "current-cell=[++items]")
		src << output(O, "skills")
	winset(src, "skills", "cells=[items]")  // cut off any remaining cells