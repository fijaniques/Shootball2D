extends KinematicBody2D

var gravity :float = 1000
var velocity = Vector2.ZERO

var bounce :float = 0.8

func _ready():
	global_position = get_viewport_rect().size / 2

func _physics_process(delta):
	velocity.y += delta * gravity
	_slide_collision_handler()

func _slide_collision_handler(): #move and slide
	velocity = move_and_slide(velocity)
	velocity = move_and_slide(velocity)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var body = collision.collider
		print("Collided with: ", body.name)
