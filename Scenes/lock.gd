extends State

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


#TO-DO
#get into LockHandler
#choose the right locking state
#transition to it
#once done return to the LockHandler


func Entre():
	Sprite.play("lock_right")
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up"):
		Transition("lockup")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down"):
		Transition("lockdown")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("move_right"):
		Transition("lockright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("move_left"):
		Transition("lockleft")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right"):
		Transition("lockupright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_left"):
		Transition("lockupleft")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_right"):
		Transition("lockdownright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_left"):
		Transition("lockdownleft")
		
	
	
func Update(_delta:float):
	if (Input.is_action_just_released("lock") or not Input.is_action_pressed("lock")) and player.is_on_floor():
		if player.velocity.x:
			Transition("walk")
		elif Input.is_action_just_pressed("move_up") and player.is_on_floor():
			Transition("Jump")
		else:
			Transition("idle")
			
	if Input.is_action_pressed("shoot") and Sprite.flip_h:
		Transition("lockedshootleft")
	
	if Input.is_action_pressed("shoot") and not Sprite.flip_h:
		Transition("lockedshootright")
		
	if Input.is_action_pressed("look_up") and Input.is_action_pressed("shoot"):
		Transition("lockedshootup")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right") and Input.is_action_pressed("shoot"):
		Transition("lockedshootupright")
			
	
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up"):
		Transition("lockup")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down"):
		Transition("lockdown")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("move_right"):
		Transition("lockright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("move_left"):
		Transition("lockleft")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right"):
		Transition("lockupright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_left"):
		Transition("lockupleft")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_right"):
		Transition("lockdownright")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_down") and Input.is_action_pressed("move_left"):
		Transition("lockdownleft")
	

func Exit():
	pass
	
	

func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
	
func _on_hit() -> void:
	Transition("hit")
