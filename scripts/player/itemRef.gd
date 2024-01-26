extends Node
class_name ItemsRef

@onready var attacks: PlayerAttacks = get_parent()

const BOOMERANG: PackedScene = preload("res://scenes/items/boomerang.tscn")


# Verifica qual item deve ser passado pro player.
func pass_item(value: String) -> void:
	match value:
		"Boomerang":
			attacks.current_item = BOOMERANG
