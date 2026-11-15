extends Node2D

var cur1
var cur2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_text(text: String):
	$ExchangeText.text = text
	
func set_modulation(color: Color):
	$Sprite2D.modulate = color
	
var player_in_area = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and not Globals.in_event and player_in_area):
		Globals.exchange_window_open.emit(cur1, cur2)
		


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
		Globals.show_tooltip = true


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
		Globals.show_tooltip = false
