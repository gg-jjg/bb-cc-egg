extends CharacterBody2D

const SPEED = 30.0
const PIVOT_POINT = Vector2(304, 304)
const RADIUS = 240

func _calculate_pivot_radians():
	var offset = position - PIVOT_POINT
	return atan2(offset.y, offset.x)

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	var current_angle = _calculate_pivot_radians()
	var rotation_speed = deg_to_rad(180)
	
	if direction!= 0:
		current_angle += direction * rotation_speed * delta
	
	position = PIVOT_POINT + Vector2(cos(current_angle), sin(current_angle)) * RADIUS
	
	look_at(PIVOT_POINT)
	move_and_slide()
