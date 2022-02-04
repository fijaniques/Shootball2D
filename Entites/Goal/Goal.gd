extends Area2D

export(bool) var lTeam

signal team

func _on_Goal_body_entered(body):
	emit_signal("team", lTeam)
	body.queue_free()
	get_tree().current_scene._ball_spawn()
