extends State
class_name PlayerWalk


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


func Entre():
	Sprite.play("walk")
	
	
func Update(_delta:float):
	if Input.is_action_just_pressed("move_up") and player.is_on_floor():
		#move to jump state
		Transition("Jump")
		
	if Input.is_action_pressed("shoot") and not Input.is_action_pressed("look_up") and player.is_on_floor():
		Transition("shoot")
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right") and player.is_on_floor():
		Transition("shootupright")
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_right") and player.is_on_floor():
		Transition("shootdownright")
		
	if Input.is_action_pressed("shoot") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_left") and player.is_on_floor():
		Transition("shootupleft")
		
	if Input.is_action_pressed("lock") and player.is_on_floor():
		Transition("lockhandler")
		
	if Input.is_action_just_pressed("dash"):
		Transition("Dash")
	
	if not player.is_on_floor():
		player.velocity.y += gravity * _delta
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		Sprite.flip_h = false

	player.move_and_slide()
	
	if not direction:
		Transition("Idle")
	
func Exit():
	pass
	
	
func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
