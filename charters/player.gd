extends CharacterBody3D
class_name Player

@export var speed : float = 512.0
@export var turn_speed : float = 64.0


	

func _physics_process(delta: float) -> void:
	
	if $RayCast3D.is_colliding():
		var dist: float = $RayCast3D.global_position.distance_to( $RayCast3D.get_collision_point())
		if dist > 0:
			position.y -= dist
	
	rotation_degrees.y += Input.get_axis("ui_right","ui_left") * turn_speed * delta
	
	velocity = basis.z * Input.get_axis("ui_up", "ui_down") * speed * delta
	move_and_slide()
