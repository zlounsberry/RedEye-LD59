extends Control


func _ready() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 1, 0.5)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_close_window_pressed() # jank! deal with it!


func show_game_over_loss() -> void:
	$DeadLabel.show()
	$ColorRect.color = "#e53b44"
	$ColorRect.modulate.a = 0.5


func show_game_over_win() -> void:
	$WinLabel.show()


func show_round_over_horf_result(horf_name: String, winning_amount: int) -> void:
	$VBoxContainer/HorseWins.text = str("[center]", horf_name, " wins!!")
	$VBoxContainer/HorseWinsValue.text = str("[center]", "You win $", winning_amount)
	$VBoxContainer.show()
	$CloseWindow.show()


func _on_restart_game_pressed() -> void:
	Signals.restart_game.emit()


func _on_close_window_pressed() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	await tween.finished
	Signals.player_wants_to_reload_scene.emit()
