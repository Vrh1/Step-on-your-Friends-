extends Node
class_name PlayerAnimations

# Objeto player
@export_category("Player")
@export var player: Player = null
@export var item_spawn_local: Marker2D = null

# Objeto AnimationPlayer e Sprite2D
@export_category("Animations")
@export var animator: AnimationPlayer = null
@export var sprite: Sprite2D = null
@export_category("RayCasts")
@export var push_raycast: RayCast2D = null


# Chamada por frame
func _physics_process(_delta) -> void:
	verify_direction(player.direction)
	if player.is_on_floor():
		check_moving(player.velocity.x)
		return
	anim_air(player.velocity.y)


# Verificar direção do player
func verify_direction(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false
		push_raycast.rotation_degrees = 0
		item_spawn_local.position.x = 7.5
	if direction < 0:
		sprite.flip_h = true
		push_raycast.rotation_degrees = 180
		item_spawn_local.position.x = -7.5
	


# Animar queda e pulo do jogador.
func anim_air(velocity: float) -> void:
	if velocity < 0:
		animator.play("jump")
		animator.speed_scale = 2
	elif velocity > 0:
		animator.play("fall")


# Verifica o movimento do player
func check_moving(velocity: float) -> void:
	if velocity == 0:
		animator.play("idle")
		animator.speed_scale = 1.0
	elif velocity != 0:
		animator.play("walk")
		if player.fire_pressed == true:
			animator.speed_scale = 1.4
		else:
			animator.speed_scale = 1.0


# Animar a morte. Press F
func dieing() -> void:
	animator.play("dead")


func dieing_byitem() -> void:
	animator.play("die_by_item")
