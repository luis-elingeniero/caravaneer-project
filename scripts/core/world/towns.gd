extends Node2D

var zones_data = []  # Datos de las zonas cargadas del JSON
var city_database = {}  # Diccionario con datos adicionales de las ciudades

func _ready():
	var json_path = "res://scripts/core/presets/tribal_zone.json"
	var file = FileAccess.open(json_path, FileAccess.READ)
	
	if file:
		var json = JSON.new()
		var json_result = json.parse(file.get_as_text())
		
		if json_result == OK:
			zones_data = json.get_data()["zones"]
			# Crear diccionario de ciudades para acceso rápido
			for zone in zones_data:
				city_database[zone["id"]] = zone
			generate_cities(zones_data)
		file.close()
	else:
		print("Error al abrir el archivo: ", json_path)

func generate_cities(zones):
	for zone in zones:
		# Obtener datos de la ciudad
		var city_position = Vector2(zone["position"]["x"], zone["position"]["y"])
		var city_name = zone["name"]
		var city_id = zone["id"]
		
		print("Ciudad:", city_name, "en posición:", city_position, "ID:", city_id)

		# Crear nodo de la ciudad
		var city_node = Node2D.new()
		city_node.name = city_name  # Nombre del nodo para facilitar el debug
		city_node.position = city_position
		add_child(city_node)

		# Asignar script visual
		var city_visual_script = preload("res://scripts/core/world/city_visual.gd")
		city_node.set_script(city_visual_script)

		# Crear hitbox interactivo
		var area = Area2D.new()
		city_node.add_child(area)

		# Configurar la hitbox circular
		var hitbox = CollisionShape2D.new()
		var circle_shape = CircleShape2D.new()
		circle_shape.radius = 50
		hitbox.shape = circle_shape
		area.add_child(hitbox)

		# Conectar evento de clic
		area.connect("input_event", Callable(self, "_on_city_clicked"))
		area.set_meta("city_id", city_id)  # Asociar ID para identificar la ciudad en el evento

func _on_city_clicked(viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var city_id = viewport.get_meta("city_id")
		print("Ciudad seleccionada con ID:", city_id)
		change_to_city_scene(city_id)

func change_to_city_scene(city_id):
	var city_data = get_city_data_by_id(city_id)
	if city_data:
		get_tree().change_scene("res://scenes/menu/town.tscn")  # Cambia a la escena del menú de ciudad
	else:
		print("Ciudad no encontrada en la base de datos.")

func get_city_data_by_id(city_id):
	return city_database.get(city_id, null)
