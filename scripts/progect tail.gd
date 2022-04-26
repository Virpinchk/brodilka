extends Node2D

func _physics_process(delta):
	var other = $RayCast2D.get_collider()
	if other:
		if other is LivingEntity:
			(other as LivingEntity).HP-= 10
		queue_free()
	else:
		position += transform .x*500*delta  #$RayCast2D  

func _ready():
	pass 
