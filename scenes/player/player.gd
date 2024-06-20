extends CharacterBody2D

var can_laser = true
signal laser_triggered(pos, direction)
var can_grenade = true
signal grenade_triggered(pos, direction)

@export var max_speed: int = 500
var speed:int = max_speed


func hit(damage:int = 10):
	Globals.health -= damage

func _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	#rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$CPUParticles2D.emitting = true
		can_laser = false
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser_pos = laser_markers[randi() % laser_markers.size()].global_position
		$LaserReloadTimer.start()
		laser_triggered.emit(selected_laser_pos, player_direction)
		
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		can_grenade = false
		Globals.grenade_amount -= 1
		$GeneradeReloadTimer.start()
		var pos = $LaserStartPositions/Marker2D.global_position
		grenade_triggered.emit(pos, player_direction)


func _on_timer_timeout():
	can_laser = true

func _on_timer_2_timeout():
	can_grenade = true

