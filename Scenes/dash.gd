extends State


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


@onready var shoot: Node = $"../Shoot"
@onready var dash_timer: Timer = $DashTimer


var direction
var canDash = true
const DashSpeed = 600
const WalkSpeed = 300



func Entre():
	canDash = false
	player.velocity.y = 0
	
	if player.is_on_floor():
		Sprite.play("dash")
	else:
		Sprite.play("air_dash")
	
	if Sprite.flip_h:
		direction = -1
	else:
		direction = 1
		
	player.velocity.x = DashSpeed * direction
	
	dash_timer.start()
	
	
func Update(_delta:float):
	if direction == -1:
		Sprite.flip_h = true
	else:
		Sprite.flip_h = false
		
	player.move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		shoot.Shoot()
	
	
func Exit():
	canDash = true


func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_dash_timer_timeout() -> void:
	if player:
		player.velocity.x = 0
		
		if player.is_on_floor():
			Transition("Idle")
		else:
			Transition("Jump")


func _on_hit() -> void:
	Transition("hit")
