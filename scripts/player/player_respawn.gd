extends Node
class_name Respawn

signal stomped

@export var parent: Player = null
@export var animations: PlayerAnimations = null
@export var raycasts: Node2D = null

@onready var respawn_timer: Timer = get_node("Respawn Timer")


func _ready() -> void:
	stomped.connect(die)
	pass

func _physics_process(_delta) -> void:
	pass


func die() -> void:
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
	respawn_timer.timeout.connect(spawn)


func spawn() -> void:
	pass
