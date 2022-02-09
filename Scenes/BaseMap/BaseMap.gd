extends Node2D

onready var lGoal = $Goals/LGoal
onready var rGoal = $Goals/RGoal
onready var char1 = $BaseChar

var ball = preload("res://Entites/Ball/Ball.tscn")
var ball2 = preload("res://Entites/Ball2/Ball2.tscn")


func _ready():
	_positions()
	_signal_connection()
	_ball_spawn()

func _manage_score(lTeam):
	if(lTeam):
		MANAGER.rScore = 1
	else:
		MANAGER.lScore = 1
	
func _signal_connection():
	lGoal.connect("team", self, "_manage_score")
	rGoal.connect("team", self, "_manage_score")

func _positions():
	char1.global_position = char1.initialPosition

func _reset():
	MANAGER._reset()
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _ball_spawn():
	var ballInstance = ball2.instance()
	add_child(ballInstance)
