extends State
class_name PlayerJump

signal isJumping

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D

@onready var shoot: Node = $"../Shoot"
@onready var loop: AudioStreamPlayer2D = $"../../BulletSounds/Loop"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


const SPEED = 300.0
const JUMP_VELOCITY = -1500.0


func Entre():
	Sprite.play("jump")
	if Input.is_action_just_pressed("move_up") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY
		
	isJumping.emit()
		
	
func Update(_delta:float):
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta * 5
		
	var direction
	if Input.is_action_pressed("move_right"):
		direction = 1
	if Input.is_action_pressed("move_left"):
		direction = -1
	
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		Sprite.flip_h = false
		
	player.move_and_slide()
	if Input.is_action_pressed("shoot"):
		shoot.Shoot()

	#print(player.velocity)
	
	if player.is_on_floor and not player.velocity.y:
		if player.velocity == Vector2.ZERO:
			Transition("Idle")
		else:
			Transition("Walk")
			
	if Input.is_action_just_pressed("dash"):
		Transition("Dash")
	
func Exit():
	pass

func Transition(newstate : String):
	state_transition.emit(self, newstate)
