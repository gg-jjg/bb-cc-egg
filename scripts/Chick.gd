extends Node2D

@onready var dir : Vector2
var speed = 3

func _ready():
	#all this does is delete the 'chick' after 2 seconds so it doesn't take up memory off-screen
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time=2.0
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta):
	position += dir * speed #move chick in a direction every physics frame. Direction determined by the Ball object when chick is spawned

func _on_timer_timeout():
	queue_free() #still part of the 2s death
