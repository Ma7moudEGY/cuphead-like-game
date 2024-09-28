extends State

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


func Entre():
	Sprite.play("lock_up")
	
	
func Update(_delta:float):
	if Input.is_action_pressed("shoot"):
		Transition("idle")
		
	if Input.is_action_just_released("lock"):
		Transition("idle")
		
	if Input.is_action_just_released("look_up"):
		Transition("lockhandler")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_left"):
		Transition("lockupleft")	
	
	if Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right") and Input.is_action_pressed("shoot"):
		Transition("idle")
	
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_right"):
		Transition("lockupright")
		
	
func Exit():
	pass

func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
	
func _on_hit() -> void:
	Transition("hit")
