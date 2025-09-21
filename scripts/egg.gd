extends StaticBody2D

@onready var gm = $"../GameManager" #get reference to the game manager
var stages = [5,3,3,2,2,2,1] #[1,1,1,1,1,1,1]#set up stages, each determines how many hits before going to the next. 
var stage = 0 #stage (index of stages)
var crackCount = 0 
var chick = preload("res://scenes/chick.tscn")

# Array that holds all colors of egg sprites
var egg_sprites = [
	("res://assets/sprites/eggs/Black.png"),
	("res://assets/sprites/eggs/Blue.png"),
	("res://assets/sprites/eggs/Cyan.png"),
	("res://assets/sprites/eggs/Green.png"),
	("res://assets/sprites/eggs/Orange.png"),
	("res://assets/sprites/eggs/Purple.png"),
	("res://assets/sprites/eggs/Red.png"),
	("res://assets/sprites/eggs/White.png"),
	("res://assets/sprites/eggs/Yellow.png")
]

# Set egg texture to a random egg color.
func rnd_egg_color():
	var rnd_i = randi() % egg_sprites.size() 
	$Egg_Sprite.texture = load(egg_sprites[rnd_i])

func _ready():
	rnd_egg_color()

#slowly grow if egg is less than full size
#func _physics_process(delta):
	#if scale < Vector2.ONE:
		#scale += Vector2(0.0002,0.0002)
		
func pop_egg(pos, dir):
	
	gm.addScore(10 * (stage + 1)) #increment score for game manager
	
	if stage == stages.size(): #avoid getting an index out of range
		return
	
	crackCount+=1
	if crackCount >= stages[stage]: #if we've hit the egg enough, move on the the next stage.
		#print("Stage: " + str(stage))
		stage +=1 #go to the next stage(index of stages)
		crackCount=0 #reset the hit count
		scale -= Vector2(0.14,0.14) #shrink the egg
		rnd_egg_color() # Change color
	
	
	var num_chicks = 3 * (stage + 1) # Spawn the chick particles - progressively more particles spawn as eggs pop
	for i in num_chicks: #this is all used to spawn the 'chick' particles off of where the ball hits.
		i+=1
		var cspawn = chick.instantiate()
		cspawn.name = "Chick" # For purposes of detecting collision
		var rng = RandomNumberGenerator.new()
		
		# Basically, take the ball's bounce vector and randomize it so they all head in the same general direction but don't just follow the ball's path. Explosion!
		cspawn.dir = Vector2(rng.randf_range(0.05*sign(dir.x), 0.30*sign(dir.x)),rng.randf_range(0.05*sign(dir.y), 0.30*sign(dir.y)))
		
		cspawn.global_position = pos
		get_tree().current_scene.add_child(cspawn)
