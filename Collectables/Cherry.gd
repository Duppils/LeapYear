extends Area2D

var eaten = false

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE


func _on_body_entered(body):
	if body.name == "Player":
		if not eaten:
			Game.player_hp += 1
			eaten = true
			
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,25), 0.3)
		tween.tween_property(self, "modulate:a", 0, 0.3)
		$AudioStreamPlayer2D.play()
		tween.tween_callback(queue_free)
