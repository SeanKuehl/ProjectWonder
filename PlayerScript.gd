extends KinematicBody2D

#export (PackedScene) var Bullet
#var Bullet = preload("res://Bullet.tscn").instance()

var speed = 400  # speed in pixels/sec

var velocity = Vector2.ZERO

#body.is_in_group("Player")


func shoot():
	
	
	var b = preload("res://PlayerBullet.tscn").instance() 	#make a new kind of bullet for enemy
	
	
	
	owner.add_child(b)	#this adds the bullet as a child of the node that owns player, in this case the root node
	
	#i've looked up lots of fixes but none of them seem to work!
	b.transform = $PlayerMuzzle.global_transform	#this will spawn the bullet at the point Muzzle found on the player



func ShowMe():
	print("hey there")

func get_input():
	#if is_in_group("Player"):
	#	pass
	#else:
	#	add_to_group("Player")
	
	#enemy will decide where to move at random
	velocity = Vector2.ZERO
	if Input.is_action_pressed('RIGHT'):
		velocity.x += 1
	if Input.is_action_pressed('LEFT'):
		velocity.x -= 1
	if Input.is_action_pressed('DOWN'):
		velocity.y += 1
	if Input.is_action_pressed('UP'):
		velocity.y -= 1
	if Input.is_action_just_pressed("SHOOT"):
		shoot()
	# Make sure diagonal movement isn't faster

	velocity = velocity.normalized() * speed
	

func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)
