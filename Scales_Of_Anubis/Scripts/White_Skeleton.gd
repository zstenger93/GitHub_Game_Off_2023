extends CharacterBody2D

@onready var MainScene : Node2D = get_node("/root/MainScene")
@onready var NavAgent : NavigationAgent2D = get_node("NavAgent")
@onready var Target : CharacterBody2D = get_node("/root/MainScene/Player")
@onready var Sprite : AnimatedSprite2D = get_node("Sprite")
@onready var LastAttackTime : float = Time.get_unix_time_from_system()
@onready var LastDamagedTime : float = Time.get_unix_time_from_system()
@export var AttackRate : float = 3.0
@export var AttackRange : float = 60.0
@export var Speed : float = 50.0
@export var Damage : float = 10.0
@export var Health : float = 10.0
@export var OriginalDamage : float = 10.0

func take_damage(_damage) -> float:
#	var CurrentTime : float = Time.get_unix_time_from_system()
#	if CurrentTime - LastDamagedTime:
	Health -= _damage
	Sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	Sprite.modulate = Color.WHITE
	return _damage / 2
#	return 0.0

func _try_attack():
	var CurrentTime : float = Time.get_unix_time_from_system()
	if CurrentTime - LastAttackTime >= AttackRate:
		Target.take_damage(Damage)
		Sprite.play("attack")
		LastAttackTime = Time.get_unix_time_from_system()


func _check_dist():
	var dist : float = global_position.distance_to(Target.global_position)
	if dist <= AttackRange:
		_try_attack()
	else:
		Sprite.play("walk")

func _ready():
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
	if Health <= 0.0:
		MainScene.EnemyCount -= 1
		queue_free()
