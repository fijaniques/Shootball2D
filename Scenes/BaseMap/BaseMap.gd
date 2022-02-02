extends Node2D

onready var lGoal = $LGoal
onready var rGoal = $RGoal

func _ready():
	lGoal.connect("team", self, "_manage_score")
	rGoal.connect("team", self, "_manage_score")
	$Ball.global_position = get_viewport_rect().size / 2

func _manage_score(body):
	print("ENTROU")
	if(body.is_in_group("LTeam")):
		print("L")
	else:
		print("R")
