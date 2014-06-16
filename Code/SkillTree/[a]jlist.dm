var/list/jlist=list()
var/list/jlistA=list()
var/list/jlistB=list()
var/list/starterlist=list()
proc
	initiatelist()
		jlist=new
		jlist+=newlist(/Jutsu/Clone,/Jutsu/Body_Flicker,/Jutsu/Body_Replacement,/Jutsu/Transform,/Jutsu/Exploding_Note)// these are starters
		jlist+= newlist(/Jutsu/Size_Multiplication,/Jutsu/Super_Size_Multiplication,/Jutsu/Human_Bullet_Tank,/Jutsu/Spinach_Pill,/Jutsu/Curry_Pill)
		jlist+= newlist(/Jutsu/Exploding_Bird,/Jutsu/Exploding_Spider,/Jutsu/C3)
		jlist+= newlist(/Jutsu/Sensatsusuisho,/Jutsu/Ice_Explosion,/Jutsu/Demonic_Ice_Crystal_Mirrors)
		jlist+= newlist(/Jutsu/Byakugan,/Jutsu/Turning_the_Tide,/Jutsu/Palms,/Jutsu/Gentle_Fist)
		jlist+= newlist(/Jutsu/Stab_Self,/Jutsu/Death_Ruling_Possession_Blood,/Jutsu/Wound_Regeneration,/Jutsu/Immortality)
		jlist+= newlist(/Jutsu/Piercing_Finger_Bullets,/Jutsu/Bone_Harden,/Jutsu/Camellia_Dance,/Jutsu/Larch_Dance,/Jutsu/Young_Bracken_Dance)
		jlist+= newlist(/Jutsu/Shadow_Binding,/Jutsu/Shadow_Neck_Bind,/Jutsu/Shadow_Sewing)
		jlist+= newlist(/Jutsu/First_Puppet,/Jutsu/Second_Puppet,/Jutsu/Puppet_Transform,/Jutsu/Puppet_Swap)
		jlist+= newlist(/Jutsu/Sand_Control,/Jutsu/Desert_Funeral,/Jutsu/Sand_Shield,/Jutsu/Sand_Armor,/Jutsu/Sand_Shuriken)
		jlist+= newlist(/Jutsu/Sharingan_2,/Jutsu/Sharingan_3,/Jutsu/Sharingan_Copy)

		///ELEMENTS////
		jlist+= newlist(/Jutsu/Iron_Skin,/Jutsu/Mole_Hiding,/Jutsu/Head_Hunter,/Jutsu/Dungeon_Chamber_of_Nothingness,/Jutsu/Split_Earth_Revolution_Palm,/Jutsu/Earth_Flow_River)
		jlist+= newlist(/Jutsu/Grand_Fireball,/Jutsu/Hosenka,/Jutsu/Ash_Accumulation_Burning,/Jutsu/Fire_Dragon_Flaming_Projectile,/Jutsu/Coiling_Flame,/Jutsu/Nail_Flower)
		jlist+= newlist(/Jutsu/Chidori,/Jutsu/Chidori_Spear,/Jutsu/Chidori_Current,/Jutsu/Chidori_Needles,/Jutsu/Four_Pillar_Binding,/Jutsu/False_Darkness)
		jlist+= newlist(/Jutsu/Giant_Vortex,/Jutsu/Bursting_Water_Shockwave,/Jutsu/Water_Dragon_Projectile,/Jutsu/Collision_Destruction,/Jutsu/Syrup_Capture,/Jutsu/Hidden_Mist,/Jutsu/Water_Prison,/Jutsu/Water_Bullet)
		jlist+= newlist(/Jutsu/Pressure_Damage,/Jutsu/Blade_of_Wind,/Jutsu/Great_Breakthrough,/Jutsu/Refined_Air_Bullet,/Jutsu/Vacuum_Blade)
		///ELEMENTS////

		jlist+= newlist(/Jutsu/Shadow_Clone,/Jutsu/Multiple_Shadow_Clone,/Jutsu/Exploding_Shadow_Clone,/Jutsu/Shuriken_Shadow_Clone)
		jlist+= newlist(/Jutsu/Opening_Gate,/Jutsu/Energy_Gate,/Jutsu/Life_Gate,/Jutsu/Pain_Gate,/Jutsu/Limit_Gate,/Jutsu/View_Gate,/Jutsu/Wonder_Gate,/Jutsu/Hidden_Lotus)
		jlist+= newlist(/Jutsu/Darkness,/Jutsu/Fear,/Jutsu/Temple_of_Nirvana)
		jlist+= newlist(/Jutsu/Achiever_of_Nirvana_Fist,/Jutsu/Lion_Combo,/Jutsu/Leaf_Great_Whirlwind,/Jutsu/Leaf_Whirlwind)
		jlist+= newlist(/Jutsu/Manipulate_Advancing_Blades,/Jutsu/Twin_Rising_Dragons,/Jutsu/Windmill_Shuriken,/Jutsu/Shadow_Windmill_Shuriken,/Jutsu/Exploding_Kunai,/Jutsu/Exploding_Body_Replacement,/Jutsu/Triple_Exploding_Kunai)
		jlist+= newlist(/Jutsu/Rasengan,/Jutsu/Large_Rasengan,/Jutsu/Camouflaged_Hiding,/Jutsu/Chakra_Leech)
		jlist+= newlist(/Jutsu/Healing,/Jutsu/Poison_Mist,/Jutsu/Poisoned_Needles,/Jutsu/Chakra_Scalpel,/Jutsu/Cherry_Blossom_Impact,/Jutsu/Creation_Rebirth,/Jutsu/Body_Disruption_Stab,/Jutsu/Delicate_Extraction,/Jutsu/Menacing_Palm,/Jutsu/Chakra_Enhancement,/Jutsu/Chakra_Enhancement_Smash)


	starterlist()
		starterlist=new
		starterlist+=newlist(/Jutsu/Clone,/Jutsu/Body_Flicker,/Jutsu/Body_Replacement,/Jutsu/Transform,/Jutsu/Exploding_Note,/Jutsu/Exploding_Kunai, /Jutsu/Windmill_Shuriken)// these are starters

	jlistA()//if n =1, generate fresh lists.
		jlistA=new
		var/i=1
		initiatelist()
		while(i<56)//1 - 55 jutsu in the game + elements
			jlistA.Add(jlist[i])
			i++
		jlistA+=newlist(/Jutsu/Earth,/Jutsu/Fire,/Jutsu/Lightning,/Jutsu/Water,/Jutsu/Wind)// place holders for elements



	jlistB()
		jlistB=new
		var/i=56
		initiatelist()
		while(i<117)//56 - 117 jutsu in the game
			jlistB.Add(jlist[i])
			i++


