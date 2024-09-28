extends Node


@onready var hud: CanvasLayer = $HUD
@onready var enemy: Area2D = $Enemy
@onready var player: CharacterBody2D = $Player
@onready var death_message: Label = $HUD/DeathMessage
@onready var win_message: Label = $HUD/WinMessage
@onready var reset_message: Label = $HUD/ResetMessage


func _ready() -> void:
	enemy.health = 2000
	player.health = 3
	win_message.visible = false
	death_message.visible = false

func _process(delta: float) -> void:
	hud.updateBar(enemy.health)
	
	if player.dead:
		reset_message.visible = true
		death_message.visible = true
		if Input.is_action_just_pressed("move_up"):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		
		if Input.is_action_just_pressed("shoot"):
			get_tree().reload_current_scene()
	
	
	if enemy.health <= 0:
		reset_message.visible = true
		win_message.visible = true
		if Input.is_action_just_pressed("move_up"):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
			
		if Input.is_action_just_pressed("shoot"):
			get_tree().reload_current_scene()
