extends Node

@onready var start: AudioStreamPlayer2D = $Start
@onready var loop: AudioStreamPlayer2D = $Loop

@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if not player.dead:
		if Input.is_action_just_pressed("shoot"):
			start.play()
	
	if Input.is_action_just_released("shoot"):
		loop.stop()

	

func _on_start_finished() -> void:
	start.set_process(false)
	if Input.is_action_pressed("shoot"):
		loop.play()
