extends CharacterBody2D


@export var speed : int = 1000
@export var wait_time : int = 2
@export var patrol_points : Node
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


const GRAVITY = 1000

enum State { Idle, Run }
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int
var can_walk : bool

func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points.")
	
	timer.wait_time = wait_time
	
	current_state = State.Idle
	

func _physics_process(delta : float):
	redharvesterant_gravity(delta)
	redharvesterant_idle(delta)
	redharvesterant_run(delta)
	
	move_and_slide()
	
	redharvesterant_animations()

func redharvesterant_gravity(delta : float):
	velocity.y += GRAVITY * delta

func redharvesterant_idle(delta : float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.Idle
	
	
func redharvesterant_run(delta : float):
	if !can_walk:
		return
	
	
	if abs(position.x -current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Run
	else:
		current_point_position += 1
		
		if current_point_position >= number_of_points:
			current_point_position = 0
		
		current_point = point_positions[current_point_position]
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
		
		can_walk = false
		timer.start()
	
	animated_sprite_2d.flip_h = direction.x <  0
	
func redharvesterant_animations():
	if current_state == State.Idle && !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run && can_walk:
		animated_sprite_2d.play("run")

func _on_timer_timeout():
	can_walk = true
