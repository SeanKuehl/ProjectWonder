extends KinematicBody2D

#get_tree().change_scene("res://Scenes/Main.tscn")
#get_tree().quit()
#signal removed

var speed = 50
var chaseSpeed = 200
var velocity = Vector2()

var shootTimer = 0

var playerDetected = false

var minimap_icon = "mob"

onready var player = get_node('../Player') #this is based on what the player is called in the scene tree, not it's actual scene
var distanceToPlayer = 0
	
func shoot():
	
	
	var b = preload("res://BasicEnemyBullet.tscn").instance() 	#make a new kind of bullet for enemy
	
	
	
	owner.add_child(b)	#this adds the bullet as a child of the node that owns player, in this case the root node
	
	#i've looked up lots of fixes but none of them seem to work!
	b.transform = $EnemyMuzzle.global_transform	#this will spawn the bullet at the point Muzzle found on the player

	
func _ready():
	rotation = rand_range(0, 2*PI)
	

func DistanceToPlayer(positionA, positionB):
	#position A is the player(x2) while position B is this(x1)
	#root of: (x2 - x1)^2 + (y2-y1)^2
	var xPart = pow((positionA.x - positionB.x),2.0)
	var yPart = pow((positionA.y - positionB.y),2.0)
	var total = abs((pow((xPart + yPart),0.5)) - 84)	#this is because the positions don't account for sprite size, I want the smallest distance to be 0 or close just for ease
	#note: this results in sometimes having a negative distance if too close, hence the abs, but the negative distances are still small and accurate enough
	return total

func _physics_process(delta):
	velocity = transform.x * speed	#this is fine unless it spots the player
	distanceToPlayer = DistanceToPlayer(player.position, position)
	#print(distanceToPlayer)
	#replace with upon detection
	#basic AI idea: walk around aimlessly until player detected, then walk toward them and fire
	
	if distanceToPlayer <= 200:
		playerDetected = true
	else:
		playerDetected = false
	
	
	#make function that does below:(remember what an exponent really is for ^1/2)
	
	if playerDetected:
		#go towards the player
		look_at(player.position)
		velocity = transform.x * chaseSpeed	#change velocity to use chase speed
		shootTimer += 1
	
		if shootTimer > 100:
			shoot()
			shootTimer = 0
		var collision = move_and_collide(velocity * delta)
		
	else:
		#walk around aimlessly
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.normal).rotated(rand_range(-PI/4, PI/4))
		rotation = velocity.angle()
		
	
	
