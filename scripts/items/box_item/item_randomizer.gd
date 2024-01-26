extends Node
class_name ItemRandomizer

@export var texture: Sprite2D = null

@export_category("Arrays")
# ATENÇÃO, as listas devem estar na mesma ordem.
@export var item_list: Array[String] = [
	"Boomerang",
]
@export var texture_directory: Array = [
	"res://assets/sprites/items/boxitem/Boomerang_item.png",
]


var index: int = 0

func _ready() -> void:
	index = random_item()
	texture.set_texture(load(texture_directory[index]))


func random_item() -> int:
	randomize()
	var item: int = randi() % item_list.size()
	return item
