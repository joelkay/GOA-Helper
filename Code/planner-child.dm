turf
	SkillMenuC
		icon='Skill-Menu-Clan.png'
	SkillMenuNC
		icon='Skill-Menu-Non.png'
	SkillMenuP
		icon='Skill-Menu-Passive.png'
	SkillMenuE
		icon='Skill-Menu-Element.png'
	Main
		icon='skillmenus.png'

mob
	verb
		ViewPlanner()
			set hidden=1

			var/Guide/G=new/Guide
			if( G.load(src.clan,src.slots[currentguide]) )
				if(!planneropen(G))//load the guide with the option to build it
					return// disable bad builds from loading at all
				//load the guide here
				winset(src,null,{"
						default.main2.left = "Planner";
						buildchild.left = "open";
						returnguide.is-visible = "false";
						"})
				LoadStuff(G)//load stuff from the guide

		ViewPlannerC()//viewing the guide in preview mode, so dont load data from web
			set hidden=1

			var/Guide/G=new/Guide
			if( G.load(src.clan,src.slots[currentguide]) )

				previewguide=1//dont give sps and such
				if(!planneropen(G))//load the guide with the option to build it
					return// disable bad builds from loading at all
				//load the guide here
				winset(src,null,{"
						default.main2.left = "Planner";
						buildchild.left = "open";
						returnguide.is-visible = "false";
						"})
				LoadStuff(G,1)//load stuff from the guide, options setting 1 so no mysql queries if need be


		UsePlanner()//public mode
			set hidden=1

			var/Guide/G=new/Guide
			if( G.load(src.clan,src.slots[currentguide]) )
				if(!planneropen(G))//load the guide with the option to build it
					return// disable bad builds from loading at all
				winset(src,null,{"
					default.main2.left = "Planner";
					default.main.left = "map";
					buildchild.left = "infogather";
					returnguide.is-visible = "true";
					returnguide.text = "Return to Menu";
					returnguide.command = "ReturnMenu";
					"})
				LoadStuff(G)//load stuff from the guide



		UsePlannerC()//creator mode
			set hidden=1

			var/Guide/G=new/Guide
			if( G.load(src.clan,src.slots[currentguide]) )

				if(!G.published)//If a new guide then do a build for them
					if(!planneropen(G))//load the guide with the option to build it
						return// disable bad builds from loading at all
				winset(src,null,{"
					default.main2.left = "Planner";
					default.main.left = "map";
					buildchild.left = "open2";
					returnguide.is-visible = "true";
					returnguide.text = "Return to Guide Creator";
					returnguide.command = "ReturnGuide";
					"})
				LoadStuff(G,1)//load stuff from the guide





	proc
		planneropen(Guide/G)
			src.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)  // turn on several bits at once
			src.client.eye=locate(9,9,2)
			//winshow(src,"default",0)

			basicinfo()
			Refresh()

			if(G)
				src.strinput=G.str1
				src.rfxinput=G.rfx1
				src.coninput=G.con1
				src.intinput=G.int1
				src.levels=G.lvl1
				src.fromguide=1
				//alert("[strinput],[rfxinput],[coninput],[intinput]") test to see if values load right
				if(src.DoBuild())
					return 1
				else
					return 0


			//load jutsu list here
			//G.skills is a list of all the jutsu in the guide.





