extends Control


func _ready() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR).set_parallel()
	tween.tween_property($ColorRect, "modulate:a", 0, 0.5)


func _on_sfx_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		AudioServer.set_bus_volume_linear(1, 0.8)
		GameData.muted_sfx = false
	else:
		AudioServer.set_bus_volume_linear(1, 0.0)
		GameData.muted_sfx = true
	$AudioStreamPlayer.play()


func _on_music_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		AudioServer.set_bus_volume_linear(2, 0.8)
		GameData.muted_music = false
	else:
		AudioServer.set_bus_volume_linear(2, 0.0)
		GameData.muted_music = true


func _on_start_game_pressed() -> void:
	$StartGame.disabled = true
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR).set_parallel()
	tween.tween_property($ColorRect, "modulate:a", 1, 1)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
