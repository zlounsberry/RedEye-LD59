extends Node2D

@onready var gun: AnimatedSprite2D = $Gun
@onready var fire: Button = $Fire
@onready var fire_sound: AudioStreamPlayer = $FireSound
@onready var cooldown: Timer = $Cooldown
@onready var race_started: bool = false


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Signals.bets_placed.connect(_enable_button)


func _start_race() -> void:
	fire.disabled = true
	fire.text = '\"Misfire\"'
	cooldown.start()
	Signals.start_race.emit()
	gun.play("fire")
	fire_sound.play()


func _misfire_gun() -> void:
	Signals.misfire_gun.emit()
	gun.play("fire")
	fire_sound.play()
	cooldown.start()


func _on_fire_pressed() -> void:
	if race_started:
		_misfire_gun()
	else:
		_start_race()


func _on_cooldown_timeout() -> void:
	fire.disabled = false


func _enable_button() -> void:
	fire.disabled = false
