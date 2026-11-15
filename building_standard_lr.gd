extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_text(text: String):
	$ExchangeText.text = text
	
func set_modulation(color: Color):
	$Sprite2D.modulate = color
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
