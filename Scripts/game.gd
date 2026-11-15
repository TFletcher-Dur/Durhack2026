extends Node2D


class _event_manager:
	var _event_dict: Dictionary
	var _current_event: Callable
	var _event_weights: Array
	func _init():
		_event_dict = {
			1: {
				"name": "test event",
				"func": "function"
			},
			2: {
				"name": "test event 2",
				"func": func test(): print("goodbye lol")
			},
			3: {
				"name": "test event 3",
				"func": func test(): print("goodbye lol")
			}
		}
		_event_weights = [1, 1, 1]
		
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
			chosen_event["func"].call()
			
	func choose_event():
		var random = RandomNumberGenerator.new()
		var events = _event_dict.keys()
		return _event_dict[events[random.rand_weighted(_event_weights)]]


func textboxEvent():
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var event_manager = _event_manager.new()
	event_manager.check_event("yellow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
