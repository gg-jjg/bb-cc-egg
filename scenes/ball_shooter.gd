extends Node2D

@onready var ball = preload("res://ball.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("space"):
		var b2 = ball.instantiate()
		get_tree().current_scene.add_child(b2)
		b2.global_position = global_position
	if Input.is_action_pressed("up"):
		position.y -= 5
	if Input.is_action_pressed("down"):
		position.y += 5
