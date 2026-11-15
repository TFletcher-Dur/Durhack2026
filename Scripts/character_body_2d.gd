extends CharacterBody2D


const SPEED = 3000.0



func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_horizontal:= Input.get_axis("left", "right")
	var direction_vertical:= Input.get_axis("up","down")
	if direction_horizontal == -1:
		$AnimatedSprite2D.play("walk_left")
	elif direction_horizontal == 1:
		$AnimatedSprite2D.play("walk_right")
	elif direction_vertical == 1:
		$AnimatedSprite2D.play("walk_down")
	elif direction_vertical == -1:
		$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.play("idle")
		
	
	velocity.x = direction_horizontal * SPEED

	velocity.y = direction_vertical * SPEED
	

	move_and_slide()
