mob
	var
		Village=""
		Trait
		clan
		prereq=""

turf
	Creation
		icon='creation.png'

mob
	var/pickvil=0
	var/picktrait=0

obj
////////MAIN
	leaf
		icon='leafp.png'
		Click()
			if(usr.pickvil)
				src.icon='leafS.png'
				usr.pickvil=1
				usr.Village="Leaf"
				for(var/obj/mist/M in world)
					M.icon='mistp.png'
				for(var/obj/sand/S in world)
					S.icon='sandp.png'

				if(!usr.Trait)
					for(var/obj/nonclan/M in world)
						M.icon='non-clanS.png'
					for(var/obj/clan/M in world)
						M.icon='clan.png'
					usr.loadnonclan(usr.Village)
				else
					for(var/obj/clan/M in world)
						M.icon='clanS.png'
					for(var/obj/nonclan/M in world)
						M.icon='non-clan.png'
					usr.loadclan(usr.Village)
			else
				src.icon='leafS.png'
				usr.pickvil=1
				usr.Village="Leaf"
	mist
		icon='mistp.png'
		Click()
			if(usr.pickvil)
				src.icon='mistS.png'
				usr.pickvil=1
				usr.Village="Mist"
				for(var/obj/leaf/L in world)
					L.icon='leafp.png'
				for(var/obj/sand/S in world)
					S.icon='sandp.png'

				if(!usr.Trait)
					for(var/obj/nonclan/M in world)
						M.icon='non-clanS.png'
					for(var/obj/clan/M in world)
						M.icon='clan.png'
					usr.loadnonclan(usr.Village)
				else
					for(var/obj/clan/M in world)
						M.icon='clanS.png'
					for(var/obj/nonclan/M in world)
						M.icon='non-clan.png'
					usr.loadclan(usr.Village)

			else
				src.icon='mistS.png'
				usr.pickvil=1
				usr.Village="Mist"

	sand
		icon='sandp.png'
		Click()
			if(usr.pickvil)
				src.icon='sandS.png'
				usr.pickvil=1
				usr.Village="Sand"
				for(var/obj/mist/M in world)
					M.icon='mistp.png'
				for(var/obj/leaf/L in world)
					L.icon='leafp.png'

				if(!usr.Trait)
					for(var/obj/nonclan/M in world)
						M.icon='non-clanS.png'
					for(var/obj/clan/M in world)
						M.icon='clan.png'
					usr.loadnonclan(usr.Village)
				else
					for(var/obj/clan/M in world)
						M.icon='clanS.png'
					for(var/obj/nonclan/M in world)
						M.icon='non-clan.png'
					usr.loadclan(usr.Village)

			else
				src.icon='sandS.png'
				usr.pickvil=1
				usr.Village="Sand"



///////SUB

	clan
		icon='clan.png'
		Click()
			if(usr.picktrait)
				src.icon='clanS.png'
				usr.picktrait=1
				usr.Trait=1
				usr.loadclan(usr.Village)
				for(var/obj/nonclan/M in world)
					M.icon='non-clan.png'

			else
				for(var/obj/nonclan/M in world)
					M.icon='non-clan.png'
				src.icon='clanS.png'
				usr.picktrait=1
				usr.Trait=1
				usr.loadclan(usr.Village)



	nonclan
		icon='non-clan.png'
		Click()
			if(usr.picktrait)
				src.icon='non-clanS.png'
				usr.picktrait=1
				usr.Trait=0
				usr.loadnonclan(usr.Village)
				for(var/obj/clan/M in world)
					M.icon='clan.png'

			else
				for(var/obj/clan/M in world)
					M.icon='clan.png'
				src.icon='non-clanS.png'
				usr.picktrait=1
				usr.Trait=0
				usr.loadnonclan(usr.Village)





//CLAN SELECT
	clanslots
		var/clan
		var/prereq
		Click()
			for(var/obj/clanslots/C in world)
				C.overlays-='clicked.dmi'

			usr.clan=src.clan
			if(src.prereq)
				usr.prereq=prereq

			src.overlays+='clicked.dmi'
			usr.loadinfo(clan)


		clanslot1
			pixel_x=12
			icon='clanbase.dmi'

		clanslot2
			pixel_x=-8
			icon='clanbase.dmi'

		clanslot3
			pixel_x=5
			icon='clanbase.dmi'

		clanslot4
			pixel_x=-15
			icon='clanbase.dmi'

		clanslot5
			pixel_x=1
			icon='clanbase.dmi'

		clanslot6
			pixel_x=-16
			icon='clanbase.dmi'




//INFO

	info
		icon='info.png'


//DONE

	done
		icon='done.png'
		Click()
			usr.finish()




mob
	proc
		loadnonclan(Village)
			loadinfo(0)//clear it out
			for(var/obj/clanslots/C in world)
				C.icon='clanbase.dmi'
			switch(Village)
				if("Leaf")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='trait-fire.png'
						a.clan="Fire"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='trait-youth.png'
						b.clan="Youth"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='trait-capacity.png'
						c.clan="Capacity"
					for(var/obj/clanslots/clanslot5/d in world)
						d.icon='trait-genius.png'
						d.clan="Genius"

				if("Sand")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='trait-battle.png'
						a.clan="Battle"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='trait-youth.png'
						b.clan="Youth"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='trait-capacity.png'
						c.clan="Capacity"
					for(var/obj/clanslots/clanslot5/d in world)
						d.icon='trait-genius.png'
						d.clan="Genius"

				if("Mist")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='trait-ruthless.png'
						a.clan="Ruthless"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='trait-youth.png'
						b.clan="Youth"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='trait-capacity.png'
						c.clan="Capacity"
					for(var/obj/clanslots/clanslot5/d in world)
						d.icon='trait-genius.png'
						d.clan="Genius"

		loadclan(Village)
			loadinfo(0)//clear it out
			for(var/obj/clanslots/C in world)
				C.icon='clanbase.dmi'
			switch(Village)
				if("Leaf")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='clan-uchiha.png'
						a.clan="Uchiha"
						a.prereq="UCHIHA"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='clan-nara.png'
						b.clan="Nara"
						b.prereq="NARA"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='clan-hyuuga.png'
						c.clan="Hyuuga"
						c.prereq="HYUUGA"
					for(var/obj/clanslots/clanslot5/d in world)
						d.icon='clan-akimichi.png'
						d.clan="Akimichi"
						d.prereq="AKIMICHI"

				if("Sand")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='clan-clay.png'
						a.clan="Clay"
						a.prereq="CLAY"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='clan-puppet.png'
						b.clan="Puppet"
						b.prereq="PUPPET"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='cland-sand.png'
						c.clan="Sand"
						c.prereq="SAND_SUMMON"




				if("Mist")
					for(var/obj/clanslots/clanslot2/a in world)
						a.icon='clan-jashin.png'
						a.clan="Jashin"
						a.prereq="JASHIN"
					for(var/obj/clanslots/clanslot3/b in world)
						b.icon='clan-kaguya.png'
						b.clan="Kaguya"
						b.prereq="KAGUYA"
					for(var/obj/clanslots/clanslot4/c in world)
						c.icon='clan-haku.png'
						c.clan="Haku"
						c.prereq="HAKU"


		loadinfo(clan)
			if(!clan)
				for(var/obj/info/a in world)
					a.icon='info.png'
				for(var/obj/clanslots/C in world)
					C.overlays-='clicked.dmi'
				winshow(src,"extra-info",0)

			if(Alert=="Off")return

			else
				winshow(src,"extra-info",1)
				switch(clan)
					if("Akimichi")
						for(var/obj/info/a in world)
							a.icon='info-akimichi.png'
							winset(src,null,{"
							clanlabel.text = "Akimichi";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 40;
							diffbar.value = 10;
							"})

					if("Battle")
						for(var/obj/info/a in world)
							a.icon='info-battle.png'
							winset(src,null,{"
							clanlabel.text = "Battle";
							healthbar.value = 60;
							chakrabar.value = 50;
							versbar.value = 80;
							diffbar.value = 30;
							"})


					if("Hyuuga")
						for(var/obj/info/a in world)
							a.icon='info-byakugan.png'
							winset(src,null,{"
							clanlabel.text = "Hyuuga";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 40;
							diffbar.value = 70;
							"})


					if("Capacity")
						for(var/obj/info/a in world)
							a.icon='info-capacity.png'
							winset(src,null,{"
							clanlabel.text = "Capactiy";
							healthbar.value = 70;
							chakrabar.value = 100;
							versbar.value = 80;
							diffbar.value = 10;
							"})

					if("Genius")
						for(var/obj/info/a in world)
							a.icon='info-genius.png'
							winset(src,null,{"
							clanlabel.text = "Genius";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 100;
							diffbar.value = 40;
							"})


					if("Clay")
						for(var/obj/info/a in world)
							a.icon='info-clay.png'
							winset(src,null,{"
							clanlabel.text = "Clay Art";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 40;
							diffbar.value = 80;
							"})


					if("Fire")
						for(var/obj/info/a in world)
							a.icon='info-fire.png'
							winset(src,null,{"
							clanlabel.text = "WOF";
							healthbar.value = 60;
							chakrabar.value = 60;
							versbar.value = 90;
							diffbar.value = 40;
							"})


					if("Haku")
						for(var/obj/info/a in world)
							a.icon='info-haku.png'
							winset(src,null,{"
							clanlabel.text = "Haku";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 60;
							diffbar.value = 70;
							"})


					if("Jashin")
						for(var/obj/info/a in world)
							a.icon='info-jashin.png'
							winset(src,null,{"
							clanlabel.text = "Jashin";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 50;
							diffbar.value = 20;
							"})


					if("Kaguya")
						for(var/obj/info/a in world)
							a.icon='info-kaguya.png'
							winset(src,null,{"
							clanlabel.text = "Kaguya";
							healthbar.value = 60;
							chakrabar.value = 50;
							versbar.value = 60;
							diffbar.value = 50;
							"})


					if("Nara")
						for(var/obj/info/a in world)
							a.icon='info-nara.png'
							winset(src,null,{"
							clanlabel.text = "Nara";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 60;
							diffbar.value = 40;
							"})


					if("Puppet")
						for(var/obj/info/a in world)
							a.icon='info-puppet.png'
							winset(src,null,{"
							clanlabel.text = "Puppet";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 100;
							diffbar.value = 100;
							"})


					if("Ruthless")
						for(var/obj/info/a in world)
							a.icon='info-ruthless.png'
							winset(src,null,{"
							clanlabel.text = "Ruthless";
							healthbar.value = 60;
							chakrabar.value = 60;
							versbar.value = 90;
							diffbar.value = 20;
							"})


					if("Sand")
						for(var/obj/info/a in world)
							a.icon='info-sand.png'
							winset(src,null,{"
							clanlabel.text = "Gaara";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 80;
							diffbar.value = 40;
							"})



					if("Youth")
						for(var/obj/info/a in world)
							a.icon='info-spring.png'
							winset(src,null,{"
							clanlabel.text = "Youth";
							healthbar.value = 70;
							chakrabar.value = 70;
							versbar.value = 30;
							diffbar.value = 50;
							"})


					if("Uchiha")
						for(var/obj/info/a in world)
							a.icon='info-uchiha.png'
							winset(src,null,{"
							clanlabel.text = "Uchiha";
							healthbar.value = 50;
							chakrabar.value = 50;
							versbar.value = 60;
							diffbar.value = 50;
							"})









		finish()
			if(src.clan)
				winshow(src,"extra-info",0)
				if(guideon)
					loadslots()
				else
					src.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)  // turn on several bits at once
					src.client.eye=locate(9,9,2)
					//winshow(src,"default",0)
					winset(src,null,{"
							default.main2.left = "Planner";
							"})

					Refresh()//initialise the guy
					basicinfo()
					if(src.clan=="Sand")
						src.contents+= new /Jutsu/Sand_Control
						src.jutsulist.Add("SAND")
					src.jutsulist.Add(src.prereq)
					UpdateSkills()
					coverskills()




obj
	clanskills
		icon='clickme.dmi'
		Click()
			usr.client.eye=locate(9,9,3)


obj
	nonclanskills
		icon='clickme.dmi'
		Click()
			usr.client.eye=locate(9,9,4)

obj
	elementskills
		icon='clickme.dmi'
		Click()
			usr.client.eye=locate(9,9,5)


obj
	passives
		icon='clickme.dmi'
		Click()
			usr.client.eye=locate(9,9,6)


obj
	back
		icon='clickme.dmi'
		Click()
			usr.client.eye=locate(9,9,2)