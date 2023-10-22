extends KinematicBody2D

const UP_DIRECTION = Vector2.UP
var speed = Vector2(600 , 1500)
var jump = 2
const gravity = 3500
var _veloctiy = Vector2.ZERO
var can_jump = true
onready var level = $"../"
onready var raycast = $RayCast2D
onready var sprite = $Sprite

var poisoned = false
var stoned = false

var rotating_speed = 8

func _physics_process(delta):
	poisoned(delta)
	stoned(delta)
		
	if raycast.is_colliding():
		can_jump = true
	else:
		can_jump = false
	var is_jump_int = Input.is_action_just_released("jump") and _veloctiy.y < 0
	var direction = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),
	-1.0 if (Input.is_action_just_pressed("jump") and can_jump)  else 2.0
	 )
	if Input.is_action_pressed("right"):
		sprite.rotation_degrees += rotating_speed
	elif Input.is_action_pressed("left"):
		sprite.rotation_degrees -= rotating_speed
	_veloctiy = calculate_move_velocity(_veloctiy , direction , speed , is_jump_int)
	_veloctiy = move_and_slide(_veloctiy , UP_DIRECTION)
	



func poisoned(delta):
	if poisoned:
		$MeshInstance2D.modulate = lerp($MeshInstance2D.modulate , Color(0.007843, 0.831373, 0) ,0.2 * delta)
		yield(get_tree().create_timer(6) ,"timeout")
		queue_free()

func stoned(delta):
	if stoned:
		rotating_speed = lerp(rotating_speed , 0 , delta * 0.2)
		jump = lerp(jump , 0 , 0.2 * delta )
		speed = lerp(speed , Vector2(0 , 0) , delta * 0.2)
		$MeshInstance2D.modulate = lerp($MeshInstance2D.modulate , Color(0.215686, 0.215686, 0.215686) ,0.2 * delta)
		yield(get_tree().create_timer(15) ,"timeout")
		queue_free()
	
func calculate_move_velocity(
	linear_velocity : Vector2,
	direction : Vector2,
	speed : Vector2,
	is_jump_int :bool
):
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1:
		new_velocity.y = speed.y * direction.y
	if is_jump_int:
		new_velocity.y = 0
	return new_velocity
	
func collectedstar():
	level.star += 1
	
	
