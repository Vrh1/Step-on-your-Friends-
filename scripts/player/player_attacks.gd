extends Node
class_name PlayerAttacks

@export var player: Player = null

@export_category("Foots")
@export var foots: Node2D = null

@export_category("PushBack")
@export var push_raycast: RayCast2D = null
@export var pushback_x: float = 50
@export var pushback_y: float = -50

@export_category("ItemSpawnPosition")
@export var item_spawn_position: Marker2D = null

@onready var knockback_temp: Timer = get_node("Knockback Timer")
@onready var item_timer_cooldown: Timer = get_node("ItemTimerCoolDown")
@onready var controller: ControllerPlayer = player.get_parent()

var enemy_push: Player = null
var current_item: PackedScene = null

var have_item: bool = false
var can_throw: bool = true


func _ready() -> void:
	knockback_temp.wait_time = 0.3
	knockback_temp.timeout.connect(knockback_timeout)
	item_timer_cooldown.wait_time = 1
	item_timer_cooldown.timeout.connect(cooldown)

# Update
func _physics_process(_delta) -> void:
	check_under_foots()
	push_back()


# Checagem se algum player está colidindo.
func check_under_foots() -> void:
	for foot in foots.get_children():
		var victim: Player = foot.get_collider()
		if foot.is_colliding():
			stomp(victim)


# Passar a morte e o objeto que morreu
func stomp(victim: Player) -> void:
	victim.respawn.stomped.emit()
	player.velocity.y = -200
	controller.update_score(
		controller.controller_number, victim.get_parent().controller_number)


# função para jogar itens, provavelmente terá que passar um argumento item.
func throw_item() -> void:
	if have_item && can_throw:
		var throw = current_item.instantiate()
		throw.set_player_launcher(player.controller_number)
		throw.set_global_position(item_spawn_position.global_position) 
		throw.direction = player.direction
		get_tree().root.call_deferred("add_child", throw)
		can_throw = false
		item_timer_cooldown.start()


# Função de empurrar o inimigo.
func push_back() -> void:
	var enemy_pushed: Player = push_raycast.get_collider()
	if enemy_pushed == null:
		return
	if player.direction != enemy_pushed.direction:
		enemy_push = enemy_pushed
		enemy_pushed.can_move = false
		enemy_pushed.pushed = true
		knockback_temp.start()
		player.velocity = Vector2(pushback_x * player.direction * -1 , pushback_y)
	elif player.direction == enemy_pushed.direction:
		enemy_push = enemy_pushed
		enemy_pushed.can_move = false
		enemy_pushed.pushed = true
		knockback_temp.start()
		enemy_pushed.velocity = Vector2(pushback_x * enemy_pushed.direction , pushback_y)


func knockback_timeout() -> void:
	enemy_push.can_move = true
	enemy_push.pushed = false
	enemy_push = null


# cooldown para lançar outro item.
func cooldown() -> void:
	can_throw = true
