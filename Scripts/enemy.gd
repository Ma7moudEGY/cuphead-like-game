extends Area2D

signal dead

var health = 2000

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_placement: Marker2D = $BulletPlacement
@onready var shoot_timer: Timer = $ShootTimer
@onready var queue_timer: Timer = $QueueTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@export var Bullet : PackedScene
@export var speed_increment = .25


var bullet_counter = 4
var shoot_counter = 1
var Player
var inside = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time = randi_range(3, 5)
	shoot_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <=0:
		dead.emit()
		collision_shape_2d.set_deferred("disabled", true)
		
	if inside:
		Player.hit.emit()
		
	

func _on_animated_sprite_2d_animation_finished() -> void:

	if animated_sprite_2d.animation == "Spawn":
		animated_sprite_2d.play("Idle")
		
	if animated_sprite_2d.animation == "Attack":
		animated_sprite_2d.play("Idle")
	
		
func Shoot():
		
	var bullet_node = Bullet.instantiate()
		
	get_tree().root.add_child(bullet_node)
	bullet_node.global_position = bullet_placement.global_position
			


func _on_shoot_timer_timeout() -> void:
	animated_sprite_2d.play("Attack")


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d:
		if animated_sprite_2d.animation == ("Attack") and animated_sprite_2d.frame == 12:
			animated_sprite_2d.speed_scale = shoot_counter
			if bullet_counter > 0:
				Shoot()
				bullet_counter -= 1
				animated_sprite_2d.set_frame_and_progress(0, 0)
				shoot_timer.stop()
			
			if bullet_counter == 0:
				if shoot_counter >= (1 + speed_increment * 3):
					shoot_counter = 1
					animated_sprite_2d.speed_scale = 1
				else:
					shoot_counter += speed_increment
					
				animated_sprite_2d.speed_scale = 1
				animated_sprite_2d.play("Idle")
				bullet_counter = 4
				shoot_timer.wait_time = randi_range(3, 5)
				shoot_timer.start()
				
				
			if shoot_counter >= (1 + speed_increment * 3):
				shoot_counter = 1
				animated_sprite_2d.speed_scale = 1
			
		if animated_sprite_2d.animation == ("Death"):	
			if animated_sprite_2d.frame == 8:
				animated_sprite_2d.play_backwards("Death")
			if animated_sprite_2d.frame == 0:
				animated_sprite_2d.play("Death")


func _on_body_entered(body: Node2D) -> void:
	if body.name.to_lower() == "player":
		body.hit.emit()
		Player = body
		inside = true
		
		


func _on_body_exited(body: Node2D) -> void:
	if body.name.to_lower() == "player":
		inside = false


func _on_dead() -> void:
	shoot_timer.stop()
	animated_sprite_2d.offset.y += 45
	animated_sprite_2d.play("Death")
	queue_timer.start()


func _on_queue_timer_timeout() -> void:
	pass
