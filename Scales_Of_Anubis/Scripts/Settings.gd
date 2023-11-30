extends Node2D

@onready var Anubis : AnimatedSprite2D = get_node("UI/Anubis")
@onready var sliderTime: Slider = get_node("UI/Time")
@onready var sliderSpawnRate: Slider = get_node("UI/SpawnRate")
@onready var spawnLabel: Label = get_node("UI/SpawnRate/SpawnLabel")
@onready var labelTime: Label = get_node("UI/Time/TimeLabel")
@onready var sliderScale: Slider = get_node("UI/ScaleModifier")
@onready var scaleLabel: Label = get_node("UI/ScaleModifier/ScaleLabel")
@onready var sliderSpeed: Slider = get_node("UI/SpeedModifier")
@onready var speedLabel: Label = get_node("UI/SpeedModifier/SpeedLabel")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")

func _on_time_value_changed(value):
	GlobalVariable.timeLimit = value * 0.6 + 60
	labelTime.text = "Round duration: " + str(round(GlobalVariable.timeLimit))


func _ready():
	Anubis.play("default")
	sliderSpawnRate.value = GlobalVariable.spawnRate * 10 - 10
	sliderTime.value = (GlobalVariable.timeLimit - 60) / 0.6
	sliderScale.value = GlobalVariable.scaleModifier * 100
	sliderSpeed.value = GlobalVariable.enemySpeed
	labelTime.text = "Round duration: " + str(round(GlobalVariable.timeLimit))
	spawnLabel.text = "Spawn Rate: " + str(round(GlobalVariable.spawnRate))
	scaleLabel.text =  "Scale Modifier: " + str(GlobalVariable.scaleModifier)
	speedLabel.text = "Enemy Speed Modifier: " + str(GlobalVariable.enemySpeed)

func _on_spawn_rate_value_changed(value):
	GlobalVariable.spawnRate = value / 10 + 1
	spawnLabel.text = "Spawn Rate: " + str(round(GlobalVariable.spawnRate))


func _on_scale_modifier_value_changed(value):
	GlobalVariable.scaleModifier = value / 100
	scaleLabel.text = "Scale Modifier: " + str(GlobalVariable.scaleModifier)



func _on_speed_modifier_value_changed(value):
	GlobalVariable.enemySpeed = value + 5
	speedLabel.text = "Enemy Speed Modifier: " + str(GlobalVariable.enemySpeed)
