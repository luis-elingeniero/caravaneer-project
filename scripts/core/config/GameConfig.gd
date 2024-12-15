extends Node

var json_path = "res://scripts/core/presets/tribal_zone.json"
# Configuración seleccionada por el jugador
var mode: String = "story"  # Valores: "story", "survival"
var difficulty: String = "normal"  # Valores: "normal", "hard"

# Datos iniciales según la configuración
var player_config: Dictionary = {}
var world_config: Dictionary = {}

# Cargar configuración inicial basada en modo y dificultad
func load_configurations():
	# Configuración del jugador
	var player_path = "res://config/player_config.json"
	var player_data = load_json(player_path)

	if player_data.has(mode):
		if player_data[mode].has(difficulty):
			player_config = player_data[mode][difficulty]
		else:
			print("Error: dificultad '%s' no encontrada en el modo '%s'" % [difficulty, mode])
	else:
		print("Error: modo '%s' no encontrado en la configuración del jugador" % mode)

	# Configuración del mundo
	var world_path = "res://scripts/core/config/world_config.json"
	world_config = load_json(world_path)

# Función para cargar un archivo JSON
func load_json(path: String) -> Dictionary:
	var json = JSON.new()
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_error = json.parse(file.get_as_text())
		file.close()

		if json_error == OK:
			return json.get_data()
		else:
			print("Error al parsear el archivo JSON en %s: %s" % [path, json.get_error_message()])
	else:
		print("Error: no se pudo abrir el archivo %s" % path)

	return {}  # Retorna un diccionario vacío en caso de error
