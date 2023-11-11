extends Node2D

signal obstacle_created(obs)

var Obstacle = preload("res://envs/obstacle.tscn")

func _ready():
	randomize()
	

func _on_timer_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = Obstacle.instantiate()
	add_child(obstacle)
	obstacle.position.y = randi() % 400 + 150
	emit_signal("obstacle_created", obstacle)

func start():
	$Timer.start()
	
func stop():
	$Timer.stop()
