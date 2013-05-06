///////////////////////////////////////////////////////////////
mob/verb
	ReturnGuide()//They Return to Guide Creator then publish guide. THIS IS ALSO THE SAVE GUIDE BASICALLY
		set hidden=1
		var/Guide/G=new/Guide
		G.load(src.clan,src.slots[currentguide])

		G.skillpoints=src.skillpoints//skillpoints left
		G.skills=src.jutsulist//the skill list to be sent to server, load it appropriately
		G.elements=src.elements//the elements list to be sent to server, load it appropriately
		G.skillspassive=src.skillspassive

		winset(src,null,{"
			default.main2.left = "updates";
			default.main.left = "viewguide";
			guidename.text="[G.description]";
			"})
		G.save()
		viewGuide(G)
		winset(src,null,{"
			publishb.is-visible = "true";
			"})

		alert("Note: You will have to publish your guide again to save changes to the servers","Guide:Publish")


mob/verb
	GuideHelp()
		set hidden=1
		var/text={"Welcome to the Guide creator,all your changes are saved automatically to your Guide Folder. After editing a section you have the option to publish and make your Guide public.
			"}
		alert(src,"[text]")
/////////////////////////////////////////////////////////////////