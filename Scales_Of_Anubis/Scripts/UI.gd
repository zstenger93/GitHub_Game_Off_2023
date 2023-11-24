extends Control

@onready var GameController : Node2D = get_node("/root/MainScene")
@onready var EnemyCountText : Label = get_node("EnemyCount")

func _process(delta):
	EnemyCountText.text = "Current Enemies: " + str(GameController.EnemyCount)
