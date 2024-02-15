extends TextureProgressBar


func _ready():
	$"../..".health_change.connect(self.update)
	update()

func update():
	$".".hide()
	value = $"../..".health 
	if value < 10000:
		$".".show()
	if value < 1:
		queue_free()
		
	
