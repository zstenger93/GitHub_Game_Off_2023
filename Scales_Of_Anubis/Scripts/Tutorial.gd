extends Node2D
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")
@onready var Anubis2 : AnimatedSprite2D = get_node("UI/Anubis2")
@onready var wasd : AnimatedSprite2D = get_node("UI/wasd")
@onready var shield : AnimatedSprite2D = get_node("UI/shield")

func _ready():
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()
	Anubis.play("default")
	Anubis2.play("default")
	wasd.play("default")
	shield.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")
