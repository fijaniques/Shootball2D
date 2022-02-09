extends KinematicBody2D

var speed :float = 1000
var destination = Vector2.ZERO
var spinCalc = Vector2.ZERO

func _physics_process(delta):
	_trajectory(delta)
	
func _trajectory(delta):
	position = position.move_toward(destination, speed * delta)
	
	if(position == destination):
		queue_free()
