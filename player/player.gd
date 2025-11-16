extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
@export var speed : int = 180
@export var jump_base : int = -200
@export var jump_horizontal : int = 1000
@export var max_charge_time : float = 5.0 # Maximum time you can hold for a charged jump
@export var max_jump_multiplier : float = 4.0 # Max jump height multiplier

enum State { Idle, Run, Jump }
var can_move = true
var current_state : State
var jump_charge : float = 0.0
var is_charging_jump : bool = false

func _ready():
	current_state = State.Idle

func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	if(can_move):
		player_run(delta)
		player_jump(delta)
		move_and_slide()

	player_animations()

func input_movement():
	return Input.get_axis("move_left", "move_right")

func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta : float):
	if is_on_floor() and not is_charging_jump:
		current_state = State.Idle

func player_run(delta : float):
	var direction = input_movement()

	if direction != 0:
		velocity.x = direction * speed
		current_state = State.Run
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func player_jump(delta : float):
	if is_on_floor():
		# Start charging jump
		if Input.is_action_pressed("jump") && velocity.x == 0:
			is_charging_jump = true
			jump_charge += delta
			jump_charge = min(jump_charge, max_charge_time)
		elif Input.is_action_just_pressed("jump"):
			velocity.y = jump_base
			velocity.x += jump_horizontal * delta
		# Release jump
		if is_charging_jump and Input.is_action_just_released("jump"):
			current_state = State.Jump
			var charge_multiplier = 1 + (jump_charge / max_charge_time) * (max_jump_multiplier - 1)
			velocity.y = jump_base * charge_multiplier
			jump_charge = 0
			is_charging_jump = false

	# Allows horizontal movement in air
	if current_state == State.Jump and !is_on_floor():
		var direction = input_movement()
		velocity.x += direction * jump_horizontal * delta

func player_animations():
	if is_charging_jump && velocity.x == 0:
		animated_sprite_2d.play("charge")
	elif current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run and is_on_floor():
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif !is_on_floor():
		animated_sprite_2d.play("fall")
func disable_movement():
	can_move = false
func enable_movement():
	can_move = true
