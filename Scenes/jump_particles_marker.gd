extends Marker2D
@onready var player: CharacterBody2D = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 654
	global_position.x = player.global_position.x


func _on_jump_is_jumping() -> void:
	global_position.x = player.global_position.x
	
	if Input.is_action_just_pressed("move_up") and player.is_on_floor():
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("default")
		
	if animated_sprite_2d.is_playing():
		animated_sprite_2d.visible = true
	else:
		animated_sprite_2d.visible = false
