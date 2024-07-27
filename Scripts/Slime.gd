extends CharacterBody2D
@onready var shapeCast = $ShapeCast2D

var data = {
	speed = 100,
	damage = 1,
	name = 'slime',
	health = 2
}

var player = null

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if player == null:
		return
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	move_and_collide(vec_to_player * data.speed *  delta)
	
	if shapeCast.is_colliding():
		if !shapeCast.is_colliding(): return
		var collider = shapeCast.get_collider(0)
		if collider == null || !collider.data.has('name'): return
		
		if collider.get_data().name == "player" and collider.has_method("hit"):
			var skipMakeInvincible = collider.hit(data.damage)
			if skipMakeInvincible: return
			collider.make_invincible()

func get_data():
	return data

func hit(amount: int):
	data.health -= amount
	if data.health == 0: queue_free()

func set_player(p):
	player = p
