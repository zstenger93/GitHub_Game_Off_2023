extends Node2D

@onready var LevelTimer : Timer = get_node("/root/MainScene/Player/MapTimer")
@onready var LevelTimeLabel : Label = get_node("/root/MainScene/Player/Camera/Canvas/MapTimerLabel")
@export var EnemyCount : int = 0
@export var LevelTime : float = 60

func _ready():
	LevelTimer.start(LevelTime)

func _process(delta):
	LevelTimeLabel.text = str(int(LevelTimer.time_left))
	if LevelTimer.is_stopped():
		GlobalVariable.sceneGlobal = GlobalVariable.sceneGlobal + 1
		if GlobalVariable.sceneGlobal == 2:
			get_tree().change_scene_to_file("res://Scenes/second_level.tscn")
		elif GlobalVariable.sceneGlobal == 3:
			get_tree().change_scene_to_file("res://Scenes/third_level.tscn")
		else:
			GlobalVariable.sceneGlobal = 2
			get_tree().change_scene_to_file("res://Scenes/intro.tscn")
