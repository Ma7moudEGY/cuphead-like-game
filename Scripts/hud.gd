extends CanvasLayer
@onready var player_hp: Label = $PlayerHP
@onready var enemy_bar: ProgressBar = $EnemyBar

@onready var player: CharacterBody2D = $"../Player"


func updateHP(hp):
	player_hp.text = "HP: " + str(hp)

func updateBar(hp):
	enemy_bar.value = hp
