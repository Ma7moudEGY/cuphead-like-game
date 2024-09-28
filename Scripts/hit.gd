extends State


@export var player: CharacterBody2D 
@export var Sprite : AnimatedSprite2D




func Entre():
	if player.is_on_floor():
		Sprite.play("hit")
	else:
		Sprite.play("air_hit")
	
	
func Update(_delta:float):
	player.move_and_slide()
	
	
func Exit():
	pass


func Transition(newstate : String):
	state_transition.emit(self, newstate)


func _on_animated_sprite_2d_animation_finished() -> void:
	if player.is_on_floor():
		Transition("Idle")
	else:
		Transition("Jump")
