extends Area2D

signal team

func _on_Goal_body_entered(body):
	emit_signal("team", body)
