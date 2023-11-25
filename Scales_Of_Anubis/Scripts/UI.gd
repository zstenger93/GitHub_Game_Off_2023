extends Control

@onready var GameController : Node2D = get_node("/root/MainScene")
@onready var Player : CharacterBody2D = get_node("/root/MainScene/Player")
@onready var EnemyCountText : Label = get_node("EnemyCount")
@onready var PlayerHealthText : Label = get_node("PlayerHealth")

func _process(delta):
	EnemyCountText.text = "Monsters: " + str(GameController.EnemyCount)
	PlayerHealthText.text = "HP: " + str(Player.health)
