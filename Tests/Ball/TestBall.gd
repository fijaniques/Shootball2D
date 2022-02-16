extends KinematicBody2D

var gravity :float = 100
var speed :float = 0
var slowFactor :float = 0.01
var bounce :float = 0.6

var velocity = Vector2.ZERO

func _ready():
	global_position = get_viewport_rect().size / 2

func _physics_process(delta):
	_movement(delta)
	_bounce(delta)


func _movement(delta):
	velocity.y += gravity * delta
	if(velocity.x > 0 or velocity.x < 0):
		velocity.x = lerp(velocity.x, 0, slowFactor)
	else:
		velocity.x = 0
	
	move_and_collide(velocity)

func _bounce(delta):
	var collision = move_and_collide(velocity * delta)
	if(collision):
		if(!collision.collider.is_in_group("char") or collision.collider.velocity == Vector2.ZERO):
			velocity = velocity.bounce(collision.normal) * bounce
		else:
			velocity = (global_position - collision.collider.global_position) / 3
