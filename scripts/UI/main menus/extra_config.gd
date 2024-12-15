extends Control

var error_sound : AudioStreamPlayer

@onready var default_mode = $mode/story
@onready var alt_mode1 = $mode/survival
@onready var default_difficulty = $dificulty/normal
@onready var alt_difficulty1 = $dificulty/hard

func _ready():
	# Estado inicial
	default_mode.button_pressed = true
	alt_mode1.button_pressed = false
	default_difficulty.button_pressed = true
	alt_difficulty1.button_pressed = false

	# Inicializa el sonido de error
	error_sound = AudioStreamPlayer.new()
	error_sound.stream = preload("res://assets/audio/menu/1051_SFXError.mp3")
	add_child(error_sound)

# Función para manejar el botón de modo historia
func _on_story_button_down() -> void:
	default_mode.disabled = true
	alt_mode1.disabled = false

	# Cargar y configurar la escena de mapa
	var scene_path = "res://scenes/gameplay/map.tscn"
	var map_scene = ResourceLoader.load(scene_path).instantiate()

	# Configurar los parámetros iniciales
	map_scene.get_node("caravan (player)").set_meta("parameters", {
		"x": -10000,
		"y": -900,
		"direction": 0,  # Ángulo en radianes
		"moving": true
	})
	print("Modo Historia seleccionado.")

# Función para manejar el botón de modo survival
func _on_survival_button_down() -> void:
	default_mode.disabled = false
	alt_mode1.disabled = true

	# Aquí también puedes configurar la lógica para modo survival
	error_sound.play()
	print("Error: Modo Survival no implementado.")

# Función para manejar dificultad normal
func _on_normal_button_down() -> void:
	default_difficulty.disabled = true
	alt_difficulty1.disabled = false
	print("Dificultad Normal seleccionada.")

# Función para manejar dificultad difícil
func _on_hard_button_down() -> void:
	default_difficulty.disabled = false
	alt_difficulty1.disabled = true
	print("Dificultad Difícil seleccionada.")

# Otros botones (autosave, tutorial, etc.)
func _on_autosave_button_down() -> void:
	error_sound.play()
	print("Error: Autosave no implementado.")

func _on_show_tutorial_button_down() -> void:
	error_sound.play()
	print("Error: Tutorial no disponible.")

# Volver atrás
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_creator.tscn")

# Comenzar el juego
func _on_start_pressed() -> void:
	var packed_scene = preload("res://scenes/gameplay/map.tscn")
	var instance = packed_scene.instantiate()

	# Configura los parámetros antes de añadir la escena
	instance.set("player_parameters", {
		"position": Vector2(-10000, -900),
		"direction": Vector2.RIGHT,
		"moving": true
	})

	get_tree().root.add_child(instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = instance
	get_tree().change_scene_to_file("res://scenes/menu/lore.tscn")
