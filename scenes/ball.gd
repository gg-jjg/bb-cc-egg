extends PhysicsBody2D

var speed = 5
var dir : Vector2 = Vector2(1.0, 0.0)

func _physics_process(delta):
	var collision = move_and_collide(dir*speed)
	if collision:
		if collision.get_collider().name == "Egg":
			collision.get_collider().score()
		dir = dir.bounce(collision.get_normal())
		#dir = collision.get_normal()+dir/2
	
func _bounce(dir):
	move_and_collide(dir*speed)
	pass
