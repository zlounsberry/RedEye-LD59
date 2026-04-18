extends Node

signal horf_is_winner(horf_id: int)
signal start_race
signal misfire_gun
signal update_money(delta: int)
signal money_updated

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
