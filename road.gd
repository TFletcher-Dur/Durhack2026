extends Node2D

const NPC_SCENES = [
	preload("res://Scenes/npcs/test_npc.tscn")
]
const MAX_NO_NPCS = 3
const NO_MARKERS = 10



# Possible difficulties: Red, Green, Yellow
var type = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_npcs.call_deferred()
		

func spawn_npcs():
	var num_npcs = randi() % (MAX_NO_NPCS + 1)
	num_npcs = 10
	var markers = range(10)
	markers.shuffle()
	print(markers)
	for i in range(num_npcs):
		var npc = NPC_SCENES[randi() % len(NPC_SCENES)].instantiate()
		print("NPCSpawn" + str(markers[0] + 1))
		var marker = get_node("NPCSpawn" + str(markers[0]))
		print(marker)
		markers.pop_front()
		add_child(npc)
		npc.global_position = marker.global_position
		if(rotation_degrees == 90):
			npc.rotation_degrees = -90


func set_colour(colour = "white") -> void:
	if colour == "red":
		type = "red"
		$Sprite2D.modulate = Color(1.0, 0.0, 0.0, 1.0)
	elif colour == "yellow":
		type = "yellow"
		$Sprite2D.modulate = Color(0.726, 0.474, 0.05, 1.0)
	elif colour == "green":
		type = "green"
		$Sprite2D.modulate = Color(0.358, 0.646, 0.0, 1.0)
	else:
		type = "white"
		$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Globals.player_detected_in_road.emit(type)
