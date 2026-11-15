extends Node

var player_in_area = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and not Globals.in_event):
		var textDTO = Globals.TextDTO.new()
		textDTO.characterName = "Bob"
		textDTO.text = "Hello."
		Globals.dialogue_append.emit(textDTO)
		Globals.dialogue_finished.connect(on_dialogue_finished)
		
func on_dialogue_finished():
	Globals.in_event = false
	Globals.dialogue_finished.disconnect(on_dialogue_finished)


func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_area = false
