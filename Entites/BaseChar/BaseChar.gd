extends KinematicBody2D

var bullet = preload("res://Entites/BaseBullet/BaseBullet.tscn")

onready var gun = $Gun
onready var gunPoint = $Gun/Position2D
onready var gunDestination = $Gun/Detination

const UP = Vector2.UP
const GRAVITY :float = 5000.00

var speed :float
var maxSpeed :float = 10000
var acceleration :float = 1000
var friction :float = 0.2
var velocity = Vector2.ZERO

var jumpForce :float = -1000

func _physics_process(delta):
	_movement(delta)
	_jump()
	_aim()
	_shoot()

func _movement(delta):
	var hDir = Input.get_action_strength("d") - Input.get_action_strength("a")
	
	if(hDir != 0):
		speed += hDir * acceleration
	else:
		speed = lerp(speed, 0, friction)
	speed = clamp(speed, -maxSpeed, maxSpeed)

	velocity.x = speed * delta
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, UP)

func _jump():
	if(Input.is_action_just_pressed("w") and is_on_floor()):
		velocity.y = jumpForce

func _aim():
	gun.look_at(get_global_mouse_position())

func _shoot():
	if(Input.is_action_just_pressed("l_mouse")):
		var bulletInstance = bullet.instance()
		get_tree().current_scene.add_child(bulletInstance)
		bulletInstance.position = gunPoint.global_position
		bulletInstance.destination = gunDestination.global_position
