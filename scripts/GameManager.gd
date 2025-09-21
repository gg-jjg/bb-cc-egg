extends Node2D

var score = 0
var max_health = 10
var curr_health = 10
@onready var scoreText = $Score

func addScore(points):
	score += points #increment score
	#print("Score: " + str(score))
	scoreText.text = "[color=black]Score: " + str(score) #edit the score text to show new score

func addHealth(val):
	if curr_health + val > max_health:
		curr_health = max_health
	else:
		curr_health += val

func subHealth(val):
	if curr_health - val <= 0:
		print("Game Over")
	else:
		curr_health -= val

func _physics_process(delta):
	#reset the game if space is pressed (mostly to help with debugging until proper game over)
	if Input.is_action_just_pressed("space"):
		print("reload")
		get_tree().reload_current_scene()
