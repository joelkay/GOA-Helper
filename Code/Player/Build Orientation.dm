mob
	var/tmp
		numz1//stamina quality
		numz2
		numz3
		numz4
		numz5
	proc
		Orientate()
			numz1=round((stamina/13850)*100)    //0 - 100 based on max stamina

			numz2=round((chakra/4250)*100)  //0 - 100 based on max chakra

			numz3=((maxskillpoints/37500)*100)+(src.elements.len*10)// 0 - 100 based on the different style of jutsus( many elements etc)

			numz4=0+skillspassive[23]*5// 0 - 100 based on self healing/protecting skills

			numz5=0+skillspassive[21]*5// 0 - 100, based on ammount of medic skills

			winset(src,null,{"
					staminabar.value = [src.numz1];
					chakrabar.value = [src.numz2];
					versatilebar.value = [src.numz3];
					durablebar.value = [src.numz4];
					supportbar.value = [src.numz5];
					"})
			/*
	////////////////////////////////////////////////////////////TAI STANCES
			for(var/Jutsu/J in contents)
				if(J.sindex == "TAI_STANCE1"||J.sindex == "TAI_STANCE2"||J.sindex == "TAI_STANCE3")
					del(J)

			if(str>=200&&rfx>=200)
				var/Jutsu/J=new/Jutsu/Taijutsu_stance_1
				src.contents+=J

			if(str>=300)
				var/Jutsu/K=new/Jutsu/Taijutsu_stance_2
				src.contents+=K

			if(rfx>=300)
				var/Jutsu/L=new/Jutsu/Taijutsu_stance_3
				src.contents+=L
			*/
			UpdateSkills()// initiate it