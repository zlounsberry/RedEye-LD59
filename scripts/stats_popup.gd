extends Node2D

@onready var name_label: Label = $VBoxContainer/Name
@onready var odds_label: Label = $VBoxContainer/Odds
@onready var speed_label: Label = $VBoxContainer/Speed
@onready var focus_label: Label = $VBoxContainer/Focus
@onready var bribe_cost_label: Label = $VBoxContainer/BribeCost
@onready var bribe_amount_label: Label = $VBoxContainer/BribeAmount


var speed_modifier: float = 1.0
var speed: float
var speed_low: float
var speed_high: float
var lock_in_likelihood: float
var horf_id: int
var odds_to_one: int
var modifier_delta_on_bribe: int
var horf_name_first: String
var horf_name_last: String
var lock_in_delta_on_bribe: int
var cost_to_bribe: int


func populate_text() -> void:
	name_label.text = str(horf_name_first, " ", horf_name_last)
	odds_label.text = str("Odds: ", odds_to_one, ":1")
	speed_label.text = str("Speed: ", speed_low, " - ", speed_high)
	focus_label.text = str("Focus: ", lock_in_likelihood)
	bribe_cost_label.text = str("Cost to Bribe: $", cost_to_bribe)
	bribe_amount_label.text = str("Bribe Impact: ", cost_to_bribe)


func _show_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15)
	tween.tween_property(self, "position", Vector2((self.size.x / 2), (self.size.y / 2)), 0.15)


func _hide_popup() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	tween.tween_property(self, "position", Vector2.ZERO, 0.15)
