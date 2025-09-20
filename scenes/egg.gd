extends StaticBody2D

@onready var gm = $"../GameManager"
var stages = [1,1,1,1,1,1,1]#[5,3,3,2,2,2,1]
var stage = 0
var crackCount = 0

func _ready():
	
	pass
	
func score():
	gm.addScore(1)
	crackCount+=1
	if stage == stages.size():
		return
	if crackCount >= stages[stage]:
		print("Stage: " + str(stage))
		stage +=1
		crackCount=0
		scale -= Vector2(0.14,0.14)
