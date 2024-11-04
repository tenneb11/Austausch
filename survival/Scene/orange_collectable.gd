extends StaticBody2D



func _ready():
	fallfromtree()
	
func fallfromtree():
	$AnimationPlayer.play("fallingfromtree")
	await get_tree().create_timer(1.5).timeout
	$AnimatableBody2D.play("fade")
	print("+1 oranges")
	await  get_tree().create_timer(8.3).timeout
	queue_free()
	
	
