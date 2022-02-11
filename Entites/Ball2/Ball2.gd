extends KinematicBody2D

var gravity :float = 1000
var speed :float = 1
var impulse :float
var slowFactor :float = 0.7
var velocity = Vector2.ZERO

var bounce :float = 0.8

func _ready():
	global_position = get_viewport_rect().size / 2

func _physics_process(delta):
	velocity.y += delta * gravity
	if(velocity.x >= 0):
		velocity.x = lerp(velocity.x, 0, slowFactor)
	_collision_handler(delta)

func _collision_handler(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		velocity = velocity.bounce(collision.normal) * bounce

func _get_pushed(velX, velY, spd, delta):
	impulse = spd
	velocity.x = velX * spd * delta
	velocity.y = velY
	
