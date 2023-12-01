extends Node2D
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")

func _ready():
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()
	Anubis.play("default")


func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")
