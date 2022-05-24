extends LivingEntity
class_name Player
export var projectile : PackedScene = preload("res://progect tail.tscn")
#var gamemanager : GameManager
#var weapon : BaseWeapon
func _ready():
	pass



func entity_calculate_target_velocity() -> Vector2:
	return speed * Input.get_vector("left", "right", "up", "down")*(Input.get_action_strength("run")/2+1)

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		var proj_instance = projectile.instance()
		proj_instance.position = position
		proj_instance.rotation = rotation + deg2rad(rand_range(-10, 10))
		if proj_instance is Projectile:
			proj_instance.proj_owner = self
		$"/root/GlobalManager".gamemanager.add_child(proj_instance)

func death():
	$"/root/GlobalManager".gamemanager.restart_level()
