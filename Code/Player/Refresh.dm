mob
	verb
		ResetBuild()
			set hidden=1
			Refresh()

mob
	proc
		Refresh()

			clevel=0

			stamina=2500
			chakra=500

			staminaregen=0
			chakraregen=0

			wounds=100

			str=50
			strbuff=0
			strneg=0

			con=50
			conbuff=0
			conneg=0

			rfx=50
			rfxbuff=0
			rfxneg=0

			int=50
			intbuff=0
			intneg=0

			skillpoints=0

			elements=new()
			jutsulist=new()//reset them
			contents=new()//reset

			winset(src,null,{"
			levelinput.text = "";
			strinput.text = "";
			intinput.text = "";
			coninput.text = "";
			rfxinput.text = "";
			"})

			for(var/i=1, i<=skillspassive.len, i++)
				skillspassive[i]=0

			Orientate()//do the maths
			clearcovers()//remove covers an dat
			Playerini()//give them starting jutsus

			spawn()
				for(var/obj/gui/passives/gauge/Q in world)
					src.client.Passive_Refresh(Q)

