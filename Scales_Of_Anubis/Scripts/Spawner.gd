extends AnimatedSprite2D

@export var enemy = preload("res://Prefabs/enemy_base.tscn")
@onready var sprite : AnimatedSprite2D = get_node(".")

func _on_timer_timeout():
	var enemyInstance = enemy.instantiate()
	add_child(enemyInstance)
	print("test")

func _ready():
	sprite.play("default")
