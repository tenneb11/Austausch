extends StaticBody2D



func _ready():
	fall_from_tree()

func fall_from_tree():
	$AnimationPlayer.play("falling_from_tree")
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("fade")
	print("+1 apples")
	await get_tree().create_timer(0.3).timeout
	queue_free()
