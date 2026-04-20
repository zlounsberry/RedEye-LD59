extends Node2D

var is_bribed_to_be_worse: bool = false


func _ready() -> void:
	if not is_bribed_to_be_worse:
		$Label.text = "Increased Speed\nAnd Focus"
	else:
		$Label.text = "Decreased Speed\nAnd Focus"
