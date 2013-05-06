Guide
	parent_type = /obj/

	var
		id
		clan
		date=""
		views=0
		likes=0
		description=""
		owner//the ckey
		creator// ign
		//////////////////////////////
		descr="Example:Typical youth build"
		pros="Example:-> You have nice regen and a load of stamina"
		cons="Example:-> most probably lose to genjutsu users"
		//////////////////////////////
		skillpoints=0
		skillspassive[40]
		//////////////////////////////
		published=0
		//////////////////////////////
		phases
		//////////////////////////////
		lvl1=100
		con1=3
		rfx1=0
		int1=0
		str1=3
		//////////////////////////////
		//////////////////////////////
		lvl2
		con2
		rfx2
		int2
		str2
		//////////////////////////////
		//////////////////////////////
		lvl3
		con3
		rfx3
		int3
		str3
		//////////////////////////////
		//////////////////////////////
		lvl4
		con4
		rfx4
		int4
		str4
		//////////////////////////////
		//////////////////////////////
		lvl5
		con5
		rfx5
		int5
		str5
		//////////////////////////////
		list/skills=list()
		list/elements=list()

	proc/save()
		var/savefile/s=new("Guides/[clan]/[name].sav")
		s["id"] << id
		s["name"] << name
		s["clan"] << clan
		s["date"] << date
		s["views"] << views
		s["likes"] << likes
		s["description"] << description
		s["owner"] << owner
		s["creator"] << creator
		//////////////////////////////////////
		s["descr"] << descr
		s["pros"] << pros
		s["cons"] << cons
		///////////////////////////////////////
		s["skillpoints"] << skillpoints
		s["skillspassive"] << skillspassive
		///////////////////////////////////////
		s["lvl1"] << lvl1
		s["con1"] << con1
		s["rfx1"] << rfx1
		s["int1"] << int1
		s["str1"] << str1
		///////////////////////////////////////
		s["lvl2"] << lvl2
		s["con2"] << con2
		s["rfx2"] << rfx2
		s["int2"] << int2
		s["str2"] << str2
		///////////////////////////////////////
		s["lvl3"] << lvl3
		s["con3"] << con3
		s["rfx3"] << rfx3
		s["int3"] << int3
		s["str3"] << str3
		///////////////////////////////////////
		s["lvl4"] << lvl4
		s["con4"] << con4
		s["rfx4"] << rfx4
		s["int4"] << int4
		s["str4"] << str4
		///////////////////////////////////////
		s["lvl5"] << lvl5
		s["con5"] << con5
		s["rfx5"] << rfx5
		s["int5"] << int5
		s["str5"] << str5
		///////////////////////////////////////
		s["skills"] << skills
		s["elements"] << elements
		s["published"] << elements





	proc/load(clanname,filename,all=1)//to reduce on load overhead call it with a 0.
		var/savefile/s=new("Guides/[clanname]/[filename]")
		s["id"] >> id
		s["name"] >> name
		s["clan"] >> clan
		s["date"] >> date
		s["views"] >> views
		s["likes"] >> likes
		s["description"] >> description
		s["owner"] >> owner
		s["creator"] >> creator
		//////////////////////////////////////////////
		if(!all)return
		s["descr"] >> descr
		s["pros"] >> pros
		s["cons"] >> cons
		///////////////////////////////////////
		s["skillpoints"] >> skillpoints
		s["skillspassive"] >> skillspassive
		///////////////////////////////////////
		s["lvl1"] >> lvl1
		s["con1"] >> con1
		s["rfx1"] >> rfx1
		s["int1"] >> int1
		s["str1"] >> str1
		///////////////////////////////////////
		s["lvl2"] >> lvl2
		s["con2"] >> con2
		s["rfx2"] >> rfx2
		s["int2"] >> int2
		s["str2"] >> str2
		///////////////////////////////////////
		s["lvl3"] >> lvl3
		s["con3"] >> con3
		s["rfx3"] >> rfx3
		s["int3"] >> int3
		s["str3"] >> str3
		///////////////////////////////////////
		s["lvl4"] >> lvl4
		s["con4"] >> con4
		s["rfx4"] >> rfx4
		s["int4"] >> int4
		s["str4"] >> str4
		///////////////////////////////////////
		s["lvl5"] >> lvl5
		s["con5"] >> con5
		s["rfx5"] >> rfx5
		s["int5"] >> int5
		s["str5"] >> str5
		///////////////////////////////////////
		s["skills"] >> skills
		s["elements"] >> elements
		s["published"] >> elements






mob
	verb
		CreateGuide()
			set hidden=1
			var/Guide/X = new/Guide
			X.name = input("Choose a name for this guide.","Guide Name",X.name)
			X.creator = input("Enter your in-game name.","Creator Name",X.creator)
			X.owner = src.ckey//save this
			X.clan=src.clan
			X.description="[X.name] created by [src.key]([X.creator])"
			X.date="[time2text(,"Month DD, YYYY at hh:mm")]"
			X.published=0// it does a build for you first time round
			winset(src,null,{"
				default.main.left = "viewguide";
				guidename.text="[X.description]";
				"})
			viewGuide(X)
			adverts(2)
			X.save()



		LikeGuide(x as num)
			set background = 1
			set hidden=1
			var/num=x

			var/Guide/G=new/Guide
			G.load(clan,slots[num])// load the guide
			if(G)
				if(G.id in src.liked)
					alert("You can only like the guide once per computer.")
					return
				else
					if(liked.len)
						liked.Add(G.id)
					else
						liked.Add(G.id)
					G.likes++
					SafeSave(src)
					G.save()
					winset(src,null,{"
					slot[num]liken.text = "[G.likes]";
					"})

					spawn()//Update server
						var/dbConnection/connector = new()
						var/dbconnection=connector.getConnection(connector.getDbi())

						if(dbconnection)
							var/DBQuery/resultset = connector.runQuery(dbconnection,"UPDATE GOAHelper SET likes = likes + 1 WHERE name='[G.name]' AND id='[G.id]'")
							if(resultset)
								if(debug) src << "Like Upload: Okay"
								resultset.Close() //free up and erase data.
							else
								resultset.Close()
								if(debug) src << "Like Upload: Failed."

		ViewGuide(x as num)
			set background = 1
			set hidden=1
			var/num=x
			currentguide=num

			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[num])// load the guide
			if(G)
				viewGuide(G)

			if(G.id in src.viewed)
				return
			else
				if(viewed.len)
					viewed.Add(G.id)
				else
					viewed.Add(G.id)
				SafeSave(src)
				G.views++
				G.save()
				winset(src,null,{"
					slot[num]viewn.text = "[G.views]";
					"})

				spawn()//Update server
					var/dbConnection/connector = new()
					var/dbconnection=connector.getConnection(connector.getDbi())

					if(dbconnection)
						var/DBQuery/resultset = connector.runQuery(dbconnection,"UPDATE GOAHelper SET views = views + 1 WHERE name='[G.name]' AND id='[G.id]'")
						if(resultset)
							if(debug) src << "View Upload: Okay"
							resultset.Close() //free up and erase data.
						else
							resultset.Close()
							if(debug) src << "View Upload: Failed."



mob/var/increate=0//this is a var that lets the guide know your working on build
mob/proc
	viewGuide(Guide/G)
		adverts(2)
		if(G)
			winset(src,null,{"
			default.main.left = "viewguide";
			guidename.text="[G.description]";
			labeldesc.text = "[G.descr]";
			labelpros.text = "[G.pros]";
			labelcons.text = "[G.cons]";

			lvl1.text = "Level 1-[G.lvl1]";
			con1.text = "Con:[G.con1]";
			str1.text = "Str:[G.str1]";
			rfx1.text = "Rfx:[G.rfx1]";
			int1.text = "Int:[G.int1]";

			lvl2.text = "Level[G.lvl2]";
			con2.text = "Con:[G.con2]";
			str2.text = "Str:[G.str2]";
			rfx2.text = "Rfx:[G.rfx2]";
			int2.text = "Int:[G.int2]";

			lvl3.text = "Level[G.lvl3]";
			con3.text = "Con:[G.con3]";
			str3.text = "Str:[G.str3]";
			rfx3.text = "Rfx:[G.rfx3]";
			int3.text = "Int:[G.int3]";

			lvl4.text = "Level[G.lvl4]";
			con4.text = "Con:[G.con4]";
			str4.text = "Str:[G.str4]";
			rfx4.text = "Rfx:[G.rfx4]";
			int4.text = "Int:[G.int4]";

			lvl5.text = "Level[G.lvl5]";
			con5.text = "Con:[G.con5]";
			str5.text = "Str:[G.str5]";
			rfx5.text = "Rfx:[G.rfx5]";
			int5.text = "Int:[G.int5]";

			guidename2.is-visible="true";
			guidename2.text="Guide brought to you by: [G.creator]";

			editdesc.is-visible = "false";
			editpros.is-visible = "false";
			editcons.is-visible = "false";
			editl1.is-visible = "false";
			editl2.is-visible = "false";
			editl3.is-visible = "false";
			editl4.is-visible = "false";
			editl5.is-visible = "false";

			returnguide.is-visible = "false";
			viewchildbot.left= "viewguidebott1";
			publishb.is-visible = "false";
			"})


		if(G.owner==ckey)
			winset(src,null,{"
			editdesc.is-visible = "true";
			editpros.is-visible = "true";
			editcons.is-visible = "true";
			editl1.is-visible = "true";

			returnguide.is-visible = "true";

			viewchildbot.left= "viewguidebott2";
			publishb.is-visible = "false";
			"})



