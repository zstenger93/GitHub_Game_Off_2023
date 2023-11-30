extends TextureProgressBar

@onready var Player : CharacterBody2D = get_node("/root/MainScene/Player")

func _process(delta):
	update()


func update():
	value = (1 - (Player.size - 1) / (Player.maxSize - 1)) * 100
