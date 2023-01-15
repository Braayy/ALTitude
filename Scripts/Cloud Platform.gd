extends StaticBody2D

func _on_Area2D_body_entered(body: Node2D) -> void:
	if self.position.y - $CollisionShape2D.shape.extents.y >= body.position.y:
		self.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D.set_deferred("monitoring", false)
		$Timer.start()

func _on_Timer_timeout() -> void:
	self.visible = true
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D.set_deferred("monitoring", true)
