extends Node2D
@onready var player = $Player
@onready var redharvesterant = $redharvesterant
@onready var textbox = $TextBox
@onready var npc : CharacterBody2D = $redharvesterantnpc
var interaction_available = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	npc.scale.x = -1
	textbox.hide_textbox()


func _process(delta: float) -> void:
	if interaction_available && Input.is_action_just_pressed("interact"):
		textbox.show_textbox()
		textbox.queue_text("?...")  
		textbox.queue_text("Who are you? What are you doing here?")  
		textbox.queue_text("You smell just like us.")  
		textbox.queue_text("Ooh.")  
		textbox.queue_text("You must be a springtail imitating our pheromones.")  
		textbox.queue_text("My grandpa once told me about you springtails. I know why you’re here.")  
		textbox.queue_text("You springtails always live near our colonies.")  
		textbox.queue_text("We don’t mind you. You clean up the fungus and mites around our tunnels.")  
		textbox.queue_text("And in return, our leftovers feed your whole group.")  
		textbox.queue_text("Some ants call it 'coexistence'. Others call it 'useful pests'.")  
		textbox.queue_text("But I... I think you're kind of important.")  
		textbox.queue_text("Our nest is pretty clean at the moment, though.")  
		textbox.queue_text("Could you help us with our chores today?")  
		textbox.queue_text("Great, thanks! Okay, let me teach you how to move around here.")  
		textbox.queue_text("Our nest structure is tricky. A quick tap of <SPACE> might not be enough to get around.")  
		textbox.queue_text("Try pressing and holding <SPACE> to jump higher.")  
		textbox.queue_text("Now go explore! Find seeds on the ground level and bring them to our storage room.")

 
func _on_area_2d_body_entered(body: Node2D) -> void:
	interaction_available = true
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	interaction_available = false
