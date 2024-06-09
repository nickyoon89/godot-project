extends Node2D


var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func test_function():
	print("this is a test function")


func _on_gate_player_entered_gate(_body):
		var tween = create_tween()
		tween.tween_property($Player, "speed", 0, 0.5)


func _on_player_laser_triggered(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_grenade_triggered(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true) #if there are more than one animation, and you want to play all the same time
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)
	#you can also use .from after this to set the start value
	


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
