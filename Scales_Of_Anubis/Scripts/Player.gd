extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = get_node("Sprite")
@onready var shield : Sprite2D = get_node("shield")
@onready var khopesh : Sprite2D = get_node("khopesh")
@onready var hurtsound : AudioStreamPlayer = get_node("Hurtsound")
@onready var shieldsound : AudioStreamPlayer = get_node("ShieldSound")
@onready var dead : AudioStreamPlayer = get_node("Dead")

var baseSpeed : float = 200.0
var speedMP : float = 8.0
var speedDIV : float = 3.0
var shieldOffset : float = 8.0
var khopeshOffset : float = 10.0
@export var health : float = 350.0
@export var maxHealth : float = 350.0
var baseHealth : float = 200
var damage : float = 10
var scaleModifier : float = GlobalVariable.scaleModifier
var passiveRegen : float = 1.8
@export var size : float = 1.0
var passiveScale : float = 0.01
var thrown : int = 0
var shieldBlockValue : int = 5
@export var maxSize : float = 3.4


func changeSceneDeath():
	GlobalVariable.sceneGlobal = GlobalVariable.sceneGlobal - 1
	if GlobalVariable.sceneGlobal == 2:
		get_tree().change_scene_to_file("res://Scenes/second_level.tscn")
	elif GlobalVariable.sceneGlobal == 1:
		get_tree().change_scene_to_file("res://Scenes/first_level.tscn")
	else:
		GlobalVariable.sceneGlobal = 2
		get_tree().change_scene_to_file("res://Scenes/LoseGame.tscn")


func take_damage(_damage):
	health -= _damage
	if health <= 0:
		changeSceneDeath()
	if _damage != shieldBlockValue:
		hurtsound.play()
		sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
	else:
		shieldsound.play()
		shield.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		shield.modulate = Color.WHITE

func _animationController(totalVelocity):
	khopesh.z_index = 2
	shield.z_index = 3
	if (totalVelocity < 60):
		sprite.play("idle")
		sprite.z_index = 1
	else:
		if (velocity.x * velocity.x > velocity.y * velocity.y):
			if (velocity.x < 0):
				sprite.play("left")
				sprite.z_index = 1
			else:
				sprite.play("right")
				sprite.z_index = 1
		else:
			if (velocity.y < 0):
				sprite.play("up")
				sprite.z_index = 4
			else:
				sprite.z_index = 1
				khopesh.z_index = 3
				shield.z_index = 2
				sprite.play("down")

func _movment(speed, totalVelocity):
	if velocity.x != 0:
		if velocity.x > 0 && velocity.x < (speed / speedDIV / 2):
			velocity.x = 0
		elif velocity.x < 0 && velocity.x > -(speed / speedDIV / 2):
			velocity.x = 0
		elif velocity.x > 0:
			velocity.x -= (totalVelocity / speedDIV)
		elif velocity.x < 0:
			velocity.x += (totalVelocity / speedDIV)
	if velocity.y != 0:
		if velocity.y > 0 && velocity.y < (speed / speedDIV / 2):
			velocity.y = 0
		elif velocity.y < 0 && velocity.y > -(speed / speedDIV / 2):
			velocity.y = 0
		elif velocity.y > 0:
			velocity.y -= (totalVelocity / speedDIV)
		elif velocity.y < 0:
			velocity.y += (totalVelocity / speedDIV)
	if Input.is_action_pressed("move_up"):
		if velocity.y > - speed * speedMP:
			if totalVelocity < speed * speedMP:
				velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		if velocity.y < speed * speedMP:
			if totalVelocity < speed * speedMP:
				velocity.y += speed
	if Input.is_action_pressed("move_left"):
		if velocity.x > - speed * speedMP:
			if totalVelocity < speed * speedMP:
				velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		if velocity.x < speed * speedMP:
			if totalVelocity < speed * speedMP:
				velocity.x += speed	

func _changeSize(size):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - sprite.global_position).normalized()
	scale = Vector2(size, size)
	thrown = thrown + 1
	var distanceFromMouse = sprite.position.distance_to(mouse_position)
	if Input.is_action_pressed("left_click_down"):
		shield.position = sprite.position + direction * shieldOffset * sqrt(size)
		shield.look_at(mouse_position + direction * shieldOffset * size)
	if Input.is_action_pressed("right_click_down"):
		animate_swipe(khopesh, direction, khopeshOffset, size * 2, mouse_position)
	else:
		khopesh.position = sprite.position + direction * khopeshOffset * sqrt(size)
		khopesh.look_at(mouse_position + direction * khopeshOffset * size * 3)

func animate_swipe(weapon, direction, offset, size, mouse_position):
	var swipe_duration = 2  # Adjust the number of frames for the swipe animation
	var delta_position = offset * sqrt(sqrt(size)) / swipe_duration
	var target_position = sprite.position + direction * offset * sqrt(sqrt(size))
	weapon.look_at(mouse_position + direction * offset * size)
	for i in range(swipe_duration):
		weapon.position += direction * delta_position
		await get_tree().create_timer(0.1).timeout
	weapon.position = target_position
	weapon.look_at(mouse_position + direction * offset * size)


func _physics_process(_delta):
	var speed = baseSpeed / size
	var totalVelocity : float = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
	health += passiveRegen / 60
	if (size > 1):
		size -= passiveScale / 60
	if (size > maxSize):
		changeSceneDeath()
	if health > maxHealth:
		health = maxHealth
	_movment(speed, totalVelocity)
	_animationController(totalVelocity)
	_changeSize(size)
	move_and_slide()

func _on_Sword_enemy_body_entered(body):
	if body.name.begins_with("Enemy"):
		await body.take_damage(damage)
		size += scaleModifier;
		if (health <= 0):
			health = 1
			passiveRegen = 0
			changeSceneDeath()
		
func _on_Shield_enemy_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.Damage = shieldBlockValue

func _on_Shield_col_area_exited(body):
	if body.name.begins_with("Enemy"):
		body.Damage = body.OriginalDamage
