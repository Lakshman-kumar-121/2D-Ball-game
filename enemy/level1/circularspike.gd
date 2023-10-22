extends Node2D


export var left = 0
export var right = 0


var moveleft = true
func _process(delta):
	if position.x < left:
		moveleft = false
	if position.x > right :
		moveleft = true
	if moveleft:
		position.x -= delta * 300
		$".".rotation_degrees += delta * 150
	else:
		position.x += delta * 300
		$".".rotation_degrees -= delta * 150


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()
