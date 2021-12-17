extends KinematicBody2D
#cambiar color en funcion de la vida
const EnemyDeathEffect = preload("res://Action RPG Resources/Effects/EnemyDeathEffect.tscn")

var knockback = Vector2.ZERO
var c_one = Color("3d46da")
var c_two = Color("80fff9")
var c_three = Color("ffff70")
var c_four = Color("ffffff")

onready var stats = $Stats

func _ready() -> void:
	stats.health -= 0


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * 120


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
