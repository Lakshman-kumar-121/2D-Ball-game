extends Node2D
onready var ap = $AnimationPlayer


func _process(delta):
	ap.play("star_anim") 


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.collectedstar()
		self.queue_free()
