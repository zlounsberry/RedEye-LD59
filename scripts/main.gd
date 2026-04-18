extends Control

const HORF_ID_ARRAY: Array = [0,1,2,3,4,5,6,7]

@onready var day_title: RichTextLabel = $DayTitle


func _ready() -> void:
	_connect_signals()
	if GameData.current_day < GameData.MAX_DAYS:
		day_title.text = str("[center]Day ", GameData.current_day)
	else:
		day_title.text = str("[center][shake]Day ", GameData.current_day)
	var random_horf_id_array = _randomize_id_array()
	_assign_horf_ids(random_horf_id_array)


func _assign_horf_ids(random_horf_id_array: Array) -> void:
	var array_position_count: int = 0
	for horf_child in get_tree().get_nodes_in_group("horf"):
		horf_child.horf_id = random_horf_id_array[array_position_count]
		horf_child.assign_values_based_on_id()
		array_position_count += 1


func _randomize_id_array() -> Array:
	var random_horf_id_array = HORF_ID_ARRAY.duplicate()
	random_horf_id_array.shuffle()
	return random_horf_id_array


func _connect_signals() -> void:
	Signals.horf_is_winner.connect(_horf_wins)


func _horf_wins(horf_id: int) -> void:
	prints("Horf wins", horf_id)
