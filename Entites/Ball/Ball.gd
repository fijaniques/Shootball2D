extends RigidBody2D

func _ready():
	global_position = get_viewport_rect().size / 2

func _on_Ball_body_entered(body):
	if(body.is_in_group("projectiles")):
		body.queue_free()
