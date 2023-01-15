extends StaticBody2D

signal stepped_above()

func _on_Area2D_body_entered(body: Node2D) -> void:
	if self.position.y - $CollisionShape2D.shape.extents.y >= body.position.y:
		emit_signal("stepped_above")
