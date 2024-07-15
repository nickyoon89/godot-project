extends CharacterBody2D

var player_nearby: bool = false
var player_nearby_attack_range: bool = false
var can_attack: bool = true
var can_damaged: bool = true

var health: int = 30
var speed: int = 200

func hit(damage:int = 10):
	if can_damaged:
		can_damaged = false
		$Timers/DmgCooldown.start()
		health -= damage
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.5)
		$Particles/HitParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(delta):
	if player_nearby:
		if not $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()
		look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - position).normalized()
		if player_nearby_attack_range:
			$AnimatedSprite2D.animation = "attack"
			if can_attack:
				Globals.health -= 10
				can_attack = false
				$Timers/AttackCooldown.start()
		else: 
			$AnimatedSprite2D.animation = "walk"
			self.global_position += direction * speed * delta
	else:
		if $AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.stop()
	


func _on_attack_area_body_entered(_body):
	player_nearby_attack_range =true


func _on_attack_area_body_exited(_body):
	player_nearby_attack_range = false


func _on_notice_area_body_entered(_body):
	player_nearby = true


func _on_notice_area_body_exited(_body):
	player_nearby = false
	


func _on_dmg_cooldown_timeout():
	can_damaged = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.0)


func _on_attack_cooldown_timeout():
	can_attack = true
