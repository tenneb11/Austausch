extends Node2D

var state = "oranges" # no apples, apples
var player_in_area = false

var orange = preload("res://scene/apple_collectable.tscn")

@export var item: INvItem
var player = null

func _ready():
	if state == "no oranges":
		$grow_Timer.start()


func _process(delta):
	if state == "no oranges":
		$AnimatedSprite2D.play("no_oranges")
	if state == "oranges":
		$AnimatedSprite2D.play("oranges")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no oranges"
				drop_orange()
				

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout() -> void:
	if state == "no oranges":
		state = "oranges"

func drop_orange():
	var orange_instance = orange.instantiate()
	orange_instance.global_position = $Marker2D.global_position
	get_parent().add_child(orange_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$grow_Timer.start()
