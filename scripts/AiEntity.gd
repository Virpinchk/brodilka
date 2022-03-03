extends "res://scripts/LivingEntity.gd"
class_name AiEntity
onready var gamemanager:GameManager = $GameManager
var target:= Vector2()
func _physics_process(delta):
	target = gamemanager.get.navpath(position,GameManager.player.position)[1]
	
func entity_calculate_target_velocity() ->Vector2:
	return position.direction_to(target)*speed


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
