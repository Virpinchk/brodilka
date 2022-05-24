extends RayCast2D
class_name Projectile
export var speed : float = 60
export var damage : float = 2
export var visual_part : NodePath
var proj_owner : LivingEntity
 
func _physics_process(delta):
	if visual_part:
		var obj = get_node_or_null(visual_part)
		if obj is Node2D:
			obj.position.x = speed*delta
	cast_to = Vector2(speed*delta, 0)
	var other := get_collider()
	if other and not other == proj_owner:
		if other is  LivingEntity:
			if is_instance_valid(proj_owner):
				proj_owner.deal_damage(other as LivingEntity, damage)
			else:
				(other as LivingEntity).HP -= damage
		queue_free()
	else:
		position += transform.x*speed*delta
		
	pass
func deal_dmg():
	pass
