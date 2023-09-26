extends Node2D

@onready var bullets = $Bullets
@onready var player = $Player

func _on_player_bullet_shot(bullet):
	bullets.add_child(bullet)
