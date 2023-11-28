extends Node2D

@onready var LevelTimer : Timer = get_node("/root/MainScene/Player/MapTimer")
@onready var LevelTimeLabel : Label = get_node("/root/MainScene/Player/Camera/Canvas/MapTimerLabel")
@export var EnemyCount : int = 0
@export var LevelTime : float = 120

func _ready():
	LevelTimer.start(LevelTime)

func _process(delta):
	LevelTimeLabel.text = str(int(LevelTimer.time_left))
	if LevelTimer.is_stopped():
		get_tree().reload_current_scene() #TODO: Implement level changing
