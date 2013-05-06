mob/admin/verb
	Debug()
		set category = "Admin"
		if(debug)
			winshow(src,"debug",0)
			debug=0
		else
			winshow(src,"debug",1)
			debug=1

	InitialiseSQLTables()
		set category = "Admin"
		createtables()
/*
	DeleteSQLTables()
		set category = "Admin"
		deletetables()
*/
	RebuildSQLTables()
		set category = "Admin"
		deletetables()
		createtables()


mob/proc
	createtables()
		set background=1
		create_table()
		create_skill_tableA()
		create_skill_tableB()
		create_skillrank_table()
		create_passive_table()

	deletetables()
		set background=1
		delete_table()
		delete_skill_tableA()
		delete_skill_tableB()
		delete_skillrank_table()
		delete_passive_table()

/*
mob/admin/verb
	TestSkillUpload()
		var/Guide/G=new/Guide
		G.load(src.clan,src.slots[currentguide])// loads the guide your in
		insert_skill_tableA(G)
		insert_skill_tableB(G)

	TestSkillDownload()
		var/Guide/G=new/Guide
		G.load(src.clan,src.slots[currentguide])// loads the guide your in
		load_skill_tableA(G) //downloads your skills from the server
		load_skill_tableB(G) //downloads your skills from the server
*/ //tests

mob/var/alerts=1//for alerts and stuff.

mob/verb
	LoadGuides()//This is the Code for downloading Guides
		set hidden=1
		spawn()GuideLoad()

mob/proc
	GuideLoad(var/num=0)
		set background=1
		load_table(clan)
		if(LoadedGuides.len)
			alert("[LoadedGuides.len] Guide(s) have been downloaded")
			refresh_pages()
			if(num==1)Load_Savefiles()//load it for them
		else
			alert("No Guides for [clan] were found on the server, be the first to make one? :)","[clan]","Maybe")



mob/verb
	SQLInsert()//This is the Code for publishing Guides
		set hidden=1
		set background=1
		spawn()
			src.insert_table()
			if(SQLInsertion(src))
				winset(src,null,{"
				publishb.is-visible = "false";
				"})
				if(alerts)alert("Your Guide has been published succesfully.")//Your Guide id is G:[Gid]

proc
	SQLInsertion(mob/M)
		set background=1
		var/Guide/G=new/Guide
		G.load(M.clan,M.slots[M.currentguide])// loads the guide your in
		M.insert_skill_tableA(G)
		M.insert_skill_tableB(G)
		M.insert_passive_table(G)
		return 1//M.getGuideId()




mob/verb
	ClearGuides()
		set hidden=1
		switch(alert("Do you want to delete every guide saved on your pc?","","Yes","No"))
			if("Yes")
				fdel("Guides/")//maybe do this before each dump
				src<<"\[[time2text(,"Month DD, YYYY hh:mm:ss")]\] All Guides have been wiped!."
			else
				return



