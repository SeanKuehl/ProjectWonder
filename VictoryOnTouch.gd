extends Area2D






func _ready():
	connect("body_entered", self, "_on_body_entered")




func _on_body_entered(body):
	if body.is_in_group("player"):
		#if I wanted to do lives, I would get a reference to the player:
		#onready var player = get_node('../Player')
		#and then call one of it's functions: player.hurt()
		#and then if dead call change scene from there
		#player.ShowMe()	#this code works for example, because of the reference to the player above
		get_tree().change_scene("res://VictoryScreen.tscn")
		body.queue_free()
	
