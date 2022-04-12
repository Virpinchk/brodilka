extends Node
var player:KinematicBody2D
var navigation:Navigation2D 
class_name GameManager
func get_navpath(a,b):
	return navigation.get_simple_path(a,b)

var entities := []

func  update_entity_list()->void:
	entities = []
	for node in get_children():
		if node is LivingEntity:
			register_entity(node as LivingEntity)
			
func select_target(entity : LivingEntity) -> LivingEntity:
	update_entity_list()
	var target : LivingEntity
	var best_distance : float = INF
	for other in entities:
		if other is LivingEntity:
			if entity.is_enemy(other) and entity.can_see():
				var distance = entity.position.distance_to(other.position)
				if best_distance > distance:
					target = other
					best_distance = distance
	return target 

func register_entity(entity : LivingEntity)-> void:
	if entity and not entities.has(entity):
		entities.append(entity)

func _ready():
	$"/root/GlobalManager".gamemanager = self





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
