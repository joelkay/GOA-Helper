mob/var/currentguide
mob/var/tmp/phases=0
mob/var/tmp/lastlevel=1
mob/var/tmp/llevel
mob
	verb
		editdescription()
			set hidden=1
			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])// loads the guide
			winset(src,null,{"
					labeldesc.text = "[G.descr]";
					"})
			sleep(2)
			G.descr = input("Give a description for this guide.","Guide Name",G.descr) as message
			winset(src,null,{"
					labeldesc.text = "[G.descr]";
					publishb.is-visible = "true";
					"})
			G.save()//saves all data
			src << output("<font size=1><font color = green><b>All Changes Saved.</font>","guideoput")//info :D

		editpros()
			set hidden=1
			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])// loads the guide
			winset(src,null,{"
					labelpros.text = "[G.pros]";
					"})
			sleep(2)
			G.pros = input("Give the strong points of the guide.","Pros",G.pros) as message
			winset(src,null,{"
					labelpros.text = "[G.pros]";
					publishb.is-visible = "true";
					"})
			G.save()//saves all data
			src << output("<font size=1><font color = green><b>All Changes Saved.</font>","guideoput")//info :D

		editcons()
			set hidden=1
			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])// loads the guide
			winset(src,null,{"
					labelcons.text = "[G.cons]";
					"})
			sleep(2)
			G.cons = input("Give some weakpoints for this guide.","Cons",G.cons) as message
			winset(src,null,{"
					labelcons.text = "[G.cons]";
					publishb.is-visible = "true";
					"})
			G.save()//saves all data
			src << output("<font size=1><font color = green><b>All Changes Saved.</font>","guideoput")//info :D

		editl1()
			set hidden=1
			winset(src,null,{"
					phase1.is-visible = "true";
					lvl1.is-visible = "true";
					con1.is-visible = "true";
					rfx1.is-visible = "true";
					int1.is-visible = "true";
					str1.is-visible = "true";
					publishb.is-visible = "true";

					editl2.is-visible = "false";
					"})//editl2.is-visible = "true" to expand sections

			var/Guide/G=new/Guide
			G.load(src.clan,src.slots[currentguide])// loads the guide

		//	BEGIN
			var/L=100
		//	L = input("Level 1 to ?.","Levels",L) as num
		//	if(L>100||L<0)
		//		alert("invalid number you may only have 100 levels")
		//		goto BEGIN
			winset(src,null,{"
					lvl1.text = "Level: 1-[L]";
					"})
			src.lastlevel=L
			src.llevel=100-L
			G.lvl1=100


			STR
			var/S
			S = input("How much str.","Str",S) as num
			if(S>3)
				alert("invalid number you may not have more than 3 Str")
				goto STR
			winset(src,null,{"
					str1.text = "Str:[S]";
					"})
			G.str1=S


			CON
			var/C
			C = input("How much con.","Con",C) as num
			if(S+C>6||C>3)
				alert("invalid number you may not have more than 3 Con and 6 stats in total")
				goto CON
			winset(src,null,{"
					con1.text = "Con:[C]";
					"})
			G.con1=C

			INT
			var/I
			I = input("How much int.","Int",I) as num
			if(S+C+I>6||I>3)
				alert("invalid number you may not have more than 3 Int 6 stats in total")
				goto INT
			winset(src,null,{"
					int1.text = "Int:[I]";
					"})
			G.int1=I


			RFX
			var/R
			R = input("How much rfx.","Rfx",R) as num
			if(S+C+I+R>6||R>3)
				alert("invalid number you may not have more than 3 Rfx 6 stats in total")
				goto RFX
			winset(src,null,{"
					rfx1.text = "Rfx:[R]";
					"})
			G.rfx1=R

			G.save()

			sleep(2)

			src << output("<font size=1><font color = green><b>All Changes Saved.</font>","guideoput")//info :D
/*			if(src.lastlevel<100)
				switch(alert("Would you like to add more phases to the build?",,"Yes","No"))
					if("No")
						winset(src,null,{"
								editl2.is-visible = "false";
								"})
						phases=0//only one phase, delete rest of inputs


					else
						winset(src,null,{"
								phase2.is-visible = "true";
								lvl2.is-visible = "true";
								con2.is-visible = "true";
								rfx2.is-visible = "true";
								int2.is-visible = "true";
								str2.is-visible = "true";
								"})
						phases=1// phase allowed can edit and add more





		editl2()
			set hidden=1
			if(src.lastlevel>=100)return
			if(phases)
				var/Guide/G=new/Guide
				G.load(src.clan,src.slots[currentguide])// loads the guide

				BEGIN
				var/L
				L = input("Level 1 to ?.","Levels",L) as num
				if(L>100||L<0)
					alert("invalid number you may only have 100 levels")
					goto BEGIN
				winset(src,null,{"
						lvl2.text = "Level: 1-[L]";
						"})
				src.lastlevel=L
				src.llevel=100-L
				G.lvl2=L


				STR
				var/S
				S = input("How much str.","Str",S) as num
				if(S>3)
					alert("invalid number you may not have more than 3 Str")
					goto STR
				winset(src,null,{"
						str2.text = "Str:[S]";
						"})
				G.str2=S


				CON
				var/C
				C = input("How much con.","Con",C) as num
				if(S+C>6||C>3)
					alert("invalid number you may not have more than 3 Con and 6 stats in total")
					goto CON
				winset(src,null,{"
						con2.text = "Con:[C]";
						"})
				G.con2=C

				INT
				var/I
				I = input("How much int.","Int",I) as num
				if(S+C+I>6||I>3)
					alert("invalid number you may not have more than 3 Int 6 stats in total")
					goto INT
				winset(src,null,{"
						int2.text = "Int:[I]";
						"})
				G.int2=I


				RFX
				var/R
				R = input("How much rfx.","Rfx",R) as num
				if(S+C+I+R>6||R>3)
					alert("invalid number you may not have more than 3 Rfx 6 stats in total")
					goto RFX
				winset(src,null,{"
						rfx2.text = "Rfx:[R]";
						"})
				G.rfx2=R

				G.save()
			if(src.lastlevel<100)
				switch(alert("Would you like to add more phases to the build?",,"Yes","No"))
					if("No")
						winset(src,null,{"
								editl3.is-visible = "false";;

								phase3.is-visible = "false";
								lvl3.is-visible = "false";
								con3.is-visible = "false";
								rfx3.is-visible = "false";
								int3.is-visible = "false";
								str3.is-visible = "false";
								"})
						phases=0//only one phase, delete rest of inputs


					else
						winset(src,null,{"
								phase3.is-visible = "true";
								lvl3.is-visible = "true";
								con3.is-visible = "true";
								rfx3.is-visible = "true";
								int3.is-visible = "true";
								str3.is-visible = "true";

								editl3.is-visible = "true";
								"})
						phases=1// phase allowed can edit and add more

		editl3()
			set hidden=1
			if(src.lastlevel>=100)return
			if(phases)
				var/Guide/G=new/Guide
				G.load(src.clan,src.slots[currentguide])// loads the guide

				BEGIN
				var/L
				L = input("Level 1 to ?.","Levels",L) as num
				if(L>100||L<0)
					alert("invalid number you may only have 100 levels")
					goto BEGIN
				winset(src,null,{"
						lvl3.text = "Level: 1-[L]";
						"})
				src.lastlevel=L
				src.llevel=100-L
				G.lvl3=L


				STR
				var/S
				S = input("How much str.","Str",S) as num
				if(S>3)
					alert("invalid number you may not have more than 3 Str")
					goto STR
				winset(src,null,{"
						str3.text = "Str:[S]";
						"})
				G.str3=S


				CON
				var/C
				C = input("How much con.","Con",C) as num
				if(S+C>6||C>3)
					alert("invalid number you may not have more than 3 Con and 6 stats in total")
					goto CON
				winset(src,null,{"
						con3.text = "Con:[C]";
						"})
				G.con3=C

				INT
				var/I
				I = input("How much int.","Int",I) as num
				if(S+C+I>6||I>3)
					alert("invalid number you may not have more than 3 Int 6 stats in total")
					goto INT
				winset(src,null,{"
						int3.text = "Int:[I]";
						"})
				G.int3=I


				RFX
				var/R
				R = input("How much rfx.","Rfx",R) as num
				if(S+C+I+R>6||R>3)
					alert("invalid number you may not have more than 3 Rfx 6 stats in total")
					goto RFX
				winset(src,null,{"
						rfx3.text = "Rfx:[R]";
						"})
				G.rfx3=R

				G.save()

			if(src.lastlevel<100)
				switch(alert("Would you like to add more phases to the build?",,"Yes","No"))
					if("No")
						winset(src,null,{"
								editl4.is-visible = "false";
								phase4.is-visible = "false";
								lvl4.is-visible = "false";
								con4.is-visible = "false";
								rfx4.is-visible = "false";
								int4.is-visible = "false";
								str4.is-visible = "false";

								"})
						phases=0//delete rest of inputs


					else
						winset(src,null,{"
								phase4.is-visible = "true";
								lvl4.is-visible = "true";
								con4.is-visible = "true";
								rfx4.is-visible = "true";
								int4.is-visible = "true";
								str4.is-visible = "true";

								editl4.is-visible = "true";
								"})
						phases=1// phase allowed can edit and add more


		editl4()
			set hidden=1
			if(src.lastlevel>=100)return
			if(phases)
				var/Guide/G=new/Guide
				G.load(src.clan,src.slots[currentguide])// loads the guide

				BEGIN
				var/L
				L = input("Level 1 to ?.","Levels",L) as num
				if(L>100||L<0)
					alert("invalid number you may only have 100 levels")
					goto BEGIN
				winset(src,null,{"
						lvl4.text = "Level: 1-[L]";
						"})
				src.lastlevel=L
				src.llevel=100-L
				G.lvl4=L


				STR
				var/S
				S = input("How much str.","Str",S) as num
				if(S>3)
					alert("invalid number you may not have more than 3 Str")
					goto STR
				winset(src,null,{"
						str4.text = "Str:[S]";
						"})
				G.str4=S


				CON
				var/C
				C = input("How much con.","Con",C) as num
				if(S+C>6||C>3)
					alert("invalid number you may not have more than 3 Con and 6 stats in total")
					goto CON
				winset(src,null,{"
						con4.text = "Con:[C]";
						"})
				G.con4=C

				INT
				var/I
				I = input("How much int.","Int",I) as num
				if(S+C+I>6||I>3)
					alert("invalid number you may not have more than 3 Int 6 stats in total")
					goto INT
				winset(src,null,{"
						int4.text = "Int:[I]";
						"})
				G.int4=I


				RFX
				var/R
				R = input("How much rfx.","Rfx",R) as num
				if(S+C+I+R>6||R>3)
					alert("invalid number you may not have more than 3 Rfx 6 stats in total")
					goto RFX
				winset(src,null,{"
						rfx4.text = "Rfx:[R]";
						"})
				G.rfx4=R

				G.save()

			if(src.lastlevel<100)
				switch(alert("Would you like to add more phases to the build?",,"Yes","No"))
					if("No")
						winset(src,null,{"
								editl5.is-visible = "false";

								phase5.is-visible = "false";
								lvl5.is-visible = "false";
								con5.is-visible = "false";
								rfx5.is-visible = "false";
								int5.is-visible = "false";
								str5.is-visible = "false";
								"})
						phases=0//only one phase, delete rest of inputs


					else
						winset(src,null,{"
								phase5.is-visible = "true";
								lvl5.is-visible = "true";
								con5.is-visible = "true";
								rfx5.is-visible = "true";
								int5.is-visible = "true";
								str5.is-visible = "true";

								editl5.is-visible = "true";
								"})
						phases=1// phase allowed can edit and add more


		editl5()
			set hidden=1
			if(src.lastlevel>=100)return
			if(phases)
				var/Guide/G=new/Guide
				G.load(src.clan,src.slots[currentguide])// loads the guide

				BEGIN
				var/L
				L = input("Level 1 to ?.","Levels",L) as num
				if(L>100||L<0)
					alert("invalid number you may only have 100 levels")
					goto BEGIN
				winset(src,null,{"
						lvl5.text = "Level: 1-[L]";
						"})
				src.lastlevel=L
				src.llevel=100-L
				G.lvl5=L


				STR
				var/S
				S = input("How much str.","Str",S) as num
				if(S>3)
					alert("invalid number you may not have more than 3 Str")
					goto STR
				winset(src,null,{"
						str5.text = "Str:[S]";
						"})
				G.str5=S


				CON
				var/C
				C = input("How much con.","Con",C) as num
				if(S+C>6||C>3)
					alert("invalid number you may not have more than 3 Con and 6 stats in total")
					goto CON
				winset(src,null,{"
						con5.text = "Con:[C]";
						"})
				G.con5=C

				INT
				var/I
				I = input("How much int.","Int",I) as num
				if(S+C+I>6||I>3)
					alert("invalid number you may not have more than 3 Int 6 stats in total")
					goto INT
				winset(src,null,{"
						int5.text = "Int:[I]";
						"})
				G.int5=I


				RFX
				var/R
				R = input("How much rfx.","Rfx",R) as num
				if(S+C+I+R>6||R>3)
					alert("invalid number you may not have more than 3 Rfx 6 stats in total")
					goto RFX
				winset(src,null,{"
						rfx5.text = "Rfx:[R]";
						"})
				G.rfx5=R

				G.save()

			if(src.lastlevel<100)
				switch(alert("Would you like to add a fifth phase to the build?",,"Yes","No"))
					if("No")
						winset(src,null,{"
								editl5.is-visible = "false";
								phase5.is-visible = "false";
								lvl5.is-visible = "false";
								con5.is-visible = "false";
								rfx5.is-visible = "false";
								int5.is-visible = "false";
								str5.is-visible = "false";
								"})
						phases=0//only one phase, delete rest of inputs


					else
						winset(src,null,{"
								phase5.is-visible = "true";
								lvl5.is-visible = "true";
								con5.is-visible = "true";
								rfx5.is-visible = "true";
								int5.is-visible = "true";
								str5.is-visible = "true";
								"})
						phases=1// phase allowed can edit and add more
*/
