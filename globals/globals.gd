extends Node

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
var played_vulnerable: bool = true
var health = 60: 
	get:
		return health
	set(value):
		if played_vulnerable:
			health = value
			played_vulnerable = false
			played_invulnerable_timer()
			player_hit_sound.play()
		else:
			if value > health:
				health = min(value, 100)
		stat_change.emit()

func played_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	played_vulnerable = true

var player_pos: Vector2

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
