extends Node

onready var lLabel = get_tree().current_scene.get_node("HUD/LT/LTScore")
onready var rLabel =  get_tree().current_scene.get_node("HUD/RT/RTScore")

var lScore :int = 0 setget _set_l_score
var rScore :int = 0 setget _set_r_score

func _reset():
	self.lScore = 0
	self.rScore = 0

func _set_l_score(value):
	lScore += value
	lLabel.text = str(lScore)

func _set_r_score(value):
	rScore += value
	rLabel.text = str(rScore)
