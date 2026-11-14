extends Node2D

var road = preload("res://Scenes/road.tscn")
var crossroad = preload("res://Scenes/crossroad.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_grid.call_deferred()

var road_arr = []
var color_arr = ["red", "green", "yellow"]
func build_grid(n: int = 5):
	var cross = $crossroad
	var nextX = cross.get_node("RIGHT")
	var nextY = cross.get_node("DOWN")
	for i in range(n): # Rows
		# create empty array
		# create vertical road
		# generate columns for row
		# generate next cross and update next var
		var row = []
		var new = null
		if i < n - 1:
			new = addVerticalRoad(nextY)
			var cross_inst = crossroad.instantiate()
			add_child(cross_inst)
			snap_to_marker(cross_inst, "UP", new)
			nextY = cross_inst
		for j in range(n): # Columns
			var gen_bottom = true if i < n - 1 else false
			var temparr = generateBlock(nextX, gen_bottom)
			nextX = temparr.newMarker
			row.append(temparr.roadInst)
		
		nextX = nextY.get_node("RIGHT")
		nextY = nextY.get_node("DOWN")
		road_arr.append(row)
	print(road_arr)
class blockOut:
	var newMarker: Marker2D
	var roadInst: Node2D

func generate_colour(difficulty: int = 0):
	return color_arr[randi_range(0, len(color_arr) - 1)]

func generateBlock(prevMarker: Marker2D, generate_vertical: bool = false) -> blockOut:
	var road_inst = road.instantiate()
	add_child(road_inst)
	road_inst.set_colour(generate_colour())
	snap_to_marker(road_inst, "LEFT", prevMarker)
	var cross_inst = crossroad.instantiate()
	add_child(cross_inst)
	snap_to_marker(cross_inst, "LEFT", road_inst.get_node("RIGHT"))
	if generate_vertical:
		var _unused = addVerticalRoad(cross_inst.get_node("DOWN"))
	var out = blockOut.new()
	out.newMarker = cross_inst.get_node("RIGHT")
	out.roadInst = road_inst
	
	return out
	
func addVerticalRoad(marker: Marker2D) -> Marker2D:
	var road_inst = road.instantiate()
	add_child(road_inst)
	road_inst.rotation = deg_to_rad(90)
	snap_to_marker(road_inst, "LEFT", marker)
	return road_inst.get_node("RIGHT")

func snap_to_marker(piece: Node2D, piece_marker_name: String, target_marker: Marker2D) -> void:
	var item_marker = piece.get_node(piece_marker_name)
	var offset = item_marker.global_position - piece.global_position
	piece.global_position = target_marker.global_position - offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
