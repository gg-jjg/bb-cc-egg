extends PhysicsBody2D

var speed = 100 #initial speed of the ball
var speedMod = 5 #speed modifier, used for logarithmic speed increase
var dir : Vector2 = Vector2(1.0, randf_range(-0.3, 0.3)) #set initial direction, rand y


func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta) #move in a direction, doing physics collision calculations.
	rotation_degrees += 90 * delta # Rotates the ball
	
	if collision and collision.get_collider().name != "Chick": # Bounce off a non-Chick
		dir = dir.bounce(collision.get_normal())
		var pos = collision.get_position()
		
		if collision.get_collider().name == "Egg": # Handle ball collides with Egg
			collision.get_collider().pop_egg(pos, dir)
			
			speed +=speedMod #speed up the ball every time it hits the egg
			speedMod*=0.83 #my relatively bad attempt at logarithmic speed up. Settles out at around 3-4 speed
			#print("Speed: "+ str(speed))
			
			
		elif collision.get_collider().name == "Paddle": # Disable collision with paddle to handle janky behavior
			disable_collision_with_paddle()
	elif collision:
		pass

func disable_collision_with_paddle():
	# Disable collision with layer 1
	collision_mask = 0
	await get_tree().create_timer(0.5).timeout
	# Re-enable collision
	collision_mask = 1
