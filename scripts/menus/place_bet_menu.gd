extends Control

const MAX_BUTTON_COUNT: = 5
const HORF_BLUE_PHOTO = preload("uid://c2f6oifl4rhr0")
const HORF_BROWN_PHOTO = preload("uid://cm7a67fxrvqf0")
const HORF_GREEN_PHOTO = preload("uid://wg6qvvjqn5jc")
const HORF_ORANGE_PHOTO = preload("uid://rkgtgu1sciwo")
const HORF_RED_PHOTO = preload("uid://coy64onte2umy")
const HORF_WHITE_PHOTO = preload("uid://bs3kln1l6c1ux")
const HORF_YELLOW_PHOTO = preload("uid://xfiuvuqvnot3")


#Just copypasta from stats_popup, not DRY but it's a jam shut up
@onready var name_0: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf0/Name
@onready var odds_0: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf0/Odds
@onready var sprite_0: Sprite2D = $PlaceBetsMenuPanel/VBoxContainer/Horf0/MarginContainer/Sprite2D
@onready var line_edit_0: LineEdit = $PlaceBetsMenuPanel/VBoxContainer/Horf0/LineEdit
@onready var lock_in_0: Button = $PlaceBetsMenuPanel/VBoxContainer/Horf0/LockIn
@onready var name_1: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf1/Name
@onready var odds_1: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf1/Odds
@onready var sprite_1: Sprite2D = $PlaceBetsMenuPanel/VBoxContainer/Horf1/MarginContainer/Sprite2D
@onready var line_edit_1: LineEdit = $PlaceBetsMenuPanel/VBoxContainer/Horf1/LineEdit
@onready var lock_in_1: Button = $PlaceBetsMenuPanel/VBoxContainer/Horf1/LockIn
@onready var name_2: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf2/Name
@onready var odds_2: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf2/Odds
@onready var sprite_2: Sprite2D = $PlaceBetsMenuPanel/VBoxContainer/Horf2/MarginContainer/Sprite2D
@onready var line_edit_2: LineEdit = $PlaceBetsMenuPanel/VBoxContainer/Horf2/LineEdit
@onready var lock_in_2: Button = $PlaceBetsMenuPanel/VBoxContainer/Horf2/LockIn
@onready var name_3: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf3/Name
@onready var odds_3: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf3/Odds
@onready var sprite_3: Sprite2D = $PlaceBetsMenuPanel/VBoxContainer/Horf3/MarginContainer/Sprite2D
@onready var line_edit_3: LineEdit = $PlaceBetsMenuPanel/VBoxContainer/Horf3/LineEdit
@onready var lock_in_3: Button = $PlaceBetsMenuPanel/VBoxContainer/Horf3/LockIn
@onready var name_4: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf4/Name
@onready var odds_4: Label = $PlaceBetsMenuPanel/VBoxContainer/Horf4/Odds
@onready var sprite_4: Sprite2D = $PlaceBetsMenuPanel/VBoxContainer/Horf4/MarginContainer/Sprite2D
@onready var line_edit_4: LineEdit = $PlaceBetsMenuPanel/VBoxContainer/Horf4/LineEdit
@onready var lock_in_4: Button = $PlaceBetsMenuPanel/VBoxContainer/Horf4/LockIn

@onready var button_press_count: int = 0

var odds_to_one_0: int
var horf_id_0: int
var horf_name_first_0: String
var horf_name_last_0: String
var horf_photo_0
var odds_to_one_1: int
var horf_id_1: int
var horf_name_first_1: String
var horf_name_last_1: String
var horf_photo_1
var odds_to_one_2: int
var horf_id_2: int
var horf_name_first_2: String
var horf_name_last_2: String
var horf_photo_2
var odds_to_one_3: int
var horf_id_3: int
var horf_name_first_3: String
var horf_name_last_3: String
var horf_photo_3
var odds_to_one_4: int
var horf_id_4: int
var horf_name_first_4: String
var horf_name_last_4: String
var horf_photo_4


func _ready() -> void:
	Signals.money_updated.emit(GameData.current_money)


func populate_text_and_photo() -> void:
	name_0.text = str(horf_name_first_0, " ", horf_name_last_0)
	odds_0.text = str(odds_to_one_0, ":1")
	sprite_0.texture = horf_photo_0
	name_1.text = str(horf_name_first_1, " ", horf_name_last_1)
	odds_1.text = str(odds_to_one_1, ":1")
	sprite_1.texture = horf_photo_1
	name_2.text = str(horf_name_first_2, " ", horf_name_last_2)
	odds_2.text = str(odds_to_one_2, ":1")
	sprite_2.texture = horf_photo_2
	name_3.text = str(horf_name_first_3, " ", horf_name_last_3)
	odds_3.text = str(odds_to_one_3, ":1")
	sprite_3.texture = horf_photo_3
	name_4.text = str(horf_name_first_4, " ", horf_name_last_4)
	odds_4.text = str(odds_to_one_4, ":1")
	sprite_4.texture = horf_photo_4


func show_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 1, 0.25)


func close_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 0, 0.25)
	await tween.finished
	Signals.bets_placed.emit()
	self.queue_free()


func _on_lock_in_0_pressed() -> void:
	if line_edit_0.text.to_int() > GameData.current_money:
		return
	lock_in_0.disabled = true
	var amount: int
	if line_edit_0.text == "":
		amount = 0
	else:
		amount = line_edit_0.text.to_int()
	Signals.player_placed_bet.emit(amount, horf_id_0)
	button_press_count += 1
	if button_press_count >= MAX_BUTTON_COUNT:
		close_popup()


func _on_lock_in_1_pressed() -> void:
	if line_edit_1.text.to_int() > GameData.current_money:
		return
	lock_in_1.disabled = true
	var amount: int
	if line_edit_1.text == "":
		amount = 0
	else:
		amount = line_edit_1.text.to_int()
	Signals.player_placed_bet.emit(amount, horf_id_1)
	button_press_count += 1
	if button_press_count >= MAX_BUTTON_COUNT:
		close_popup()


func _on_lock_in_2_pressed() -> void:
	if line_edit_2.text.to_int() > GameData.current_money:
		return
	lock_in_2.disabled = true
	var amount: int
	if line_edit_2.text == "":
		amount = 0
	else:
		amount = line_edit_2.text.to_int()
	Signals.player_placed_bet.emit(amount, horf_id_2)
	button_press_count += 1
	if button_press_count >= MAX_BUTTON_COUNT:
		close_popup()


func _on_lock_in_3_pressed() -> void:
	if line_edit_3.text.to_int() > GameData.current_money:
		return
	lock_in_3.disabled = true
	var amount: int
	if line_edit_3.text == "":
		amount = 0
	else:
		amount = line_edit_3.text.to_int()
	Signals.player_placed_bet.emit(amount, horf_id_3)
	button_press_count += 1
	if button_press_count >= MAX_BUTTON_COUNT:
		close_popup()


func _on_lock_in_4_pressed() -> void:
	if line_edit_4.text.to_int() > GameData.current_money:
		return
	lock_in_4.disabled = true
	var amount: int
	if line_edit_4.text == "":
		amount = 0
	else:
		amount = line_edit_4.text.to_int()
	Signals.player_placed_bet.emit(amount, horf_id_4)
	button_press_count += 1
	if button_press_count >= MAX_BUTTON_COUNT:
		close_popup()


func _on_done_pressed() -> void:
	close_popup()
