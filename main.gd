extends Control

const black_stylebox = preload("res://button_black.tres")
const black_orange_stylebox = preload("res://button_black_orange.tres")
const black_orange_stylebox_pressed = preload("res://button_black_orange_pressed.tres")

@onready var grid_container: GridContainer = $GridContainer
@onready var h_box_container: HBoxContainer = $SizeSelector/HBoxContainer
@onready var size_selector: VBoxContainer = $SizeSelector

var button_grid: Dictionary = {}
var blank_button: Vector2i
var side: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count: int = 1
	for button in h_box_container.get_children():
		count += 1
		button = button as Button
		button.pressed.connect(_on_hbox_button_pressed.bind(count * count))


func _process(_delta):
	pass


func init_grid(grid_size: int) -> void:
	side = int(sqrt(grid_size))
	grid_container.columns = side

	var numbers = range(1, grid_size)
	numbers.shuffle()

	for i in range(side):
		for j in range(side):
			var button = Button.new()
			button.custom_minimum_size = Vector2(60, 60)
			button.add_theme_color_override("font_hover_color", Global.orange)
			button.add_theme_color_override("font_pressed_color", Global.orange)
			button.add_theme_color_override("font_focus_color", Color.WHITE)
			button.add_theme_stylebox_override("normal", black_orange_stylebox)
			button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
			button.add_theme_stylebox_override("hover", black_orange_stylebox)
			button.add_theme_stylebox_override("pressed", black_orange_stylebox_pressed)

			# Not needed, font size is set via parent node theme (default font size)
			# button.add_theme_font_size_override("font_size", 35)

			var value = (i * side) + j
			if value != grid_size - 1:
				button.text = str(numbers[value])
				if numbers[value] % 2 == 0:
					button.add_theme_color_override("font_color", Global.light_blue)
					button.add_theme_color_override("font_focus_color", Global.light_blue)
			else:
				button.text = ""
				blank_button = Vector2i(i, j)

			button.pressed.connect(_on_grid_button_pressed.bind(button))
			grid_container.add_child(button)
			button_grid[Vector2i(i, j)] = button

	update_buttons()


func calculate_neighbors() -> Array:
	var neighbors = []
	var x = blank_button.x
	var y = blank_button.y

	if x > 0:
		neighbors.append(Vector2i(x - 1, y))
	if x < side - 1:
		neighbors.append(Vector2i(x + 1, y))
	if y > 0:
		neighbors.append(Vector2i(x, y - 1))
	if y < side - 1:
		neighbors.append(Vector2i(x, y + 1))

	return neighbors

func update_buttons() -> Array:
	for button in button_grid.values():
		button.add_theme_color_override("font_hover_color", button.get_theme_color("font_color"))
		button.add_theme_color_override("font_pressed_color", button.get_theme_color("font_color"))
		button.add_theme_stylebox_override("normal", black_stylebox)
		button.add_theme_stylebox_override("hover", black_stylebox)
		button.add_theme_stylebox_override("pressed", black_stylebox)

	var neighbors = calculate_neighbors()
	for neighbor in neighbors:
		button_grid[neighbor].add_theme_color_override("font_hover_color", Global.orange)
		button_grid[neighbor].add_theme_color_override("font_pressed_color", Global.orange)
		button_grid[neighbor].add_theme_stylebox_override("normal", black_orange_stylebox)
		button_grid[neighbor].add_theme_stylebox_override("hover", black_orange_stylebox)
		button_grid[neighbor].add_theme_stylebox_override("pressed", black_orange_stylebox_pressed)

	return neighbors


func _on_grid_button_pressed(button: Button) -> void:
	var neighbors = update_buttons()
	for neighbor in neighbors:
		if button_grid[neighbor] == button:
			print("lolz")
			# TODO swap positions with the blank button


func _on_hbox_button_pressed(grid_size: int) -> void:
	init_grid(grid_size)
	size_selector.process_mode = Node.PROCESS_MODE_DISABLED
	size_selector.hide()
