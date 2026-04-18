extends Node2D

const VELOCITY_UPDATES: int = 5

@export var speed_low: float = 8
@export var speed_high: float = 12
@export var speed_modifier: float = 1.0
@export var horf_id: int = 1

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var timer: Timer = $Timer
@onready var race_over: bool = false

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
	prints("speed:", speed, horf_id)


func _race_start() -> void:
	pass


func _race_over(_horf_id: int) -> void:
	race_over = true


func _on_timer_timeout() -> void:
	_update_current_speed()
