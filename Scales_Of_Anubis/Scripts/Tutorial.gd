extends Node2D
@onready var musicSound : AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	var sound = preload("res://Audio/gamesound.mp3")
	musicSound.stream = sound
	musicSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")
