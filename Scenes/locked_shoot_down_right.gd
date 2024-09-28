extends State


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D
@export var Bullet : PackedScene

@export var ShootSpeed = 10.0

@onready var shoot_speed_timer: Timer = $"../../Player/ShootSpeedTimer"
@onready var down_right_marker: Marker2D = $"../../Player/DownRightMarker"



var can_shoot = true
var bullet_direction = Vector2(1,0)
var bullet_count = 0

var direction


func Entre():
	Sprite.flip_h = false
	Sprite.play("shoot_down_right")
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	direction = 1
	
	
func Update(_delta:float):
	if Input.is_action_pressed("lock"):
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_down"):
			Transition("lockhandler")
			
		if Input.is_action_just_released("move_right"):
			Transition("lockhandler")
	else:
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_down"):
			Transition("shoot")
			
		if Input.is_action_just_released("move_right"):
			Transition("shootdown")
			
	if Input.is_action_just_released("lock"):
		Transition("shoot")

	ShootDownRight()
	
	
func Exit():
	pass


func ShootDownRight():
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	if can_shoot:
		can_shoot = false
		bullet_count += 1
		shoot_speed_timer.start()
		
		var bullet_node = Bullet.instantiate()
		
		bullet_node.set_direction(bullet_direction)
		
		get_tree().root.add_child(bullet_node)
			
		bullet_node.direction = Vector2(1, 1)
		
		bullet_node.global_rotation = down_right_marker.global_rotation
		bullet_node.global_position = down_right_marker.global_position



func _on_shoot_speed_timer_timeout() -> void:
	can_shoot = true
	
	
func setup_direction(direction):
	bullet_direction = direction


func Transition(newstate : String):
	state_transition.emit(self, newstate)
	

func _on_hit() -> void:
	Transition("hit")
