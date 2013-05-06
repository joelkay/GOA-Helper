mob/verb
	orient()
		set hidden=1
		winset(src,null,{"
			orientatechild.left = "orientate";
			"})
		Orientate()//do the maths

mob/verb
	featured()
		set hidden=1
		winset(src,null,{"
			orientatechild.left = "featured";
			"})
		spawn() load_jutsusbought(src)


mob/verb
	search()
		set hidden=1
		jlistA()//create a list of all jutsu in table A
		jlistB()//create a list of all jutsu in table B
		var/Jutsu/S = input("Which Skill would you like to look up?","Search") in list("Cancel") + jlistA + jlistB
		if(S=="Cancel")return
		spawn() load_jutsusbought(src,S)


mob/var/list/loadedimages=list()

proc/load_jutsusbought(mob/M,var/Jutsu/S=null)//parse through a Guide

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	for(var/I in M.loadedimages)
		del(I)

	M.Featured=0
	M.vnum=0
	winset(M,null,{"
		ranklabel.text = "Rate this skill";
		Sname.text = "Skill";
		Sbought.text = "";
		ranklabel2.text = "";
		"})


	if(dbconnection)
		if(!S)
			jlistA()//create a fresh list of all jutsu in table A
			jlistB()//create a fresh list of all jutsu in table B
			var/Jutsu/J=pick(jlistA)
			var/Jutsu/K=pick(jlistB)

			S=pick(J,K)

		S.screen_loc="featuredmap:1,1"
		M.client.screen+=S // Add it to the screen
		M.loadedimages.Add(S)

		spawn() M.Ranked(S)

		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT Bought,Rank FROM `GOAHelperRank` WHERE Skillname='[S.sindex]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()

				for(var/D in row_data)
					if(D=="Bought")
						//var/ntext = copytext("[D]",8)//this should give the number of the passive
						if(debug) world<<"[D] = [row_data[D]]"


						var/nnum = text2num(row_data[D])//convert them to numbers


						winset(M,null,{"
						Sname.text = "[S.sname]";
						Sbought.text = "[nnum]";
						"})


				for(var/D in row_data)
					if(D=="Rank")
						if(debug) world<<"[D] = [row_data[D]]"

						if(text2num(row_data[D])>0)//if its ranked display the stars
							M.download(S.sindex)











mob
	var/Featured=0
	var/vnum=0
	var/Voted[0]

	proc/upload(var/S,num)//S= Skill passed through
		if(S in Voted)
			spawn() usr.download(S)
			return

		else
			Featured=0//reset his view
			vnum=0
			spawn() SkillRank(src,S,num)


			Voted[S]=num//saving var so you cant vote twice




	proc/download(var/S)

		if(!Featured&&!vnum)
			spawn() LoadRanks(src,S)

		else
			for(var/obj/Star/St in world)
				if(St.num<=Featured)
					St.icon_state="y"

			var/v
			if(S in Voted)
				v=Voted[S]

				winset(src,null,{"
					ranklabel2.text = "Your rating:[v]/[Featured]";
					"})

			winset(src,null,{"
					ranklabel.text = "Based on [vnum] votes.";
					"})



obj
	Box
		icon='bg.dmi'
		New()
			..()
			src.icon+=rgb(117,58,0)//the nice brown

	Star
		icon='star.dmi'
		var/num=0
		var/Skill

		Click()
			usr.upload(src.Skill,src.num)


		MouseEntered()
			if(num==5)
				icon_state="y"
				for(var/obj/Star/S in world)
					if(S.num<=5)
						S.icon_state="y"
					else
						S.icon_state="n"

			if(num==4)
				icon_state="y"
				for(var/obj/Star/S in world)
					if(S.num<=4)
						S.icon_state="y"
					else
						S.icon_state="n"

			if(num==3)
				icon_state="y"
				for(var/obj/Star/S in world)
					if(S.num<=3)
						S.icon_state="y"
					else
						S.icon_state="n"

			if(num==2)
				icon_state="y"
				for(var/obj/Star/S in world)
					if(S.num<=2)
						S.icon_state="y"
					else
						S.icon_state="n"

			if(num==1)
				icon_state="y"
				for(var/obj/Star/S in world)
					if(S.num<=1)
						S.icon_state="y"
					else
						S.icon_state="n"


		MouseExited()
			icon_state="n"
			for(var/obj/Star/S in world)
				S.icon_state="n"

			if(usr.Featured)//if they have the data
				usr.download(src.Skill)//refresh
			//else wait and chill for them to vote




		Yes
			icon_state="y"

		No
			icon_state="n"

mob
	proc/Ranked(var/Jutsu/J)
		var/obj/Box/B=new/obj/Box
		B.screen_loc="rankedmap:1,1:-1 to 5,1"
		src.client.screen+=B // Add it to the screen

		for(var/i=1,i<6,i++)
			var/obj/Star/S=new/obj/Star/No
			S.screen_loc="rankedmap:[i],1"
			S.num=i
			S.Skill=J.sindex
			src.client.screen+=S // Add it to the screen







proc
	SkillRank(mob/M,var/S,num)//ammount of times skill has been bought 1 = add, 0 = subtract
		set background=1
		var/dbConnection/connector = new()
		var/dbconnection=connector.getConnection(connector.getDbi())

		if(debug) alert("Skill:[S] Rank:[num]")

		if(dbconnection)
			var/DBQuery/resultset = connector.runQuery(dbconnection,"UPDATE GOAHelperRank SET Rank = Rank + [num], Votes = Votes + 1 WHERE Skillname='[S]'")
			if(resultset)
				if(debug) world << "Rank Upload: Okay"
				resultset.Close() //free up and erase data.
			else
				resultset.Close()
				if(debug) world << "Rank Upload: Failed."

		spawn() M.download(S)


	LoadRanks(mob/M,var/S)//This loads the skills Ranks
		set background=1
		var/dbConnection/connector = new()
		var/dbconnection=connector.getConnection(connector.getDbi())

		if(debug) alert("Skill:[S]")

		if(dbconnection)
			var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT Rank,Votes FROM `GOAHelperRank` WHERE Skillname='[S]'")
			var/ranknum
			var/votenum
			if(resultset.RowCount() > 0)
				while(resultset.NextRow())
					var/list/row_data = resultset.GetRowData()

					for(var/D in row_data)
						if(D=="Rank")//if there is data
							//var/ntext = copytext("[D]",8)//this should give the number of the passive
							if(debug) world<<"[D] = [row_data[D]]"
							ranknum = text2num(row_data[D])//convert them to numbers

					for(var/D in row_data)
						if(D=="Votes")//if there is data
							//var/ntext = copytext("[D]",8)//this should give the number of the passive
							if(debug) world<<"[D] = [row_data[D]]"
							votenum = text2num(row_data[D])//convert them to numbers

			if(debug) world<<"Rank:[ranknum] Votes:[votenum]"

			if(votenum<=0)
				if(debug) world<<"Divide by 0 error"
				return

			var/average=ranknum/votenum

			if(debug) world<<"Average:[average]"

			var/final=round(average)//(average,5)

			if(debug) world<<"Stars:[final]"

			for(var/obj/Star/St in world)
				if(St.num<=final)
					St.icon_state="y"

			winset(M,null,{"
					ranklabel.text = "Based on [votenum] votes.";
					"})

			M.Featured=final
			M.vnum=votenum

			var/v
			if(S in M.Voted)
				v=M.Voted[S]

				winset(M,null,{"
					ranklabel2.text = "[v]/[final]";
					"})

/*

mob/proc/CreateDrop()
	var/obj/Drop/O = new/obj/Drop
	O.screen_loc="Dropmap:1,1"
	src.client.screen+=O // Add it to the screen

obj
	Drop
		icon='drag.dmi'
		icon_state="drop"
		var/oneloop=0

		proc/Run(mob/M,var/Jutsu/S)
			if(debug) alert("[S.sindex]")

			spawn()
				load_jutsusbought(M,S,1)
*/