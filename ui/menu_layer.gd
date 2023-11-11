extends CanvasLayer

signal start_game

var game_started = false

@onready var start_massage = $StartMenu/StartMassage
@onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		emit_signal("start_game")
		create_tween().tween_property(start_massage, "modulate:a", 0, 0.5)
		game_started = true

func init_game_over_menu(score, highscore):
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "Sore: " + str(highscore)
	$GameOverMenu.visible = true

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
