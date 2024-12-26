extends Node

var peer : ENetMultiplayerPeer

const MAX_CLIENTS = 16
const PORT = 16998
const IP_ADDRESS = "localhost"

var my_player_node : Player = null

func _ready() -> void:
	set_j_h_visibility(true)

func set_j_h_visibility(on : bool) -> void:
	$VBoxContainer/join.visible = on
	$VBoxContainer/host.visible = on
	$VBoxContainer/exit.visible = not on

func _on_join_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
	
	SceneManager.reload()
	my_player_node = SceneManager.player_node
	set_j_h_visibility(false)



func _on_host_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(SceneManager.set_player_id)
	multiplayer.peer_disconnected.connect(SceneManager.remove_player_by_id)
	
	SceneManager.reload()
	my_player_node = SceneManager.player_node
	set_j_h_visibility(false)




func _on_exit_pressed() -> void:
	multiplayer.multiplayer_peer = null
	set_j_h_visibility(true)
