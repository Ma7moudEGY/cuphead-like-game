extends State

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


func Entre():
	Sprite.play("lock_down")
	
	
func Update(_delta:float):
	if Input.is_action_just_released("lock"):
		Transition("idle")
	
	if Input.is_action_just_released("look_down"):
		Transition("lockhandler")
	
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_right"):
		Transition("lockdownright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_left"):
		Transition("lockdownleft")
		
	if Input.is_action_pressed("shoot"):
		Transition("lockedshootdown")
	
func Exit():
	pass

func Transition(newstate : String):
	state_transition.emit(self, newstate)
