extends CharacterBody2D
class_name Boomerang

@export var speed: float = 200
@export var upping: float = 40
@export var brake: float = 80

@onready var animSprite: AnimatedSprite2D = get_node("AnimSprite")
@onready var going_timer: Timer = get_node("GoingTimer")
@onready var free_timer: Timer = get_node("FreeTimer")
@onready var hitbox: Area2D = get_node("HitBox")

var is_backing: bool = false
var is_upping: bool = false

var direction: float = 1
var player_launcher: int = 0 


#func _init(player_direction: float) -> void:
	#direction = player_direction

# os Timers estão com autostart no próprio node
func _ready() -> void:
	hitbox.set_monitoring(true) # habilita o monitoramento da hitbox.
	animSprite.play("loop")
	is_backing = false
	going_timer.timeout.connect(going_timeout)
	free_timer.timeout.connect(on_maxtimeout)
	hitbox.body_entered.connect(on_hit)
	going_timer.start(0.5)
	free_timer.start(5)


func _physics_process(_delta: float) -> void:
	if !is_backing:
		going()
	else:
		returning()
	move_and_slide()


# Boomerangue Indo
func going() -> void:
	velocity.x = speed * direction


func going_timeout() -> void:
	is_backing = true
	is_upping = true


#Boomerangue Voltando
func returning() -> void:
	while is_upping == true:
		velocity.x = move_toward(velocity.x , 0, brake)
		velocity.y = -upping
		if velocity.x == 0:
			is_upping = false
			return
		return
	velocity.x = move_toward(velocity.x, direction * -speed, brake)
	velocity.y = move_toward(velocity.y, 0, brake)


#Limpar o boomerangue
func on_maxtimeout() -> void:
	queue_free()


# Detectação de colisão com player.
func on_hit(body: Player) -> void:
	if player_launcher != body.controller_number:
		body.respawn.killed_by_item.emit()
		body.controller.update_score(player_launcher, body.controller_number)


func set_player_launcher(param: int) -> void:
	player_launcher = param
