extends RigidBody2D

var awaken :bool = false

func _ready():
	global_position = get_viewport_rect().size / 2

# warning-ignore:unused_argument
func _integrate_forces(state):
	if(awaken):
		sleeping = false
		linear_velocity.y = -800
		gravity_scale = 10
		awaken = false
		can_sleep = true

func _on_Area2D_body_entered(body):
	body.queue_free()

func _on_SleepTimer_timeout():
	can_sleep = false
	awaken = true
	$CollisionShape2D.disabled = false
