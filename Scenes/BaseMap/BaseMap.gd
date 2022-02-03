extends Node2D

onready var lGoal = $Goals/LGoal
onready var rGoal = $Goals/RGoal

func _ready():
	MANAGER._reset()
	_signal_connection()
#	$Ball.global_position = get_viewport_rect().size / 2

func _manage_score(lTeam):
	print("test")
	if(lTeam):
		MANAGER.rScore = 1
	else:
		MANAGER.lScore = 1
	
func _signal_connection():
	lGoal.connect("team", self, "_manage_score")
	rGoal.connect("team", self, "_manage_score")
