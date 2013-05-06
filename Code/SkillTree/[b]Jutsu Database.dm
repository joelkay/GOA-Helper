Jutsu
	parent_type= /obj
	var/sname//jutsu name
	var/descr//description of the skill

	var/chakracost=0//how much chakra
	var/staminacost=0//how much stamina

	var/skillcost//how many skillpoints
	var/cooldown//cooldown for the jutsu
	var/formula=""//jutsu formula to work out damage

	var/skill_reqs //list of jutsus needed.
	icon='gui.dmi'

	var/sindex=""//jutsu INDEX
	var/element=""//element
	var/nonclick=0//clan displays
/*
	mouse_drag_pointer ='drag.dmi'

	MouseDrop(obj/Drop/over_object)
		if(nonclick)return

		if(istype(over_object,/obj/Drop))
			over_object.oneloop=0
			over_object.Run(usr,src)
*/


	Click()
		if(nonclick)return
		var/srccost=src.skillcost

		var/newcool=cooldown
		var/newcost=chakracost
		if(usr.skillspassive[6])
			newcool = round(cooldown * (1 - usr.skillspassive[6] * 0.03))

		if(usr.skillspassive[5])
			newcost = round(chakracost * (1 - usr.skillspassive[5] * 0.04))

		var/description = {"
		<html>
		<body bgcolor="#763900">
		<b><font color=#877871>Ability:<font color=#cfc9c6> [src.sname]</b></br>
		<font color=#877871>Description</font><font color=#cfc9c6>: [src.descr]</br>
		<font color=#877871>Cooldown</font><font color=#cfc9c6>: [newcool]</br>
		"}
		if(element)
			var/value
			switch(usr.elements.len)
				if(0)
					value=250
				if(1)
					value=450
				if(2)
					value=650
				if(3)
					value=850
				else // 4
					value=1050
			description+= {"
			<font color=#877871>Skill Point Cost</font><font color=#cfc9c6>: [value]</br>
			"}
		else
			description+= {"
			<font color=#877871>Skill Point Cost</font><font color=#cfc9c6>: [srccost]</br>
			"}

		if(src.chakracost)
			description+= {"
			<font color=#877871>Chakra Cost</font><font color=#cfc9c6>: [newcost]</br>
			"}

		if(src.staminacost)
			description+= {"
			<font color=#877871>Stamina Cost</font><font color=#cfc9c6>: [src.staminacost]</br>
			"}


		if(src.sindex in usr.jutsulist)//PREVENT SALE OF FOUR STARTERS!!!!!
			if(sindex=="KAWARIMI"||sindex=="HENGE"||sindex=="BUNSHIN"||sindex=="SHUNSHIN"||sindex=="EXPLODING_NOTE")
				if(debug)src<<"GG"
				usr << browse(description,"window=plannerb")
				return

			else
				description+= {"
				<i><a href='?src=\ref[usr];action=sell;cost=[srccost];name=[sname];element=[element]'>Sell Skill</a></font>
				"}
				usr << browse(description,"window=plannerb")
				return

		else
			if(src.skillcost==0)
				if(debug)src<<"GG"
				usr << browse(description,"window=plannerb")
				return

			else

				description+= {"
				<i><a href='?src=\ref[usr];action=buy;cost=[srccost];name=[sname];element=[element]'>Buy Skill</a></font>
				"}
				usr << browse(description,"window=plannerb")
				return







		/*
		if(srccost)
			var/has_clan = 1
			if(clan_reqs)
				for(var/req_clan in clan_reqs)
					if(usr.clan != req_clan)
						has_clan = 0
						break

			if(has_clan)
				if(sindex > 0)
					if(!usr:HasSkill(sindex))
						options += "Buy Skill"
				else if(element)
					if(!(element in usr.elements))
						options += "Buy Skill"
		*/
	Akimichi
		nonclick=1
		icon_state="Akimichi"
		sindex = "AKIMICHI"

	Clone
		icon_state="bunshin"
		sname="Clone"
		descr="Creates a clone to distract your enemies."
		chakracost = 80
		skillcost = 50
		cooldown = 21
		sindex = "BUNSHIN"

	Size_Multiplication
		icon_state="sizeup"
		descr={"A skill of the Akimichi clan
	Increases your size.
		Although you become slower, your punches reach farther and do more damage.
		"}
		chakracost = 400
		cooldown = 200
		sname="Size Multiplication"
		sindex = "SIZEUP1"
		skillcost = 800
		skill_reqs = list("AKIMICHI")

	Super_Size_Multiplication
		icon_state="sizeup"
		descr="Creates a clone to distract your enemies."
		chakracost = 500
		cooldown = 200
		sname="Super Size Multiplication"
		sindex = "SIZEUP2"
		skillcost = 1500
		skill_reqs = list("SIZEUP1","AKIMICHI")

	Human_Bullet_Tank
		icon_state="meattank"
		descr={"A skill of the Akimichi clan
	Although you cannot stop moving in this state, you can roll over your enemies!
		"}
		chakracost = 300
		cooldown = 30
		sname="Human Bullet Tank"
		sindex = "MEAT_TANK"
		skillcost = 600
		skill_reqs = list("AKIMICHI")

	Spinach_Pill
		icon_state="spinach"
		descr={"A skill of the Akimichi clan
		A green pill. Eating it increases your strength and stamina regen, but you start taking internal damage.
		"}
		chakracost = 0
		cooldown = 5
		sname="Spinach Pill"
		sindex = "SPINACH_PILL"
		skillcost = 800
		skill_reqs = list("AKIMICHI")

	Curry_Pill
		icon_state="curry"
		descr={"A skill of the Akimichi clan
		A yellow pill. Eating it increases your strength and stamina regen even higher, but you start taking significant internal damage.
		"}
		chakracost = 0
		cooldown = 5
		sname="Size up"
		sindex = "CURRY_PILL"
		skillcost = 1200
		skill_reqs = list("SPINACH_PILL","AKIMICHI")


	Deidara
		nonclick=1
		icon_state="diedara"
		sindex = "CLAY"

	Exploding_Bird
		icon_state="exploading bird"
		descr={"A skill of the Deidara clan. Creates a small bird of explosive clay that follows your target.
		"}
		chakracost = 270
		cooldown = 15
		sname="Exploding Bird"
		sindex = "EXPLODING_BIRD"
		skillcost = 800
		skill_reqs = list("CLAY")

	Exploding_Spider
		icon_state="exploading spider"
		descr={"A skill of the Deidara clan
	Creates a spider from explosive clay that can be ordered to move around with your mouse.
		 It will seek out your target after a short delay. You can prevent this effect by holding the SHIFT key on activation.
		"}
		chakracost = 350
		cooldown = 45
		sname="Exploding Spider"
		sindex = "EXPLODING_SPIDER"
		skillcost = 800
		skill_reqs = list("CLAY")

	C3
		icon_state="c3"
		descr={"A skill of the Deidara clan
	Creates a giant statue of explosive clay that KOs anyone in the area when it goes off!
		"}
		chakracost = 800
		cooldown = 160
		sname="C3"
		sindex = "C3"
		skillcost = 3500
		skill_reqs = list("EXPLODING_BIRD", "EXPLODING_SPIDER","CLAY")


	Haku
		nonclick=1
		icon_state="haku"
		sindex = "HAKU"

	Sensatsusuisho
		icon_state="ice_needles"
		descr={"A skill of the Haku clan
	Creates needles of ice that pierce your enemy.
		 Uses 2.5x more chakra if there is no water nearby.
		"}
		chakracost = 500
		cooldown = 30
		sname="Ice Needles"
		sindex = "ICE_NEELDES"
		skillcost = 800
		skill_reqs = list("HAKU")

	Ice_Explosion
		icon_state="ice_spike_explosion"
		descr={"A skill of the Haku clan
	Creates many spikes of ice that protect you from your enemies after damaging anyone near by.
		"}
		chakracost = 350
		cooldown = 80
		sname="Ice Explosion"
		sindex = "ICE_SPIKE_EXPLOSION"
		skillcost = 1500
		skill_reqs = list("ICE_NEELDES","HAKU")

	Demonic_Ice_Crystal_Mirrors
		icon_state="demonic_ice_mirrors"
		descr={"A skill of the Haku clan
		Creates mirrors of ice that hide you from your enemies. Anyone caught inside the mirrors is pierced by many needles!
		"}
		chakracost = 550
		cooldown = 180
		sname="Demonic Ice Crystal Mirrors"
		sindex = "DEMONIC_ICE_MIRRORS"
		skillcost = 2500
		skill_reqs = list("ICE_SPIKE_EXPLOSION","HAKU")

	Hyuuga
		nonclick=1
		icon_state="hyuuga"
		sindex = "HYUUGA"

	Byakugan
		icon_state="byakugan"
		descr={"A skill of the Hyuuga clan
	Allows you to use most Hyuuga skills, and boosts your ability to react to unexpected threats.
		"}
		chakracost = 0
		cooldown = 0
		sname="Byakugan"
		sindex = "BYAKUGAN"
		skillcost = 400
		skill_reqs = list("HYUUGA")

	Turning_the_Tide
		icon_state="kaiten"
		descr={"A skill of the Hyuuga clan
	Creates a barrier of rapidly spinning chakra.
		"}
		chakracost = 90
		cooldown = 10
		sname="Eight Trigrams Palm: Turning the Tide"
		sindex = "KAITEN"
		skillcost = 1500
		skill_reqs = list("BYAKUGAN","HYUUGA")

	Palms
		icon_state="64 palms"
		descr={"A skill of the Hyuuga clan
	Blocks off all of your enemy's chakra with precise strikes.
		"}
		chakracost = 500
		cooldown = 120
		sname="Eight Trigrams: 64 Palms"
		sindex = "HAKKE_64"
		skillcost = 3000
		skill_reqs = list("BYAKUGAN","HYUUGA")

	Gentle_Fist
		icon_state="gentle_fist"
		descr={"A skill of the Hyuuga clan
	Allows your normal hits to drain your enemy's chakra and do internal damage.
		"}
		chakracost = 100
		cooldown = 30
		sname="Gentle Fist"
		sindex = "GENTLE_FIST"
		skillcost = 700
		skill_reqs = list("BYAKUGAN","HYUUGA")


	Jashin
		nonclick=1
		icon_state="jashin"
		sindex = "JASHIN"

	Stab_Self
		icon_state="masachism"
		descr={"A skill of the Jashin clan
	Stab yourself to do internal damage to a bound enemy..
		"}
		chakracost = 0
		cooldown = 3
		sname="Stab Self"
		sindex = "MASOCHISM"
		skillcost = 500
		skill_reqs = list("BLOOD_BIND","JASHIN")

	Death_Ruling_Possession_Blood
		icon_state="blood contract"
		descr={"A skill of the Jashin clan
	Binds an enemy to you, transferring all internal damage you take to them as well.
		"}
		chakracost = 450
		cooldown = 200
		sname="Sorcery: Death-Ruling Possession Blood"
		sindex = "BLOOD_BIND"
		skillcost = 1200
		skill_reqs = list("JASHIN")

	Wound_Regeneration
		icon_state="wound regeneration"
		descr={"A skill of the Jashin clan
	Heals your internal wounds.
		"}
		chakracost = 100
		cooldown = 20
		sname="Wound Regeneration"
		sindex = "WOUND_REGENERATION"
		skillcost = 800
		skill_reqs = list("MASOCHISM","JASHIN")

	Immortality
		icon_state="imortality"
		descr={"A skill of the Jashin clan
	Sacrifies a corpse to allow you to continue fighting even when others would be dead.
		"}
		chakracost = 400
		cooldown = 600
		sname="Immortality"
		sindex = "IMMORTALITY"
		skillcost = 1500
		skill_reqs = list("JASHIN")

	Kaguya
		nonclick=1
		icon_state="kaguya"
		sindex = "KAGUYA"

	Piercing_Finger_Bullets
		icon_state="bonebullets"
		descr={"Creates bullets from your finger bones..
		"}
		chakracost = 300
		cooldown = 20
		sname="Piercing Finger Bullets"
		sindex = "BONE_BULLETS"
		skillcost = 1500
		skill_reqs = list("KAGUYA")

	Bone_Harden
		icon_state="bone_harden"
		descr={"A skill of the Kaguya clan
	Creates a layer of hardened bone, blocking most sources of damage..
		"}
		chakracost = 150
		cooldown = 0
		sname="Bone Harden"
		sindex = "BONE_HARDEN"
		skillcost = 1000
		skill_reqs = list("KAGUYA")

	Camellia_Dance
		icon_state="bone_sword"
		descr={"A skill of the Kaguya clan
	Creates a fast sword out of your bone.
		"}
		chakracost = 100
		cooldown = 200
		sname="Camellia Dance"
		sindex = "BONE_SWORD"
		skillcost = 500
		skill_reqs = list("KAGUYA")

	Larch_Dance
		icon_state="bone_spines"
		descr={"A skill of the Kaguya clan
	Creates spikes on your body from bone, damaging anyone who tries to use physical attacks on you.
		 Disables all nonkaguya skills during its duration..
		"}
		chakracost = 100
		cooldown = 45
		sname="Larch Dance"
		sindex = "BONE_SPINES"
		skillcost = 800
		skill_reqs = list("BONE_SWORD","KAGUYA")

	Young_Bracken_Dance
		icon_state="sawarabi"
		descr={"A skill of the Kaguya clan
	Creates spikes from bone, damaging anyone caught in them and making it harder for your enemies to move.
		"}
		chakracost = 200
		cooldown = 120
		sname="Young Bracken Dance"
		sindex = "SAWARIBI"
		skillcost = 2500
		skill_reqs = list("BONE_SPINES", "BONE_BULLETS","KAGUYA")



	Nara
		nonclick=1
		icon_state="nara"
		sindex = "NARA"

	Shadow_Binding
		icon_state="shadow_imitation"
		descr={"Binds your enemies with shadows.
		"}
		chakracost = 100
		cooldown = 40
		sname="Shadow Binding"
		sindex = "SHADOW_IMITATION"
		skillcost = 1100
		skill_reqs = list("NARA")

	Shadow_Neck_Bind
		icon_state="shadow_neck_bind"
		descr={"A skill of the Nara clan
	Chokes your enemies with shadows dealing damage over time.
		 While this is active your shadow bind will consume more chakra.
		"}
		chakracost = 0
		cooldown = 5
		sname="Shadow Neck Bind"
		sindex = "SHADOW_NECK_BIND"
		skillcost = 1500
		skill_reqs = list("SHADOW_IMITATION","NARA")

	Shadow_Sewing
		icon_state="shadow_sewing_needles"
		descr={"Pierces your enemies with needles made of shadow..
		"}
		chakracost = 200
		cooldown = 80
		sname="Shadow Sewing"
		sindex = "SHADOW_SEWING_NEEDLES"
		skillcost = 2000
		skill_reqs = list("SHADOW_NECK_BIND","NARA")



	Puppet
		nonclick=1
		icon_state="puppeteer"
		sindex = "PUPPET"

	First_Puppet
		icon_state="puppet1"
		descr={"A skill of the Puppeteer clan
	Summons a puppet with hidden weapons.
		"}
		chakracost = 0
		cooldown = 60
		sname="Summoning: First Puppet"
		sindex = "PUPPET_SUMMON1"
		skillcost = 700
		skill_reqs = list("PUPPET")

	Second_Puppet
		icon_state="puppet2"
		descr={"A skill of the Puppeteer clan
	Summons a puppet with hidden weapons.
		"}
		chakracost = 0
		cooldown = 60
		sname="Summoning: Second Puppet"
		sindex = "PUPPET_SUMMON2"
		skillcost = 2000
		skill_reqs = list("PUPPET_SUMMON1","PUPPET")

	Puppet_Transform
		icon_state="puppethenge"
		descr={"A skill of the Puppeteer clan
	Transforms your puppet so it looks like you.
		"}
		chakracost = 50
		cooldown = 25
		sname="Puppet Transform"
		sindex = "PUPPET_HENGE"
		skillcost = 350
		skill_reqs = list("PUPPET_SUMMON1","PUPPET")

	Puppet_Swap
		icon_state="puppetswap"
		descr={"A skill of the Puppeteer clan
	Switches your position with that of your puppet.
		"}
		chakracost = 100
		cooldown = 45
		sname="Puppet Swap"
		sindex = "PUPPET_SWAP"
		skillcost = 350
		skill_reqs = list("PUPPET_SUMMON1","PUPPET")


	Gaara
		nonclick=1
		icon_state="sand_control"
		sindex = "SAND"

	Sand_Control
		icon_state="sand_control"
		descr={"Creates a blob of sand that you control..
		"}
		chakracost = 300
		cooldown = 10
		sname="Sand Control"
		sindex = "SAND_SUMMON"
		skillcost = 100


	Desert_Funeral
		icon_state="desert_funeral"
		descr={"A skill of the Sand Control clan
	Crushes your enemy with a blob of sand.
		"}
		chakracost = 400
		cooldown = 120
		sname="Desert Funeral"
		sindex = "DESERT_FUNERAL"
		skillcost = 2000
		skill_reqs = list("SAND_SUMMON")

	Sand_Shield
		icon_state="sand_shield"
		descr={"A skill of the Sand Control clan
	Turns your controlled sand into a shield, blocking most sources of damage.
		"}
		chakracost = 150
		cooldown = 40
		sname="Sand Shield"
		sindex = "SAND_SHIELD"
		skillcost = 800
		skill_reqs = list("SAND_SUMMON")

	Sand_Armor
		icon_state="sand_armor"
		descr={"A skill of the Sand Control clan
	Turns your controlled sand into a shield, blocking most sources of damage..
		"}
		chakracost = 200
		cooldown = 120
		sname="Sand Armor"
		sindex = "SAND_ARMOR"
		skillcost = 1500
		skill_reqs = list("SAND_SHIELD")

	Sand_Shuriken
		icon_state="sand_shuriken"
		descr={"A skill of the Sand Control clan
	Turns your controlled sand into a shield, blocking most sources of damage.
		"}
		chakracost = 400
		cooldown = 40
		sname="Sand Shuriken"
		sindex = "SAND_SHURIKEN"
		skillcost = 1750
		skill_reqs = list("SAND_SUMMON")


	Uchiha
		nonclick=1
		icon_state="uchiha"
		sindex = "UCHIHA"

	Sharingan_2
		icon_state="sharingan1"
		descr={"A skill of the Uchiha clan
		Enhances your vision and genjutsu ability, allowing you to react faster, see when your oppoents use jutsu,
		and detect chakra levels.
		"}
		chakracost = 150
		cooldown = 150
		sname="Sharingan: 2 tomoe:"
		sindex = "SHARINGAN1"
		skillcost = 750
		skill_reqs = list("UCHIHA")

	Sharingan_3
		icon_state="sharingan2"
		descr={"A skill of the Uchiha clan
		Enhances your vision and genjutsu ability, allowing you to react faster, see when your oppoents use jutsu,
		and detect chakra levels.
		"}
		chakracost = 150
		cooldown = 150
		sname="Sharingan: 3 tomoe:"
		sindex = "SHARINGAN2"
		skillcost = 2000
		skill_reqs = list("SHARINGAN1","UCHIHA")

	Sharingan_Copy
		icon_state="sharingancopy"
		descr={"A skill of the Uchiha clan
	Allows you to use a skill that you have previously seen someone use.
		"}
		chakracost = 0
		cooldown = 0
		sname="Sharingan Copy"
		sindex = "SHARINGAN_COPY"
		skillcost = 2500
		skill_reqs = list("SHARINGAN2","UCHIHA")




	Earth
		icon_state="doton"
		descr={"Gives the ability to convert chakra to the Earth element..
		Each additional element you purchase increases the price by 250
		"}
		chakracost = 0
		cooldown = 0
		sname="Earth Element"
		sindex = "EARTH"
		element = "EARTH"
		skillcost = 250

	Water
		icon_state="suiton"
		descr={"Gives the ability to convert chakra to the Water element..
		Each additional element you purchase increases the price by 250
		"}
		chakracost = 0
		cooldown = 0
		sname="Water Element"
		sindex = "WATER"
		element = "WATER"
		skillcost = 250

	Wind
		icon_state="fuuton"
		descr={"Gives the ability to convert chakra to the Wind element..
		Each additional element you purchase increases the price by 250
		"}
		chakracost = 0
		cooldown = 0
		sname="Wind Element"
		sindex = "WIND"
		element = "WIND"
		skillcost = 250

	Fire
		icon_state="katon"
		descr={"Gives the ability to convert chakra to the Fire element..
		Each additional element you purchase increases the price by 250
		"}
		chakracost = 0
		cooldown = 0
		sname="Fire Element"
		sindex = "FIRE"
		element = "FIRE"
		skillcost = 250

	Lightning
		icon_state="raiton"
		descr={"Gives the ability to convert chakra to the Lightning element..
		Each additional element you purchase increases the price by 250
		"}
		chakracost = 0
		cooldown = 0
		sname="Lightning Element"
		sindex = "LIGHTNING"
		element = "LIGHTNING"
		skillcost = 250



	Iron_Skin
		icon_state="doton_iron_skin"
		descr={"Requires the ability to convert chakra to the Earth element
	Hardens your skin, reducing the damage you take from most jutsu..
		"}
		chakracost = 150
		cooldown = 240
		sname="Iron Skin"
		sindex = "DOTON_IRON_SKIN"
		skillcost = 1800
		skill_reqs = list("EARTH")

	Mole_Hiding
		icon_state="molehide"
		descr={"Requires the ability to convert chakra to the Earth element
		Change earth into fine sand by channelling chakra into it, allowing you to dig through it like a mole.
		"}
		chakracost = 300
		cooldown = 120
		sname="Mole Hiding"
		sindex = "MOLE_HIDING"
		skillcost = 700
		skill_reqs = list("EARTH")

	Head_Hunter
		icon_state="headhunt"
		descr={"Requires the ability to convert chakra to the Earth element
	Drag your victim down into the earth, robbing them of their freedom..
		"}
		chakracost = 200
		cooldown = 180
		sname="Head Hunter"
		sindex = "HEAD_HUNTER"
		skillcost = 1100
		skill_reqs = list("MOLE_HIDING","EARTH")

	Dungeon_Chamber_of_Nothingness
		icon_state="Dungeon Chamber of Nothingness"
		descr={"Requires the ability to convert chakra to the Earth element
	Traps your enemy in a dome made of rock.
		"}
		chakracost = 100
		cooldown = 40
		sname="Dungeon Chamber of Nothingness"
		sindex = "DOTON_CHAMBER"
		skillcost = 800
		skill_reqs = list("EARTH")

	Split_Earth_Revolution_Palm
		icon_state="doton_split_earth_turn_around_palm"
		descr={"Requires the ability to convert chakra to the Earth element
	Crushes the rock prison, dealing heavy damage to anyone inside it.
		"}
		chakracost = 250
		cooldown = 100
		sname="Split Earth Revolution Palm"
		sindex = "DOTON_CHAMBER_CRUSH"
		skillcost = 1500
		skill_reqs = list("DOTON_CHAMBER")

	Earth_Flow_River
		icon_state="earthflow"
		descr={"Requires the ability to convert chakra to the Earth element
	Creates a river of mud, sweeping away anyone in its path..
		"}
		chakracost = 400
		cooldown = 60
		sname="Earth Flow River"
		sindex = "DOTON_EARTH_FLOW"
		skillcost = 1900
		skill_reqs = list("EARTH")





	Grand_Fireball
		icon_state="grand_fireball"
		descr={"Requires the ability to convert chakra to the Fire element
			Creates a large fireball, dealing burst damage and damage over time to anyone caught in it..
		"}
		chakracost = 150
		cooldown = 60
		sname="Grand Fireball"
		sindex = "KATON_FIREBALL"
		skillcost = 800
		skill_reqs = list("FIRE")

	Hosenka
		icon_state="katon_phoenix_immortal_fire"
		descr={"Requires the ability to convert chakra to the Fire element
	Throws a small fireball, dealing burst damage and damage over time..
		"}
		chakracost = 250
		cooldown = 10
		sname="Hôsenka"
		sindex = "KATON_PHOENIX_FIRE"
		skillcost = 400
		skill_reqs = list("FIRE")


	Ash_Accumulation_Burning
		sindex = "KATON_ASH_BURNING"
		icon_state="katon_ash_product_burning"
		sname="Ash Accumulation Burning"
		descr={"Requires the ability to convert chakra to the Fire element
			Creates a huge cloud of ash, slowing anyone caught in it.
			Igniting the ash will create rapid explosions across the ash dealing stamina and wound damage.
			"}
		chakracost = 450
		cooldown = 120
		skillcost = 2500
		skill_reqs = list("FIRE")


	Fire_Dragon_Flaming_Projectile
		icon_state="dragonfire"
		descr={"Requires the ability to convert chakra to the Fire element
	Blows a small column of fire, dealing heavy damage to whoever it hits!.
		"}
		chakracost = 500
		cooldown = 70
		sname="Fire Dragon Flaming Projectile"
		sindex = "KATON_DRAGON_FIRE"
		skillcost = 2200
		skill_reqs = list("KATON_PHOENIX_FIRE")


	Coiling_Flame
		icon_state="coilingf"
		descr={"Requires the ability to convert chakra to the Fire element
	Sends a wave of fire forward from your weapon, burning enemies in its path.
		"}
		chakracost = 270
		cooldown = 15
		sname="Coiling Flame"
		sindex = "COILING_FLAME"
		skillcost = 800
		skill_reqs = list("FIRE")



	Nail_Flower
		icon_state="phoenixf"
		descr={"Requires the ability to convert chakra to the Fire element
	Imbues shuriken with fire, setting your foes ablaze.
		"}
		chakracost = 200
		cooldown = 30
		sname="Katon Phoenix Nail Flower"
		sindex = "NAIL_FLOWER"
		skillcost = 1500
		skill_reqs = list("FIRE")





	Chidori
		icon_state="chidori"
		descr={"Requires the ability to convert chakra to the Lightning element
	Pierces through enemies with a quick charge for heavy internal damage.
		"}
		chakracost = 300
		cooldown = 90
		sname="Chidori"
		sindex = "CHIDORI"
		skillcost = 1500
		skill_reqs = list("LIGHTNING")

	Chidori_Spear
		icon_state="raton_sword_form_assasination_technique"
		descr={"Requires the ability to convert chakra to the Lightning element
	Pierces through enemies with a spear of electricity.
		"}
		chakracost = 350
		cooldown = 150
		sname="Chidori Spear"
		sindex = "CHIDORI_SPEAR"
		skillcost = 2500
		skill_reqs = list("LIGHTNING")

	Chidori_Current
		icon_state="chidori_nagashi"
		descr={"Requires the ability to convert chakra to the Lightning element
	Creates a field of electricity surrounding you, damaging anyone near you..
		"}
		chakracost = 100
		cooldown = 30
		sname="Chidori Current"
		sindex = "CHIDORI_CURRENT"
		skillcost = 600
		skill_reqs = list("LIGHTNING")

	Chidori_Needles
		icon_state="chidorisenbon"
		descr={"Requires the ability to convert chakra to the Lightning element
	Charges needles with electricty, temporarily slowing the movements of anyone they hit.
		"}
		chakracost = 300
		cooldown = 30
		sname="Chidori Needles"
		sindex = "CHIDORI_NEEDLES"
		skillcost = 1500
		skill_reqs = list("CHIDORI")

	Four_Pillar_Binding
		icon_state="ratonp"
		descr={"Requires the ability to convert chakra to the Lightning element
	Four giant rock pillars are summoned around the enemy, then shoot bolts of lightning, immobilising the target and doing minimal damage to them.
		"}
		chakracost = 350
		cooldown = 110
		sname="Four Pillar Binding"
		sindex = "FOUR_PILLAR"
		skillcost = 1200
		skill_reqs = list("LIGHTNING")


	False_Darkness
		icon_state="falsed"
		descr={"Requires the ability to convert chakra to the Lightning element
	Releases a piercing lightning attack that will home in on one to three enemies..
		"}
		chakracost = 300
		cooldown = 90
		sname="False Darkness"
		sindex = "FALSE_DARKNESS"
		skillcost = 1500
		skill_reqs = list("CHIDORI_SPEAR")




	Giant_Vortex
		icon_state="giant_vortex"
		descr={" Requires the ability to convert chakra to the Water element
	Creates a small pool of water.
		"}
		chakracost = 200
		cooldown = 60
		sname="Giant Vortex"
		sindex = "SUITON_VORTEX"
		skillcost = 600
		skill_reqs = list("WATER")

	Bursting_Water_Shockwave
		icon_state="exploading_water_shockwave"
		descr={" Requires the ability to convert chakra to the Water element
	Creates a large pool of water.
		"}
		chakracost = 500
		cooldown = 120
		sname="Bursting Water Shockwave"
		sindex = "SUTION_SHOCKWAVE"
		skillcost = 2500
		skill_reqs = list("WATER")

	Water_Dragon_Projectile
		icon_state="water_dragon_blast"
		descr={"Requires the ability to convert chakra to the Water element
	Creates a dragon of water that follows your enemy.
		"}
		chakracost = 100
		cooldown = 90
		sname="Water Dragon Projectile"
		sindex = "SUITON_DRAGON"
		skillcost = 1100
		skill_reqs = list("WATER")

	Collision_Destruction
		icon_state="watercollision"
		descr={"Requires the ability to convert chakra to the Water element
	Traps your enemy in a ball of turbulent water.
		"}
		chakracost = 450
		cooldown = 70
		sname="Collision Destruction"
		sindex = "COLLISION_DESTRUCTION"
		skillcost = 2100
		skill_reqs = list("SUITON_VORTEX")

	Syrup_Capture
		icon_state="suiton_Syrup_Capture_Field"
		descr={" Requires the ability to convert chakra to the Water element
	Creates a small pool of water that is infused with chakra
		, slowing or stopping your opponents in their tracks.
		"}
		chakracost = 500
		cooldown = 160
		sname="Syrup Capture"
		sindex = "SYRUP_CAPTURE"
		skillcost = 1100
		skill_reqs = list("WATER")

	Hidden_Mist
		icon_state="hiddenm"
		descr={"Requires the ability to convert chakra to the Water element
	Create a dense mist which causes your enemies to have difficulty tracking you
		. This costs 200 less chakra if the user is near water.
		"}
		chakracost = 650
		cooldown = 180
		sname="Hidden Mist"
		sindex = "HIDDEN_MIST"
		skillcost = 1500
		skill_reqs = list("WATER")

	Water_Prison
		icon_state="waterp"
		descr={"Requires the ability to convert chakra to the Water element
	Traps your enemy in a prison of water so dense it has been compaired to steel
		"}
		chakracost = 100
		cooldown = 150
		sname="Water Prison"
		sindex = "WATER_PRISON"
		skillcost = 1200
		skill_reqs = list("WATER")

	Water_Bullet
		icon_state="waterb"
		descr={"Requires the ability to convert chakra to the Water element
	Fires a water projectile at your opponent
		"}
		chakracost = 250
		cooldown = 30
		sname="Water Bullet"
		sindex = "WATER_BULLET"
		skillcost = 800
		skill_reqs = list("WATER")




	Pressure_Damage
		icon_state="futon_pressure_damage"
		descr={"Requires the ability to convert chakra to the Wind element
	Blows away enemies with a massive blast of air!
		"}
		chakracost = 300
		cooldown = 120
		sname="Pressure Damage"
		sindex = "FUUTON_PRESSURE_DAMAGE"
		skillcost = 2500
		skill_reqs = list("WIND")

	Blade_of_Wind
		icon_state="blade_of_wind"
		sname="Blade of Wind"
		descr={"Requires the ability to convert chakra to the Wind element
	Slashes your enemy with a sword made of air! Full damage from melee range
   70% damage with a tile between you and your target.
			"}
		chakracost = 450
		cooldown = 90
		skillcost = 1500
		sindex = "FUUTON_WIND_BLADE"
		skill_reqs = list("WIND")



	Great_Breakthrough
		icon_state="great_breakthrough"
		descr={"Requires the ability to convert chakra to the Wind element
	Pushes enemies away with a wave of air.
		"}
		chakracost = 250
		cooldown = 15
		sname="Great Breakthrough"
		sindex = "FUUTON_GREAT_BREAKTHROUGH"
		skillcost = 600
		skill_reqs = list("WIND")

	Refined_Air_Bullet
		icon_state="fuuton_air_bullet"
		descr={"Requires the ability to convert chakra to the Wind element
	Blasts enemies with a ball of compressed air.
		"}
		chakracost = 600
		cooldown = 90
		sname="Refined Air Bullet"
		sindex = "FUUTON_AIR_BULLET"
		skillcost = 2000
		skill_reqs = list("FUUTON_GREAT_BREAKTHROUGH")

	Vacuum_Blade
		icon_state="vacuumb"
		descr={"Requires the ability to convert chakra to the Wind element
			Hurl a flurry of sharp wind bursts at an enemy, causing stamina and wound damage.
		"}
		chakracost = 500
		cooldown = 120
		sname="Vacuum Blade Rush"
		sindex = "VACUUM_BLADE"
		skillcost = 1500
		skill_reqs = list("WIND")





	Shadow_Clone
		icon_state="kagebunshin"
		descr={"Creates a controllable clone to distract your enemies.
		"}
		chakracost = 150
		cooldown = 60
		sname="Shadow Clone"
		sindex = "KAGE_BUNSHIN"
		skillcost = 1500
		skill_reqs = list("BUNSHIN")

	Multiple_Shadow_Clone
		icon_state="taijuu_kage_bunshin"
		descr={"<font color = red>This jutsu is being discontinued.
		"}
		chakracost = 500
		cooldown = 120
		sname="Multiple Shadow Clone"
		sindex = "TAJUU_KAGE_BUNSHIN"
		skillcost = 1800
		skill_reqs = list("MASTERDAN")//xD

	Exploding_Shadow_Clone
		icon_state="exploading bunshin"
		descr={"Creates a controllable clones that explodes when hurt!
		"}
		chakracost = 400
		cooldown = 45
		sname="Exploding Shadow Clone"
		sindex = "EXPLODING_KAGE_BUNSHIN"
		skillcost = 1900
		skill_reqs = list("KAGE_BUNSHIN")

	Shuriken_Shadow_Clone
		icon_state="Shuriken Kage Bunshin no Jutsu"
		descr={"Throws a shuriken that splits into many shuriken.
		"}
		chakracost = 300
		cooldown = 60
		sname="Shuriken Shadow Clone"
		sindex = "SHUIRKEN_KAGE_BUNSHIN"
		skillcost = 1300
		skill_reqs = list("KAGE_BUNSHIN")




	Opening_Gate
		icon_state="gate1"
		descr={"Opens the first limiter gate, increasing your power at the cost of internal damage over time.
		"}
		chakracost = 0
		cooldown = 400
		sname="Opening Gate"
		sindex = "GATE1"
		skillcost = 1500

	Energy_Gate
		icon_state="gate2"
		descr={"Opens the second limiter gate, refreshing your stamina and allowing you to avoid being knocked down at the cost of internal damage over time.
		"}
		chakracost = 0
		cooldown = 400
		sname="Energy Gate"
		sindex = "GATE2"
		skillcost = 1000
		skill_reqs = list("GATE1")

	Life_Gate
		icon_state="gate3"
		descr={"Opens the third limiter gate, further increasing your power, increasing your maximum stamina at the cost of internal damage over time.
		"}
		chakracost = 0
		cooldown = 400
		sname="Life Gate"
		sindex = "GATE3"
		skillcost = 1250
		skill_reqs = list("GATE2")

	Pain_Gate
		icon_state="gate4"
		descr={"Opens the fourth limiter gate, further increasing your power and allowing you to move faster than the eye can see. (35% chance to teleport in front of your target)
		"}
		chakracost = 0
		cooldown = 400
		sname="Pain Gate"
		sindex = "GATE4"
		skillcost = 2000
		skill_reqs = list("GATE3")

	Limit_Gate
		icon_state="gate5"
		descr={"Opens the fifth limiter gate, further increasing your power and speed. (50% chance to teleport in front of your target)
		"}
		chakracost = 0
		cooldown = 400
		sname="Limit Gate"
		sindex = "GATE5"
		skillcost = 1500
		skill_reqs = list("GATE4")

	View_Gate
		icon_state="gate6"
		descr={"Opens the sixth limiter gate, further increasing your power and speed at the cost of heavy internal damage over time and ability penalties after exhaustion. Allows use of Morning Peacock. (65% chance to teleport in front of your target)
		"}
		chakracost = 0
		cooldown = 400
		sname="View Gate"
		sindex = "GATE6"
		skillcost = 1500
		skill_reqs = list("GATE5")

	Wonder_Gate
		icon_state="gate7"
		descr={"Opens the seventh limiter gate, further increasing power and speed at the cost of heavy internal damage over time and ability penalties after exhaustion. The user also passes out taking wound damage at exhaustion. Allows use of Daytime Tiger. (75% chance to teleport in front of your target)
		"}
		chakracost = 0
		cooldown = 400
		sname="Wonder Gate"
		sindex = "GATE7"
		skillcost = 1250
		skill_reqs = list("GATE6")

	Hidden_Lotus
		icon_state="hlotus"
		descr={"Allows the user to move at amazing speeds.
		"}
		chakracost = 0
		cooldown = 42
		sname="Hidden Lotus"
		sindex = "Hidden_Lotus"
		skillcost = 1500
		skill_reqs = list("GATE3")


	Darkness
		icon_state="darkness"
		descr={"Blinds your enemy.
		"}
		chakracost = 800
		cooldown = 200
		sname="Genjutsu: Darkness"
		sindex = "DARKNESS_GENJUTSU"
		skillcost = 1700
		skill_reqs = list("PARALYZE_GENJUTSU")

	Fear
		icon_state="paralyse_genjutsu"
		descr={"Slows the actions of anyone looking at you.
		"}
		chakracost = 100
		cooldown = 60
		sname="Genjutsu: Fear"
		sindex = "PARALYZE_GENJUTSU"
		skillcost = 1000

	Temple_of_Nirvana
		icon_state="sleep_genjutsu"
		descr={"Puts everyone in a large area to sleep.
		"}
		chakracost = 250
		cooldown = 120
		sname="Genjutsu: Temple of Nirvana"
		sindex = "SLEEP_GENJUTSU"
		skillcost = 1300



	Lion_Combo
		icon_state="lioncombo"
		descr={"Traps your enemy with multiple hits!
		"}
		staminacost = 600
		cooldown = 60
		sname="Lion Combo"
		sindex = "LION_COMBO"
		skillcost = 1400

	Achiever_of_Nirvana_Fist
		icon_state="achiever_of_nirvana_fist"
		sname="Achiever of Nirvana Fist"
		descr="Blows your opponent back and slows their movements with a hard punch."
		staminacost = 150
		skillcost = 400
		cooldown = 10
		sindex = "NIRVANA_FIST"


	Leaf_Whirlwind
		icon_state="leaf_great_whirlwind"
		descr={"Swiftly kicks your enemy knocking them away. Damage decreases depending on your range from your opponent.
		"}
		staminacost = 100
		cooldown = 60
		sname="Leaf Whirlwind"
		skillcost = 800
		sindex = "LEAF_WHIRLWIND"

	Leaf_Great_Whirlwind
		icon_state="leaf_great_whirlwind"
		descr={"Swiftly kick your enemies three times. The first is a homing attack. The other two are area attacks around the user.
		"}
		staminacost = 250
		cooldown = 50
		sname="Leaf Great Whirlwind"
		skillcost = 1300
		sindex = "LEAF_GREAT_WHIRLWIND"
		skill_reqs = list("LEAF_WHIRLWIND")






	Manipulate_Advancing_Blades
		icon_state="Manipulate Advancing Blades"
		descr={"Allows you to throw many kunai at once. Wounds are based on the weak spot passive. Getting hit 3 times will end the skill.
		"}
		chakracost = 50
		cooldown = 30
		sname="Manipulate Advancing Blades"
		sindex = "MANIPULATE_ADVANCING_BLADES"
		skillcost = 1000

	Twin_Rising_Dragons
		icon_state="Twin Rising Dragons"
		descr={"Summons a large variety of weapons.
		"}
		chakracost = 100
		cooldown = 50
		sname="Twin Rising Dragons"
		sindex = "TWIN_RISING_DRAGONS"
		skillcost = 2500

	Windmill_Shuriken
		icon_state="windmill"
		descr={"Throws a large shuriken.
		"}
		chakracost = 0
		cooldown = 30
		sname="Windmill Shuriken"
		sindex = "WINDMILL_SHURIKEN"
		skillcost = 600

	Shadow_Windmill_Shuriken
		icon_state="windmillb"
		descr={"Throws a large shuriken, directly followed by a cloned shuriken..
		"}
		chakracost = 120
		cooldown = 60
		sname="Shadow Windmill Shuriken"
		sindex = "SHADOW_WINDMILL_SHURIKEN"
		skillcost = 900
		skill_reqs = list("WINDMILL_SHURIKEN")

	Exploding_Kunai
		icon_state="explkunai"
		descr={"Throws a kunai with an explosive attached to it.
		"}
		chakracost = 0
		cooldown = 20
		sname="Exploding Kunai"
		sindex = "EXPLODING_KUNAI"
		skillcost = 600

	Triple_Exploding_Kunai
		icon_state="tripletag"
		descr={"Throws three kunai with an explosive attached to each.
		"}
		chakracost = 0
		cooldown = 40
		sname="Triple Exploding Kunai"
		sindex = "TRIPLE_EXPLODING_KUNAI"
		skillcost = 900
		skill_reqs = list("EXPLODING_KUNAI")




	Exploding_Note
		icon_state="explnote"
		sname="Exploding Note"
		descr={"Places a small piece of paper that can explode.
				Supply Cost: 15
			"}
		chakracost = 0
		cooldown = 10
		sindex = "EXPLODING_NOTE"
		skillcost = 800


	Body_Flicker
		icon_state="shunshin"
		sname="Body Flicker"
		descr={"Moves you at a high speed.
			"}
		chakracost = 270
		cooldown = 5
		sindex = "SHUNSHIN"
		skillcost = 100


	Body_Replacement
		icon_state="kawarimi"
		sname="Body Replacement"
		descr={"Prepares you for a quick escape.
			"}
		chakracost = 50
		cooldown = 60
		sindex = "KAWARIMI"
		skillcost = 100


	Exploding_Body_Replacement
		icon_state="explodekawa"
		sname="Exploding Body Replacementt"
		descr={"Prepares you for a quick escape, leaving an explosive tag behind.
			"}
		chakracost = 50
		cooldown = 60
		skillcost = 750
		sindex = "EXPLODING_KAWARIMI"
		skill_reqs = list("KAWARIMI")





	Rasengan
		icon_state="rasengan"
		sname="Rasengan"
		descr={"Creates a small ball of highly concentrated chakra that rapidly expands when punched into an enemy.
			"}
		chakracost = 300
		cooldown = 90
		sindex = "RASENGAN"
		skillcost = 1500

	Large_Rasengan
		icon_state="oodama_rasengan"
		sname="Large Rasengan"
		descr={"Creates a ball of highly concentrated chakra that rapidly expands when punched into an enemy.
			"}
		chakracost = 500
		cooldown = 140
		sindex = "OODAMA_RASENGAN"
		skillcost = 2500
		skill_reqs = list("RASENGAN")

	Camouflaged_Hiding
		icon_state="Camouflage Concealment Technique"
		sname="Camouflaged Hiding"
		descr={"Blends you into your surroundings, making it harder for your enemies to see you.
			"}
		chakracost = 100
		cooldown = 60
		sindex = "CAMOFLAGE_CONCEALMENT"
		skillcost = 1200

	Chakra_Leech
		icon_state="chakra_leach"
		sname="Chakra Leech"
		descr={"Drains your enemies of chakra, repleshing your chakra.
			"}
		chakracost = 100
		cooldown = 60
		sindex = "CHAKRA_LEECH"
		skillcost = 1700


	Transform
		icon_state="henge"
		sname="Transform"
		descr={"Changes your appearance to that of someone else.
			"}
		chakracost = 40
		cooldown = 60
		sindex = "HENGE"
		skillcost = 50








	Healing
		icon_state="medical_jutsu"
		sname="Healing"
		descr={"Heals your ally's internal damage.
			"}
		chakracost = 60
		cooldown = 5
		sindex = "MEDIC"
		skillcost = 2000

	Poison_Mist
		icon_state="poisonbreath"
		sname="Poison Mist"
		descr={"Creates a cloud of poisonous gas.
			"}
		chakracost = 420
		cooldown = 60
		sindex = "POISON_MIST"
		skillcost = 1500
		skill_reqs = list("MEDIC")

	Poisoned_Needles
		icon_state="poison_needles"
		sname="Poison Needles"
		descr={"Throws posioned needles at your enemy.
			"}
		chakracost = 0
		cooldown = 60
		sindex = "POISON_NEEDLES"
		skillcost = 1500
		skill_reqs = list("POISON_MIST")

	Chakra_Scalpel
		icon_state="mystical_palm_technique"
		sname="Chakra Scalpel"
		descr={"Uses chakra to create a sharp blade around your hands, allowing you to deal heavy damage with precise strikes.
			"}
		chakracost = 100
		cooldown = 30
		sindex = "MYSTICAL_PALM"
		skillcost = 1000
		skill_reqs = list("MEDIC")

	Cherry_Blossom_Impact
		icon_state="chakra_taijutsu_release"
		sname="Cherry Blossom Impact"
		descr={"Enhances your strength with chakra, allowing you break bones with one big punch.
			"}
		chakracost = 100
		cooldown = 15
		sindex = "CHAKRA_TAI_RELEASE"
		skillcost = 1700
		skill_reqs = list("MEDIC")

	Creation_Rebirth
		icon_state="pheonix_rebirth"
		sname="Creation Rebirth"
		descr={"Heals you almost completely with a large infusion of chakra.
			"}
		chakracost = 500
		cooldown = 900
		sindex = "PHOENIX_REBIRTH"
		skillcost = 2500
		skill_reqs = list("IMPORTANT_BODY_PTS_DISTURB", "CHAKRA_TAI_RELEASE")


	Body_Disruption_Stab
		icon_state="important_body_ponts_disturbance"
		sname="Body Disruption Stab"
		descr={"Scrambles your enemy's nerves with a precise injection of chakra.
			"}
		chakracost = 100
		cooldown = 180
		sindex = "IMPORTANT_BODY_PTS_DISTURB"
		skillcost = 1000
		skill_reqs = list("MYSTICAL_PALM")

	Delicate_Extraction
		icon_state="delicatee"
		sname="Delicate Extraction"
		descr={"Removes poison from your ally's body.
			"}
		chakracost = 80
		cooldown = 5
		sindex = "DELICATE_EXTRACTION"
		skillcost = 500
		skill_reqs = list("MEDIC")

	Menacing_Palm
		icon_state="menacingp"
		sname="Menacing Palm"
		descr={"Infuse your enemy with an explosion of chakra, dealing moderate stamina damage and minor wounds.
			"}
		chakracost = 100
		cooldown = 180
		sindex = "MENACING_PALM"
		skillcost = 1200
		skill_reqs = list("MEDIC")

	Chakra_Enhancement
		icon_state="chakraen"
		sname="Chakra Enhancement"
		descr={"Enhances your strength with chakra, allowing you break bones with multiple punches. Lasts for 15 seconds. Can be canceled.
			"}
		chakracost = 100
		cooldown = 180
		sindex = "CHAKRA_ENHANCEMENT"
		skillcost = 1800
		skill_reqs = list("CHAKRA_TAI_RELEASE")

	Chakra_Enhancement_Smash
		icon_state="chakraens"
		sname="Chakra Enhancement Smash"
		descr={"Smash the ground with incredible force.
			"}
		chakracost = 240
		cooldown = 60
		sindex = "CHAKRA_ENHANCEMENT_SMASH"
		skillcost = 1800
		skill_reqs = list("CHAKRA_ENHANCEMENT")



	Taijutsu_stance_1
		icon_state="Strong_fist"
		sname="Strong fist"
		descr={"Taijutsu stance 1 - Strong fist (200rfx and 200str prereq): Increases taijutsu range by 1 by quickly dashing one square closer to a target which is only 1 tile out of range. Allows for fast drive by taijutsu.
			"}
		//chakracost = 100
		//cooldown = 180
		sindex = "TAI_STANCE1"
		skillcost = 0


	Taijutsu_stance_2
		icon_state="Rising_impact_palm"
		sname="Rising impact palm"
		descr={"Taijutsu stance 2 - Rising impact palm (300 str prereq):  Increases taijutsu damage and slightly lowers attacking speed and has a 1 in 3 chance to knockback opponent.
			"}
		//chakracost = 100
		//cooldown = 180
		sindex = "TAI_STANCE2"
		skillcost = 0

	Taijutsu_stance_3
		icon_state="Swift_style"
		sname="Swift style"
		descr={"Taijutsu stance 3 - Swift style (300 rfx prereq): each attack phase results in 2 attacks rather than 1, with only 40% damage each (increased chance to daze/critical)
			"}
		//chakracost = 100
		//cooldown = 180
		sindex = "TAI_STANCE3"
		skillcost = 0

