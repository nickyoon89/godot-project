extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		open.emit($SpawnPositions/Marker2D.global_position, current_direction)
		opened = true
