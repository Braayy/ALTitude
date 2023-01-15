extends KinematicBody2D

export(float, 1, 200, 0.1) var jump_force
export(float, 1, 200, 0.1) var super_jump_force
export(float, 1, 200, 1) var movement_speed
export(float, 1, 200, 0.1) var gravity
export(float, 0.001, 1, 0.001) var air_resistance

var velocity := Vector2.ZERO

onready var furthest_distance := get_viewport().size.y * 2
var score := 0

func _process(delta: float) -> void:
	disable_pass_through_collision_when_jumping()

func _physics_process(delta: float) -> void:
	var input_strength = Input.get_axis("ui_left", "ui_right")
	if input_strength != 0:
		self.velocity.x = input_strength * movement_speed * delta
	else:
		self.velocity.x *= 1 - self.air_resistance
		
	self.velocity += Vector2.DOWN * self.gravity * delta
	
	var col = self.move_and_collide(self.velocity)
	if col and col.collider.is_in_group("platforms"):
		self.velocity.y = -1 * self.jump_force
		
		if self.furthest_distance > self.position.y:
			self.furthest_distance = self.position.y - 50
			self.score += 1
			get_node("%Score").text = "%03d" % self.score

func disable_pass_through_collision_when_jumping() -> void:
	if self.velocity.y < 0:
		self.set_collision_mask_bit(1, false)
	else:
		self.set_collision_mask_bit(1, true)

func _on_jumped_above_special_platform():
	self.velocity.y = -1 * self.super_jump_force
