extends KinematicBody2D

export(Array, float, 1, 100, 1) var speeds: Array

var velocity := Vector2.ZERO

func _ready() -> void:
	var random_dir = -1 if randf() <= 0.5 else 1
	var random_speed = self.speeds[floor(randf() * self.speeds.size())]
	
	velocity = Vector2(random_dir * random_speed, 0)
	pass

func _physics_process(delta: float) -> void:
	self.move_and_collide(self.velocity * delta)
	
	var half_width = ($Sprite.scale.x * self.scale.x) / 2
	
	if (self.position.x - half_width <= 0) or (self.position.x + half_width >= get_viewport().size.x * 2):
		self.velocity *= -1
