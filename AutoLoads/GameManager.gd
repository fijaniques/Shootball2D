extends Node

export(PackedScene) var goal

var lTeam
var rTeam
var lScore :int = 0
var rScore :int = 0

func _ready():
	goal.connect("team", self, "_score_manager")

func _score_manager(body):
	print("OK")
	if(body.is_in_group("LTeam")):
		print("GOL R")
	else:
		print("GOL L")
