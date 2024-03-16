extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	print("water entered: ", body.name)
	if body.name.begins_with("Frog"):
		body.swimming = true
	elif body.name == "Player":
		body.die()
