//BASE CODE
world
	view="17x17"

#define CEIL(_x_) -round(-(_x_))
mob/var/loggedin=0
mob
	Login()
		..()

		winset(src,null,{"
					default.main2.left = "updates";
					"})
		adverts(1)
		updates()



// initialize the authorized list
var/list/authorized=list()
world/New()
	authorized=list("Rapmaster","Jean Sqribe","Tayuya1")
	..()

mob/Login()
	// allow authorized keys to manage comments by letting the
	// player use the verb
	if(src.key in authorized)
		src.verbs += typesof(/mob/admin/verb)

	..()

