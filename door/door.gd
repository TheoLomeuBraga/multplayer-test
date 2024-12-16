extends Area3D

@export_file("*.tscn") var destination_scene : String = ""
@export var tag : String = ""

var paused : bool = false

func _ready() -> void:
	if SceneManager.next_tag == tag:
		SceneManager.spawn_player(global_position)
		paused = true
		SceneManager.next_tag = ""
	



func _on_body_entered(body: Node3D) -> void:
	if body is Player and not paused:
		SceneManager.load_map(destination_scene,tag)


func _on_body_exited(body: Node3D) -> void:
	paused = false
