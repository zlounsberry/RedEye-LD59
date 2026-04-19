extends Node2D

@onready var money_count: Label = $MoneyCount
@onready var bag_sprite: AnimatedSprite2D = $MarginContainer/BagSprite
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
	var tween_size: float
	if GameData.current_money <= 0:
		tween_size = 0.0
	elif GameData.current_money > 0 and GameData.current_money <= 100:
		tween_size = 0.1
	elif GameData.current_money > 100 and GameData.current_money <= 1000:
		tween_size = 0.2
	elif GameData.current_money > 1000 and GameData.current_money <= 10000:
		tween_size = 0.3
	elif GameData.current_money > 10000 and GameData.current_money <= 50000:
		tween_size = 0.4
	elif GameData.current_money > 10000 and GameData.current_money <= 50000:
		tween_size = 0.5
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(bag_sprite, "scale", Vector2(tween_size,tween_size), 0.5)
	await get_tree().process_frame
	if is_inside_tree():
		get_tree().paused = false
	Signals.money_updated.emit()
