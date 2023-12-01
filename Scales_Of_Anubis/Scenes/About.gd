extends Node2D
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

func _ready():
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()


func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")
