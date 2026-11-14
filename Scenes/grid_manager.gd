extends Node2D

var road = preload("res://Scenes/road.tscn")
var crossroad = preload("res://Scenes/crossroad.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var possible_values = {
	"road": ["LEFT", "RIGHT"],
	"crossroad": ["LEFT", "RIGHT", "UP", "DOWN"]
}

func build_grid(n: int = 5) -> void:
	var current = 0
	var current_crossroadX = $crossroad
	var current_crossroadY = $crossroad
	var current_X = $crossroad/RIGHT
	var current_Y = $crossroad/DOWN
	while current <= 1:
		var pos_spawnY = current_Y
		var prev_road = false
		var currentX = 0
		while currentX <= n:
			if (prev_road):
				# Get left pointer
				var pos_spawnX = current_X
				
				# spawn road at left pointer
				# spawn crossroad at left pointer
				# add 1
			else:
				var pos_spawnX = current_X
				var inst = road.instantiate()
				get_tree().current_scene.add_child(inst)
				var item_marker = inst.get_child("RIGHT")
				var offset = item_marker.global_position - inst.global_position
				
				inst.global_position = current_X - offset
				current_X = inst.global_position
				
				
				
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
