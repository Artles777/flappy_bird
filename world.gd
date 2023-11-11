extends Node2D

const SAVE_FILE_PATH = "user://savedata.save"

var score: int = 0: set = set_score
var highscore = 0

func _ready():
	$ObstacleSpawner.obstacle_created.connect(_on_obstacle_created)
	load_highscore()

func set_score(new_score):
	score = new_score
	$HUD.update_score(new_score)

func player_score():
	self.score += 1

func _on_obstacle_created (obs):
	obs.score.connect(player_score)

func new_game():
	self.score = 0
	$ObstacleSpawner.start()


func _on_death_zone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_bird_died():
	game_over()

func game_over():
	$ObstacleSpawner.stop()
	$Ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	$MenuLayer.init_game_over_menu(score, highscore)

func _on_menu_layer_start_game():
	new_game()
	
func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		highscore = save_data.get_var()
		save_data.close()
