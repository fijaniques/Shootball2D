extends KinematicBody2D

var gravity :float = 1000
var movement = Vector2.ZERO

var bounce :float = 0.6

func _ready():
	movement = Vector2(100,-100)
	global_position = get_viewport_rect().size / 2

func _physics_process(delta):
	movement.y += delta * gravity
	
	var collision = move_and_collide(movement * delta)
	if collision:
		movement = movement.bounce(collision.normal) * bounce
