extends KinematicBody2D

var inertia = 1000
var velocity = Vector2.ZERO

func _physics_process(delta):
	_movement()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.is_in_group("bodies")):
			collision.collider.apply_central_impulse(-collision.normal * inertia)
			print(collision.normal)

func _movement():
	velocity.y = 100
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
