extends Node2D

@onready var money_count: Label = $MoneyCount
@onready var bag_sprite: AnimatedSprite2D = $MarginContainer/BagSprite
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var coins: CPUParticles2D = $Coins
@onready var coin_sound: AudioStreamPlayer = $CoinSound



func _ready() -> void:
	money_count.text = str("$", GameData.current_money)
	Signals.update_money.connect(_change_number)


func _change_number(delta: int) -> void:
	get_tree().paused = true
	var new_value = GameData.current_money + delta
	_play_coin_sounds(new_value)
	while GameData.current_money != new_value:
		var money_iteration: int
		if abs(GameData.current_money - new_value) > 2000:
			money_iteration = 2000
		elif abs(GameData.current_money - new_value) > 500:
			money_iteration = 500
		elif abs(GameData.current_money - new_value) > 100:
			money_iteration = 100
		elif abs(GameData.current_money - new_value) > 50:
			money_iteration = 50
		elif abs(GameData.current_money - new_value) > 10:
			money_iteration = 10
		else:
			money_iteration = 1
		if not coins.emitting:
			_throw_coins(new_value)
		if delta > 0:
			GameData.current_money += money_iteration
		else:
			GameData.current_money -= money_iteration
		money_count.text = str("$", GameData.current_money)
		await get_tree().create_timer(0.025).timeout
	anim.play("RESET")
	var tween_size: float
	var tween_position_y: float
	if GameData.current_money <= 0:
		tween_size = 0.0
		tween_position_y = 120
	elif GameData.current_money > 0 and GameData.current_money <= 100:
		tween_size = 0.1
		tween_position_y = 120
	elif GameData.current_money > 100 and GameData.current_money <= 1000:
		tween_size = 0.2
		tween_position_y = 114
	elif GameData.current_money > 1000 and GameData.current_money <= 10000:
		tween_size = 0.3
		tween_position_y = 100
	elif GameData.current_money > 10000 and GameData.current_money <= 50000:
		tween_size = 0.4
		tween_position_y = 90
	elif GameData.current_money > 10000 and GameData.current_money <= 50000:
		tween_size = 0.5
		tween_position_y = 82
	elif GameData.current_money > 10000 and GameData.current_money <= 50000:
		tween_size = 0.6
		tween_position_y = 74
	elif GameData.current_money > 50000 and GameData.current_money <= 100000:
		tween_size = 0.7
		tween_position_y = 58
	else:
		tween_size = 0.8
		tween_position_y = 42
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(bag_sprite, "scale", Vector2(tween_size,tween_size), 0.5)
	tween.tween_property(bag_sprite, "position:y", tween_position_y, 0.5)
	await get_tree().process_frame
	coins.emitting = false
	if is_inside_tree():
		get_tree().paused = false
	Signals.money_updated.emit()


func _play_coin_sounds(new_value: int) -> void:
	var play_sound_count: int
	if abs(GameData.current_money - new_value) > 2000:
		play_sound_count = 12
	elif abs(GameData.current_money - new_value) > 500:
		play_sound_count = 6
	elif abs(GameData.current_money - new_value) > 100:
		play_sound_count = 4
	elif abs(GameData.current_money - new_value) > 50:
		play_sound_count = 3
	elif abs(GameData.current_money - new_value) > 10:
		play_sound_count = 2
	else:
		play_sound_count = 1
	for _coin_sound_count: int in play_sound_count:
		coin_sound.play()
		await get_tree().create_timer(0.08).timeout


func _throw_coins(new_value: int) -> void:
	if abs(GameData.current_money - new_value) > 2000:
		coins.amount = 64
	elif abs(GameData.current_money - new_value) > 500:
		coins.amount = 32
	elif abs(GameData.current_money - new_value) > 100:
		coins.amount = 16
	elif abs(GameData.current_money - new_value) > 50:
		coins.amount = 8
	elif abs(GameData.current_money - new_value) > 10:
		coins.amount = 4
	else:
		coins.amount = 1
	if not coins.emitting:
		coins.emitting = true
