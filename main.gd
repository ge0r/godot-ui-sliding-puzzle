extends Control

const SIZE = 9

@onready var grid_container: GridContainer = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func init_grid() -> void:
	var side = sqrt(SIZE)
	for i in range(side):
		for j in range(side):
			pass

	# TODO create dynamically the buttons with their text and its color
