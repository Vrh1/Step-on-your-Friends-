extends Area2D
class_name Item

@onready var texture: Sprite2D = get_node("Sprite")
@onready var randomizer: ItemRandomizer = get_node("Randomizer")

var location: Vector2 = Vector2.ZERO
var item: String = ""


func _ready() -> void:
	set_monitoring(true)
	body_entered.connect(catch_player)


func _physics_process(_delta) -> void:
	if location != global_position:
		translate(Vector2(0, -1))


# Quando o player entrar na área de colisão do item esta função é ativada.
# Passa o item que o player pagou.
func catch_player(body: Player) -> void:
	body.attacks.get_node("ItemRef").pass_item(randomizer.item_list[randomizer.index])
	body.attacks.have_item = true
	queue_free()
