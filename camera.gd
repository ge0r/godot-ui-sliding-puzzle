extends Camera2D

func _ready():
	# Center the camera on the control node
	self.offset = get_viewport_rect().size / 2
