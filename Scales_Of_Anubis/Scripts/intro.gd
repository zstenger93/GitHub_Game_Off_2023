extends Node2D

@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Anubis.play("default")
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/first_level.tscn")


