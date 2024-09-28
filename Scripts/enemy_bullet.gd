extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var speed = 600
@export var damage = 1

var direction = -1

	
func _physics_process(delta: float) -> void:
	global_position.x += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name.to_lower() == "player":
		body.hit.emit()
