extends RigidBody2D

func _on_Ball_body_entered(body):
	if(body.name == "BaseBullet"):
		body.queue_free()
