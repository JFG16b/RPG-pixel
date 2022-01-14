extends KinematicBody2D

const PlayerHurtSound = preload ("res://Action RPG Resources/Player/PlayerHurtSound.tscn")
const PlayerDeathEffect = preload ("res://Action RPG Resources/Effects/GrassEffect.tscn")

export var ACCELERATION = 400
export var MAX_SPEED = 100
export var ROLL_SPEED = 150
export var FRICTION = 350

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready() -> void:
	stats.connect("no_health", self, "_on_Stats_no_health")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state(delta)
	
		ROLL:
			roll_state()
	
		ATTACK:
			attack_state()

func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)    
		animationTree.set("parameters/Run/blend_position", input_vector) 
		animationTree.set("parameters/Attack/blend_position", input_vector)  
		animationTree.set("parameters/Roll/blend_position", input_vector)    
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func attack_state():
	velocity = Vector2.ZERO 
	animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity = velocity / 2
	state = MOVE


func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area) -> void:
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)

func _on_Stats_no_health():
	queue_free()
	var playerDeathEffect = PlayerDeathEffect.instance()
	get_parent().add_child(playerDeathEffect)
	playerDeathEffect.global_position = global_position - Vector2(5, 10)


func _on_Hurtbox_invincibility_started() -> void:
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended() -> void:
	blinkAnimationPlayer.play("Stop")
