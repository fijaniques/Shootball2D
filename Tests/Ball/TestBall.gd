extends KinematicBody2D

var gravity :float = 100
var speed :float = 0
var slowFactor = 0.01

var velocity = Vector2.ZERO

func _ready():
	global_position = get_viewport_rect().size / 2

func _physics_process(delta):
	_movement(delta)

func _movement(delta):
	velocity.y += gravity * delta
	if(velocity.x > 0):
		velocity.x = lerp(velocity.x, 0, slowFactor)
	else:
		velocity.x = 0
	
	move_and_collide(velocity)
	
	print(velocity.x)
