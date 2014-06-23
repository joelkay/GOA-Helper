mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("buy")
			var/sname = href_list["name"]
			var/element= href_list["element"]
			var/value= text2num(href_list["cost"])
			if(usr.previewguide) return

			if(element)
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
			switch (alert("Obtain [sname] for [value] points?","Skill Obtain","Yes","No"))
				if("Yes")
					if(usr.skillpoints-value<0)
						alert("You do not have enough skillpoints to purchase this skill [skillpoints]/[value]")
						return

					initiatelist()// makes all the jutsus


					if(!element)
						var/Jutsu/SKILL
						for(var/Jutsu/J in jlist)
							if(J.sname==sname)
								SKILL=J

						if(debug)usr<<"[SKILL]"

						if(SKILL.skill_reqs)
							for(var/R in SKILL.skill_reqs)
								usr<<"[R]"// for debug
								if(R in usr.jutsulist)continue
								else
									alert("You do not have the required jutsu [R].","Skill Obtain")
									return
						usr.contents.Add(SKILL)// to be shown
						usr.jutsulist.Add(SKILL.sindex)//prereqs etc
						spawn()SkillBuy(SKILL.sindex,1)//update server

					else
						usr.jutsulist.Add(element)//elements in jutsu list can be retrieved :D
						usr.elements.Add(element)//elements
						spawn()SkillBuy(element,1)//update server


					usr.skillpoints-=value

					alert(src,"You have obtained [sname]!","Skill Obtain")
					UpdateSkills()//add it
					coverskills()

				if("No")
					return



		if("sell")
			var/sname = href_list["name"]
			var/element= href_list["element"]
			var/value= text2num(href_list["cost"])
			if(usr.previewguide) return

			if(element)
				switch(usr.elements.len)
					if(1)
						value=250
					if(2)
						value=450
					if(3)
						value=650
					if(4)
						value=850
					else // 5
						value=1050
			switch (alert("Sell [sname] for [value] points?","Skill Refund","Yes","No"))
				if("Yes")
					initiatelist()// makes all the jutsus
					if(!element)
						var/Jutsu/SKILL
						for(var/Jutsu/J in jlist)
							if(J.sname==sname)
								SKILL=J

						if(debug)usr<<"[SKILL]"

						for(var/Jutsu/J in contents)
							if(J.sname==sname)
								del(J)

						usr.jutsulist.Remove(SKILL.sindex)//prereqs etc
						spawn() SkillBuy(SKILL.sindex,0)//update server

					else
						usr.jutsulist.Remove(element)//elements in jutsu list can be retrieved :D
						usr.elements.Remove(element)//elements
						spawn()SkillBuy(element,0)//update server

					usr.skillpoints+=value

					alert(src,"You have got a Refund for [sname]!","Skill Refund")
					UpdateSkills()//add it
					clearcovers()




				if("No")
					return

		else
			return ..()



mob/proc
	clearcovers()
		for(var/Jutsu/J in world)
			J.overlays=null
		coverskills()//refresh basically

	coverskills()
		for(var/Jutsu/X in world)
			if(X.sindex in jutsulist)
				if(X in contents)continue
				else
					X.overlays+='cover.dmi'


proc
	SkillBuy(var/S,num)//Skill Rating
		set background=1
		var/dbConnection/connector = new()
		var/dbconnection=connector.getConnection(connector.getDbi())

		if(dbconnection)
			var/DBQuery/resultset

			if(num)
				resultset = connector.runQuery(dbconnection,"UPDATE GOAHelperRank SET Bought = Bought + 1 WHERE Skillname='[S]'")
			else
				resultset = connector.runQuery(dbconnection,"UPDATE GOAHelperRank SET Bought = Bought - 1 WHERE Skillname='[S]'")

			if(resultset)
				if(debug) world << "Buy Upload: Okay"
				resultset.Close() //free up and erase data.

			else
				resultset.Close()
				if(debug) world << "Buy Upload: Failed."



