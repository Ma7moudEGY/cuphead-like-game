extends Area2D


@export var speed = 1200
@export var damage = 5
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var direction : Vector2


func set_direction(bullet_direction):
	direction = bullet_direction
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
	
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name.to_lower() == ("enemy"):
		area.health -= damage
		print(area.health)
		animated_sprite_2d.play("fade")
		speed = 0


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "fade":
		queue_free()
