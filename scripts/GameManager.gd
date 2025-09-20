extends Node2D

var score = 0
@onready var scoreText = $RichTextLabel

func addScore(points):
	score += points #increment score
	print("Score: " + str(score))
	scoreText.text = "Score: " + str(score) #edit the score text to show new score

func _physics_process(delta):
	#reset the game if space is pressed (mostly to help with debugging until proper game over)
	if Input.is_action_just_pressed("space"):
		print("reload")
		get_tree().reload_current_scene()
