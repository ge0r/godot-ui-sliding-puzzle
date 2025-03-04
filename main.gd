extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var h_box_container: HBoxContainer = $SizeSelector/HBoxContainer
@onready var size_selector: VBoxContainer = $SizeSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count = 1
	for button in h_box_container.get_children():
		count += 1
		button = button as Button
		button.pressed.connect(_on_button_pressed.bind(count*count))

func init_grid(size: int) -> void:
	var side = sqrt(size)

	grid_container.columns = side
	for i in range(size):
		var button = Button.new()
		if i != size - 1:
			button.text = str(i + 1)

		if i%2 == 0:
			button.add_theme_color_override("font_color", Color.WHITE)
		else:
			button.add_theme_color_override("font_color", Color.RED)
			button.add_theme_color_override("font_hover_color", Color.RED)
			button.add_theme_color_override("font_pressed_color", Color.RED)
			button.add_theme_color_override("font_focus_color", Color.RED)
		button.custom_minimum_size = Vector2(35, 35)
		grid_container.add_child(button)
	print(size)

func _on_button_pressed(size: int):
	init_grid(size)
	size_selector.process_mode = Node.PROCESS_MODE_DISABLED
	size_selector.hide()
	# size_selector.show()
