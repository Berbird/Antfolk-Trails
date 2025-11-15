extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000  
const SPEED = 180
const JUMP = -200
const JUMP_HORIZONTAL = 1000

enum State { Idle, Run, Jump }

var current_state

func _ready():
	current_state = State.Idle

func _physics_process(delta):
	player_falling(delta)
	player_idle()
	player_run(delta)
<<<<<<< HEAD
	player_jump(delta)
	
	move_and_slide()
	
=======
	move_and_slide() # no arguments in Godot 4
>>>>>>> ac6fdd847bca5e6ffbf613c17a766ebba8624930
	player_animations()
	print("State: ", State.keys()[current_state])

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

func player_jump(delta):
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			current_state = State.Jump
			velocity.y = JUMP
	
	if State.Jump:
		if !is_on_floor():
			var direction = Input.get_axis("move_left", "move_right")
			velocity.x += direction * JUMP_HORIZONTAL * delta


func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
