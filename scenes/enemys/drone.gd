extends CharacterBody2D

func _process(_delta):
	#direction
	var direct = Vector2.RIGHT
	#velocity
	velocity = direct * 100
	#move and slide
	move_and_slide()
