extends Node

func transition_music(from_song: String, to_song: String) -> void:
	if GameData.muted_music:
		return
	var from_song_node: AudioStreamPlayer = get_node(from_song)
	var to_song_node: AudioStreamPlayer = get_node(to_song)
	to_song_node.volume_linear = 0.001
	to_song_node.play()
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(from_song_node, "volume_linear", 0.001, 1.0)
	tween.tween_property(to_song_node, "volume_linear", 0.8, 1.0)
	await tween.finished
	from_song_node.stop()
