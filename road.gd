extends Node2D

const NPC_SCENES = [
	preload("res://Scenes/npcs/test_npc.tscn")
]

var standardLL = preload("res://Scenes/building_standard_ll.tscn")
var exchangeLL = preload("res://Scenes/building_exchange_ll.tscn")
var standardLR = preload("res://Scenes/building_standard_lr.tscn")
var exchangeLR = preload("res://Scenes/building_exchange_lr.tscn")
var standardUL = preload("res://Scenes/buliding_standard_ul.tscn")
var standardUR = preload("res://Scenes/building_standard_ur.tscn")

const MAX_NO_NPCS = 3
const NO_MARKERS = 10

var shopTuple

# Possible difficulties: Red, Green, Yellow
var type = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_npcs.call_deferred()
	spawn_buildings.call_deferred()


const COMMON_NAMES: Array[String] = [
	"James", "Mary", "Michael", "Patricia", "Robert",
	"Jennifer", "John", "Linda", "David", "Elizabeth",
	"William", "Barbara", "Richard", "Susan", "Joseph",
	"Jessica", "Thomas", "Sarah", "Christopher", "Karen",
	"Charles", "Lisa", "Daniel", "Nancy", "Matthew",
	"Betty", "Anthony", "Sandra", "Mark", "Margaret",
	"Donald", "Ashley", "Steven", "Kimberly", "Andrew",
	"Emily", "Paul", "Donna", "Joshua", "Michelle",
	"Kenneth", "Carol", "Kevin", "Amanda", "Brian",
	"Melissa", "George", "Deborah", "Timothy", "Stephanie",
	"Ronald", "Dorothy", "Jason", "Rebecca", "Edward",
	"Sharon", "Jeffrey", "Laura", "Ryan", "Cynthia",
	"Jacob", "Amy", "Gary", "Kathleen", "Nicholas",
	"Angela", "Eric", "Shirley", "Jonathan", "Brenda",
	"Stephen", "Emma", "Larry", "Anna", "Justin",
	"Pamela", "Scott", "Nicole", "Brandon", "Samantha",
	"Benjamin", "Katherine", "Samuel", "Christine", "Gregory",
	"Helen", "Alexander", "Debra", "Patrick", "Rachel",
	"Frank", "Carolyn", "Raymond", "Janet", "Jack",
	"Maria", "Dennis", "Heather", "Jerry", "Diane", 
	"Carrot", "Sam the Butcher", "Cousin Oliver", "President",
	"Jim", "Jimmybob", "Mclauren", "asdf", "yes", "Danny Devito"
]

const SPRITES = [
	preload("res://Assets/npc_1.png"),
	preload("res://Assets/npc_2.png"),
	preload("res://Assets/npc_3.png"),
	preload("res://Assets/npc_4.png"),
	preload("res://Assets/npc_5.png"),
	preload("res://Assets/npc_6.png"),
	preload("res://Assets/npc_7.png"),
	preload("res://Assets/npc_8.png"),
	preload("res://Assets/npc_10.png")
]

func get_random_name() -> String:
	return COMMON_NAMES.pick_random()
	
func spawn_npcs():
	var num_npcs = randi() % (MAX_NO_NPCS + 1)
	#num_npcs = 10
	var markers = range(10)
	markers.shuffle()
	#print(markers)
	for i in range(num_npcs):
		var npc = NPC_SCENES[randi() % len(NPC_SCENES)].instantiate()
		npc.set_npc_name(get_random_name())
		npc.set_sprite(SPRITES.pick_random())
		#print("NPCSpawn" + str(markers[0] + 1))
		var marker = get_node("NPCSpawn" + str(markers[0]))
		#print(marker)
		markers.pop_front()
		add_child(npc)
		npc.global_position = marker.global_position
		if(rotation_degrees == 90):
			npc.rotation_degrees = -90


func spawn_buildings():
	# get the spawns.
	# pick buildings
	# score!
	var SPAWNERS = [$buildingSpawnLL, $buildingSpawnLR, $buildingSpawnUL, $buildingSpawnUR]
	
	# Spawner LL
	if (rotation_degrees != 90):
		for spawner_index in len(SPAWNERS):
			if spawner_index == 0:
				if shopTuple[0] == 0:
					var temp = standardLL.instantiate()
					add_child(temp)
					temp.global_position = SPAWNERS[spawner_index].global_position
				else:
					var temp = exchangeLL.instantiate()
					add_child(temp)
					temp.global_position = SPAWNERS[spawner_index].global_position
					temp.set_modulation(Color(randf(),randf(), randf()))
					temp.set_text("WOW! " + str(randi()))
				
			elif spawner_index == 1:
				if shopTuple[1] == 0:
					var temp = standardLR.instantiate()
					add_child(temp)
					temp.global_position = SPAWNERS[spawner_index].global_position
				else:
					var temp = exchangeLR.instantiate()
					add_child(temp)
					temp.global_position = SPAWNERS[spawner_index].global_position
					temp.set_modulation(Color(randf(),randf(), randf()))
					temp.set_text("WOW! " + str(randi()))
				pass
			elif spawner_index == 2:
				var temp = standardUL.instantiate()
				add_child(temp)
				temp.global_position = SPAWNERS[spawner_index].global_position
			else:
				var temp = standardUR.instantiate()
				add_child(temp)
				temp.global_position = SPAWNERS[spawner_index].global_position

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
