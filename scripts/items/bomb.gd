extends CharacterBody2D
class_name Bomb

@export var gravity_force: float = 150

@onready var animator: AnimationPlayer = get_node("Animation")
@onready var boom_timer: Timer = get_node("BoomTimer")
@onready var boom_hitbox: Area2D = get_node("BoomHitBox")

var player_laucher: int = 0
var direction: float = 1


func _ready() -> void:
	boom_hitbox.set_monitoring(false)
	boom_hitbox.body_entered.connect(explosion)
	animator.animation_finished.connect(tictac_change)
	boom_timer.timeout.connect(max_explosion_time)
	boom_timer.set_one_shot(true)
	thrown()


func _physics_process(delta) -> void:
	gravity(delta)
	move_and_slide()


# Chamada na explosão, dependendo do tipo do objeto terá ações diferentes.
func explosion(body: CharacterBody2D) -> void:
	if body is Player:
		if body.controller_number != player_laucher:
			body.respawn.killed_by_item.emit()
			body.controller.update_score(player_laucher, body.controller_number)
		else:
			body.respawn.killed_by_item.emit()
	elif body is Boomerang:
		body.queue_free()


func thrown() -> void:
	velocity = Vector2(100 * direction, -150)


func set_player_launcher(param: int) -> void:
	player_laucher = param


func gravity(force: float) -> void:
	velocity.y += (gravity_force * 3) * force
	velocity.x = move_toward(velocity.x, 0, 1)
	if is_on_floor():
		velocity.x = 0


func tictac_change(anim: StringName) -> void:
	match anim:
		"tic_tac":
			animator.play("BOOM")
			boom_hitbox.set_monitoring(true)
			boom_timer.start(2)


func max_explosion_time() -> void:
	queue_free()
