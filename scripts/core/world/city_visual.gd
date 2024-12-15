# Nodo que representará cada ciudad
extends Node2D

var circle_radius = 10  # Radio del círculo blanco
var ring_radius = 20    # Radio del anillo café

func _draw():
	# Dibuja un círculo blanco
	draw_circle(Vector2.ZERO, circle_radius, Color(1, 1, 1, 0.8))
	# Dibuja un anillo café alrededor
	draw_circle(Vector2.ZERO, ring_radius, Color(0.3, 0.15, 0))

# Para actualizar la apariencia, podemos llamar a update()
