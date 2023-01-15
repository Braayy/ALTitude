extends Camera2D

func _process(delta):
	self.position.x = get_viewport().size.x
	self.position.y = min(700, $"../Player".position.y)
