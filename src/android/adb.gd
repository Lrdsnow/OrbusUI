extends Node

var props = {}
var apps = []

var app_actv = {
	"dev.beefers.vendetta":"dev.beefers.vendetta/com.discord.main.MainActivity",
	"com.discord":"com.discord/.main.MainActivity"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() != "Android":
		props = {
	"ro.product.system_ext.brand":"null",
	"ro.product.system_ext.model":"null",
	"ro.system.build.version.release":"null",
	"ro.system.build.version.sdk":"null"
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getid():
	var output=[]
	OS.execute("id", [], output)
	return output[0]

func test():
	var output = []
	OS.execute("ls", ["/storage/emulated/0/Orbus"], output)
	print(output)

func getprop():
	if props == {}:
		var output = []
		if OS.get_name() == "Android":
			OS.execute("getprop", [], output)
		else:
			OS.execute("adb", ["shell", "getprop"], output)
		output=output[0].split('\n')
		for x in output:
			var values=x.replace("]", "").replace("[", "").split(": ")
			if len(values) != 1:
				props[values[0]] = values[1]
			else:
				props[values[0]] = ""
	return props

func openapp(app):
	if OS.get_name() == "Android":
		print(Engine.get_singleton_list())
		if Engine.has_singleton("applauncher"):
			var singleton = Engine.get_singleton("applauncher")
			singleton.launchapp(app)
		else:
			print("AppLauncher not found")
	else:
		OS.execute("adb", ["shell", "monkey", "-p", app, "-c", "android.intent.category.LAUNCHER", "1"])

func getapps(refresh=false):
	if apps == [] or refresh:
		var output=[]
		if OS.get_name() == "Android":
			OS.execute("pm", ["list", "packages", "-3"], output)
			apps=Array(output[0].replace("package:", "").split("\n"))
		else:
			OS.execute("adb", ["shell", "pm", "list", "packages", "-3"], output)
			apps=Array(output[0].replace("package:", "").split("\n"))
	return apps
