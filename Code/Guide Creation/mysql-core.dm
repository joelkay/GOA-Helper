//EXPORT GUIDE TO MYSQL SERVER
var/debug=0// TURN THIS TO 1 TO SEE ERROR MESSAGES E.T.C

var// my server
	my_database = "zadmin_goahelper"
	my_server = "162.243.27.121"
	server_port = 3306
	my_username = "jsqribe"
	my_password = "a3ame4e7y"


dbConnection
	proc
		getDbi(databasename = my_database ,serverip = my_server,serverport = server_port)
			set background=1
			//database name can also be refered to as
			//the schema or inital catalog - i use one named byond.

			//server ip can be a host name. Set for localhost, only change if remote.

			//serverport is 3306. No need to set this unless you changed.

			var/dbi = "dbi:mysql:[databasename]:[serverip]:[serverport]"
			return dbi




		getConnection(dbi,username = my_username,password = my_password) //returns the connection or null.
			set background=1
			//world<<"[dbi],[username],[password]"

			var/DBConnection/dbcon = new()  //This is an instance of a connection object.
			                                         //See db.html for more info on callable functions
			dbcon.Connect(dbi,username,password)
			if(dbcon.IsConnected())

				world.log << text("Connected to mysql using the dbi [].</font>",dbi)
				return dbcon

			//add logging here

			world.log << text("The connection to mysql failed using the dbi [].\n\nError Text: []</font>",dbi,dbcon.ErrorMsg())

			return null




		runQuery(DBConnection/dbcon,querytext = null) //returns the set or null
			set background=1
			if(dbcon != null && dbcon.IsConnected() && querytext !=null) //check if we are connected, and if the query is not empty.

				//var/sanitised=dbcon.Quote(querytext)
				var/DBQuery/query = dbcon.NewQuery(querytext)
				//sanitise the query and pass it through
				if(debug) world<<"[querytext]"
				query.Execute()
				return query

			world.log << text("The mysql query has failed.\n\nError Text: []</font>",dbcon.ErrorMsg())
			return null

proc/create_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset1 = connector.runQuery(dbconnection,"CREATE TABLE GOAHelper ( id INT NOT NULL AUTO_INCREMENT,name VARCHAR(30), ckey VARCHAR(30), PRIMARY KEY(id,name),UNIQUE (name))")
		if(resultset1)
			if(debug) src << "Phase:1 Okay"
		else
			resultset1.Close()
			if(debug) src << "Failed."

		var/SQLQuery
		SQLQuery+="ALTER TABLE GOAHelper ADD (clan VARCHAR(30), creator VARCHAR(30), date VARCHAR(30),views INT(20),likes INT(20)"
		SQLQuery+=",description VARCHAR(100),descr VARCHAR(200)"
		SQLQuery+=",pros VARCHAR(1000),cons VARCHAR(1000),skillpoints VARCHAR(30), lvl1 VARCHAR(30)"
		SQLQuery+=",ent1 VARCHAR(30), con1 VARCHAR(30), rfx1 VARCHAR(30) ,str1 VARCHAR(30))"

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) src << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) src << "Failed."
///////////////////////////////////////////////////////////////////////////////////////SKILL TABLE CREATION
proc/create_skill_tableA()
	set background=1
	jlistA()//create a list of all jutsu in table A
	var/i=1
	var/SQLQuery
	SQLQuery+="ALTER TABLE GOAHelperJDBA ADD ("
	while(i<=jlistA.len)//1 - 55 jutsu in the game
		var/Jutsu/J = jlistA[i]
		sleep(2)
		SQLQuery+="[J.sindex] INT(10)"// its 1 or 0
		if(i<jlistA.len)SQLQuery+=","//making sure to put a comma beside all values, minus the last one
		//if(debug) world << "Jutsu(A)[i]:[J.sindex] Okay"
		i++//continue looping
	SQLQuery+=")"

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"CREATE TABLE GOAHelperJDBA (Guidename VARCHAR(30), GuideID VARCHAR(30), PRIMARY KEY(GuideID),UNIQUE (GuideID))")
		if(resultset)
			if(debug) world << "GuideID Okay"
		else
			resultset.Close()
			if(debug) world << "Failed."

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."



proc/create_skill_tableB()
	set background=1
	jlistB()//create a list of all jutsu in table A
	var/i=1
	var/SQLQuery
	SQLQuery+="ALTER TABLE GOAHelperJDBB ADD ("
	while(i<=jlistB.len)//56 - 115 jutsu in the game
		var/Jutsu/J = jlistB[i]
		sleep(2)
		SQLQuery+="[J.sindex] INT(10)"// its 1 or 0
		if(i<jlistB.len)SQLQuery+=","//making sure to put a comma beside all values, minus the last one
		//if(debug) world << "Jutsu(B)[i]:[J] Okay"
		i++//continue looping
	SQLQuery+=")"

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"CREATE TABLE GOAHelperJDBB (Guidename VARCHAR(30), GuideID VARCHAR(30), PRIMARY KEY(GuideID),UNIQUE (GuideID))")//incase we use join later on
		if(resultset)
			if(debug) world << "GuideID Okay"
		else
			resultset.Close()
			if(debug) world << "Failed."

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."




proc/create_skillrank_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"CREATE TABLE GOAHelperRank (Skillname VARCHAR(30), Rank INT(10),Votes INT(10), Bought INT(10), PRIMARY KEY(Skillname),UNIQUE (Skillname))")
		if(resultset)
			if(debug) world << "Okay"
		else
			resultset.Close()
			if(debug) world << "Failed."

		insert_skillrank_tableA()
		insert_skillrank_tableB()


proc/insert_skillrank_tableA()
	set background=1
	var/list/Added=list()
	jlistA()//create a list of all jutsu in table A
	var/i=1
	var/SQLQuery
	SQLQuery+="INSERT INTO `GOAHelperRank` (Skillname,Rank,Votes,Bought) VALUES"
	while(i<=jlistA.len)//1 - 55 jutsu in the game
		var/Jutsu/J = jlistA[i]
		if(J.sindex in Added) continue
		Added.Add(J.sindex)
		sleep(2)
		SQLQuery+="('[J.sindex]','0','0','0')"//
		if(i<jlistA.len) SQLQuery+=","
		if(debug) world << "Jutsu(A)[i]:[J] Okay"
		i++//continue looping
	//SQLQuery+=";"

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."


proc/insert_skillrank_tableB()
	set background=1
	var/list/Added=list()
	jlistB()//create a list of all jutsu in table B
	var/i=1
	var/SQLQuery
	SQLQuery+="INSERT INTO `GOAHelperRank` (Skillname,Rank,Votes,Bought) VALUES"
	while(i<=jlistB.len)//1 - 55 jutsu in the game
		var/Jutsu/J = jlistB[i]
		if(J.sindex in Added) continue
		Added.Add(J.sindex)
		sleep(2)
		SQLQuery+="('[J.sindex]','0','0','0')"//
		if(i<jlistB.len) SQLQuery+=","
		if(debug) world << "Jutsu(B)[i]:[J] Okay"
		i++//continue looping
	//SQLQuery+=";"

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())
	if(dbconnection)
		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."

/////////////////////////////////////////////////////////////////////////////////////////////////////////////SKILL TABLES

mob/proc/create_passive_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"CREATE TABLE GOAHelperPassives (Guidename VARCHAR(30), GuideID VARCHAR(30), PRIMARY KEY(GuideID),UNIQUE (GuideID))")//incase we use join later on
		if(resultset)
			if(debug) world << "GuideID Okay"
		else
			resultset.Close()
			if(debug) world << "Failed."

		var/SQLQuery
		SQLQuery+="ALTER TABLE GOAHelperPassives ADD ("
		var/i=0
		while(i<40)// go through each passive
			sleep(2)
			i++
			SQLQuery+="passive[i] INT(3)"//cant get above 3digit passives
			if(i<40)SQLQuery+=","//making sure to put a comma beside all values, minus the last one
			if(debug) world << "passive[i] Okay"

		SQLQuery+=")"

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) src << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) src << "Failed."


////////////////////////////////////////////////////////////////////////////////////////////////////////PASSIVE TABLE
mob/var/tmp/Gid//for jutsu purpz

mob/proc/getGuideId()
	set background=1
	var/Guide/G=new/Guide
	G.load(src.clan,src.slots[currentguide])// load the guide

	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT id FROM `GOAHelper` WHERE name='[G.name]' AND ckey='[ckey]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()
				for(var/D in row_data)
					if(D=="id")
						src.Gid=text2num(row_data[D])//for the sorter
						if(debug) world<<"[Gid]"





mob/proc/insert_skill_tableA(Guide/G)
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)

		jlistA()//create a list of all jutsu in table A
		getGuideId()//gets the real ID of the Guide you are editing

		var/DBQuery/resultset1 = connector.runQuery(dbconnection,"INSERT INTO `GOAHelperJDBA` (Guidename, GuideID) VALUES('[G.name]','[Gid]')")//adds it to the table
		if(resultset1)
			if(debug) src << "Guide [G.name] id [Gid]: Okay"
			resultset1.Close(); //free up and erase data.
		else
			resultset1.Close();
			if(debug) src << "Failed.";


		var/SQLQuery
		SQLQuery+="UPDATE GOAHelperJDBA SET Guidename='[G.name]'"
		for(var/Jutsu/J in jlistA)//1 - 55 jutsu in the game
			//sleep(2)
			if(J.sindex in src.jutsulist)
				SQLQuery+=",[J.sindex]='1'"
				if(debug) src << "Jutsu [J]: Okay"
		SQLQuery+="WHERE Guidename='[G.name]' AND GuideID='[Gid]'"//1 = they have it

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."




mob/proc/insert_skill_tableB(Guide/G)
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)

		jlistB()//create a list of all jutsu in table B
		getGuideId()//gets the real ID of the Guide you are editing

		var/DBQuery/resultset1 = connector.runQuery(dbconnection,"INSERT INTO `GOAHelperJDBB` (Guidename, GuideID) VALUES('[G.name]','[Gid]')")//adds it to the table
		if(resultset1)
			if(debug) src << "Guide [G.name] id [Gid]: Okay"
			resultset1.Close(); //free up and erase data.
		else
			resultset1.Close();
			if(debug) src << "Failed.";


		var/SQLQuery
		SQLQuery+="UPDATE GOAHelperJDBB SET Guidename='[G.name]'"
		for(var/Jutsu/J in jlistB)//1 - 55 jutsu in the game
			//sleep(2)
			if(J.sindex in src.jutsulist)
				SQLQuery+=",[J.sindex]='1'"
				if(debug) src << "Jutsu [J]: Okay"
		SQLQuery+="WHERE Guidename='[G.name]' AND GuideID='[Gid]'"//1 = they have it

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."




mob/proc/insert_passive_table(Guide/G)
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)

		getGuideId()//gets the real ID of the Guide you are editing

		var/DBQuery/resultset1 = connector.runQuery(dbconnection,"INSERT INTO `GOAHelperPassives` (Guidename, GuideID) VALUES('[G.name]','[Gid]')")//adds it to the table
		if(resultset1)
			if(debug) src << "Guide [G.name] id [Gid]: Okay"
			resultset1.Close(); //free up and erase data.
		else
			resultset1.Close();
			if(debug) src << "Failed.";

		var/SQLQuery
		SQLQuery+="UPDATE GOAHelperPassives SET Guidename='[G.name]'"
		var/i=0
		while(i<skillspassive.len)// go through each passive
			i++
			sleep(2)
			if(skillspassive[i])
				SQLQuery+=",passive[i]='[ skillspassive[i] ]'"//1 = they have it
				if(debug) src << "passive[i]: Okay"
		SQLQuery+="WHERE Guidename='[G.name]' AND GuideID='[Gid]'"

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) world << "Phase: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) world << "Failed."


var/list/LoadedPassives=list()
proc/load_passive_table(Guide/G)//parse through a Guide
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())
	LoadedPassives=new
	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT * FROM `GOAHelperPassives` WHERE Guidename='[G.name]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()
				for(var/D in row_data)
					if(row_data[D])//if there is data
						var/ntext = copytext("[D]",8)//this should give the number of the passive
						if(debug) world<<"[D] : [ntext] = [row_data[D]]"

						var/nnum = text2num(ntext)//convert them to numbers

						G.skillspassive[nnum]=text2num(row_data[D])// add it in



var/list/LoadedJutsus=list()

proc/load_skill_tableA(Guide/G)//parse through a Guide
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())
	LoadedJutsus=new
	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT * FROM `GOAHelperJDBA` WHERE Guidename='[G.name]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()

				for(var/D in row_data)
					if(row_data[D])
						if(debug) world<<"[D]"
						G.skills.Add(D)//update Guide Jutsus
						LoadedJutsus.Add(D)


						//element addition///////////////////////////////////
				for(var/D in row_data)
					if(row_data[D])
						if(D=="EARTH")
							G.elements.Add("EARTH")

				for(var/D in row_data)
					if(row_data[D])
						if(D=="FIRE")
							G.elements.Add("FIRE")

				for(var/D in row_data)
					if(row_data[D])
						if(D=="LIGHTNING")
							G.elements.Add("LIGHTNING")
				for(var/D in row_data)
					if(row_data[D])
						if(D=="WATER")
							G.elements.Add("WATER")
				for(var/D in row_data)
					if(row_data[D])
						if(D=="WIND")
							G.elements.Add("WIND")
						//////////////////////////////////////////////////////


proc/load_skill_tableB(Guide/G)//parse through a Guide
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())
	LoadedJutsus=new
	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT * FROM `GOAHelperJDBB` WHERE Guidename='[G.name]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()

				for(var/D in row_data)
					if(row_data[D])
						if(debug) world<<"[D]"
						G.skills.Add(D)//update Guide Jutsus
						LoadedJutsus.Add(D)




var/list/LoadedGuides=list()

proc/load_table(var/value)//do it pre clan less laggy?
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT * FROM `GOAHelper` WHERE clan='[value]'")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()

				var/Guide/G=new/Guide
				if(G)
					for(var/D in row_data)
						if(D=="id")
							G.id=text2num(row_data[D])//for the sorter
							if(debug) world<<"[G.id]"

					for(var/D in row_data)
						if(D=="name")
							G.name=row_data[D]
							if(debug) world<<"[G.name]"

					for(var/D in row_data)
						if(D=="ckey")
							G.owner=row_data[D]
							if(debug) world<<"[G.owner]"

					for(var/D in row_data)
						if(D=="creator")
							G.creator=row_data[D]
							if(debug) world<<"[G.creator]"

					for(var/D in row_data)
						if(D=="clan")
							G.clan=row_data[D]
							if(debug) world<<"[G.clan]"

					for(var/D in row_data)
						if(D=="date")
							G.date=row_data[D]

					for(var/D in row_data)
						if(D=="views")
							G.views=text2num(row_data[D])//for the sorter

					for(var/D in row_data)
						if(D=="likes")
							G.likes=text2num(row_data[D])//for the sorter

					for(var/D in row_data)
						if(D=="description")
							G.description=row_data[D]

					for(var/D in row_data)
						if(D=="descr")
							G.descr=row_data[D]

					for(var/D in row_data)
						if(D=="pros")
							G.pros=row_data[D]

					for(var/D in row_data)
						if(D=="cons")
							G.cons=row_data[D]
					for(var/D in row_data)
						if(D=="skillpoints")
							G.skillpoints=text2num(row_data[D])//for various stuff
					for(var/D in row_data)

						if(D=="str1")
							G.str1=text2num(row_data[D])//for the build
					for(var/D in row_data)
						if(D=="rfx1")
							G.rfx1=text2num(row_data[D])//for the build
					for(var/D in row_data)
						if(D=="con1")
							G.con1=text2num(row_data[D])//for the build
					for(var/D in row_data)
						if(D=="ent1")
							G.int1=text2num(row_data[D])//for the build
					for(var/D in row_data)
						if(D=="lvl1")
							G.lvl1=text2num(row_data[D])//for the build

					G.published=1//all these guides already have builds no need to babysit now bro(do their build)

					G.save() //*Only save guides that they preview or w.e*

					LoadedGuides.Add(G)





			resultset.Close(); //free up and erase data.


		else
			if(resultset) resultset.Close();
			if(debug) src << "No Results.";



mob/proc/insert_table()
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
			if(debug) src << "Failed.";

		//INITIATE THE GUIDE
		var/SQLQuery
		SQLQuery+="UPDATE GOAHelper SET clan='[G.clan]', date='[G.date]', description='[G.description]', views='[G.views]'"
		SQLQuery+=",likes='[G.likes]', creator='[G.creator]', descr='[G.descr]'"
		SQLQuery+=",pros='[G.pros]', cons='[G.cons]', skillpoints='[G.skillpoints]'"
		SQLQuery+=",str1='[G.str1]', rfx1='[G.rfx1]', con1='[G.con1]'"
		SQLQuery+=",ent1='[G.int1]', lvl1='[G.lvl1]' WHERE name='[G.name]' AND ckey='[G.owner]'"

		var/DBQuery/resultset2 = connector.runQuery(dbconnection,SQLQuery)
		if(resultset2)
			if(debug) src << "Phase2: Okay"
			resultset2.Close() //free up and erase data.
		else
			resultset2.Close()
			if(debug) src << "Failed."





proc/delete_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE GOAHelper")
		if(resultset)
			world << "Main Table Deleted"
			resultset.Close() //free up and erase data.
		else
			if(!resultset)
				resultset.Close()
				if(debug)world << "Failed"

proc/delete_skill_tableA()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE GOAHelperJDBA")
		if(resultset)
			world << "Skill Table A Deleted"
			resultset.Close(); //free up and erase data.
		else
			if(!resultset)
				resultset.Close();
				if(debug)world << "Failed"


proc/delete_skill_tableB()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE GOAHelperJDBB")
		if(resultset)
			world << "Skill Table B Deleted"
			resultset.Close() //free up and erase data.
		else
			if(!resultset)
				resultset.Close()
				if(debug)world << "Failed"


proc/delete_skillrank_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE GOAHelperRank")
		if(resultset)
			world << "Skill Ranks Deleted"
			resultset.Close() //free up and erase data.
		else
			if(!resultset)
				resultset.Close()
				if(debug)world << "Failed"


proc/delete_passive_table()
	set background=1
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE GOAHelperPassives")
		if(resultset)
			world << "Passive Table Deleted"
			resultset.Close() //free up and erase data.
		else
			if(!resultset)
				resultset.Close()
				if(debug)world << "Failed"



//UPDATE
//mysql_query(UPDATE SQLchars SET age='60', value='12' WHERE ckey='Tjessem' AND name='Jakob')

///CREATE
//mysql_query("CREATE TABLE SQLchars (id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), name VARCHAR(30), age INT)")

//ADD ROWS
//mysql_query("ALTER TABLE SQLchars ADD)

//DELETE VALUE
//mysql_query("DELETE FROM SQLchars WHERE age='15'")

//DELETE TABLE
//mysql_query("DROP TABLE SQLchars")

//LOAD ALL GUIDES IN MYSQL SERVER