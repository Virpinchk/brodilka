extends "res://scripts/LivingEntity.gd"
class_name AiEntity
#onready var gamemanager:GameManager = $GameManager
var chase_timeout_time: int = 0.2
var final_target
var chase_target: LivingEntity
var chase_target_visibility:bool = false
var chase_timeout_timer:= Timer.new()
var target:= Vector2()
func _physics_process(delta):
	target = gamemanager.get.navpath(position,GameManager.player.position)[1]
	
func entity_calculate_target_velocity() ->Vector2:
	return position.direction_to(target)*speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_path(a):
	pass#уй
	
func update_final_target(new_value:Vector2):
	final_target = new_value
	update_path(gamemanager.get_nothpath) 
	
func update_target():
	pass
	
func process_potrul():
	if chek_visual_contact(gamemanager.player):
		new_state(EntityState.CHASE)
		
func target_entity_position(entity: LivingEntity)-> Vector2:
	return entity.position
	
		
func process_chase():
	update_final_target(target_entity_position(chase_target))
	update_target()
	var new_chase_target_visibility: bool = chek_visual_contact(chase_target)
	if chase_target_visibility and not new_chase_target_visibility and chase_timeout_time!= -1:
		chase_timeout_timer.start(max(chase_timeout_time, 0))
	elif new_chase_target_visibility:
		chase_timeout_timer.stop()
	
