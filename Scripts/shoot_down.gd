extends State


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D
@export var Bullet : PackedScene

@export var ShootSpeed = 10.0

@onready var shoot_speed_timer: Timer = $"../../Player/ShootSpeedTimer"
@onready var left_down_marker: Marker2D = $"../../Player/LeftDownMarker"
@onready var right_down_marker: Marker2D = $"../../Player/RightDownMarker"



var can_shoot = true
var bullet_direction = Vector2(1,0)
var bullet_count = 0

@onready var shoot: Node = $"../Shoot"


func Entre():
	Sprite.play("shoot_down")
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	
	
func Update(_delta:float):
	if Input.is_action_just_released("shoot"):
		Transition("idle")
		
	if Input.is_action_just_released("look_down"):
		Transition("shoot")
		
	if Input.is_action_pressed("move_right"):
		Transition("shoot")
		
	if Input.is_action_pressed("move_left"):
		Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		Sprite.flip_h = false
	
	ShootDown()
	
func Exit():
	pass
	
	

func ShootDown():
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	if can_shoot:
		can_shoot = false
		bullet_count += 1
		shoot_speed_timer.start()
		
		var bullet_node = Bullet.instantiate()
		
		bullet_node.set_direction(bullet_direction)
		
		get_tree().root.add_child(bullet_node)
			
		bullet_node.direction = Vector2(0, 1)
		bullet_node.global_rotation = right_down_marker.global_rotation
		
		if Sprite.flip_h:
			bullet_node.global_position = left_down_marker.global_position

		else:
			bullet_node.global_position = right_down_marker.global_position
			
		if bullet_count % 2 == 0:
			bullet_node.global_position.x -= 25


func _on_shoot_speed_timer_timeout() -> void:
	can_shoot = true
	
	
func setup_direction(direction):
	bullet_direction = direction


func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_hit() -> void:
	Transition("hit")