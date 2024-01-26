extends MatchLogicBase

@export var death_threshold: int

func check_win_condition() -> void:
	if score_manager.player1_deaths >= death_threshold || score_manager.player2_deaths >= death_threshold:
		finish_game()
