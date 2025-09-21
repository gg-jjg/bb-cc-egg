extends PhysicsBody2D

@onready var dir : Vector2
var speed = 3

func _ready():
	self.name = "Chick"
	collision_mask = 0
	# Enable collision after n seconds.
	_set_timer_with_arg(0.75, "collide")
	
	# Destroy the chick after n seconds.
	var seconds = randf_range(3.0, 6.0)
	_set_timer_with_arg(seconds, "destroy")

func _physics_process(delta):
	position += dir * speed #move chick in a direction every physics frame. Direction determined by the Ball object when chick is spawned
	var collision = move_and_collide(dir * speed * delta, true)
	
	if collision:
		print(self.name, " collides with : ", collision.get_collider().name)
		if collision.get_collider().name == "Paddle":
			print("Ouch")
			queue_free()
		elif collision.get_collider().name == "Ball":
			print("Score")
			queue_free()

func _set_timer_with_arg(n, arg):
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time=n
	timer.start()
	timer.timeout.connect(func() -> void:
		_on_timer_timeout(arg)
	)

func _on_timer_timeout(arg):
	if arg == "destroy":
		queue_free() #still part of the 2s death
	elif arg == "collide":
		collision_mask = 1
