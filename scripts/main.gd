extends Control

const HORF_ID_ARRAY: Array = [0,1,2,3,4,5,6,7]
const STRANGER = preload("uid://cjxlxx057f5gc")


@onready var day_title: RichTextLabel = $DayTitle
@onready var place_bets_menu: Control = $PlaceBetsMenu
@onready var horf_0: Node2D = $VBoxContainer/MarginContainer/Horf
@onready var horf_1: Node2D = $VBoxContainer/MarginContainer2/Horf
@onready var horf_2: Node2D = $VBoxContainer/MarginContainer3/Horf
@onready var horf_3: Node2D = $VBoxContainer/MarginContainer4/Horf
@onready var horf_4: Node2D = $VBoxContainer/MarginContainer5/Horf
@onready var horf_bet_dict: Dictionary = {}


func _ready() -> void:
	_connect_signals()
	if GameData.current_day < GameData.MAX_DAYS:
		day_title.text = str("[center]Day ", GameData.current_day)
	else:
		day_title.text = str("[center][shake]Day ", GameData.current_day)
	if GameData.current_day == 1:
		var stranger = STRANGER.instantiate()
		stranger.text_id = 0
		add_child(stranger)
	var random_horf_id_array = _randomize_id_array()
	_assign_horf_ids(random_horf_id_array)
	await get_tree().process_frame
	_populate_betting_menu()


func _input(event: InputEvent) -> void:
	#DEBUG
	if event.is_action("ui_text_delete"):
		if OS.has_feature("editor"):
			Engine.time_scale *= 4


func _connect_signals() -> void:
	Signals.horf_is_winner.connect(_on_horf_is_winner)
	Signals.player_placed_bet.connect(_on_player_placed_bet)
	Signals.restart_game.connect(_on_restart_game)


func _assign_horf_ids(random_horf_id_array: Array) -> void:
	var array_position_count: int = 0
	var horf_color_array: Array = [0,1,2,3,4,5,6]
	horf_color_array.shuffle()
	for horf_child in get_tree().get_nodes_in_group("horf"):
		horf_child.horf_id = random_horf_id_array[array_position_count]
		horf_child.horf_color = horf_color_array[array_position_count]
		horf_child.assign_colors()
		horf_child.assign_values_based_on_id()
		horf_bet_dict[random_horf_id_array[array_position_count]] = 0
		array_position_count += 1


func _game_over() -> void:
	var stranger = STRANGER.instantiate()
	if GameData.current_money <= 100000:
		stranger.text_id = 1
	elif GameData.current_money <= 100000 and GameData.current_money >= 500000:
		stranger.text_id = 2
	else:
		stranger.text_id = 3
	stranger.game_is_over = true
	add_child(stranger)


func _randomize_id_array() -> Array:
	var random_horf_id_array = HORF_ID_ARRAY.duplicate()
	random_horf_id_array.shuffle()
	return random_horf_id_array


func _on_player_placed_bet(amount: int, horf_id: int) -> void:
	Signals.update_money.emit(-amount)
	if horf_bet_dict.has(horf_id):
		horf_bet_dict[horf_id] = amount
	for horf_child in get_tree().get_nodes_in_group("horf"):
		if horf_id == horf_child.horf_id:
			horf_child.populate_bet_text(amount)


func _populate_betting_menu() -> void:
#	 Don't judge me it's a jam!
	place_bets_menu.odds_to_one_0 = horf_0.odds_to_one
	place_bets_menu.horf_id_0 = horf_0.horf_id
	place_bets_menu.horf_name_first_0  = horf_0.horf_name_first
	place_bets_menu.horf_name_last_0 = horf_0.horf_name_last
	place_bets_menu.horf_photo_0 = horf_0.color_array[1]
	place_bets_menu.odds_to_one_1 = horf_1.odds_to_one
	place_bets_menu.horf_id_1 = horf_1.horf_id
	place_bets_menu.horf_name_first_1  = horf_1.horf_name_first
	place_bets_menu.horf_name_last_1 = horf_1.horf_name_last
	place_bets_menu.horf_photo_1 = horf_1.color_array[1]
	place_bets_menu.odds_to_one_2 = horf_2.odds_to_one
	place_bets_menu.horf_id_2 = horf_2.horf_id
	place_bets_menu.horf_name_first_2  = horf_2.horf_name_first
	place_bets_menu.horf_name_last_2 = horf_2.horf_name_last
	place_bets_menu.horf_photo_2 = horf_2.color_array[1]
	place_bets_menu.odds_to_one_3 = horf_3.odds_to_one
	place_bets_menu.horf_id_3 = horf_3.horf_id
	place_bets_menu.horf_name_first_3  = horf_3.horf_name_first
	place_bets_menu.horf_name_last_3 = horf_3.horf_name_last
	place_bets_menu.horf_photo_3 = horf_3.color_array[1]
	place_bets_menu.odds_to_one_4 = horf_4.odds_to_one
	place_bets_menu.horf_id_4 = horf_4.horf_id
	place_bets_menu.horf_name_first_4  = horf_4.horf_name_first
	place_bets_menu.horf_name_last_4 = horf_4.horf_name_last
	place_bets_menu.horf_photo_4 = horf_4.color_array[1]
	place_bets_menu.populate_text_and_photo()


func _on_horf_is_winner(horf_id: int) -> void:
	var winning_bet: int
	if horf_bet_dict.has(horf_id):
		winning_bet = horf_bet_dict[horf_id]
	var odds_multiplier: int
	for horf_child in get_tree().get_nodes_in_group("horf"):
		if horf_id == horf_child.horf_id:
			odds_multiplier = horf_child.odds_to_one
	var total_winnings = odds_multiplier * winning_bet
	Signals.update_money.emit(total_winnings)
	await Signals.money_updated
	GameData.current_day += 1
	if GameData.current_day > GameData.MAX_DAYS:
		_game_over()
		return
	get_tree().reload_current_scene()


func _on_restart_game() -> void:
	GameData.current_money = 5000
	GameData.current_day = 1
	get_tree().reload_current_scene()


func _on_restart_game_pressed() -> void:
	Signals.restart_game.emit()
