extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = load("res://Assets/Creatures/Player/Player-Right.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	if Input.is_action_pressed("move_left"):
		self.texture = load("res://Assets/Creatures/Player/Player-Left.png")
	if Input.is_action_pressed("move_right"):
		self.texture = load("res://Assets/Creatures/Player/Player-Right.png")
