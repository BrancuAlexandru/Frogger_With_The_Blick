extends CharacterBody2D
@onready var raycast = $RayCast2D
@onready var my_timer = $"Invincible-Timer"

var data = {
	speed = 150,
	damage = 1,
	name = 'player',
	health = 3,
	isInvincible = false
}

func _ready():
	await get_tree().process_frame
	get_tree().call_group("enemies", "set_player", self)
	my_timer.timeout.connect(_on_timer_timeout)
	my_timer.wait_time = 0.3
	
func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * data.speed * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	raycast.rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		var collider = raycast.get_collider()
		if raycast.is_colliding() and collider.has_method("hit"):
			collider.hit(data.damage)

func make_invincible():
	$PlayerSprite.modulate = Color(1, 0, 0, 1)
	data.isInvincible = true
	my_timer.start()

func _on_timer_timeout():
	$PlayerSprite.modulate = Color(1, 1, 1, 1)
	data.isInvincible = false
	my_timer.stop()

func get_data():
	return data

func hit(amount: int):
	if data.isInvincible == true: return
	data.health -= amount
	print('got hit')
	Hearts.texture = load("res://Assets/UI/Hearts/Hearts-0.png")
	Hearts.set_texture(load("res://Assets/UI/Hearts/Hearts-0.png"))
	if data.health == 0:
		get_tree().reload_current_scene()
		return true
	return false
