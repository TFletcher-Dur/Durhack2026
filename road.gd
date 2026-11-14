extends Node2D


# Possible difficulties: Red, Green, Yellow
var type = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_colour(colour = "white") -> void:
	if colour == "red":
		$Sprite2D.modulate = Color(1.0, 0.0, 0.0, 1.0)
	elif colour == "yellow":
		$Sprite2D.modulate = Color(0.726, 0.474, 0.05, 1.0)
	elif colour == "green":
		$Sprite2D.modulate = Color(0.358, 0.646, 0.0, 1.0)
	else:
		$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
