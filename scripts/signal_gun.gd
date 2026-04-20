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
	race_started = true
	fire.disabled = true
	fire.text = '\"Misfire\"'
	cooldown.start()
	gun.play("fire")
	await get_tree().create_timer(0.2).timeout
	Signals.start_race.emit()
	$MuzzleFlash.emitting = true
	$Smoke.emitting = true
	fire_sound.play()


func _misfire_gun() -> void:
	Signals.misfire_gun.emit()
	gun.play("fire")
	await get_tree().create_timer(0.2).timeout
	$MuzzleFlash.emitting = true
	$Smoke.emitting = true
	fire_sound.play()
	fire.disabled = true
	fire.text = 'No Ammo'


func _on_fire_pressed() -> void:
	if race_started:
		_misfire_gun()
	else:
		_start_race()


func _on_cooldown_timeout() -> void:
	fire.disabled = false


func _enable_button() -> void:
	fire.disabled = false
