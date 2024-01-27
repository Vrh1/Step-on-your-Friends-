extends StaticBody2D
class_name BoxItem

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimSprite")

@onready var raycasts: Node2D = get_node("Raycasts")
@onready var cooldown: Timer = get_node("Cooldown")
@onready var spawn_item_locate: Marker2D = get_node("SpawnItemLocate")
@onready var generic_item: PackedScene = preload("res://scenes/items/boxItems/item.tscn")

enum {
	ITEM,
	NOITEM,
}

var state: int = ITEM


func _ready() -> void:
	cooldown.set_one_shot(true)
	cooldown.timeout.connect(timeout_ready_item)


func _process(_delta) -> void:
	match state:
		ITEM:
			anim_sprite.item()
			verify_player_head()
		NOITEM:
			anim_sprite.no_item()


# Função executada quando o bloco for atingido.
func on_hit() -> void:
	var new_item = generic_item.instantiate()
	new_item.global_position = global_position
	new_item.location = spawn_item_locate.global_position
	get_tree().root.call_deferred("add_child", new_item)
	state = NOITEM
	cooldown.start(20)


# Temporizador, quando o tempo acabar o bloco entrará em estado de ITEM.
func timeout_ready_item() -> void:
	state = ITEM


# Verifica se a cabeça do player está colidindo.
func verify_player_head() -> void:
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			on_hit()
