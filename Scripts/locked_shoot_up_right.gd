extends State


@onready var shoot_up_right: Node = $"../ShootUpRight"

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D
@export var Bullet : PackedScene

@export var ShootSpeed = 10.0

@onready var shoot_speed_timer: Timer = $"../../Player/ShootSpeedTimer"
@onready var up_right_marker: Marker2D = $"../../Player/UpRightMarker"



var can_shoot = true
var bullet_direction = Vector2(1,0)
var bullet_count = 0

var direction

@onready var shoot: Node = $"../Shoot"


func Entre():
	Sprite.flip_h = false
	Sprite.play("shoot_up_right")
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	direction = 1
	
	
func Update(_delta:float):
	if Input.is_action_pressed("lock"):
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_up"):
			Transition("lockhandler")
			
		if Input.is_action_just_released("move_right"):
			Transition("lockhandler")
	else:
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_up"):
			Transition("shoot")
			
		if Input.is_action_just_released("move_right"):
			Transition("shootup")
			
	if Input.is_action_just_released("lock"):
		Transition("shootupright")

	
	shoot_up_right.ShootUpRight()
	
func Exit():
	pass



func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_hit() -> void:
	Transition("hit")
