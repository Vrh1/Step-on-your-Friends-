extends StaticBody2D
class_name BoxItem

@export var anim_sprite: AnimatedSprite2D = null

@onready var raycasts: Node2D = get_node("Raycasts")
@onready var cooldown: Timer = get_node("Cooldown")

var item_ready: bool = true


func _ready() -> void:
	anim_sprite.play("Item")


func _process(_delta) -> void:
	if item_ready == false:
		return
	for i in raycasts.get_children():
		if i.is_colliding():
			anim_sprite.play("OnHit")
			on_hit()
			
	


func on_hit() -> void:
	pass
