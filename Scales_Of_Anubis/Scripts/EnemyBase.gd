extends CharacterBody2D

@onready var NavAgent : NavigationAgent2D = get_node("NavAgent")
@onready var Target : CharacterBody2D = get_node("/root/MainScene/Player")
@export var speed : float = 50.0

func _ready():
	var MainScene : Node2D = get_node("/root/MainScene")
	MainScene.EnemyCount += 1

func _physics_process(_delta):
	if NavAgent.is_navigation_finished():
		return
	var direction = global_position.direction_to(NavAgent.get_next_path_position())
	velocity = direction * speed
	move_and_slide()

func _process(_delta):
	NavAgent.target_position = Target.global_position
