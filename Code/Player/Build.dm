mob
	var
		strinput=0
		rfxinput=0
		coninput=0
		intinput=0
		levels=0
		fromguide=0//custom info
		previewguide=0//live previews

	verb
		rebuild()
			set hidden=1
			src.Refresh()
			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])
			previewguide=0
			if(!planneropen(G))//load the guide with the option to build it
				return// disable bad builds from loading at all
			alert("Rebuild Sucessful")
	verb
		Build()
			set hidden=1
			src.fromguide=0
			src.DoBuild()


	proc
		DoBuild()
			if(!fromguide)
				var/num1 = winget(usr, "strinput", "text")
				strinput = text2num(num1)
				if(debug)src<<"Str:[strinput]"

				var/num2 = winget(usr, "rfxinput", "text")
				rfxinput = text2num(num2)
				if(debug)src<<"Rfx:[rfxinput]"

				var/num3 = winget(usr, "coninput", "text")
				coninput = text2num(num3)
				if(debug)src<<"Con:[coninput]"

				var/num4 = winget(usr, "intinput", "text")
				intinput = text2num(num4)
				if(debug)src<<"Int:[intinput]"


			if(strinput+coninput+intinput+rfxinput==6 && strinput<=3&&coninput<=3&&intinput<=3&&rfxinput<=3)

				if(clevel+levels>100)
					alert("Levels cant go above 100, currently [clevel+levels]")
					return

				if(!fromguide)alert("Build Succesfull")//dont tell them from a guide

				if(!fromguide)
					var/num5 = winget(usr, "levelinput", "text")
					levels = text2num(num5)

				if(levels<0||levels>100)
					alert("Level range should be 0 - 100")
					levels=0
					return

				var/newlevels=clevel+levels// for use in formulas

				//////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////

				if(!clevel)//straight builders
					clevel=levels
					str=(50+levels)+(strinput*levels)
					con=(50+levels)+(coninput*levels)
					rfx=(50+levels)+(rfxinput*levels)
					int=(50+levels)+(intinput*levels)

				else
					clevel=newlevels//allow partial buildig
					str+=levels+(strinput*levels)
					con+=levels+(coninput*levels)
					rfx+=levels+(rfxinput*levels)
					int+=levels+(intinput*levels)

					if(clevel==100)
						if(src.str+src.rfx+src.int+src.con==1200)
						else alert("Something went wrong","Build Error")



				//////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////


				switch(clan)
					if("Capacity")
						var/cmul=1.3//increase capa chakra/regen by 30%

						if(!clevel)//straight builders
							stamina=2500+(40*levels)+(13*str)//capa
							staminaregen=round((((2500+(str*13))+(levels*25)))/100)//normal
						else
							stamina=2500+(40*newlevels)+(13*str)//capa
							staminaregen=round((((2500+(str*13))+(newlevels*25)))/100)//normal

						if(!clevel)//straight builders
							chakra=((500+(15*levels)+(5*con))*cmul)//capa
							chakraregen=round(((((500+(con*5))+(levels*5)))/60)*cmul)//normal
						else
							chakra=((500+(15*newlevels)+(5*con))*cmul)//capa
							chakraregen=round(((((500+(con*5))+(newlevels*5)))/60)*cmul)//normal

					if("Youth")
						if(!clevel)//straight builders
							stamina=2500+(55*levels)+(13*str)//youth
							staminaregen=round((((2500+(str*13))+(levels*25)))/100)//normal
						else
							stamina=2500+(55*newlevels)+(13*str)//youth
							staminaregen=round((((2500+(str*13))+(newlevels*25)))/100)//normal

						if(!clevel)//straight builders
							chakra=500+(0*levels)+(5*con)//youth
							chakraregen=round((((500+(con*5))+(levels*5)))/60)//normal
						else
							chakra=500+(0*newlevels)+(5*con)//youth
							chakraregen=round((((500+(con*5))+(newlevels*5)))/60)//normal

					else//NORMAL
						if(!clevel)//straight builders
							stamina=2500+(25*levels)+(13*str)//normal
							staminaregen=round((((2500+(str*13))+(levels*25)))/100)//normal
						else
							stamina=2500+(25*newlevels)+(13*str)//normal
							staminaregen=round((((2500+(str*13))+(newlevels*25)))/100)//normal

						if(!clevel)//straight builders
							chakra=500+(5*levels)+(5*con)
							chakraregen=round((((500+(con*5))+(levels*5)))/60)

						else
							chakra=500+(5*newlevels)+(5*con)
							chakraregen=round((((500+(con*5))+(newlevels*5)))/60)


						switch(clan)
							if("Jashin")
								wounds=100
							if("Fire")
								wounds=130

				/*if(clan == "Genius")
				src.skillpoints+=60
				if(S == "int") src.skillpoints+=5*/
				//////////////////////////////////////////////////////////
				//SKILL POINTS
				//////////////////////////////////////////////////////////
				if(!previewguide)//if they are just previewing dont allocate sp
				//////////////////////////////////////////////////////////

					if(src.clan=="Genius")
						if(!clevel)//straight builders
							src.skillpoints=((270+(intinput*55))*levels)
						else
							src.skillpoints+=((270+(intinput*55))*levels)

					else
						if(!clevel)//straight builders
							src.skillpoints=((270+(intinput*35))*levels)
						else
							src.skillpoints+=((270+(intinput*35))*levels)

					src.maxskillpoints=skillpoints//what does dis do? LuL


				//////////////////////////////////////////////////////////
				//PASSIVES
				//////////////////////////////////////////////////////////
				if(!previewguide)//if they are just previewing dont allocate passives
				//////////////////////////////////////////////////////////
					if(!clevel)//straight builders
						skillspassive[25]=((round(levels/10))+(round(strinput*levels)/10))//str passives
						skillspassive[26]=((round(levels/10))+(round(rfxinput*levels)/10))//rfx passives
						skillspassive[27]=((round(levels/10))+(round(intinput*levels)/10))//int passives
						skillspassive[28]=((round(levels/10))+(round(coninput*levels)/10))//con passives
					else
						skillspassive[25]+=((round(levels/10))+(round(strinput*levels)/10))//str passives
						skillspassive[26]+=((round(levels/10))+(round(rfxinput*levels)/10))//rfx passives
						skillspassive[27]+=((round(levels/10))+(round(intinput*levels)/10))//int passives
						skillspassive[28]+=((round(levels/10))+(round(coninput*levels)/10))//con passives


				spawn()
					for(var/obj/gui/passives/gauge/Q in world)
						src.client.Passive_Refresh(Q)

				Orientate()//do the maths

				return 1




			else
				alert("You inputed incorrect values. All the numbers should add up to 6, A stat may only have 3 points maximum","Build Error","Ok")

				return 0//halt all stuffs
