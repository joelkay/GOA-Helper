mob/var/guideon

mob
	verb
		guidesection()
			set hidden=1

			winset(src,null,{"
					default.main.left = "map";
					buildchild.left = "open";
					"})
			src.guideon=1// this is for viewing saved guides and creating them


		testsection()
			set hidden=1
			winset(src,null,{"
					default.main.left = "map";
					buildchild.left = "infogather";
					returnguide.is-visible = "true";
					returnguide.text = "Return to Menu";
					returnguide.command = "ReturnMenu";
					"})
			src.guideon=0// your typical goa planner use.

		ReturnMenu()
			set hidden=1
			winset(src,null,{"
				default.main2.left = "updates";
				default.main.left = "login";
				guidename2.is-visible="false";
				"})
			usr.client.eye=locate(1,1,1)
			pickvil=0
			picktrait=0
			Village=""
			Trait=""
			clan=""
			prereq=""
			elements=new()
			jutsulist=new()//reset them
			contents=new()//reset
			for(var/obj/clanslots/C in world)
				C.icon='clanbase.dmi'

			for(var/obj/clanslots/C in world)
				C.overlays-='clicked.dmi'

			for(var/obj/nonclan/M in world)
				M.icon='non-clan.png'

			for(var/obj/clan/M in world)
				M.icon='clan.png'

			for(var/obj/info/a in world)
				a.icon='info.png'

			for(var/obj/leaf/b in world)
				b.icon='leafp.png'

			for(var/obj/mist/c in world)
				c.icon='mistp.png'

			for(var/obj/sand/d in world)
				d.icon='sandp.png'


