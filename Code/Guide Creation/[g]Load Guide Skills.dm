mob/var/tmp/loadingskills=0
mob/proc
	LoadStuff(Guide/G,var/num=0)
		initiatelist()
		src.contents=new

		RELOAD// if they finished downloading skills

		if(G.skills.len>0)//local use

			for(var/X in G.skills)
				for(var/Jutsu/J in jlist)
					if(J.sindex==X)
						src.contents+=J
						src<<"[J]"


			src.jutsulist=G.skills//t
			src.elements=G.elements//the elements list to be sent to server, load it appropriately
			src.skillpoints=G.skillpoints//appropiate sp's

			if(G.skillspassive)
				src.skillspassive=G.skillspassive//add passives

			src.UpdateSkills()// initiate it
			src.coverskills()
			//update passives here
			for(var/obj/gui/passives/gauge/Q in world)
				src.client.Passive_Refresh(Q)

			Orientate()//do the maths
			loadingskills=0//reset it


		else// download Guides skills
			if(num)return//dont load in preview mode
			//make it not load if your just previewing.

			alert("Retrieving Guide Jutsus from the server. Please Wait")
			load_skill_tableA(G) //downloads your skills from the server
			load_skill_tableB(G) //downloads your skills from the server
			load_passive_table(G) //downloads passives

			G.save()//save it for local use

			if(LoadedJutsus.len>0)//if anything was found
				if(alerts)alert("Succesfull")
				goto RELOAD

			else
				if(alerts)alert("No Jutsus were found on the server")



