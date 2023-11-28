extends AnimatedSprite2D

@export var enemy = load("res://Prefabs/enemy_base.tscn")
@export var spawnTime : float = 5.0
@onready var gameController = get_node("/root/MainScene")
@onready var sprite : AnimatedSprite2D = get_node(".")
@onready var spawnTimer : Timer = get_node("Timer")
var i : int = 0

func _on_timer_timeout():
	var enemyInstance = enemy.instantiate()
	enemyInstance.set_name("Enemy_" + name + "_" + str(i))
	i += 1
	add_child(enemyInstance)

func _ready():
	sprite.play("default")
	spawnTimer.start(spawnTime)
