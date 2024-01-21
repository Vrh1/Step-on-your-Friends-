extends Node2D
class_name ControllerPlayer

@export_category("Inputs")
@export var left: String = ""
@export var right: String = ""
@export var fire: String = ""
@export var jump: String = ""

@export_category("Controller")
@export var controller_number: int = 0

func _ready() -> void:
	pass


# Função que vai passar para a lógica do game quem matou e quem morreu.
# OBS: acredito que usando groups na lógica da partida seja o melhor caminho.
func update_score(killer: int, victim: int) -> void:
	get_tree().call_group("logica", "score_board", killer, victim)
