extends Control

func _ready() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 1, 0.25)


func show_game_over_loss() -> void:
	$DeadLabel.show()


func _on_restart_game_pressed() -> void:
	Signals.restart_game.emit()


func _on_close_window_pressed() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel()
	tween.tween_property(self, "modulate:a", 0, 0.25)
	await tween.finished
	self.queue_free()
