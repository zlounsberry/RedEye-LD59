extends Node2D

@onready var money_count: Label = $MoneyCount
@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	money_count.text = str("$", GameData.current_money)
	Signals.update_money.connect(_change_number)


func _change_number(delta: int) -> void:
	get_tree().paused = true
	var new_value = GameData.current_money + delta
	while GameData.current_money != new_value:
		var money_iteration: int
		if abs(GameData.current_money - new_value) > 500:
			money_iteration = 500
		elif abs(GameData.current_money - new_value) > 100:
			money_iteration = 100
		elif abs(GameData.current_money - new_value) > 50:
			money_iteration = 50
		elif abs(GameData.current_money - new_value) > 10:
			money_iteration = 10
		else:
			money_iteration = 1
		if delta > 0:
			GameData.current_money += money_iteration
		else:
			GameData.current_money -= money_iteration
		money_count.text = str("$", GameData.current_money)
		await get_tree().create_timer(0.025).timeout
	anim.play("RESET")
	await get_tree().process_frame
	if is_inside_tree():
		get_tree().paused = false
	Signals.money_updated.emit()
