extends Control

const TEXT_DICT: Dictionary = {
	0: {
		0: "Another fine day at the horf racing track, eh? *Ahem*... Boss sent me to collect your debt by the end of the week.",
		1: "No hard feelings, but if you don't have that $100,000 by Day 5... Well...",
		2: "You know...",
		3: "But hey, boss says you're resourceful! Shady racetrack like this? No one is going to be the wiser if you tip the scales in your favor.",
		4: "Why not try your hand at being strategic with your starting signal? Bet on a bad-odds horse that'll pay out well and be smart about when you fire that shot, eh? If you can catch the fast ones distracted...",
		5: "Plus, you know those handlers don't get paid enough. You can always pay 'em a little extra to try a little harder... *Ahem*... in one direction or the other.",
		6: "And in a real pinch, no one is going to notice if your starter pistol pops off an extra time during the race, right? Those things are finicky! Just make sure your horf is locked in when you do it, eh?",
		7: "Either way, you've got until the weekend to get our cash. $100K, remember? Should be easy for a slick starter like you. I'll be back in a few days... *Ahem*... And you'll have our money."
	},
	1: {
		0: "Tough break kid... There's no way you're getting 100K by week's end. You know you're supposed to bet on the horses with bad odds right? And bribe those horses' handlers to win? *Ahem*",
		1: "Anyway you're gonna want to come with me. Well, you're not gonna WANT to, but better to use those legs while you still got 'em, eh? Let's go..."
	},
	2: {
		0: "Well kid, you know the deal...",
		1: "You're gonna want to... Wait, 100K? Really? Huh, I'll be damned. *Ahem* Turns out you really ARE resourceful. Good to know down the road. Nice job kid... I'll be on my way then. Keep your nose clean."
	},
	3: {
		0: "Well kid, you know the deal...",
		1: "Seriously?? Over half a million? Calm down! I guess I'll take my 100K and be on my way... Better quit while you're ahead, eh?"
	},
	4: {
		0: "Holy shit you got over a million! Go play some other Ludum Dare games! Calm down! lmao. That's it you win. You super did it. Go touch some grass!",
	},
}

@export var text_id: int
@export var game_is_over: bool = false

@onready var current_text_block: int = 0
@onready var entry_anim: AnimationPlayer = $EntryAnim
@onready var label: Label = $Panel/Label
@onready var can_advance: bool = false



func _ready() -> void:
	get_tree().paused = true
	if game_is_over:
		$RestartGame.show()
	entry_anim.play("enter")
	await entry_anim.animation_finished
	_populate_text()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if can_advance:
			can_advance = false
			_populate_text()


func _populate_text() -> void:
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
	print("Stranger left")
	entry_anim.play_backwards("enter")
	await entry_anim.animation_finished
	print("Stranger left anim finished")
	if is_inside_tree():
		get_tree().paused = false
	if game_is_over:
		# How's THIS for end-of-day jank?!
		if text_id == 1:
			prints("game over! you lose!", get_tree().paused)
			Signals.final_show_game_over_screen.emit(false)
		else:
			print("game over! you win!!", get_tree().paused)
			Signals.final_show_game_over_screen.emit(true)
	self.queue_free()


func _on_skip_pressed() -> void:
	can_advance = false
	_leave()


func _on_restart_game_pressed() -> void:
	if is_inside_tree():
		get_tree().paused = false
	Signals.restart_game.emit()
