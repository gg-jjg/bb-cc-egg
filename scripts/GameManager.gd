extends Node2D

var score = 0
var max_health = 10
var curr_health = 10
@onready var scoreText = $HBoxContainer/Score
@onready var healthText = $HBoxContainer/Health
@onready var stageText = $HBoxContainer/Stage
@onready var crackText = $HBoxContainer/Crack

func addScore(points):
	score += points #increment score
	#print("Score: " + str(score))
	scoreText.text = "[color=black]Score: " + str(score) #edit the score text to show new score

func addHealth(val):
	if curr_health + val > max_health:
		curr_health = max_health
	else:
		curr_health += val
	healthText.text = "[color=black]Health: " + str(curr_health) + " / " + str(max_health)

func subHealth(val):
	if curr_health - val <= 0:
		healthText.text = "[color=black]Health: " + str(curr_health) + " / " + str(max_health)
		print("Game Over")
	else:
		curr_health -= val
		healthText.text = "[color=black]Health: " + str(curr_health) + " / " + str(max_health)
		

func _physics_process(delta):
	#reset the game if space is pressed (mostly to help with debugging until proper game over)
	if Input.is_action_just_pressed("space"):
		print("reload")
		get_tree().reload_current_scene()

func _update_stage_text(count):
	stageText.text = "[color=black]Stage: " + str(count)

func _update_crack_text(count):
	crackText.text = "[color=black]Cracks: " + str(count)
