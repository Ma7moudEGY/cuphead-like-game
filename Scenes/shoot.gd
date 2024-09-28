extends State

signal shootup

const SPEED = 300.0

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D
@export var Bullet : PackedScene

@export var ShootSpeed = 10.0

@onready var shoot_speed_timer: Timer = $"../../Player/ShootSpeedTimer"

@onready var right_marker: Marker2D = $"../../Player/RightMarker"
@onready var left_marker: Marker2D = $"../../Player/LeftMarker"
@onready var up_right_marker: Marker2D = $"../../Player/UpRightMarker"
@onready var right_up_marker: Marker2D = $"../../Player/RightUpMarker"
@onready var left_up_marker: Marker2D = $"../../Player/LeftUpMarker"
@onready var up_left_marker: Marker2D = $"../../Player/UpLeftMarker"
@onready var down_left_marker: Marker2D = $"../../Player/DownLeftMarker"
@onready var left_down_marker: Marker2D = $"../../Player/LeftDownMarker"
@onready var right_down_marker: Marker2D = $"../../Player/RightDownMarker"
@onready var down_right_marker: Marker2D = $"../../Player/DownRightMarker"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var can_shoot = true
var bullet_direction = Vector2(1,0)
var bullet_count = 0
const JUMP_VELOCITY = -1200.0

var new_state : String


func Entre():
	if not player.velocity:
		Sprite.play("shoot")
	elif player.velocity.x and not player.velocity.y and player.is_on_floor():
		Sprite.play("walk_shoot")

		
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	

func Update(_delta:float):
	if Input.is_action_just_released("shoot") and player.is_on_floor():
		if player.velocity.x:
			Transition("walk")
		else:
			Transition("idle")
			
	if Input.is_action_just_released("shoot") and not player.is_on_floor():
		Transition("Jump")
		
	if Input.is_action_pressed("lock") and player.is_on_floor():
		Transition("lockhandler")
		
	if Input.is_action_pressed("look_up"):
		Transition("idle")
		
	if Input.is_action_pressed("look_down"):
		Transition("idle")
		
	if Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right"):
		Transition("idle")
		
		
	#if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_up"):
#		Transition("shootup")
		
#	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_down"):
#		Transition("shootdown")
		
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta * 3
		Sprite.play("jump")
		
			
	var direction
	if Input.is_action_pressed("move_right"):
		direction = 1
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_left"):
		direction = 0
	
	if direction:
		player.velocity.x = direction * SPEED
		Sprite.play("walk_shoot")	
	else:
		player.velocity.x = 0
		Sprite.play("shoot")
		
	if Input.is_action_pressed("move_left"):
		Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		Sprite.flip_h = false
		
		
	if Input.is_action_just_pressed("move_up") and player.is_on_floor():
		Transition("Jump")
		
	if Input.is_action_just_pressed("dash"):
		Transition("Dash")
		#new_state = "Jump"	
	player.move_and_slide()
	Shoot()
	
	
func Exit():
	Sprite.stop()
	
	
func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
	
func Shoot():
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	if can_shoot:
		can_shoot = false
		bullet_count += 1
		shoot_speed_timer.start()
		
		var bullet_node = Bullet.instantiate()
		if Sprite.flip_h:
			bullet_node.get_child(0).flip_h = true
		else:
			bullet_node.get_child(0).flip_h = false
		
		bullet_node.set_direction(bullet_direction)
		
		get_tree().root.add_child(bullet_node)
			
		if Sprite.flip_h:
			bullet_node.global_position = left_marker.global_position
			bullet_node.speed *= -1
			
		else:
			bullet_node.global_position = right_marker.global_position
			bullet_node.global_rotation = right_marker.global_rotation
			bullet_node.speed = abs(bullet_node.speed)
			
		if bullet_count % 2 == 0:
			bullet_node.global_position.y -= 25


func _on_shoot_speed_timer_timeout() -> void:
	can_shoot = true
	
	
func setup_direction(direction):
	bullet_direction = direction
	
