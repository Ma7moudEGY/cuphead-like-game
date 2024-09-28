extends State


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D


@onready var shoot: Node = $"../Shoot"


func Entre():
	Sprite.flip_h = true
	Sprite.play("shoot")
	
	
func Update(_delta:float):
	if Input.is_action_just_released("shoot"):
		Transition("lockhandler")
		
	if Input.is_action_just_pressed("move_right"):
		Transition("lockedshootright")
		
	if Input.is_action_pressed("look_up"):
		Transition("lockedshootup")
		
	if Input.is_action_pressed("look_down"):
		Transition("lockedshootdown")
		
	shoot.Shoot()
	
	
func Exit():
	pass


func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_hit() -> void:
	Transition("hit")
