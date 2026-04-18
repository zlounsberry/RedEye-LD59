extends Node2D

const VELOCITY_UPDATES: int = 5

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var change_speed_timer: Timer = $ChangeSpeed
@onready var lock_in_timer: Timer = $LockIn
@onready var horf_anim: AnimationPlayer = $HorfAnim
@onready var emote_anim: AnimationPlayer = $EmoteAnim
@onready var stats_popup: Panel = $StatsPopup
@onready var lose_button: Button = $VBoxContainer/LoseButton
@onready var win_button: Button = $VBoxContainer/WinButton
@onready var race_over: bool = false
@onready var locked_in: bool = false

var speed_modifier: float = 1.0
var speed: float
var speed_low: float
var speed_high: float
var lock_in_likelihood: float
var horf_id: int
var odds_to_one: int
var horf_name_first: String
var horf_name_last: String

var speed_modifier_delta_on_bribe: float = randf_range(0.025, 0.05)
var lock_in_delta_on_bribe: float = randf_range(0.025, 0.05)
var cost_to_bribe: int = randi_range(100, 500)


func _ready() -> void:
#	 Most functions called from main.tscn
	_connect_signals()


func assign_values_based_on_id() -> void:
	if not GameData.HORF_DICT.has(horf_id):
		print("out of range error")
		return
	odds_to_one = GameData.HORF_DICT[horf_id]["odds_to_one"]
	speed_low = GameData.HORF_DICT[horf_id]["low_speed"]
	speed_high = GameData.HORF_DICT[horf_id]["high_speed"]
	lock_in_likelihood = GameData.HORF_DICT[horf_id]["lock_in_likelihood"]
	var first_name_array: Array = GameData.HORF_FIRST_NAME_ARRAY.duplicate()
	var last_name_array: Array = GameData.HORF_LAST_NAME_ARRAY.duplicate()
	first_name_array.shuffle()
	last_name_array.shuffle()
	horf_name_first = first_name_array[0]
	horf_name_last = last_name_array[0]
	_populate_stats_popup()


func _connect_signals() -> void:
	Signals.start_race.connect(_race_start)
	Signals.horf_is_winner.connect(_race_over)


func _physics_process(delta: float) -> void:
	if race_over:
		return
	path_follow_2d.progress += (speed * delta * speed_modifier)
	if path_follow_2d.progress_ratio >= 1.0:
		print("horf wins!")
		Signals.horf_is_winner.emit(horf_id)


func _update_current_speed() -> void:
	var new_speed: float = randf_range(speed_low, speed_high) * speed_modifier
	speed = new_speed


func _populate_stats_popup() -> void:
	stats_popup.speed_low = speed_low
	stats_popup.speed_high = speed_high
	stats_popup.lock_in_likelihood = lock_in_likelihood
	stats_popup.odds_to_one = odds_to_one
	stats_popup.horf_name_first = horf_name_first
	stats_popup.horf_name_last = horf_name_last
	stats_popup.cost_to_bribe = cost_to_bribe
	stats_popup.modifier_delta_on_bribe = speed_modifier_delta_on_bribe
	stats_popup.lock_in_delta_on_bribe = lock_in_delta_on_bribe
	stats_popup.populate_text()


func _bribe_jockey(is_bribed_to_be_worse: bool) -> void:
	print("bribe jockey")
	if is_bribed_to_be_worse:
		speed_modifier -= speed_modifier_delta_on_bribe
		lock_in_likelihood -= lock_in_delta_on_bribe
	else:
		speed_modifier += speed_modifier_delta_on_bribe
		lock_in_likelihood += lock_in_delta_on_bribe
	speed_low *= speed_modifier
	speed_high *= speed_modifier


func _race_start() -> void:
	horf_anim.play("run")
	_update_current_speed()
	$ChangeSpeed.start()


func _race_over(_horf_id: int) -> void:
	race_over = true


func _on_misfire_gun() -> void:
	if locked_in:
		return
	speed = 0
	change_speed_timer.start()


func _on_change_speed_timeout() -> void:
	_update_current_speed()


func _on_lock_in_timeout() -> void:
	if locked_in:
		return
	var random_float: float = randf()
	if random_float <= lock_in_likelihood:
		locked_in = true
	await get_tree().create_timer(3.0).timeout
	locked_in = false
	change_speed_timer.start()


func _on_mouse_hitbox_mouse_entered() -> void:
	for popup_child in get_tree().get_nodes_in_group("stats_popup"):
		popup_child.hide_popup()
	print("show_stats_popup")
	stats_popup.show_popup()


func _on_mouse_hitbox_mouse_exited() -> void:
	print("hide_popup")
	stats_popup.hide_popup()


func _on_lose_button_pressed() -> void:
	_bribe_jockey(true)
	Signals.update_money.emit(-cost_to_bribe)


func _on_win_button_pressed() -> void:
	_bribe_jockey(false)
	Signals.update_money.emit(-cost_to_bribe)
