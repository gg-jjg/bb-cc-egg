extends StaticBody2D

@onready var gm = $"../GameManager"

func _ready():
	
	pass
	
func score():
	gm.addScore(1)
