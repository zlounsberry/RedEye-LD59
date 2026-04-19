extends Panel

const POPUP_GLOBAL_POSITION: = Vector2(704.0, 252.0)

@onready var name_label: Label = $VBoxContainer/Name
@onready var horf_sprite: Sprite2D = $VBoxContainer/MarginContainer/HorfSprite
@onready var odds_label: Label = $VBoxContainer/Odds
@onready var speed_label: Label = $VBoxContainer/Speed
@onready var focus_label: Label = $VBoxContainer/Focus
@onready var bribe_cost_label: Label = $VBoxContainer/BribeCost
@onready var bribe_amount_speed: Label = $VBoxContainer/BribeAmountSpeed
@onready var bribe_amount_focus: Label = $VBoxContainer/BribeAmountFocus


var speed_modifier: float = 1.0
var speed: float
var speed_low: float
var speed_high: float
var lock_in_likelihood: float
var horf_id: int
var odds_to_one: int
var horf_name_first: String
var horf_name_last: String
var modifier_delta_on_bribe: float
var lock_in_delta_on_bribe: float
var cost_to_bribe: int
var horf_sprite_string: String


func populate_text() -> void:
	name_label.text = str(horf_name_first, " ", horf_name_last)
	odds_label.text = str("Odds: ", odds_to_one, ":1")
	speed_label.text = str("Speed: ", str(speed_low).left(4), " - ", str(speed_high).left(4))
	focus_label.text = str("Focus: ", str(lock_in_likelihood).left(4))
	bribe_cost_label.text = str("Cost to Bribe: $", str(cost_to_bribe).left(4))
	bribe_amount_speed.text = str("Bribe Speed Increase: ", str(modifier_delta_on_bribe).left(4))
	bribe_amount_focus.text = str("Bribe Focus Increase: ", str(lock_in_delta_on_bribe).left(4))
	if horf_sprite_string == "":
		return
	horf_sprite.texture = load(horf_sprite_string)


func show_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15)
	tween.tween_property(self, "global_position", POPUP_GLOBAL_POSITION, 0.15)


func hide_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	tween.tween_property(self, "global_position", get_parent().global_position, 0.15)
