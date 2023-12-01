extends Node2D

@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")
@onready var Rob : AnimatedSprite2D = get_node("UI/RobertsDrawing")
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Anubis.play("default")
	Rob.play("default")
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/second_level.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")


func _on_about_pressed():
	get_tree().change_scene_to_file("res://Scenes/About.tscn")
