class_name ScoreManager extends Node

var player1_kills: int = 0
var player2_kills: int = 0
var player3_kills: int = 0
var player4_kills: int = 0

var player1_deaths: int = 0
var player2_deaths: int = 0
var player3_deaths: int = 0
var player4_deaths: int = 0

func _process(_delta: float) -> void:
	print(str(player1_kills) + " a " + str(player2_kills))
	pass

func score_board(killer: int, victim: int) -> void:
	match killer:
		1:
			player1_kills += 1
		2:
			player2_kills += 1
	
	match victim:
		1:
			player1_deaths += 1
		2:
			player2_deaths += 1
