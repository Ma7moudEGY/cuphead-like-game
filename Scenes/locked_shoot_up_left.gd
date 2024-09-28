extends State

@onready var shoot_up_left: Node = $"../ShootUpLeft"


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D
@export var Bullet : PackedScene

@export var ShootSpeed = 10.0

@onready var shoot_speed_timer: Timer = $"../../Player/ShootSpeedTimer"
@onready var up_left_marker: Marker2D = $"../../Player/UpLeftMarker"




var can_shoot = true
var bullet_direction = Vector2(1,0)
var bullet_count = 0

var direction


func Entre():
	Sprite.flip_h = true
	Sprite.play("shoot_up_right")
	shoot_speed_timer.wait_time = 1 / ShootSpeed
	direction = 1
	
	
func Update(_delta:float):
	if Input.is_action_pressed("lock"):
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_up"):
			Transition("lockhandler")
			
		if Input.is_action_just_released("move_left"):
			Transition("lockhandler")
	else:
		if Input.is_action_just_released("shoot"):
			Transition("idle")
			
		if Input.is_action_just_released("look_up"):
			Transition("shoot")
			
		if Input.is_action_just_released("move_left"):
			Transition("shootup")
			
	if Input.is_action_just_released("lock"):
		Transition("shootupleft")

	shoot_up_left.ShootUpLeft()
	
	
func Exit():
	pass



func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_shoot_speed_timer_timeout() -> void:
	pass # Replace with function body.


func _on_hit() -> void:
	Transition("hit")
