/////////////////////OPTIONS////////////////////////////////////////////////
mob/var
	Alert="On"//game alerts on/off
	Dview="featured"//or "orientate" //the default bottom view

mob/verb
	options()
		set hidden=1
		winset(src,null,{"
			main2.left = "options";
			"})
		gamesettings()


	closeoptions()
		set hidden=1
		winset(src,null,{"
			main2.left = "updates";
			"})

	optionbuild()
		set hidden=1
		Dview="orientate"
		gamesettings()

	optionfeature()
		set hidden=1
		Dview="featured"
		alert("Warning: setting the Featured skills pane as default may cause slight loading time delays","Options")
		gamesettings()

	alerton()
		set hidden=1
		Alert="On"
		gamesettings()

	alertoff()
		set hidden=1
		Alert="Off"
		alert("Warning: This disables all extra-info and Guide assistance from the planner","Options")
		gamesettings()




mob/proc
	gamesettings()
		if(Alert)
			winset(src,null,{"
				alertlabel.text = "[Alert]";
				"})

		if(Dview)
			winset(src,null,{"
				dviewlabel.text = "[Dview]";
				"})

		winset(src,null,{"
			orientatechild.left = "[Dview]";
			"})

		if(Dview=="featured")
			spawn() load_jutsusbought(src)

		SafeSave(src)