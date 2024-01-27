extends Node
class_name ItemsRef

@onready var attacks: PlayerAttacks = get_parent()

# Carregamento do item.
const BOOMERANG: PackedScene = preload("res://scenes/items/boomerang.tscn")
const BOMB: PackedScene = preload("res://scenes/items/bomb.tscn")

var do_item: int = num_none
var ammo_item: int = 0

enum {
	num_none,
	num_boomerang,
	num_bomb
}


# Verifica qual item deve ser passado pro player.
func pass_item(value: String) -> void:
	match value:
		"Boomerang":
			attacks.current_item = BOOMERANG
			do_item = num_boomerang
			ammo_item = 2
		
		"Bomb":
			attacks.current_item = BOMB
			do_item = num_bomb
			ammo_item = 1


# Tratamento do item após instanciado, número de munições ou tempo ativo deve ser tratado aqui.
func item_treatment() -> void:
	match do_item:
		num_none:
			pass
		
		num_boomerang:
			if ammo_item > 0:
				ammo_item =- 1
			else:
				attacks.current_item = null
				attacks.have_item = false
				ammo_item = 0
		
		num_bomb:
			attacks.current_item = null
			attacks.have_item = false
