extends Control

var leftCurrency
var rightCurrency
var currencyChange = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	leftCurrency = "DEF"
	rightCurrency = "ABC"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Setting currency display if either currency has changed:
	if(currencyChange):
		$CurrencyLettersDisplay/CurrencyLettersDisplayText.text = leftCurrency + "<=>" + rightCurrency
	#Setting button display values.
	$SellButton/BalanceText.text = num_to_text(Globals.playerBalance[leftCurrency])
	$BuyButton/BalanceText.text = num_to_text(Globals.playerBalance[rightCurrency])

func _on_sell_button_pressed() -> void:
	performTransfer(rightCurrency, leftCurrency)


func performTransfer(currentCurrency, targetCurrency):
	var tradingUnit = text_to_num($TradingUnit.text)
	#print(tradingUnit)
	if(tradingUnit <= Globals.playerBalance[currentCurrency]):
		Globals.playerBalance[currentCurrency] -= tradingUnit
		Globals.playerBalance[targetCurrency] += tradingUnit * 2



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
