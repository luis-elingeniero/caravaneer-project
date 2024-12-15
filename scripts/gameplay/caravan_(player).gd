extends CharacterBody2D

# Variables de configuración
var speed: float = 500  # Velocidad del movimiento
var target_position: Vector2 = Vector2.ZERO  # Posición objetivo del jugador
var moving: bool = false  # Estado de movimiento
var move_direction: Vector2 = Vector2(0, -1)  # Dirección inicial

# Referencias a nodos del jugador
@onready var label = $"../CanvasLayer/Angle"  # Indicador en pantalla
@onready var hitbox = $click_Hitbox  # Hitbox del jugador
@onready var direction_arrow = $Direction_Arrow  # Flecha de dirección
@onready var mouse_indicator = $Mouse_Indicator  # Indicador del mouse

func _ready():
	# Inicialización de nodos y posiciones
	direction_arrow.position = Vector2.ZERO
	mouse_indicator.position = Vector2.ZERO
	target_position = position

	# Mostrar la información inicial del jugador
	update_indicator()

	# Cargar parámetros iniciales opcionales
	# Verificar si hay parámetros iniciales y configurarlo

func _process(_delta: float) -> void:
	if moving:
		# Movimiento continuo del jugador
		if move_direction == Vector2.ZERO:
			moving = false  # Detener movimiento si no hay dirección válida
			return

		velocity = move_direction * speed
		move_and_slide()

	# Actualizar los elementos visuales siempre, incluso cuando esté quieto
	update_indicator()
	update_direction_arrow()
	update_mouse_indicator()

func update_indicator() -> void:
	# Mostrar posición y ángulo en la etiqueta
	var angle_degrees = rad_to_deg(move_direction.angle())
	label.text = "Posición: (x: %.2f, y: %.2f)\nÁngulo: %.2f°" % [position.x, position.y, angle_degrees]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Configurar el movimiento hacia el punto clicado
			target_position = get_global_mouse_position()
			move_direction = (target_position - position).normalized()
			moving = true

func update_direction_arrow() -> void:
	# Actualizar la flecha para que apunte en la dirección del movimiento
	direction_arrow.rotation = move_direction.angle() + deg_to_rad(90)

func update_mouse_indicator() -> void:
	# Calcular la posición del indicador del mouse alrededor del jugador
	var mouse_position = get_global_mouse_position()
	var circle_radius = 25  # Radio del círculo imaginario
	var relative_angle = (mouse_position - position).angle()

	# Posicionar el indicador alrededor del jugador
	mouse_indicator.position = Vector2(cos(relative_angle), sin(relative_angle)) * circle_radius
	mouse_indicator.rotation = relative_angle + deg_to_rad(270)
