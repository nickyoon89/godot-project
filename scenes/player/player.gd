extends CharacterBody2D

var can_laser = true
signal laser_triggered(pos, direction)
var can_grenade = true
signal grenade_triggered(pos, direction)

func _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser:
		$CPUParticles2D.emitting = true
		can_laser = false
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser_pos = laser_markers[randi() % laser_markers.size()].global_position
		
		$LaserReloadTimer.start()
		laser_triggered.emit(selected_laser_pos, player_direction)
		
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GeneradeReloadTimer.start()
		var pos = $LaserStartPositions/Marker2D.global_position
		grenade_triggered.emit(pos, player_direction)
		
		



func _on_timer_timeout():
	can_laser = true



func _on_timer_2_timeout():
	can_grenade = true
