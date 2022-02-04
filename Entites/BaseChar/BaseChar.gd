extends KinematicBody2D

var bullet = preload("res://Entites/BaseBullet/BaseBullet.tscn")

onready var gun = $Gun
onready var gunPoint = $Gun/Position2D
onready var gunDestination = $Gun/Detination
onready var dashTimer = $Timers/Dash

const UP = Vector2.UP
const GRAVITY :float = 2000.00

var hDir :float
var vDir :float
var speed :float
export (float) var maxSpeed = 10000
export (float) var acceleration = 1000
export (float) var friction = 0.2
export (float) var jumpForce = -1000
export (float) var dashForce
var dashing :bool = false
var canDash :bool = true
var canMove :bool = true

var velocity = Vector2.ZERO
var initialPosition

func _ready():
	initialPosition = global_position
	dashForce = maxSpeed * 10

func _physics_process(delta):
	_movement(delta)
	_jump()
	_aim()
	_shoot()
	_dash(delta)

func _movement(delta):
	hDir = Input.get_action_strength("d") - Input.get_action_strength("a")
	vDir = Input.get_action_strength("s") - Input.get_action_strength("w")
	
	if(canMove):
		if(hDir != 0):
			speed += hDir * acceleration
		else:
			speed = lerp(speed, 0, friction)
		speed = clamp(speed, -maxSpeed, maxSpeed)

		velocity.x = speed * delta
		velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, UP)

func _jump():
	if(Input.is_action_just_pressed("w") and is_on_floor() and !dashing):
		velocity.y = jumpForce

func _aim():
	gun.look_at(get_global_mouse_position())

func _shoot():
	if(Input.is_action_just_pressed("l_mouse")):
		var bulletInstance = bullet.instance()
		get_tree().current_scene.add_child(bulletInstance)
		bulletInstance.position = gunPoint.global_position
		bulletInstance.destination = gunDestination.global_position

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


func _on_Dash_timeout():
	dashing = false
	canMove = true
	velocity.y = 0
