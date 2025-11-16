extends CanvasLayer
@onready var textbox_container = $TextBoxContainer
@onready var start_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label
@onready var player = $"../Player"
const CHAR_READ_RATE = 0.05
var active_tween: Tween = null
var current_state = State.READY
var text_queue = []

enum State{
	READY,
	READING,
	FINISHED
}
	
func _process(delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				player.disable_movement()
				display_text()
			elif !player.can_move:
				player.enable_movement()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1
				active_tween.kill()
				end_symbol.text = "v"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)
	
func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	show_textbox()
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	label.visible_ratio = 0  # start invisible
	active_tween = create_tween()
	active_tween.tween_property(label, "visible_ratio", 1.0, next_text.length() * CHAR_READ_RATE)
	active_tween.finished.connect(_on_tween_finished)
	
func _on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to ready.")
		State.READING:
			print("Changing state to reading.")
		State.FINISHED:
			print("Changing state to finished.")
			
