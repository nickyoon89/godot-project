extends Node


signal laser_change
signal grenade_change
signal health_change

var laser_amount = 20:
	set(value):
		laser_amount = value
		laser_change.emit()
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		grenade_change.emit()
var played_vulnerable: bool = true
var health = 60: 
	get:
		return health
	set(value):
		if played_vulnerable:
			health = value
			played_vulnerable = false
			played_invulnerable_timer()
		else:
			if value > health:
				health = min(value, 100)
		health_change.emit()

func played_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	played_vulnerable = true

var player_pos: Vector2
