extends Node

var next_scene : String = ""
var next_tag : String = ""

var player_node : Player = null

@export var player_packed_sceane : PackedScene
func spawn_player(g_pos:Vector3):
	if player_node == null:
		player_node = player_packed_sceane.instantiate()
		add_child(player_node)
	player_node.global_position = g_pos
	
	

func load_map(scene: String, tag: String):
	next_scene = scene
	ResourceLoader.load_threaded_request(scene)
	next_tag = tag




func _process(delta: float) -> void:
	$AspectRatioContainer.visible = next_scene != ""
	if $AspectRatioContainer.visible:
		var progress := []
		ResourceLoader.load_threaded_get_status(next_scene,progress)
		$AspectRatioContainer/VBoxContainer/ProgressBar.value = progress[0] * 100
		
		if progress[0] == 1:
			get_tree().change_scene_to_packed(load(next_scene))
			next_scene = ""
