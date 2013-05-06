mob
	var/list/RawData=list()//raw data
	var/list/SortedRawDataViews=list()//sorted data
	var/list/SortedRawDataLikes=list()//sorted data
	var/list/SortedRawDataDate=list()//sorted data
	var/AsocList[0]//divided into 7's and assigned to Page associatively
	var/tmp/sort="views"//default
	var/list/slots=list()
	var/page=1

var/primerouno=""

Page
	var/number
	var/list/slots=list()
	var/list/sortedlist=list()//raw

	var/busy=0// cant sort atm

	New()
		..()
		if(!primerouno)
			primerouno=src

	proc/Generate()
		if(src==primerouno)
			slots=new()
			usr.slots=new()

			var/x=sortedlist.len
			var/list/L=sortedlist
			for(var/i=x, i>0, i--)//test from x->0
				var/slot=L[1]
				L.Remove(slot)//remove the entry
				slots.Add(slot)// add it to the page list
				usr.slots.Add(slot)// for liking and viewing

			save()
			usr.slotloader()

		else
			spawn()
				slots=new()
				var/x=sortedlist.len
				var/list/L=sortedlist
				for(var/i=x, i>0, i--)//test from x->0
					var/slot=L[1]
					L.Remove(slot)//remove the entry
					slots.Add(slot)// add it to the page list
				save()
				usr.slotloader()





	proc/save()
		var/savefile/s=new("Guides/tmp/Pages[number].sav")
		s["slots"] << slots

	proc/load()
		var/savefile/s=new("Guides/tmp/Pages[number].sav")
		s["slots"] >> slots


////////////////////////////////////////
mob
	proc
		Load_Savefiles()
			set hidden=1

			var/filelistx = flist("Guides/tmp/")
			if(length(filelistx) != 0)
				for(var/m in filelistx)
					fdel(m)

			RawData=new()
			var/filelist = flist("Guides/[clan]/")
			if(length(filelist) != 0)
				for(var/m in filelist)
					RawData.Add(m)

				DataSort()
			else
				switch(alert(src,"No Files for [clan] would you like to check the server?","[clan] Guides","Yes","No"))
					if("Yes")
						GuideLoad(1)//so they can call the load saves again
				winset(src,null,{"
				Loader.text = "Loading...";
				Loader.is-visible = "false";
				"})

		DataSort()
			switch(sort)
				if("views")
					sortviews(RawData)
				if("likes")
					sortlikes(RawData)
				if("date")
					sortdate(RawData)
				if("own")
					sortown(RawData)
			PageSort()

		PageSort()
			AsocList=new()
			var/num=1//want 1 page minimum
			var/list/L=RawData

			if(L.len>7)

				//world<<"Raw Data is [L.len]"

				num=CEIL(L.len/7) // add a page for the rest of the values

				//world<<"Raw Data is rounded to roughly [num] pages"

			maxpage=num

			winset(src,null,{"
				pagelabel.text = "1 of [maxpage]";
				Loader.text = "Loading....";
				"})

			var/list/x// a temporary list to store data

			for(var/i=1, i<maxpage+1, i++)// loops through the ammount of pages we need
				x=new()//makes a new list x for us to use
				if(L.len>7)//nothing left, stop the loop
					x=L.Copy(1,8)//copies 7 items to the temp list
					L.Cut(1,8)//removes them from the selection
					AsocList["[i]"]=x//adds the list x the [i] page
				else
					x=L.Copy(1,0)//copies the rest of the items to the temp list
					L.Cut(1,0)//removes the rest of the items from the selection
					AsocList["[i]"]=x//adds the list x the [i] page


			var/i
			for(i in AsocList)
				//world<<"Page [i] now has [AsocList[i]] items"
				var/Page/P =new/Page
				P.number=i//page number
				P.sortedlist=AsocList[i]//page items
				spawn() P.Generate()







var/maxpage
mob
	verb
		nextpage()
			set hidden=1
			usr.page++
			if(usr.page>maxpage)
				usr.page=maxpage
				return
			winset(src,null,{"
				pagelabel.text = "[usr.page] of [maxpage]";
				"})
			clear_pages()
			slotloader()

		backpage()
			set hidden=1
			usr.page--
			if(usr.page<1)
				usr.page=1
				return
			winset(src,null,{"
				pagelabel.text = "[usr.page] of [maxpage]";
				"})
			clear_pages()
			slotloader()



mob
	proc
		assign_pages()
			set background =1
			winset(src,null,{"
				clanlabel2.text = "Guides for: [clan]";
				"})
			clear_pages()
			Load_Savefiles()



		clear_pages()
			set background =1
			winset(src,null,{"
			Loader.text = "Loading...";
			Loader.is-visible = "false";
			"})
			var/x=7
			var/num=0
			for(var/i=x, i>0, i--)//generate all pages
				num++
				winset(src,null,{"
					slot[num].is-visible = "false";
					slot[num]desc.is-visible = "false";
					slot[num]date.is-visible = "false";
					slot[num]view.is-visible = "false";
					slot[num]viewn.is-visible = "false";
					slot[num]like.is-visible = "false";
					slot[num]liken.is-visible = "false";
					"})


		refresh_pages()
			primerouno=""//reset
			page=1
			winset(src,null,{"
				pagelabel.text = "[usr.page] of [maxpage]";
				"})
			assign_pages()




mob
	verb
		closeguide()
			set hidden=1
			winset(src,null,{"
			default.main.left = "info";
			"})
			refresh_pages()



//////////////Guide Sort
mob
	var/busy=0
	verb
		sortviewsz()
			set hidden=1
			sort="views"
			sortviews(RawData)
			refresh_pages()

		sortlikesz()
			set hidden=1
			sort="likes"
			sortlikes(RawData)
			refresh_pages()

		sortdatez()
			set hidden=1
			sort="date"
			sortdate(RawData)
			refresh_pages()

		sortownz()
			set hidden=1
			sort="own"
			sortown(RawData)
			refresh_pages()



	proc
		sortviews(list/Q)
			var/BIG=0//changing number
			var/max=Q.len
			var/list/L=Q

			if(!max||busy) return
			busy=1
			RawData=new()
			SortedRawDataViews=new()

			for(var/x in L)
				var/Guide/G=new/Guide
				G.load(usr.clan,x,0)// load the first guide

				if(G.views>=BIG)
					world<<"[G.views]"
					SortedRawDataViews.Insert(1,x)//add it to the list
					L.Remove(x)//remove it from the list
					BIG=G.views
				else
					SortedRawDataViews.Add(x)//add it to the list
					L.Remove(x)//remove it from the list

			usr.sort="views"//sort pages by views now
			RawData=SortedRawDataViews
			busy=0



		sortlikes(list/Q)
			var/BIG=0//changing number
			var/max=Q.len
			var/list/L=Q

			if(!max||busy) return
			busy=1
			RawData=new()
			SortedRawDataLikes=new()

			for(var/x in L)
				var/Guide/G=new/Guide
				G.load(usr.clan,x,0)// load the first guide

				if(G.likes>=BIG)
					SortedRawDataLikes.Insert(1,x)//add it to the list
					L.Remove(x)//remove it from the list
					BIG=G.likes
				else
					SortedRawDataLikes.Add(x)//add it to the list
					L.Remove(x)//remove it from the list


			usr.sort="likes"//sort pages by likes now
			RawData=SortedRawDataLikes
			busy=0


		sortdate(list/Q)
			var/BIG=0//changing number start
			var/max=Q.len
			var/list/L=Q

			if(!max||busy) return
			busy=1
			RawData=new()
			SortedRawDataDate=new()

			for(var/x in L)
				var/Guide/G=new/Guide
				G.load(usr.clan,x,0)// load the first guide

				if(G.id>=BIG)
					SortedRawDataDate.Insert(1,x)//add it to the list
					L.Remove(x)//remove it from the list
					BIG=G.id
				else
					SortedRawDataDate.Add(x)//add it to the list
					L.Remove(x)//remove it from the list


			usr.sort="date"//sort pages by date now
			RawData=SortedRawDataDate
			busy=0

		sortown(list/Q)
			var/max=Q.len
			var/list/L=Q

			if(!max||busy) return
			busy=1
			RawData=new()
			SortedRawDataDate=new()

			for(var/x in L)
				var/Guide/G=new/Guide
				G.load(usr.clan,x,0)// load the first guide

				if(G.owner==src.ckey)
					SortedRawDataDate.Insert(1,x)//add it to the list
					L.Remove(x)//remove it from the list
				else
					SortedRawDataDate.Remove(x)//remove it from the list
					L.Remove(x)//remove it from the list


			usr.sort="own"//sort pages by date now
			RawData=SortedRawDataDate
			busy=0





		slotloader(usr.page)
			set background =1
			winset(src,null,{"
			Loader.text = "Loading...";
			Loader.is-visible = "false";
			"})

			var/Page/P=new/Page
			P.number=usr.page
			P.load(P.number)
			usr.slots=P.slots//for liking and viewing the page
			var/x=P.slots.len//should be 7
			var/num=0
			for(var/i=x, i>0, i--)//test from x->0
				num++
				var/Guide/G=new/Guide
				G.load(src.clan,P.slots[num],0)// load the guides
				winset(src,null,{"
					slot[num].is-visible = "true";
					slot[num]desc.is-visible = "true";
					slot[num]date.is-visible = "true";
					slot[num]view.is-visible = "true";
					slot[num]viewn.is-visible = "true";
					slot[num]like.is-visible = "true";
					slot[num]liken.is-visible = "true";

					slot[num]desc.text = "[G.description]";
					slot[num]date.text = "[G.date]";
					slot[num]liken.text = "[G.likes]";
					slot[num]viewn.text = "[G.views]";
					"})




		loadslots()
			assign_pages()
			winset(src,null,{"
					Loader.is-visible = "true";
					Loader.text = "Loading.";
					default.main.left = "info";
					"})

			//alert(src,"[src.RawData.len]")// this was to test how many pages got generated.









