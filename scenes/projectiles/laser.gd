extends Area2D

@export var speed: int = 1000
var direction: Vector2

func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body):
	if "hit" in body: #body.has_method('hit') but this only check method
		body.hit()
	queue_free()


func _ready():
	$SelfDestructTimer.start()
	$AudioStreamPlayer2D.play()


func _on_self_destruct_timer_timeout():
	queue_free()
