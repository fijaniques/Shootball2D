extends KinematicBody2D

var bullet = preload("res://Entites/BaseBullet/BaseBullet.tscn")
var bomb = preload("res://Entites/Attacks/Bomb/Bomb.tscn")

onready var gun = $Gun
onready var gunPoint = $Gun/Position2D
onready var gunDestination = $Gun/Detination
onready var dashTimer = $Timers/Dash
onready var dodgeTimer = $Timers/Dodge
onready var dodgeCD = $Timers/DodgeCD

const UP = Vector2.UP
const GRAVITY :float = 2000.00

var hDir :float
var vDir :float
export (float) var speed = 20000
export (float) var acceleration = 0.2
export (float) var friction = 0.2
export (float) var jumpForce = -1000
export (float) var dashForce = 1.5
export (float) var inertia = 100 
var dashing :bool = false
var canDash :bool = true
var canMove :bool = true
var dodging :bool = false
var canDodge :bool = true
var flipped :bool = false

var velocity = Vector2.ZERO
var initialPosition

func _ready():
	initialPosition = global_position
	dashForce = speed * 10

func _process(delta):
	_aim()

func _physics_process(delta):
	_movement(delta)
	_jump()
	_dash(delta)
	_dodge(delta)
	_atk_2(delta)

func _unhandled_input(event):
	hDir = Input.get_action_strength("d") - Input.get_action_strength("a")
	vDir = Input.get_action_strength("s") - Input.get_action_strength("w")

	if(Input.is_action_just_pressed("l_mouse")):
		_shoot()

func _movement(delta):
	if(hDir < 0):
		flipped = true
	elif(hDir > 0):
		flipped = false

	if(canMove):
		if(hDir != 0):
			velocity.x = lerp(velocity.x, hDir * speed * delta, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, UP, false, 4, PI/4, false)

	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.name == "Ball"):
			collision.collider.apply_central_impulse(collision.remainder * inertia)

func _jump():
	if(Input.is_action_just_pressed("w") and is_on_floor() and !dashing):
		velocity.y = jumpForce

func _aim():
	gun.look_at(get_global_mouse_position())

func _shoot():
	var bulletInstance = bullet.instance()
	get_tree().current_scene.add_child(bulletInstance)
	bulletInstance.position = gunPoint.global_position
	bulletInstance.destination = gunDestination.global_position

func _atk_2(delta):
	if(Input.is_action_just_pressed("q")):
		var bombInstance = bomb.instance()
		bombInstance.global_position = $Positions/BombSpawn.global_position
		bombInstance.linear_velocity.y = -800
		if(!dashing):
			bombInstance.linear_velocity.x = velocity.x
		else:
			bombInstance.linear_velocity.x = velocity.x /4
		get_tree().current_scene.add_child(bombInstance)

func _dash(delta):
	if(is_on_floor()):
		canDash = true
	if(Input.is_action_just_pressed("ui_accept") and canDash):
		velocity.x = hDir * dashForce * delta
		velocity.y = vDir * dashForce * delta
		dashing = true
		canMove = false
		canDash = false
		dashTimer.start()

func _dodge(delta):
	if(Input.is_action_just_pressed("shift") and canDodge):
		$Collision.disabled = true
		velocity.x = hDir * dashForce * delta
		velocity.y = vDir * dashForce * delta
		dodging = true
		canMove = false
		canDodge = false
		dodgeTimer.start()

#TIMERS
func _on_Dash_timeout():
	dashing = false
	canMove = true
	velocity.y = 0

func _on_Dodge_timeout():
	dodging = false
	canMove = true
	velocity.y = 0
	dodgeCD.start()
	$Collision.disabled = false

func _on_DodgeCD_timeout():
	$Collision.disabled = false
	canDodge = true
