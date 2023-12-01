extends Node2D

@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")
@onready var button : Button = get_node("UI/Button")
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Anubis.play("default")


func _on_button_pressed():
	if GlobalVariable.sceneGlobal == 2:
		get_tree().change_scene_to_file("res://Scenes/second_level.tscn")
	elif GlobalVariable.sceneGlobal == 1:
		get_tree().change_scene_to_file("res://Scenes/first_level.tscn")
	else:
		GlobalVariable.sceneGlobal = 2
		get_tree().change_scene_to_file("res://Scenes/intro.tscn")

