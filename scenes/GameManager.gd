extends Node2D

var score = 0
@onready var scoreText = $RichTextLabel

func addScore(points):
	score += points
	print(score)
	scoreText.text = str(score)

func _physics_process(delta):
	if Input.is_action_just_pressed("space"):
		print("reload")
		get_tree().reload_current_scene()
