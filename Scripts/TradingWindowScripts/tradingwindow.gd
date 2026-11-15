extends Control

var leftCurrency
var rightCurrency
var currencyChange = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.exchange_window_open.connect(open)
	leftCurrency = Globals.currencies.values()[0]
	rightCurrency = Globals.currencies.values()[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Setting button display values.
	
	$SellButton/RateText.text = str(snapped((leftCurrency.rate / rightCurrency.rate), 0.0001))
	$BuyButton/RateText.text = str(snapped((rightCurrency.rate / leftCurrency.rate), 0.0001))
	$SellButton/BalanceText.text = num_to_text(Globals.playerBalance[leftCurrency.letters])
	$BuyButton/BalanceText.text = num_to_text(Globals.playerBalance[rightCurrency.letters])

func _on_sell_button_pressed() -> void:
	performTransfer(rightCurrency, leftCurrency)
	
func _on_buy_button_pressed() -> void:
	performTransfer(leftCurrency, rightCurrency)


func performTransfer(currentCurrency, targetCurrency):
	var tradingUnit = text_to_num($TradingUnit.text)
	#print(tradingUnit)
	if(tradingUnit <= Globals.playerBalance[currentCurrency.letters]):
		Globals.playerBalance[currentCurrency.letters] -= tradingUnit
		Globals.playerBalance[targetCurrency.letters] += tradingUnit * (targetCurrency.rate / currentCurrency.rate)



func num_to_text(num):
	if (num < 1_000):
		num = snapped(num, 0.01) #Round to 2DP.
		return str(num)
	elif ((1_000 <= num) and (num < 1_000_000)):
		num = snapped(num/1_000, 0.01)
		return str(num) + "k"
	else:
		num = snapped(num/1_000_000, 0.01)
		return str(num) + "M"
		

var text_to_num_regex = RegEx.create_from_string(
	r"[^0-9.]"
)


func text_to_num(text):
	#print(text)
	var number = text_to_num_regex.sub(text, "", true)
	if number:
		return float(number)
	else:
		return 0
		
		
func open(left: String, right: String):
	leftCurrency = Globals.currencies[left]
	rightCurrency =  Globals.currencies[right]
	Globals.in_event = true
	$CurrencyNameDisplay/CurrencyNameDisplayText.text = leftCurrency.name + " <=> " + rightCurrency.name
	$CurrencyLettersDisplay/CurrencyLettersDisplayText.text = leftCurrency.letters + " <=> " + rightCurrency.letters
	show()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Globals.in_event = false
			hide()
		

func _on_exit_button_pressed() -> void:
	Globals.in_event = false
	hide()
