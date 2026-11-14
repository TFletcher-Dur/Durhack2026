extends Control

const TEXT_SCROLL_SPEED = 15.0 #text speed in ms per char

var textQueue = []
var isShowingText = false
var currentTextDTO = null
var currentDisplayedText = ""
var positionInCurrentText = -1
var timeSincePreviousChar = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (not isShowingText): #Starting text display.
		print(textQueue.is_empty())
		if (not textQueue.is_empty()):
			currentTextDTO = textQueue.pop_front()
			positionInCurrentText = 0
			timeSincePreviousChar = 0.0
			show()
			isShowingText = true
	if (isShowingText):
		timeSincePreviousChar += delta
		if (Input.is_action_just_pressed("interact")):
			timeSincePreviousChar = 0.0
			if ((currentDisplayedText != currentTextDTO.text) and currentTextDTO.isSkippable):
				currentDisplayedText = currentTextDTO.text
				positionInCurrentText = -1
			else:
				currentDisplayedText = ""
				if (not textQueue.is_empty()):
					currentTextDTO = textQueue.pop_front()
					positionInCurrentText = 0
				else:
					currentTextDTO = null
					positionInCurrentText = -1
					isShowingText = false
		else:
			while (timeSincePreviousChar > TEXT_SCROLL_SPEED):
				timeSincePreviousChar -= TEXT_SCROLL_SPEED
				currentDisplayedText += currentTextDTO.text[positionInCurrentText]
				positionInCurrentText += 1
		$TextBoxBackground/CharacterDialogueText.text = currentDisplayedText
				
