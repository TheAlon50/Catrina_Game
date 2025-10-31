extends Label

func _process(delta):
	$".".text="PAN: "+str(GlobalPm.pan)
