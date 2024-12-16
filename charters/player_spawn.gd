extends Node3D

func _ready() -> void:
	SceneManager.spawn_player(global_position)
