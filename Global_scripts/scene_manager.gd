extends Node

var next_scene : String = "res://scenes/hub.tscn"
var next_scene_loaded : bool = true
var next_tag : String = ""

var player_node : Player = null

@export var player_packed_sceane : PackedScene

var player_id : int


func spawn_player(g_pos:Vector3) -> void:
	var g_rot : Vector3 = Vector3.ZERO
	
	if player_node != null:
		g_rot = player_node.global_rotation
		#player_node.queue_free()
	
	
	player_node = player_packed_sceane.instantiate()
	player_node.name = str(player_id)
	$MultplaterRoot.add_child(player_node)
	player_node.global_position = g_pos
	player_node.global_rotation = g_rot
	
	

func set_player_id(id = 1) -> void:
	player_id = id
	if player_node == null:
		spawn_player(Vector3.ZERO)
	spawn_player(player_node.global_position)

func remove_player_by_id(id = 1) -> void:
	$MultplaterRoot.get_node(str(id)).queue_free()

func remove_player(id = 1) -> void:
	$MultplaterRoot.get_node(str(id)).queue_free()

func load_map(scene: String, tag: String):
	next_scene = scene
	ResourceLoader.load_threaded_request(scene)
	next_tag = tag
	next_scene_loaded = false
	
func reload():
	load_map(next_scene, next_tag)




func _process(delta: float) -> void:
	$AspectRatioContainer.visible = not next_scene_loaded
	if $AspectRatioContainer.visible:
		var progress := []
		ResourceLoader.load_threaded_get_status(next_scene,progress)
		$AspectRatioContainer/VBoxContainer/ProgressBar.value = progress[0] * 100
		
		if progress[0] == 1:
			get_tree().change_scene_to_packed(load(next_scene))
			next_scene_loaded = true
