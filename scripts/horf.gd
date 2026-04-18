extends Node2D

const VELOCITY_UPDATES: int = 5

@export var speed_low: float = 8
@export var speed_high: float = 12
@export var speed_modifier: float = 1.0
@export var horf_id: int = 1
@export var lock_in_likelihood: float = 0.2

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var change_speed_timer: Timer = $ChangeSpeed
@onready var lock_in_timer: Timer = $LockIn
@onready var horse_anim: AnimationPlayer = $HorseAnim
@onready var emote_anim: AnimationPlayer = $EmoteAnim
@onready var race_over: bool = false
@onready var locked_in: bool = false

var speed: float


func _ready() -> void:
	_update_current_speed()
	_connect_signals() 


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


func _race_start() -> void:
	horse_anim.play("run")


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
