extends CharacterBody2D

var speed : float = 100.0

func _physics_process(_delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	move_and_slide()
