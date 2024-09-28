extends State

@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


func Entre():
	Sprite.flip_h = true
	Sprite.play("lock_up_right")
	
	
func Update(_delta:float):
	if Input.is_action_just_released("lock"):
		Transition("idle")
		
	if Input.is_action_pressed("lock") and Input.is_action_pressed("look_up") and Input.is_action_pressed("move_left") and Input.is_action_pressed("shoot"):
		Transition("lockedshootupleft")
	
	if Input.is_action_just_released("look_up") or Input.is_action_just_released("move_left"):
		Transition("lockhandler")
	
	
func Exit():
	pass

func Transition(newstate : String):
	state_transition.emit(self, newstate)
	
	
func _on_hit() -> void:
	Transition("hit")
