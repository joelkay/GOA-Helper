//passives
mob
	var
		skillspassive[40]


client/var/list/passive_imgs=new/list()
client/var/list/_passive_cache=new/list()
client/proc/Passive_Refresh(var/obj/gui/passives/Of)
	_passive_cache.len = mob.skillspassive.len
	passive_imgs.len = mob.skillspassive.len
	var/lvln=mob.skillspassive[Of.pindex]
	if(!lvln || lvln < 0)
		lvln = 0
	if(_passive_cache[Of.pindex] == lvln)
		return

	for(var/image/I in passive_imgs[Of.pindex])
		images -= I

	var/lvl="[lvln]"

	if(length(lvl)<=1)
		var/image/I=Of.digit1[lvl]
		passive_imgs[Of.pindex] = list(I)
		src << I
		_passive_cache[Of.pindex] = lvln

	else
		var/dig1=copytext(lvl,1,2)
		var/dig2=copytext(lvl,2)
		var/image/I1=Of.digit1["[dig2]"]
		var/image/I2=Of.digit2["[dig1]"]
		passive_imgs[Of.pindex] = list(I1, I2)
		src << I1
		src << I2
		_passive_cache[Of.pindex] = lvln



obj/gui/passives
	icon='gui.dmi'
	icon_state="bland"
	var/list/digit1=new/list()
	var/list/digit2=new/list()
	var/disc
	var/pindex=0
	var/max=0
	New()
		..()

		digit1["1"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="1",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["2"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="2",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["3"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="3",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["4"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="4",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["5"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="5",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["6"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="6",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["7"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="7",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["8"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="8",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["9"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="9",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit1["0"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="0",pixel_x=16,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["1"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="1",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["2"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="2",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["3"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="3",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["4"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="4",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["5"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="5",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)
		digit2["0"]=new/image('fonts/Cambria8ptblk.dmi',loc=src.loc,icon_state="0",pixel_x=10,pixel_y=-20,layer=MOB_LAYER+10)

	Click()
		if(istype(src,/obj/gui/passives/gauge))
			return

		switch(input2(usr,"[src.name]:[src.disc]  ([usr.skillspassive[src.pindex]]/[src.max])", "Skill",list("Buy Passive","Remove Passive","Nevermind")))//,
			if("Buy Passive")
				var/client/C=usr.client
				if(pindex)
					if(istype(src,/obj/gui/passives/str))
						if(usr.skillspassive[25]>=1 && usr.skillspassive[src.pindex]<src.max)
							usr.skillspassive[25]--
							usr.skillspassive[src.pindex]++
							usr<<"Bought passive!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==25)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to buy Passive"

					if(istype(src,/obj/gui/passives/rfx))
						if(usr.skillspassive[26]>=1 && usr.skillspassive[src.pindex]<src.max)
							usr.skillspassive[26]--
							usr.skillspassive[src.pindex]++
							usr<<"Bought passive!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==26)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to buy Passive"
					if(istype(src,/obj/gui/passives/int))
						if(usr.skillspassive[27]>=1 && usr.skillspassive[src.pindex]<src.max)
							usr.skillspassive[27]--
							usr.skillspassive[src.pindex]++
							usr<<"Bought Passive!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==27)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to buy Passive"
					if(istype(src,/obj/gui/passives/con))
						if(usr.skillspassive[28]>=1 && usr.skillspassive[src.pindex]<src.max)
							usr.skillspassive[28]--
							usr.skillspassive[src.pindex]++
							usr<<"Bought Passive!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==28)
									if(C)C.Passive_Refresh(Q)

						else
							usr<<"Failed to buy Passive"
				if(C)C.Passive_Refresh(src)

			if("Remove Passive")
				var/client/C=usr.client
				if(pindex)
					if(istype(src,/obj/gui/passives/str))
						if(usr.skillspassive[src.pindex]>=1)
							usr.skillspassive[25]++
							usr.skillspassive[src.pindex]--
							usr<<"passive refunded!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==25)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to refund Passive"

					if(istype(src,/obj/gui/passives/rfx))
						if(usr.skillspassive[src.pindex]>=1)
							usr.skillspassive[26]++
							usr.skillspassive[src.pindex]--
							usr<<"passive refunded!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==26)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to buy Passive"
					if(istype(src,/obj/gui/passives/int))
						if(usr.skillspassive[src.pindex]>=1)
							usr.skillspassive[27]++
							usr.skillspassive[src.pindex]--
							usr<<"passive refunded!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==27)
									if(C)C.Passive_Refresh(Q)
						else
							usr<<"Failed to refund Passive"
					if(istype(src,/obj/gui/passives/con))
						if(usr.skillspassive[src.pindex]>=1)
							usr.skillspassive[28]++
							usr.skillspassive[src.pindex]--
							usr<<"passive refunded!"
							for(var/obj/gui/passives/gauge/Q in world)
								if(Q.pindex==28)
									if(C)C.Passive_Refresh(Q)

						else
							usr<<"Failed to refund Passive"
				if(C)C.Passive_Refresh(src)





	gauge
		str
			pindex=25
		rfx
			pindex=26
		int
			pindex=27
		con
			pindex=28
	str
		Better_Criticals
			max=10
			pindex=2
			disc="For every level of this passive, Critical hits do +10% damage"

		Built_Solid
			max=10
			pindex=9
			disc="For every level of this passive, taijutsu daze resistance is increased by 8%"

		Piercing_Strike
			max=20
			pindex=10
			disc="For every level of this passive, 3% of Taijutsu damage blows through all forms of defence."

		Impact
			max=10
			pindex=11
			disc="For every level of this passive, Daze effect duration is increased by 10%"

		Deflection
			max=20
			pindex=12
			disc="For every level of this passive, there is a 3% chance per point of wound damage to convert 1 wound damage into 120 stamina damage."

		Combo
			max=5
			pindex=13
			disc="Stackable Effect; every taijutsu attack does +20% extra damage than the last until you are hit. Stack limit is 1 + the level of this passive."
	rfx
		Weak_Spot
			max=5
			pindex=14
			disc="5% Chance on Hit for projectiles to cause 1-4 wound damage per level of this passive."

		Projectile_Master
			max=10
			disc="+20 Max Supply capacity for every level of this passive."
			pindex=15

		Blindside
			max=10
			pindex=16
			disc="For every level of this passive, All damage done to an opponent who has not targeted you is increased by 10%"

		Speed_Demon
			max=5
			pindex=4
			disc="For every level of this passive, the stun after using Shunshin is reduced by 20%"

		Rend
			max=10
			pindex=17
			disc="Knives and Swords have a 3% COH to cause serious bleeding damage per level of this passive."

		Sword_Mastery
			max=20
			pindex=18
			disc="For every level of this passive, Sword damage increased by 3%"
	int
		Tracking
			max=3
			pindex=8
			disc="Each level of this passive dramatically increases the range and number of targets that you can track.  Offscreen targets will show up on the map."
		Analytical
			max=3
			pindex=7
			disc="Each level of this passive increases the information given to you about your opponent when you target them."
		Genjutsu_Mastery
			max=20
			pindex=19
			disc="Each level of this passive increases intelligence by 5% for purposes of Genjutsu effects."
		Kawa_Mastery
			icon='kawapassive.dmi'
			max=5
			pindex=20
			disc="Each level of this passive increases the duration of body replacement,reduces the cooldown and increases the range."
		Bunshin_Mastery
			max=20
			pindex=1
			disc="For every level of this passive, Int is increased by 5% for the purpose of Bunshin targeting tricks."
		Concentration
			max=20
			pindex=21
			disc="The first level of this passive enables Genjutsu resistance and canceling. Each subequent level of this passive increases control by 5% for the purpose of resisting and canceling Genjutsu."
	con
		Efficiency
			max=5
			pindex=5
			disc="Each level of this passive reduces chakra costs for skills by 4%"

		Powerhouse
			max=5
			pindex=22
			disc="Each level of this passive increases maximum chakra by 4% but does not impact regeneration"

		Medic_Training
			max=20
			pindex=23
			disc="For each level of this passive, Wound healing effects from the medic skill are increased by 5%"

		Pure_Power
			max=20
			pindex=24
			disc="For each level of this passive, Con for the purpose of Ninjutsu damage is increased by 5%"

		Regeneration
			pindex=3
			disc="For each level of this passive, Chakra and Stamina regenerate 3% faster."
			max=15

		Hand_Seal_Mastery
			pindex=6
			max=10
			disc="For each level of this passive, cooldowns for skills are reduced by 3%"

