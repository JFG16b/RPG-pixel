extends KinematicBody2D

const EnemyDeathEffect = preload("res://Action RPG Resources/Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 80
export var FRICTION = 200
enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var c_one = Color("3d46da")
var c_two = Color("80fff9")
var c_three = Color("ffff70")
var c_four = Color("ffffff")

var state = CHASE

onready var sprite = $Sprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderControler
onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	stats.health -= 0
	state = pick_ramdom_state([IDLE, WANDER])

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
		
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			
			accelerate_towards_point(wanderController.target_position,delta)
			
			if global_position.distance_to(wanderController.target_position) <= 4:
				update_wander()
		
		CHASE:
			var player = playerDetectionZone.player 
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0 

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func update_wander():
	state = pick_ramdom_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0 

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_ramdom_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)


func _on_Stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position - Vector2(0, 7)


func _on_Stats_four_plus_health() -> void:
	$Sprite.modulate = c_one

func _on_Stats_two_health() -> void:
	$Sprite.modulate = c_two

func _on_Stats_one_health() -> void:
	$Sprite.modulate = c_three

func _on_Stats_three_health() -> void:
	$Sprite.modulate = c_four


func _on_Hurtbox_invincibility_ended() -> void:
	animationPlayer.play("Stop")


func _on_Hurtbox_invincibility_started() -> void:
	animationPlayer.play("Start")
