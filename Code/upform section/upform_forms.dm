//http://files.byondhome.com/UnknownPerson/dreammakers/upform_doc.html#gstart_s2

upForm/global_css = " body, table { font-family: Verdana; font-size: 10pt } "
// Form Definitions

upForm
	interface_bgstyle = "background-color: #763900"
	basicinfo
		// A closewindow is a window designed to be Xed out by the viewers
		// The instance is deleted right after it displays the page to the viewers
		form_name = "plannerb"
		window_size = "208x216"
		form_type = UPFORM_INTERFACE
		GenerateBody()
			var/page = {"<body bgcolor="#763900" text="#cfc9c6">
				Welcome [usr]!<br />
				This html page will dynamically update based on your [usr.clan] and many other skills.<br />
				</body>
			"}

			UpdatePage(page)



