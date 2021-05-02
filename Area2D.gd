extends Area2D
#this is the playe bullet's code
var speed = 750

onready var player = get_node('../Player')


func _ready():
	connect("body_entered", self, "_on_EnemyBullet_body_entered")

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_EnemyBullet_body_entered(body):
	if body.is_in_group("player"):
		#if I wanted to do lives, I would get a reference to the player:
		#onready var player = get_node('../Player')
		#and then call one of it's functions: player.hurt()
		#and then if dead call change scene from there
		#player.ShowMe()	#this code works for example, because of the reference to the player above
		get_tree().change_scene("res://GameOverMenu.tscn")
		body.queue_free()
	queue_free()
