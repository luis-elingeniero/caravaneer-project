extends Control

var error_sound : AudioStreamPlayer
func _ready():
	error_sound = AudioStreamPlayer.new()
	error_sound.stream = preload("res://assets/audio/menu/1051_SFXError.mp3")
	add_child(error_sound)

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_creator.tscn")


func _on_load_game_pressed() -> void:
	error_sound.play()


func _on_dl_cmods_pressed() -> void:
	error_sound.play()


func _on_credits_pressed() -> void:
	error_sound.play()


func _on_instructions_and_guides_pressed() -> void:
	error_sound.play()


func _on_change_lenguaje_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/change_language.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_sfx_pressed() -> void:
	error_sound.play()


func _on_music_pressed() -> void:
	error_sound.play()


func _on_full_screen_pressed() -> void:
	error_sound.play()
