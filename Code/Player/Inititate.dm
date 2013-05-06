mob
	var/list/jutsulist=list()
	var/list/elements=list()
	proc
		Playerini()
			starterlist()
			contents += starterlist
			jutsulist.Add("BUNSHIN")
			jutsulist.Add("KAWARIMI")
			jutsulist.Add("SHUNSHIN")
			jutsulist.Add("EXPLODING_NOTE")
			jutsulist.Add("HENGE")
			if(loadingskills)return
			UpdateSkills()// initiate it
			clearcovers()
			clevel=0//so they can build
			int=50
			con=50
			rfx=50
			str=50
			stamina=2500
			chakra=500
			supplies=100
			staminaregen=17
			chakraregen=50
			return






/*
	verb
		viewcontents()
			for(var/M in contents)
				src<<"Contents:[M]"

	verb
		viewjutsulist()
			for(var/M in jutsulist)
				src<<"Sindex:[M]"

*/
