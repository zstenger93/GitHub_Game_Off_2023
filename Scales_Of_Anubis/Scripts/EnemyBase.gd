extends CharacterBody2D

@onready var NavAgent : NavigationAgent2D = get_node("NavAgent")
@onready var Target : CharacterBody2D = get_node("/root/MainScene/Player")
@onready var LastAttackTime : float = Time.get_unix_time_from_system()
@export var AttackRate : float = 3.0
@export var AttackRange : float = 40.0
@export var Speed : float = 50.0
@export var Damage : float = 5.0

func _try_attack():
	var CurrentTime : float = Time.get_unix_time_from_system()
	if CurrentTime - LastAttackTime >= AttackRate:
		Target.take_damage(Damage)
		LastAttackTime = Time.get_unix_time_from_system()

func _check_dist():
	var dist : float = global_position.distance_to(Target.global_position)
	if dist <= AttackRange:
		_try_attack()

func _ready():
	var MainScene : Node2D = get_node("/root/MainScene")
	MainScene.EnemyCount += 1

func _physics_process(_delta):
	if NavAgent.is_navigation_finished():
		return
	var Direction = global_position.direction_to(NavAgent.get_next_path_position())
	velocity = Direction * Speed
	move_and_slide()

func _process(_delta):
	NavAgent.target_position = Target.global_position
	_check_dist()
