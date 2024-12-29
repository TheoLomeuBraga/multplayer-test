extends CharacterBody3D
class_name Player

@export var speed : float = 512.0
@export var turn_speed : float = 64.0

@export var bullet_asset : PackedScene


var color : Color :
	set(value):
		var mat : Material = $body.get_surface_override_material(0)
		mat.albedo_color = value
		$body.set_surface_override_material(0,mat)
	get:
		var mat : Material = $body.get_surface_override_material(0)
		return mat.albedo_color

var coldow_timer : float = 0

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func set_color() -> void:
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	color = Color(rng.randf_range(0.25,1.0),rng.randf_range(0.25,1.0),rng.randf_range(0.25,1.0),1.0)



func _ready() -> void:
	set_color()
	if not name.is_valid_int():
		queue_free()



@rpc("authority","call_local","reliable")
func shoot():
	if multiplayer.is_server():
		var b : Node3D = bullet_asset.instantiate()
		get_parent().add_child(b,true)
		b.global_position = $muzle.global_position
		b.global_rotation = $muzle.global_rotation

func _physics_process(delta: float) -> void:
	
	if is_multiplayer_authority():
		global_position.y = 1
		
		if $RayCast3D.is_colliding():
			var dist: float = $RayCast3D.global_position.distance_to( $RayCast3D.get_collision_point())
			if dist > 0:
				position.y -= dist
		
		rotation_degrees.y += Input.get_axis("ui_right","ui_left") * turn_speed * delta
		
		velocity = basis.z * Input.get_axis("ui_up", "ui_down") * speed * delta
		move_and_slide()
		
		coldow_timer -= delta
		if Input.is_action_pressed("ui_accept") and coldow_timer <= 0:
			shoot.rpc()
			coldow_timer = 0.2
	
	elif $Camera3D != null:
		$Camera3D.queue_free()
