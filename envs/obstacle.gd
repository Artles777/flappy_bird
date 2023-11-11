extends Node2D

signal score

const SPEED = 215

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -SPEED:
		queue_free()


func _on_pipe_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_score_area_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if body is Player:
		$Point.play()
		emit_signal("score")
