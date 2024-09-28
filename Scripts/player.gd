extends  CharacterBody2D

signal hit

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm: FiniteStateMachine = $"../FSM"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hit_timer: Timer = $HitTimer
@onready var hud: CanvasLayer = $"../HUD"
@onready var dash_timer: Timer = $"../FSM/Dash/DashTimer"
@onready var hit_sfx: AudioStreamPlayer2D = $HitSFX
@onready var lose_sfx: AudioStreamPlayer2D = $"../LoseSFX"

var health = 3
var canHit = true
var dead = false

func _process(delta: float) -> void:
	hud.updateHP(health)
	if animated_sprite_2d.modulate.b < 1 and animated_sprite_2d.modulate.g < 1:
		animated_sprite_2d.modulate += Color(0,1,1) * delta
		
	if health == 0:
		fsm.set_process(false)
		collision_shape_2d.set_deferred("disabled", true)
		animated_sprite_2d.play("death")
		dead = true
	
func _on_hit() -> void:
	if canHit:
		animated_sprite_2d.modulate = Color(1, 0, 0)
		canHit = false
		hit_sfx.play()
		if health > 0:
			health -= 1
			
		if health == 0:
			hit_sfx.set_process(false)
			lose_sfx.play()
		
		hud.updateHP(health)
		hit_timer.start()

func _on_hit_timer_timeout() -> void:
	canHit = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		hide()


func _on_lose_sfx_finished() -> void:
	pass # Replace with function body.
