extends CharacterBody2D

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var breaking : = 20
@export var gravity : = 500
@export var jump_force : = 200

var move_input : float

@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# get the move inuput 
	move_input = Input.get_axis("move_left", "move_right")
	
	# movement 
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, breaking * delta)
	
	# jumping 
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()
	
func _process(delta):
	if velocity.x != 0:
		sprite.flip_h = velocity. x > 0

	_manage_animaion()

func _manage_animaion ():
	if not is_on_floor(): 
		anim.play("jump")
	elif move_input != 0:
		anim.play("move")
	else:
		anim.play("idle")
	
	
	
	
	
