extends Control

var hovered_orblet=-1
var last_pressed_orblet=-1
var error="none"

# Called when the node enters the scene tree for the first time.
func _ready():
	#$test.text = String(ashell.getprop())
	ashell.getprop()
	$orblets.hide()
	print(ashell.getapps())
	print(ashell.getid())
	ashell.test()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_debug()
	#pass

var page0 = ["0","1","2","3","4","5","6","7","8","9","discord","back"]

func _on_texture_rect_gui_input(event):
	if event is InputEventScreenTouch:
		Input.vibrate_handheld(20)
		if event.is_pressed():
			print("pressed")
			dynamic_orblets(-1)
			$orblets.show()
		else:
			if hovered_orblet != -1:
				print(page0[hovered_orblet])
				launcher(page0[hovered_orblet])
				last_pressed_orblet=hovered_orblet
				hovered_orblet=-1
			$orblets.hide()


func _on_orblet_mouse_entered(num):
	Input.vibrate_handheld(20)
	hovered_orblet=num
	dynamic_orblets(num)

func update_debug():
	$test.text = "Brand: "+ashell.props["ro.product.system_ext.brand"]+"\nModel: "+ashell.props["ro.product.system_ext.model"]+"\nAndroid Version: "+ashell.props["ro.system.build.version.release"]+"\nAndroid SDK Version: "+ashell.props["ro.system.build.version.sdk"]+"\nHovered Orblet: "+str(hovered_orblet)+"\nLast Pressed Orblet: "+str(last_pressed_orblet)+"\nError: "+error

func dynamic_orblets(orblet_num):
	for orb in $orblets.get_children():
		orb.modulate = Color(1,1,1,0)
		if orblet_num != -1:
			if orb.name == "orblet"+str(orblet_num):
				orb.modulate = Color(1,1,1,1)
			elif orb.name == "orblet"+str(orblet_num-1) or orb.name == "orblet"+str(orblet_num+1) or orblet_num==11 and orb.name == "orblet0" or orblet_num==0 and orb.name == "orblet11":
				orb.modulate = Color(1,1,1,0.5)
			elif orb.name == "orblet"+str(orblet_num-2) or orb.name == "orblet"+str(orblet_num+2) or orblet_num==11 and orb.name == "orblet1" or orblet_num==10 and orb.name == "orblet0" or orblet_num==0 and orb.name == "orblet10" or orblet_num==1 and orb.name == "orblet11":
				orb.modulate = Color(1,1,1,0.2)

func launcher(ol):
	if ol == "1":
		ashell.openapp("com.teslacoilsw.launcher")
	if ol == "discord":
		if "dev.beefers.vendetta" in ashell.apps:
			ashell.openapp("dev.beefers.vendetta")
		elif "com.hammerandchisel.discord" in ashell.app:
			ashell.openapp("com.hammerandchisel.discord")
		else:
			error="no discord found"
