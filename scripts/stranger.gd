extends Control

const TEXT_DICT: Dictionary = {
	0: {
		0: "Another fine day at the office, eh? *Ahem*... Boss sent me to collect your debt by the end of the week.",
		1: "No hard feelings, but if you don't have that $100,000 by Day 5... Well...",
		2: "You know...",
		3: "But hey, you're resourceful. You've got more control here than you think. Shady racetrack like this? No one is going to be the wiser if you tip the scales in your favor.",
		4: "Why not try your hand at being strategic with your starting signal? Go ahead and bet on a horse that'll pay you out and be smart about when you fire that shot, eh?",
		5: "Plus, you know those riders don't get paid enough. You can give 'em a little extra to try a little harder... *Ahem*... in one direction or the other.",
		6: "And in a real pinch, no one is going to notice if your starter pistol pops off an extra time during the race, right? Those things are finicky! Just make sure your horf is locked in when you do it, eh?",
		7: "Either way, you've got until the weekend to get our cash. $100K, remember? Should be easy for a slick starter like you. I'll be back in a few days... *Ahem*... And you'll have our cash."
	},
	1: {
		0: "Yep!"
	},
}

@export var text_id: int

@onready var current_text_block: int = 0
@onready var entry_anim: AnimationPlayer = $EntryAnim
@onready var label: Label = $Panel/Label
@onready var can_advance: bool = false


func _ready() -> void:
	get_tree().paused = true
	entry_anim.play("enter")
	await entry_anim.animation_finished
	_populate_text()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print('click')
		if can_advance:
			print('click registered', can_advance)
			can_advance = false
			_populate_text()


func _populate_text() -> void:
	prints("_populate_text()", text_id)
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label, "modulate:a", 0, 0.15)
	await tween.finished
	if current_text_block >= TEXT_DICT[text_id].size():
		_leave()
		return
	label.text = TEXT_DICT[text_id][current_text_block]
	label.visible_ratio = 0
	label.modulate.a = 1
	var text_tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	text_tween.tween_property(label, "visible_ratio", 1, 0.5)
	await text_tween.finished
	current_text_block += 1
	can_advance = true


func _leave() -> void:
	entry_anim.play_backwards("enter")
	await entry_anim.animation_finished
	if is_inside_tree():
		get_tree().paused = false
		self.queue_free()


func _on_skip_pressed() -> void:
	can_advance = false
	_leave()
