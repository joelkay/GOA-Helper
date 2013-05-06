mob/proc/insert_table2()//updated version 2
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/Guide/G=new/Guide
		G.load(src.clan,src.slots[currentguide])// loads the guide
		var/DBQuery/resultset1 = connector.runQuery(dbconnection,"INSERT INTO `GOAHelper` (ckey, name) VALUES('[ckey]','[G.name]')")
		if(resultset1)
			if(debug) src << "Phase1: Okay"
			resultset1.Close(); //free up and erase data.
		else
			resultset1.Close();
			if(debug) src << "Failed."

		//INITIATE THE GUIDE
		var/SQLQuery
		SQLQuery+="UPDATE GOAHelper SET clan='[G.clan]', date='[G.date]', description='[G.description]', views='[G.views]'"
		SQLQuery+=",likes='[G.likes]', creator='[G.creator]', descr='[G.descr]'"
		SQLQuery+=",pros='[G.pros]', cons='[G.cons]', skillpoints='[G.skillpoints]'"
		SQLQuery+=",str1='[G.str1]', rfx1='[G.rfx1]', con1='[G.con1]'"
		SQLQuery+=",ent1='[G.int1]', lvl1='[G.lvl1]' WHERE name='[G.name]' AND ckey='[G.owner]'"

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."

SQLQuery+="ALTER TABLE GOAHelperPassives ADD ("
var/i=0
		while(i<40)// go through each passive
			sleep(2)
			i++
			SQLQuery+="passive[i] INT(3)"//cant get above 3digit passives
			if(i<39)SQLQuery+=","//making sure to put a comma beside all values, minus the last one
			if(debug) world << "passive[i] Okay"

SQLQuery+=")"


SQLQuery+="INSERT INTO `GOAHelperRank` (Skillname,Rank,Votes,Bought) VALUES"
while(i<=jlistA.len)//1 - 55 jutsu in the game
			var/Jutsu/J = jlistA[i]
			sleep(2)
			SQLQuery+="('[J.sindex]','0','0','0')"//
			if(i<jlistA.len) SQLQuery+=","
			if(debug) world << "Jutsu(A)[i]:[J] Okay"
			i++//continue looping
SQLQuery+=";"



mob
	verb
		Test()
			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])// loads the guide
			var/SQLQuery
			SQLQuery+="UPDATE GOAHelper SET clan='[G.clan]', date='[G.date]', description='[G.description]', views='[G.views]'"
			SQLQuery+=",likes='[G.likes]', creator='[G.creator]', descr='[G.descr]'"
			SQLQuery+=",pros='[G.pros]', cons='[G.cons]', skillpoints='[G.skillpoints]'"
			SQLQuery+=",str1='[G.str1]', rfx1='[G.rfx1]', con1='[G.con1]'"
			SQLQuery+=",ent1='[G.int1]', lvl1='[G.lvl1]' WHERE name='[G.name]' AND ckey='[G.owner]'"

			src<<SQLQuery