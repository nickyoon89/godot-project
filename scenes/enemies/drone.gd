extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true
var health: int = 50
var speed: int = 0
var max_speed: int = 400

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explosion")
			
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 0.5)
	if health <= 0:
		speed = 0
		$AnimationPlayer.play("Explosion")


func _on_notice_area_body_entered(_body):
	active = true
	var speedTween = create_tween()
	speedTween.tween_property(self, 'speed', max_speed, 6)


func _on_hit_timer_timeout():
	$Sprite2D.material.set_shader_parameter("progress", 0)
	vulnerable = true
