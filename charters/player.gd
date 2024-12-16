extends CharacterBody3D
class_name Player

@export var speed : float = 512.0
@export var turn_speed : float = 64.0

#"ui_left", "ui_right", "ui_up", "ui_down"
func _physics_process(delta: float) -> void:
	
	rotation_degrees.y += Input.get_axis("ui_right","ui_left") * turn_speed * delta
	
	velocity = basis.z * Input.get_axis("ui_up", "ui_down") * speed * delta
	move_and_slide()
