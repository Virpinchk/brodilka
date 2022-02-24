extends KinematicBody2D
class_name LivingEntity
export var HP: int = 10 setget entity_HP_change
export var max_HP: int = 10

func entity_HP_change(new_value):
	HP = clamp(new_value,0,max_HP)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
