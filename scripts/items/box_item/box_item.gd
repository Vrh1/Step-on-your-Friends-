extends StaticBody2D
class_name BoxItem

@export var anim_sprite: AnimatedSprite2D = null

@onready var raycasts: Node2D = get_node("Raycasts")
@onready var cooldown: Timer = get_node("Cooldown")

var item_ready: bool = true
var item_number: int = 0

enum ITEMS {
	boomerang,
	outro
}


func _ready() -> void:
	anim_sprite.play("Item")
	item_number = select_item()


func _process(_delta) -> void:
	if item_ready == false:
		return
	for i in raycasts.get_children():
		if i.is_colliding():
			anim_sprite.play("OnHit")
			on_hit(item_number)
	


func on_hit(_item: int) -> void:
	pass


func select_item() -> int:
	randomize()
	var random_item: int = randi() % ITEMS.size()
	return random_item
