extends AiEntity
class_name RangedEnemy

var attack_timer := Timer.new()
export var attack_cooldown = 1
export var projectile : PackedScene = preload("res://progect tail.tscn")

func _ready():
	add_child(attack_timer)

func process_chase():
	.process_chase()
	if can_see(chase_target) and position.distance_to(chase_target.position) < 300 and attack_timer.is_stopped():
		attack_timer.one_shot = true
		attack_timer.start(attack_cooldown)
		var proj_instance = projectile.instance()
		look_at(chase_target.position)
		proj_instance.position = position
		proj_instance.rotation = rotation + deg2rad(rand_range(-10, 10))
		$"/root/GlobalManager".gamemanager.add_child(proj_instance)
		

func target_entity_position(entity:LivingEntity)->Vector2:
	if entity:
		return entity.position.direction_to(position) * 250 + entity.position
	else:
		return position
	
