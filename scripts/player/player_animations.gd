extends Node
class_name PlayerAnimations

# Objeto player
@export_category("Player")
@export var player: Player = null

# Objeto AnimationPlayer e Sprite2D
@export_category("Animations")
@export var animator: AnimationPlayer = null
@export var sprite: Sprite2D = null


func _physics_process(_delta):
	verify_direction(player.direction)
	if player.is_on_floor():
		check_moving(player.velocity.x)


# Verificar direção do player
func verify_direction(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true


func fall_jumping() -> void:
	pass


# Verifica o movimento do player
func check_moving(velocity: float) -> void:
	if velocity == 0:
		animator.play("idle")
	elif velocity != 0:
		animator.play("walk")
		if player.fire_pressed == true:
			animator.speed_scale = 1.4
		else:
			animator.speed_scale = 1.0
