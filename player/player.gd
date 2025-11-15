extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
const SPEED = 180

enum State { Idle, Run }

var current_state

func _ready():
	current_state = State.Idle

func _physics_process(delta):
	player_falling(delta)
	player_idle()
	player_run(delta)
	move_and_slide() # no arguments in Godot 4
	player_animations()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle():
	if is_on_floor() and velocity.x == 0:
		current_state = State.Idle

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
		current_state = State.Run
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
