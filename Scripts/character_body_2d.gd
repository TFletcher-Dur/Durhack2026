extends CharacterBody2D


const SPEED = 3000.0
var last_direction: String="down"


func _physics_process(delta: float) -> void:
	if !Globals.in_event:
		# Get the input direction and handle the movement
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction_horizontal:= Input.get_axis("left", "right")
		var direction_vertical:= Input.get_axis("up","down")

		
		if direction_horizontal == -1:
			$AnimatedSprite2D.play("walk_left")
			last_direction = "left"
		elif direction_horizontal == 1:
			$AnimatedSprite2D.play("walk_right")
			last_direction = "right"
		elif direction_vertical == 1:
			$AnimatedSprite2D.play("walk_down")
			last_direction = "down"
		elif direction_vertical == -1:
			$AnimatedSprite2D.play("walk_up")
			last_direction = "up"
		else:
			if last_direction == "up":
				$AnimatedSprite2D.play("idle_up")
			elif last_direction == "down":
				$AnimatedSprite2D.play("idle")
			elif last_direction == "right":
				$AnimatedSprite2D.play("idle_right")
			else:
				$AnimatedSprite2D.play("idle_left")
			
		
		velocity.x = direction_horizontal * SPEED

		velocity.y = direction_vertical * SPEED
		

		move_and_slide()
