extends RigidBody2D

var upLeft
var downRigh

var awaken :bool = false

func _ready():
	global_position = get_viewport_rect().size / 2
	upLeft = get_tree().current_scene.get_node("Limiters").get_node("UPLEFT").global_position
	downRigh = get_tree().current_scene.get_node("Limiters").get_node("DOWNRIGHT").global_position

# warning-ignore:unused_argument
func _integrate_forces(state):
	if(awaken):
		sleeping = false
		linear_velocity.y = -800
		gravity_scale = 10
		awaken = false
		can_sleep = true
	_movement_limiter()

func _on_SleepTimer_timeout():
	can_sleep = false
	awaken = true
	$CollisionShape2D.disabled = false

func _on_Ball_body_entered(body):
	if(body.get_collision_layer_bit(4)):
		body.queue_free()

func _movement_limiter():
	var size = 16
	if(global_position.x <= upLeft.x):
		global_position.x = upLeft.x + size / 2
	if(global_position.y <= upLeft.y):
		global_position.y = upLeft.y + size / 2
