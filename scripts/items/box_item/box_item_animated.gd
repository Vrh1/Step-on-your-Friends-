extends AnimatedSprite2D
class_name BoxItemAnimated

@onready var box_item: BoxItem = get_parent()


func item() -> void:
	play("Item")


func no_item() -> void:
	play("NoItem")
