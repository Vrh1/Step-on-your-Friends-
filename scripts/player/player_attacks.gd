extends Node
class_name PlayerAttacks

@export_category("Foots")
@export var foots: Node2D = null

@export_category("PushBack")
@export var push_raycast: RayCast2D = null
@export var pushback_x: float = 50
@export var pushback_y: float = -50

@onready var knockback_temp: Timer = get_node("Knockback Timer")

var enemy_push: Player = null


func _ready() -> void:
	knockback_temp.wait_time = 0.3
	knockback_temp.timeout.connect(knockback_timeout)


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
	# 2 jeitos de emitir um sinal
	victim.respawn.stomped.emit()
	#victim.respawn.emit_signal("stomped") 
	
	get_parent().velocity.y = -200


# TODO função para jogar itens, provavelmente terá que passar um argumento item.
func throw_item() -> void:
	pass


# Função de empurrar o inimigo.
func push_back() -> void:
	var enemy_pushed: Player = push_raycast.get_collider()
	if enemy_pushed is Player:
		enemy_push = enemy_pushed
		knockback_timer(enemy_pushed)
		enemy_pushed.velocity.x = (pushback_x * get_parent().direction)
		enemy_pushed.velocity.y = pushback_y


func knockback_timer(enemy: Player) -> void:
	enemy.can_move = false
	knockback_temp.start()


func knockback_timeout() -> void:
	enemy_push.can_move = true
