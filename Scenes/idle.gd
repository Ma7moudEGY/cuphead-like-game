extends State
class_name PlayerIdle


@export var player : CharacterBody2D
@export var Sprite : AnimatedSprite2D

@onready var loop: AudioStreamPlayer2D = $"../../BulletSounds/Loop"
@onready var dash: Node = $"../Dash"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func Entre():
	if player.is_on_floor():
		Sprite.play("idle")
	else:
		Sprite.play("jump")
	
	
func Update(_delta:float):
	if loop.is_playing():
		loop.stop
		
	if player.is_on_floor():
		Sprite.play("idle")
	
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta * 5
		player.move_and_slide()
		
	
	if Input.get_axis("move_left", "move_right") and player.is_on_floor():
		Transition("walk")
		
	if Input.is_action_just_pressed("move_up") and player.is_on_floor():
		Transition("jump")
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_up") and player.is_on_floor():
		Transition("shootup")	
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right") and player.is_on_floor():
		Transition("shootupright")
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_down") and player.is_on_floor():
		Transition("shootdown")
		
	if Input.is_action_pressed("shoot") and not Input.is_action_pressed("look_up") and player.is_on_floor():
		Transition("shoot")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right") and Input.is_action_pressed("shoot"):
		Transition("lockupright")
		
	if Input.is_action_pressed("lock") and player.is_on_floor():
		Transition("lockhandler")
		
	if Input.is_action_just_pressed("dash"):
		Transition("Dash")
	
func Exit():
	pass
	
	
func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
