extends AudioStreamPlayer

var music_muted := false
var last_music_volume_db := 0.0

func change_music(music_path: String, fade_out_time: float = 2.0, fade_in_time: float = 1.0, target_volume_db: float = 0.0):
	if stream !=null and stream.resource_path == music_path and playing:
		return
	
	var tween := get_tree().create_tween()
	tween.tween_property($".", "volume_db", -80, fade_out_time)
	tween.tween_callback(Callable(self, "_on_fade_out_done").bind(music_path, fade_out_time,fade_in_time, target_volume_db))


func _on_fade_out_done(music_path: String, fade_out_time: float, fade_in_time: float, target_volume_db: float):
	$".".stream = load(music_path)
	$".".volume_db = -80
	$".".play()

	var tween := get_tree().create_tween()
	tween.tween_property($".", "volume_db", target_volume_db, fade_in_time)


func play_FX(fx : AudioStream, volume = 0.0, pitch = 1.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = fx
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	fx_player.pitch_scale = pitch
	fx_player.bus = &"FX"
	add_child(fx_player)
	fx_player.play()
	await fx_player.finished
	fx_player.queue_free()

#A utiliser pour du debug
func toggle_mute_music():
	if not playing:
		return # rien à couper

	if music_muted:
		volume_db = last_music_volume_db
		music_muted = false
	else:
		last_music_volume_db = volume_db
		volume_db = -80
		music_muted = true
