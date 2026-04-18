extends Control


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Signals.horf_is_winner.connect(_horf_wins)


func _horf_wins(horf_id: int) -> void:
	prints("Horf wins", horf_id)

func ok() -> void
