extends KinematicBody2D

class_name LivingEntity

export var HP : int = 10 setget entity_HP_changed
export var max_HP : int = 10
export var respawn_timeout:float = -1

signal HP_changed(old_value, new_value)

func entity_HP_changed(new_value:int):
	if self.state != EntityState.DEAD:
		var new_HP = clamp(new_value, 0 ,max_HP)
		emit_signal("HP_changed", HP, new_HP)
		HP = new_HP
		if new_value == 0:
			new_state(EntityState.DEAD)
#	HP = clamp(new_value,0,max_HP)
	
export var gamemanager_nodepath:NodePath
var gamemanager:GameManager
export var speed:float = 200
export var acceleratioon:float = 2000
var velocity:Vector2

func entity_calculate_target_velocity() ->Vector2:
	return Vector2()
	
func deal_damage(target:LivingEntity, damage : int):
	if target:
		target.HP -= damage
		emit_signal("damage_dealt", target, damage)

func entity_move(targetvel:Vector2, frame_delta:float):
	velocity = velocity.move_toward(targetvel, min(acceleratioon * frame_delta, velocity.distance_to(targetvel)))
	velocity = move_and_slide(velocity)

signal damage_dealt(target, damage)

func _ready():
	gamemanager = get_node_or_null(gamemanager_nodepath)as GameManager
	if Engine.editor_hint:
		set_physics_process(false)
	pass
	
enum EntityState{
		DEAD = 0,
		INACTIVE = 1,
		ALIVE = 2,
		PATROL = 3,
		CHASE = 4
}

export(EntityState) var state = EntityState.INACTIVE setget new_state

signal state_shanged(old_state, new_state)
 
func new_state(new_value):
	emit_signal("state_shanged", state, new_value) 
	state = new_value
	match new_value:
		EntityState.ALIVE:
			rebirth()
		EntityState.DEAD:
			death()
			
func death():
	if respawn_timeout == -1:
		self.queue_free()
	elif respawn_timeout <= 0:
		new_state(EntityState.ALIVE)
	else:
		var timer := Timer.new()
		timer.connect("timeout", self, "new_state", [EntityState.ALIVE])
		timer.connect("timeout", timer, "queue_free")
		timer.one_shot = true
		timer.state(respawn_timeout)

func rebirth():
	entity_HP_changed(max_HP)

func chek_visual_contact(other:LivingEntity)-> bool:
	var raycast = RayCast.new()
	gamemanager.add_chic(raycast)
	raycast.cast_to = other.position - position
	raycast.position = position
	raycast.force_raycast_update()
	var return_olata:=raycast.get_collider() as LivingEntity == other
	raycast.quene_free()
	return return_olata

func process_movement(delta:float):
	entity_move(entity_calculate_target_velocity(), delta)
	
func _physics_process(delta:float):
	process_movement(delta)
	
	
	
	
