extends Node
class_name Respawn

signal stomped
signal killed_by_item

@export var parent: Player = null
@export var animations: PlayerAnimations = null
@export var raycasts: Node2D = null

@onready var respawn_timer: Timer = get_node("Respawn Timer")


func _ready() -> void:
	stomped.connect(die)
	killed_by_item.connect(by_item)
	respawn_timer.timeout.connect(spawn)

func _physics_process(_delta) -> void:
	pass


func die() -> void:
	animations.set_physics_process(false)
	animations.dieing()
	parent.can_move = false
	parent.set_collision_layer_value(2, false)
	parent.set_collision_mask_value(2, false)
	for i in raycasts.get_children():
		if i is RayCast2D:
			i.enabled = false
		elif i is Node2D:
			for j in i.get_children():
				j.enabled = false
	respawn_timer.start(5)


# Respawnd do player, ativando todos os objetos novamente
func spawn() -> void:
	animations.set_physics_process(true)
	parent.can_move = true
	parent.set_physics_process(true)
	parent.collision.set_deferred("disabled", false)
	parent.set_collision_layer_value(2, true)
	parent.set_collision_mask_value(2, true)
	for i in raycasts.get_children():
		if i is RayCast2D:
			i.enabled = true
		elif i is Node2D:
			for j in i.get_children():
				j.enabled = true
	parent.set_global_position(Vector2(30, 50))


func by_item() -> void:
	animations.set_physics_process(false)
	animations.dieing()
	parent.set_physics_process(false)
	parent.collision.set_deferred("disabled", true)
	for i in raycasts.get_children():
		if i is RayCast2D:
			i.enabled = false
		elif i is Node2D:
			for j in i.get_children():
				j.enabled = false
	respawn_timer.start(5)


func change_safe_position() -> void:
	parent.set_physics_process(false)
	parent.set_global_position(Vector2(0, -50))
