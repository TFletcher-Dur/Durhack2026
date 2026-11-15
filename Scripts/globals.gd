extends Node

signal player_detected_in_road(road_colour: String)
signal dialogue_finished()
signal dialogue_append(text: TextDTO)

const DEFAULT_RANDOM_NOISE_MAGNITUDE = 0.005
const _TIME_BETWEEN_RANDOM_NOISE_APPLICATIONS = 0.5 #s
var in_event = false
var _timeSincePreviousRandomNoiseApplication = 0.0 #Private used in random noise application timing.

class TextDTO:
	var characterName
	var text
	var textScrollSpeed = 0.015 #characters per second.
	var isSkippable = true
	

"""
var playerBalance = {
	"ABC": 1_000_000,
	"DEF": 1_000,
	"GBA": 100,
	"SGX": 2_938
}
"""

"""
var currencies = {
	"SGX": Currency.new("SGXTRADING", "SGX", 1),
	"ABA": Currency.new(),
	"DEF": Currency.new("DEFENGAOIS", "DEF", 1.7),
	"GBA": Currency.new("GAMEBOYADVANCE", "GBA", 20.56)
}
"""
const NUM_CURRENCIES = 8
const NUM_CURRENCY_RANDOMISATION_STEPS = 100
const ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var LOWERCASE_ALPHABET = ALPHABET.to_lower() #This is a constant.
var currencies = {}

const PLAYER_STARTING_BALANCE = 100
var playerBalance = {}


class Currency:
	var name = "ABACUS"
	var letters = "ABA"
	var rate = 1.0
	var instability = DEFAULT_RANDOM_NOISE_MAGNITUDE
	
	func _init(name="ABACUS", letters="ABA", rate=1.0):
		self.name = name
		self.letters = letters
		self.rate = rate
	
	func convertToOther(value, other):
		value /= self.rate
		value *= other.rate
		return value
		
	func applyRandomNoise(magnitude=self.instability):
		var noise = randfn(0.0, magnitude)
		self.rate += noise
		if self.rate < 0: self.rate = 0
		
	func applyEventTriggeredRateChange(rateChange):
		self.rate += rateChange
		if self.rate < 0: self.rate = 0
		
	func scaleToBaseCurrencyChange(newBase):
		self.rate /= newBase
		
	
		

class BaseCurrency extends Currency:
	func _init():
		self.name = "SGXTRADING"
		self.letters = "SGX"
		self.rate = 1.0
		
	func scaleToBaseCurrencyChange(newBase):
		pass
		
	func applyEventTriggeredRateChange(rateChange):
		var newBase = self.rate + rateChange
		for currency in Globals.currencies:
			currency.scaleToBaseCurrency(newBase)
	
	func applyRandomNoise(magnitude=0.1):
		var newBase = self.rate + randfn(0.0, magnitude)
		for currency in Globals.currencies:
			currency.scaleToBaseCurrencyChage(newBase)
		
		



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while len(currencies.keys()) < NUM_CURRENCIES:
		var letters = ""
		for j in range(3):
			letters += ALPHABET[randi() % len(ALPHABET)]
		if letters in currencies:
			continue
		var name = letters[0] + random_sequence(1) + letters[1] + random_sequence(2) + letters[2] + random_sequence(5)
		#print(name + "   " + letters)
		currencies[letters] = Currency.new(name, letters)
	for i in range(NUM_CURRENCY_RANDOMISATION_STEPS):
		for currency in currencies.values():
			currency.applyRandomNoise()
	for currency in currencies:
		playerBalance[currency] = PLAYER_STARTING_BALANCE
	#for currency in currencies.values():
	#	print(currency.letters, " ", currency.rate)
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_timeSincePreviousRandomNoiseApplication += delta
	while _timeSincePreviousRandomNoiseApplication >= _TIME_BETWEEN_RANDOM_NOISE_APPLICATIONS:
		_timeSincePreviousRandomNoiseApplication -= _TIME_BETWEEN_RANDOM_NOISE_APPLICATIONS
		for currency in currencies.values():
			currency.applyRandomNoise()
			#if currency.letters == "ABA":
			#	print(currency.rate)
		#for currency in currencies.values():
		#	print(currency.letters, " ", currency.rate)


func random_sequence(max_length):
	var sequence = ""
	for i in range(randi() % (max_length + 1)):
		sequence += LOWERCASE_ALPHABET[randi() % len(LOWERCASE_ALPHABET)]
	return sequence
