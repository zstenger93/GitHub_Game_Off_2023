extends TextureProgressBar

@onready var Player : CharacterBody2D = get_node("/root/MainScene/Player")

func _process(delta):
	update()


func update():
	value = Player.health / Player.maxHealth * 100;
