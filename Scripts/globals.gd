extends Node

class TextDTO:
	var characterName
	var text
	var textScrollSpeed = 0.015 #characters per second.
	var isSkippable = true
	
	
var playerBalance = {
	"ABC": 1_000_000,
	"DEF": 1_000,
	"GBA": 100,
	"SGX": 2_938
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
