extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var h_box_container: HBoxContainer = $SizeSelector/HBoxContainer
@onready var size_selector: VBoxContainer = $SizeSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count: int = 1
	for button in h_box_container.get_children():
		count += 1
		button = button as Button
		button.pressed.connect(_on_button_pressed.bind(count*count))


func init_grid(grid_size: int) -> void:
	const black_orange_stylebox = preload("res://button_black_orange.tres")
	const black_orange_stylebox_pressed = preload("res://button_black_orange_pressed.tres")

	var side: int = int(sqrt(grid_size))

	grid_container.columns = side
	for i in range(grid_size):

		var button = Button.new()
		button.custom_minimum_size = Vector2(60, 0)
		button.add_theme_color_override("font_hover_color", Global.orange)
		button.add_theme_color_override("font_pressed_color", Global.orange)
		button.add_theme_color_override("font_focus_color", Color.WHITE)
		button.add_theme_stylebox_override("normal", black_orange_stylebox)
		button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		button.add_theme_stylebox_override("hover", black_orange_stylebox)
		button.add_theme_stylebox_override("pressed", black_orange_stylebox_pressed)

		# Not needed anymore, font size set via parent node theme (default font size)
		# button.add_theme_font_size_override("font_size", 35)

		if i != grid_size - 1:
			button.text = str(i + 1)
		if i%2 == 0:
			button.add_theme_color_override("font_color", Global.light_blue)
			button.add_theme_color_override("font_focus_color", Global.light_blue)

		grid_container.add_child(button)


func _on_button_pressed(grid_size: int) -> void:
	init_grid(grid_size)
	size_selector.process_mode = Node.PROCESS_MODE_DISABLED
	size_selector.hide()
