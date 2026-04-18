extends Panel

#Just copypasta from stats_popup, not DRY but it's a jam shut up
@onready var name_0: Label = $VBoxContainer/Horf0/Name
@onready var odds_0: Label = $VBoxContainer/Horf0/Odds
@onready var sprite_0: Sprite2D = $VBoxContainer/Horf0/MarginContainer/Sprite2D
@onready var line_edit_0: LineEdit = $VBoxContainer/Horf0/LineEdit
@onready var lock_in_0: Button = $VBoxContainer/Horf0/LockIn
@onready var name_1: Label = $VBoxContainer/Horf1/Name
@onready var odds_1: Label = $VBoxContainer/Horf1/Odds
@onready var sprite_1: Sprite2D = $VBoxContainer/Horf1/MarginContainer/Sprite2D
@onready var line_edit_1: LineEdit = $VBoxContainer/Horf1/LineEdit
@onready var lock_in_1: Button = $VBoxContainer/Horf1/LockIn
@onready var name_2: Label = $VBoxContainer/Horf2/Name
@onready var odds_2: Label = $VBoxContainer/Horf2/Odds
@onready var sprite_2: Sprite2D = $VBoxContainer/Horf2/MarginContainer/Sprite2D
@onready var line_edit_2: LineEdit = $VBoxContainer/Horf2/LineEdit
@onready var lock_in_2: Button = $VBoxContainer/Horf2/LockIn
@onready var name_3: Label = $VBoxContainer/Horf3/Name
@onready var odds_3: Label = $VBoxContainer/Horf3/Odds
@onready var sprite_3: Sprite2D = $VBoxContainer/Horf3/MarginContainer/Sprite2D
@onready var line_edit_3: LineEdit = $VBoxContainer/Horf3/LineEdit
@onready var lock_in_3: Button = $VBoxContainer/Horf3/LockIn
@onready var name_4: Label = $VBoxContainer/Horf4/Name
@onready var odds_4: Label = $VBoxContainer/Horf4/Odds
@onready var sprite_4: Sprite2D = $VBoxContainer/Horf4/MarginContainer/Sprite2D
@onready var line_edit_4: LineEdit = $VBoxContainer/Horf4/LineEdit
@onready var lock_in_4: Button = $VBoxContainer/Horf4/LockIn

var odds_to_one_0: int
var horf_id_0: int
var horf_name_first_0: String
var horf_name_last_0: String
var horf_photo_path_0: String
var odds_to_one_1: int
var horf_id_1: int
var horf_name_first_1: String
var horf_name_last_1: String
var horf_photo_path_1: String
var odds_to_one_2: int
var horf_id_2: int
var horf_name_first_2: String
var horf_name_last_2: String
var horf_photo_path_2: String
var odds_to_one_3: int
var horf_id_3: int
var horf_name_first_3: String
var horf_name_last_3: String
var horf_photo_path_3: String
var odds_to_one_4: int
var horf_id_4: int
var horf_name_first_4: String
var horf_name_last_4: String
var horf_photo_path_4: String


func populate_text() -> void:
	name_0.text = str(horf_name_first_0, " ", horf_name_last_0)
	odds_0.text = str(odds_to_one_0, ":1")
	sprite_0.texture = load(horf_photo_path_0)
	name_1.text = str(horf_name_first_1, " ", horf_name_last_1)
	odds_1.text = str(odds_to_one_1, ":1")
	sprite_1.texture = load(horf_photo_path_1)
	name_2.text = str(horf_name_first_2, " ", horf_name_last_2)
	odds_2.text = str(odds_to_one_2, ":1")
	sprite_2.texture = load(horf_photo_path_2)
	name_3.text = str(horf_name_first_3, " ", horf_name_last_3)
	odds_3.text = str(odds_to_one_3, ":1")
	sprite_3.texture = load(horf_photo_path_3)
	name_4.text = str(horf_name_first_4, " ", horf_name_last_4)
	odds_4.text = str(odds_to_one_4, ":1")
	sprite_4.texture = load(horf_photo_path_4)


func show_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", Vector2.ONE, 0.25)


func close_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", Vector2.ZERO, 0.25)
	await tween.finished
	self.queue_free()
