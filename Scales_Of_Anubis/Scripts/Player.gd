extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = get_node("Sprite")
@onready var shield : Sprite2D = get_node("shield")
@onready var khopesh : Sprite2D = get_node("khopesh")

var baseSpeed : float = 200.0
var speedMP : float = 8.0
var speedDIV : float = 3.0
var shieldOffset : float = 8.0
var khopeshOffset : float = 15.0
var health : float = 100.0
var baseHealth : float = 100
var damage : float = 10

func take_damage(_damage):
	health -= _damage
	if _damage != 0:
		sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
	else:
		shield.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		shield.modulate = Color.WHITE
	
	if health <= 0:
		get_tree().reload_current_scene()

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
	if (totalVelocity < 30):
		sprite.play("idle")
	else:
		if (velocity.x * velocity.x > velocity.y * velocity.y):
			if (velocity.x < 0):
				sprite.play("left")
			else:
				sprite.play("right")
		else:
			if (velocity.y < 0):
				sprite.play("up")
			else:
				sprite.play("down")

func _changeSize(size):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - sprite.global_position).normalized()
	if size > 4:
		size = 4
	scale = Vector2(size, size)
	var distanceFromMouse = sprite.position.distance_to(mouse_position)
	if Input.is_action_pressed("left_click_down"):
		shield.position = sprite.position + direction * shieldOffset * sqrt(size)
		shield.look_at(mouse_position + direction * shieldOffset * size)
	if Input.is_action_pressed("right_click_down"):
		khopesh.position = sprite.position + direction * khopeshOffset * sqrt(size)
		khopesh.look_at(mouse_position + direction * khopeshOffset * size)

func _physics_process(_delta):
	var speed = baseSpeed - (baseHealth - health)
	var size = 1
	size = baseHealth / health;
	var totalVelocity : float = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
	_movment(speed, totalVelocity)
	_changeSize(size)
	move_and_slide()

func _on_Sword_enemy_body_entered(body):
	if body.name.begins_with("Enemy"):
		health += await body.take_damage(damage)
		
func _on_Shield_enemy_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.Damage = 0

func _on_Shield_col_area_exited(body):
	if body.name.begins_with("Enemy"):
		body.Damage = 5

