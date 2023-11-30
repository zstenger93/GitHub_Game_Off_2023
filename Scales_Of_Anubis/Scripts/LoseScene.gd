extends Node2D

@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")
@onready var button : Button = get_node("UI/Button")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Anubis.play("default")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")

