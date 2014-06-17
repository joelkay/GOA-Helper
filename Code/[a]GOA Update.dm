mob/proc
	adverts(var/num)
		switch(num)
			if(1)//front page ads
				var/ad=pick(1,2)
				switch(ad)
					if(1)
						src << output("<font size=1><font color = blue><b><u><a href='http://bit.ly/116hD01'>:my other projects</a></font>","advertoutput")//adverts :D
						src << output("<font size=1><font color = blue><b><u><a href='http://bit.ly/116hD01'>my other projects</a></font>","planneroutput")

					if(2)
						src << output("<font size=1><font color = blue><b><u><a href='http://jsqribe.juplo.com/blog/sample-page/4-2'>:find guides online</a></font>","advertoutput")//adverts :D
						src << output("<font size=1><font color = blue><b><u><a href='http://jsqribe.juplo.com/blog/sample-page/4-2'>find guides online</a></font>","planneroutput")

			if(2)//in guide ads
				var/ad=pick(1,2)
				switch(ad)
					if(1)
						src << output("<font size=1><font color = blue><b><u><a href='http://bit.ly/116hD01'>my other projects</a></font>","guideoput")//adverts :D
						src << output("<font size=1><font color = blue><b><u><a href='http://bit.ly/116hD01'>my other projects</a></font>","planneroput")
					if(2)
						src << output("<font size=1><font color = blue><b><u><a href='http://jsqribe.juplo.com/blog/sample-page/4-2'>find guides online</a></font>","guideoput")//adverts :D
						src << output("<font size=1><font color = blue><b><u><a href='http://jsqribe.juplo.com/blog/sample-page/4-2'>find guides online</a></font>","planneroput")

				//src << output("<font size=1><font color = blue><b><u><a href='http://bit.ly/116hD01'>:my other projects</a></font>","guideoput")//adverts :D
				//src << browse("<body disabledload=\"window.location.href='http://jsqribe.juplo.com/blog/sample-page/4-2'\">","updatez")
				//show web page inplace of updates


////////////////////////////////////////////////////////////////////////////////////////////////////////

var/version=2.1
var/guidesdelete=0//change to 1 if you want the update to ask people to delete stuff

////////////////////////////////////////////////////////////////////////////////////////////////////////

upForm
	updates
		// A closewindow is a window designed to be Xed out by the viewers
		// The instance is deleted right after it displays the page to the viewers
		form_name = "updatez"
		window_size = "544x544"
		form_type = UPFORM_INTERFACE
		GenerateBody()
			var/page = {"<body bgcolor="#763900" text="#cfc9c6">
				Welcome to GOA Helper [usr]!, Below is a log of all updates<br />
				<b>
				<font color =black>
				Version: [version]<br />
				->Updated for GOA Classic.<br />
				->Server back online for guide saving/loading.<br />
				</b>
				<br />

				<font color =grey><>Update Log:<>
				<br />

				<font color =grey>
				Version: 2.0<br />
				->MySQL queries have been updated. Uploading guides should be faster now.<br />
				->New MySQL server, slight increase in upload speed.<br />
				->Added Chakra Enhancement and Hidden Lotus.<br />
				</b>
				<br />

				Version: 1.5<br />
				->New Features! Genjutsu Dice and Featured Skills.<br />
				->New Features! Options: work in progress, you can find this at the login screen.<br />
				->Added Taijutsu Stances.<br />
				->Updated all skill costs up to Feral's last update.
				->More passives have been activated and can be shown in the Damage Information.
				->Capacity Chakra/Regen Added.
				->Fixed skillpoint costs of several skills.<i><font size =1> Bug Report: Kaguya BB</i></font><br />
				<br />

				Version: 1.1<br />
				->changes to the map section, skills now display a border when they have been bought.<br />
				->Elements now show how much they cost when stacked.<i><font size =1> Bug Report: AdamJay</i></font><br />
				->some fixes to some of the elements not buying properly.<i><font size =1> Bug Report: AdamJay</i></font><br />
				<br />

				Version: 1.0<br />
				 -> Guide section revamp,it is now easier to make/publish guides.<br />
				 -> Fixed partial builds <font size =1><i>Bug Report: Takezo</i></font>.<br />
				 -> Fixed reset function in the planner, it now resets passives. <font size =1><i>Bug Report: Takezo</i></font>.<br />
				 -> Added a remove passive feature <font size =1><i>Feature Suggestion: Takezo</i></font>.<br />
				 -> Stamina and Chakra formulas are still not up to date,waiting on Dipic..<br />
				 <br />

				Version: 0.5<br />
				 -> Added MySql functionality, Guides can now be published and downloaded.<br />
				 -> Added partial build, you can now do a build for x levels at a time.<br />
				 -> Added reset function in the planner, it is easier to redo builds if you mess up.<br />
				 -> Updated passives(added kawa passive).<br />
				 -> Stamina and Chakra formulas are not up to date, still trying to figure the new ones out.<br />
				 <br />

				Version: 0.1<br />
				-> Added Genius Clan, need to sort out the sp gain.<br />
				-> Fixed NailFlower, correct sp cost.<br />
				</body>
			"}

			UpdatePage(page)




mob/verb
	GuidesLink()
		set hidden=1
		src << link("http://jsqribe.juplo.com/blog/sample-page/4-2")









///////////COMPATIBILITY STUFFS///////////////////////////
mob
	Login()//MAIN LOGIN
		..()
		load()//load version
		if(guidesdelete&&versionplayed<version)
			switch(alert("You are playing on a new version of GOA Helper, All Guides will be purged from your local folder for compatibility issues. Is this Okay?","Compatibility","Yes","No"))
				if("Yes")
					fdel("Guides/")//maybe do this before each dump
					alert("All Guides Have been wiped, you may download new copies by visiting the Guides Section. Have Fun")
					versionplayed=version
					SafeSave(src)

				if("No")
					//fdel("Guides/")//maybe do this before each dump
					alert("Your folder is untouched, you can always manually delete your Guides folder if you need to. Have Fun")
					versionplayed=version
					SafeSave(src)


		else
			if(versionplayed<version)
				alert("Your Guides are compatible with this version of GOA Helper, Updates for version:[version] are shown on the right panel. Have Fun")
				versionplayed=version
				SafeSave(src)

		if(Dview)
			winset(src,null,{"
				orientatechild.left = "[Dview]";
				"})

			if(Dview=="featured")
				spawn() load_jutsusbought(src)

			//CreateDrop()


	Logout()
		SafeSave(src)
		..()

mob
	var/versionplayed=0//save this far for compatibility shizzles
	var/list/liked=list()//list of guides they liked that get save
	var/list/viewed=list()//list of guides they viewed that get save


	proc/load()//to reduce on load overhead call it with a 0.
		var/savefile/s=new("tmp/Settings.sav")
		s["versionplayed"] >> versionplayed
		s["liked"] >> liked
		s["viewed"] >> viewed
		s["Voted"] >> Voted
		s["Alert"] >> Alert
		s["Dview"] >> Dview
		if(!liked)
			liked = list()

		if(!viewed)
			viewed = list()

		if(!Voted)
			Voted = list()


proc/SafeSave(mob/M)
	var/savefile/s=new("tmp/Settings.sav")
	s["versionplayed"] << M.versionplayed
	s["liked"] << M.liked
	s["viewed"] << M.viewed
	s["Voted"] << M.Voted
	s["Alert"] << M.Alert
	s["Dview"] << M.Dview
