extends KinematicBody2D

var speed :float = 1000
var destination = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	_trajectory(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)

	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.is_in_group("bodies")):
			collision.collider.apply_central_impulse(collision.remainder * speed)
	
func _trajectory(delta):
	position = position.move_toward(destination, speed * delta)
	
	if(position == destination):
		queue_free()
