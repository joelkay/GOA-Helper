mob/var
	Opponentint=450
	Opponentcon=450
	Opponentconbuff=0
	Opponentconneg=0

	Opponentintbuff=0
	Opponentpassives=20//gen passives
	Opponenttricks=20//bunshin tricks

mob/verb
	ModifyOpponent()
		set hidden=1
		var/intel = input("Opponents int 50-450?","Int") as num
		if(intel<50||intel>450)return
		var/contel = input("Opponents con 50-450?","Con") as num
		if(contel<50||contel>450)return
		var/genpassives = input("Opponents gen pasives 0-20?","GP") as num
		if(genpassives<0||genpassives>20)return
		var/btrick = input("Opponents Bunshin trick 0-20?","BT") as num
		if(btrick<0||btrick>20)return

		if(Alert=="On")
			alert("Opponent Verified")

		Opponentint=intel
		Opponentcon=contel
		Opponentpassives=genpassives
		Opponenttricks=btrick

		winset(src,null,{"
				opintlabel.text = "Int: [Opponentint]";
				opconlabel.text = "Con: [Opponentcon]";
				opgenlabel.text = "Gen Passives: [Opponentpassives]";
				optricklabel.text = "Bunshin Tricks: [Opponenttricks]";
				"})


var/list/Dicelist=list()
mob/var/selectroll="Sleep"
mob/var/factoron=0
mob/verb
	Dice()
		set hidden=1
		winset(src,null,{"
			Dice.is-visible = "true";
			"})



	Factor()
		set hidden=1
		if(!factoron)
			factoron=1
			winset(src,null,{"
			Factor.is-visible = "true";
			Factor.text = "Factor:
			If you lose or win a roll, the factor lets you know how convincing the win or loss was. Winning by 50% is good, winning by 10% is lucky";
			"})
		else
			factoron=0
			winset(src,null,{"
			Factor.is-visible = "false";
			"})



	SelectSkill()
		set hidden=1
		Dicelist=new
		Dicelist+= newlist(/Jutsu/Clone,/Jutsu/Darkness,/Jutsu/Fear,/Jutsu/Temple_of_Nirvana)
		var/Jutsu/S = input("Which Skill would you like to look up?","Search") in list("Cancel") + Dicelist
		if(S=="Cancel")return
		for(var/I in loadedimages)
			del(I)
		S.screen_loc="Dicemap:1,1"
		src.client.screen+=S // Add it to the screen
		src.loadedimages.Add(S)
		selectroll=S.sindex
		winset(src,null,{"
			selectdicelabel.text = "[S.sname]";
			"})


	Roll()
		set hidden=1
		switch(selectroll)
			if("SLEEP_GENJUTSU")
				//SLEEP
				var/resist_roll=Roll_Against((Opponentint+Opponentintbuff)*(1 + 0.05*Opponentpassives),(con+conbuff-conneg)*(1 + 0.05*(skillspassive[21]-1)),100)
				if(resist_roll < 4)
					winset(src,null,{"
					windicelabel.text = "You win: Factor[100-(resist_roll/4)*100]%";
					"})
				else
					winset(src,null,{"
					windicelabel.text = "You lose: Factor[100-(resist_roll/4)*100]%";
					"})


			if("PARALYZE_GENJUTSU")	//PARA
				var/resist_rolla=Roll_Against((Opponentint+Opponentintbuff)*(1 + 0.05*Opponentpassives),(con+conbuff-conneg)*(1 + 0.05*(skillspassive[21]-1)),100)
				if(resist_rolla < 4)
					winset(src,null,{"
					windicelabel.text = "You win: Factor[100-(resist_rolla/4)*100]%";
					"})
				else
					winset(src,null,{"
					windicelabel.text = "You lose: Factor[100-(resist_rolla/4)*100]%";
					"})


			if("BUNSHIN")	//BTRICK
				var/result=Roll_Against((Opponentint+Opponentintbuff)*(1 + 0.05*Opponenttricks),(int+intbuff-intneg)*(1 + 0.05*skillspassive[20]),100)
				if(result>3)
					winset(src,null,{"
					windicelabel.text = "You lose: Factor[100-(result/3)*100]%";
					"})
				else
					winset(src,null,{"
					windicelabel.text = "You win: Factor[100-(result/3)*100]%";
					"})

			if("DARKNESS_GENJUTSU")//DARK
				var/resist_rollb=Roll_Against((Opponentint+Opponentintbuff)*(1 + 0.05*Opponentpassives),(con+conbuff-conneg)*(1 + 0.05*(skillspassive[21]-1)),100)
				if(resist_rollb < 4)
					winset(src,null,{"
					windicelabel.text = "You win: Factor[100-(resist_rollb/4)*100]%";
					"})
				else
					winset(src,null,{"
					windicelabel.text = "You lose: Factor[100-(resist_rollb/4)*100]%";
					"})

proc
	Roll_Against(a,d,m) //attackers stats,defenders stats, Multiplier 1%->500%
		var/outcome = ((a*rand(5,10))/(d*rand(5,10))) *m
		var/rank=0
		//critical
		if(outcome >=200)
			rank=6  //way dominated
		if(outcome <200 && outcome >=150)
			rank=5 //dominated
		if(outcome<150 && outcome>=100)
			rank=4 //won
		if(outcome<100 && outcome>=75)
			rank=3 //not fully, but hit
		if(outcome<75 && outcome >=50)
			rank=2 //skimmed
		if(outcome<50 && outcome >=25)
			rank=1 //might have some effect.
		if(outcome <25)
			rank=0 //failed roll
		if(rank<2)
			var/underdog=rand(1,6)
			if(underdog==6)
				rank=4
		return rank