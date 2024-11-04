extends Node2D

var state = "apples" # no apples, apples
var player_in_area = false

var apple = preload("res://scene/apple_collectable.tscn")

@export var item: INvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no apples":
		$grow_Timer.start()

@warning_ignore("unused_parameter")
func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no_apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no apples"
				drop_apple()



func _on_pick_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body
	

func _on_pick_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_grow_timer_timeout():
	if state == "no apples":
		state = "apples"

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$grow_Timer.start()
