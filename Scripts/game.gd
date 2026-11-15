extends Node2D

func textboxEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "NO one"
	text.text = "Hello!"
	$CanvasLayer/TextBox.enqueueText(text)
	
func jackEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "Jack"
	text.text = "Boo!"
	$CanvasLayer/TextBox.enqueueText(text)
	
func butterflyEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "butterfly"
	text.text = "Begone! Butterflies only"
	$CanvasLayer/TextBox.enqueueText(text)
	
func ghostEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "ghoul"
	text.text = "I will now read an excerpt from Dracula"
	$CanvasLayer/TextBox.enqueueText(text)
	text.text = 'I must say they were not cheering to me, for amongst them were "Ordog"--Satan, "Pokol"--hell, "stregoica"--witch, "vrolok" and "vlkoslak"--both mean the same thing, one being Slovak and the other Servian for something that is either werewolf or vampire.'
	$CanvasLayer/TextBox.enqueueText(text)
func plagueisEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "Prince of Darkness"
	text.text = "Did you ever hear the tragedy of Darth Plagueis The Wise? " 
	$CanvasLayer/TextBox.enqueueText(text)
	text.text = "I thought not. It’s not a story the Jedi would tell you. It’s a Sith legend. Darth Plagueis was a Dark Lord of the Sith, so powerful and so wise he could use the Force to influence the midichlorians to create life… He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. The dark side of the Force is a pathway to many abilities some consider to be unnatural. He became so powerful… the only thing he was afraid of was losing his power, which eventually, of course, he did. Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself."
	$CanvasLayer/TextBox.enqueueText(text)
	
func timeEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "Old John"
	text.text = "Excuse me young man... do you know... the time?"
	text.textScrollSpeed=0.25
	$CanvasLayer/TextBox.enqueueText(text)
	
func trespassingEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "Jeff"
	text.text = "Trespasser!"
	$CanvasLayer/TextBox.enqueueText(text)
	text.text = "This is Jeff's road, Jeff's road only!"
	
func pumpkinEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "pumpkin"
	text.text = "....."
	$CanvasLayer/TextBox.enqueueText(text)
	text.text="(pumpkins can't talk)"
	$CanvasLayer/TextBox.enqueueText(text)
	
func petEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "pet thing"
	text.text = "treat? You have treat???"
	$CanvasLayer/TextBox.enqueueText(text)

func riddleEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "danny"
	text.text = "When you stop to look, you can always see me. But if you try to touch me, you can never feel me. Although you walk towards me, I remain the same distance from you. What am I?"
	$CanvasLayer/TextBox.enqueueText(text)
	
func robotEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "robot"
	text.text = "Cyborg... malfunctioning... get... help"
	text.textScrollSpeed=0.25
	$CanvasLayer/TextBox.enqueueText(text)

	

class _event_manager:
	var _event_dict: Dictionary
	var _current_event: Callable
	var _event_weights: Array
	func _init():
		_event_dict = {}
		_event_weights = []
		
	func running_event(road_type: String = "white") -> bool:
		# if road_Type is yellow, check prob. if red, ALWAYS run an event. if green, never run an event*
		if road_type == "yellow":
			var choice = randi_range(1,2)
			if choice == 1:
				return true
			else:
				return false
		elif road_type == "red":
			return true
		else:
			return false
		
	func check_event(road_type: String = "white"):
		var is_event_running = running_event(road_type)
		
		if (is_event_running):
			var chosen_event = choose_event()
			print(chosen_event)
			Globals.in_event = true
			chosen_event["func"].call()
	
	func add_event(name: String, function: Callable, weight: float):
		var last_event_id = _event_dict.keys()[-1] if len(_event_dict.keys()) != 0 else 1
		
		_event_dict[last_event_id + 1] = {
			"name": name,
			"func": function
		}
		_event_weights.append(weight)
	
	func choose_event():
		var random = RandomNumberGenerator.new()
		var events = _event_dict.keys()
		return _event_dict[events[random.rand_weighted(_event_weights)]]
	
var event_manager = _event_manager.new()

func _dialogue_finished():
	Globals.in_event = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player_detected_in_road.connect(_on_player_detected)
	Globals.dialogue_finished.connect(_dialogue_finished)
	event_manager.add_event("test event", textboxEvent, 1)
	event_manager.add_event("butterfly dialogue", butterflyEvent, 1)
	event_manager.add_event("ghoul dialogue", ghostEvent, 1)
	event_manager.add_even("Plagueis dialogue",plagueisEvent,0.1 )
	event_manager.add_even("Old John event",timeEvent,1 )
	event_manager.add_even("Jim event", trespassingEvent, 1)
	event_manager.add_even("pumpkin event", pumpkinEvent, 1)
	event_manager.add_even("pet event", petEvent, 1)
	event_manager.add_event("Danny's riddle event", riddleEvent, 1)
	event_manager.add_event("robot event", robotEvent, 1)
	event_manager.add_event("Jack event", jackEvent, 1)
	
	
	
	print(event_manager._event_dict, event_manager._event_weights)

func _on_player_detected(type: String) -> void:
	event_manager.check_event(type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func teleportEvent():
	var targetPosX = 0 + ((randi() % 5) * (1440 + 288))
	var targetPosY = 0 + ((randi() % 5) * (1440 + 288))
	$CharacterBody2D.global_position = Vector2(targetPosX, targetPosY)
	var text = Globals.TextDTO.new()
	text.characterName = "Developer"
	text.text = "Because everyone loves getting randomly teleported across the map, we created an event to randomly teleport you across the map! You're welcome."
	$CanvasLayer/TextBox.enqueueText(text)
