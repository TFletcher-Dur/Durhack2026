extends Node2D

func textboxEvent():
	var text = Globals.TextDTO.new()
	text.characterName = "NO one"
	text.text = "Hello!"
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
	print(event_manager._event_dict, event_manager._event_weights)

func _on_player_detected(type: String) -> void:
	event_manager.check_event(type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
