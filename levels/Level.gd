extends Node2D
@onready var player = $Player
@onready var redharvesterant = $redharvesterant
@onready var textbox = $TextBox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.hide_textbox()
	textbox.queue_text("First text queued.")
	textbox.queue_text("Second text queued.")
	textbox.queue_text("Third text queued.")
	textbox.queue_text("Fourth text queued.")
	textbox.hide_textbox()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
