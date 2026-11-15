extends Node

var player_in_area = false
var npc_name = "Gertrude"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and not Globals.in_event and player_in_area):
		var textDTO = Globals.TextDTO.new()
		textDTO.characterName = npc_name
		if Globals.galactic_event_log != []:
			textDTO.text = Globals.galactic_event_log[-1]["npc_text"]
		else:
			textDTO.text = "There have been no interesting developments of late. I have been so terribly bored..."
		Globals.dialogue_append.emit(textDTO)
		Globals.dialogue_finished.connect(on_dialogue_finished)
		
func on_dialogue_finished():
	Globals.in_event = false
	Globals.dialogue_finished.disconnect(on_dialogue_finished)

func set_sprite(sprite_text: Texture):
	$Sprite2D.texture = sprite_text
	
func set_npc_name(name: String):
	npc_name = name

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
		Globals.show_tooltip = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_area = false
	Globals.show_tooltip = false
