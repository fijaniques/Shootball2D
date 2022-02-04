extends Node

onready var lLabel = get_tree().current_scene.get_node("HUD/LT/LTScore")
onready var rLabel =  get_tree().current_scene.get_node("HUD/RT/RTScore")

var lScore :int = 0 setget _set_l_score
var rScore :int = 0 setget _set_r_score

func _ready():
	lLabel.text = str(lScore)
	rLabel.text = str(rScore)

func _reset():
	lScore = 0
	rScore = 0
	lLabel.text = str(lScore)
	rLabel.text = str(rScore)
	get_tree().current_scene._positions()

func _set_l_score(value):
	lScore += value
	lLabel.text = str(lScore)
	
	if(lScore >= 3):
		_reset()

func _set_r_score(value):
	rScore += value
	rLabel.text = str(rScore)
	
	if(rScore >= 3):
		_reset()
