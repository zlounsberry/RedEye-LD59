extends Node

signal horf_is_winner(horf_id: int)
signal start_race
signal misfire_gun
signal update_money(delta: int)
signal money_updated
signal player_placed_bet(amount: int, horf_id: int)
signal bets_placed
signal restart_game
signal player_wants_to_reload_scene
signal final_show_game_over_screen(player_wins: bool)


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
