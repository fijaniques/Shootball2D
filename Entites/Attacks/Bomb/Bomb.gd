extends RigidBody2D

func _on_Bomb_body_entered(body):
	$Collision.scale = 3
