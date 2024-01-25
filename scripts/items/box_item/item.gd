extends Area2D
class_name Item

@export var item_list: Array = [
	"Boomerang",
]
@export var ammo_list: Dictionary = {
	"Boomerang": 5,
}


func _ready() -> void:
	print(ammo_list[item_list[random_item()]])


func random_item() -> int:
	randomize()
	var item: int = randi() % item_list.size()
	return item
