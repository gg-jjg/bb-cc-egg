extends PhysicsBody2D

var speed = 100 #initial speed of the ball
var speedMod = 5 #speed modifier, used for logarithmic speed increase
var dir : Vector2 = Vector2(1.0, 0.0) #set initial direction, otherwise the ball will just sit there when you press play

var chick = preload("res://scenes/chick.tscn")

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta) #move in a direction, doing physics collision calculations.
	rotation_degrees += 90 * delta # Rotates the ball
	
	if collision: #if we hit something (egg or paddle right now)
		dir = dir.bounce(collision.get_normal()) #bounce off the object
		
		if collision.get_collider().name == "Egg": #if we hit the egg, trigger the egg's score function
			collision.get_collider().score()
			
			speed +=speedMod #speed up the ball every time it hits the egg
			speedMod*=0.83 #my relatively bad attempt at logarithmic speed up. Settles out at around 3-4 speed
			print("Speed: "+ str(speed))
			
			for i in 5: #this is all used to spawn the 'chick' particles off of where the ball hits.
				i+=1
				var cspawn = chick.instantiate()
				var rng = RandomNumberGenerator.new()
				
				#messy code. Basically, take the ball's bounce vector and randomize it so they all head in the same general direction but don't just follow the ball's path. Explosion!
				cspawn.dir = Vector2(rng.randf_range(0.2*sign(dir.x),sign(dir.x)),rng.randf_range(0.2*sign(dir.y),sign(dir.y)))
				
				cspawn.global_position = collision.get_position()
				get_tree().current_scene.add_child(cspawn)
		elif collision.get_collider().name == "paddle":
			disable_collision_with_paddle()

func disable_collision_with_paddle():
	# Disable collision with layer 1
	collision_layer = 0
	collision_mask = 0
	await get_tree().create_timer(0.5).timeout
	# Re-enable collision
	collision_layer = 1
	collision_mask = 1
