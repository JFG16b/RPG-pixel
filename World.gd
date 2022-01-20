extends Node2D

const Player = preload ("res://Action RPG Resources/Player/Player.tscn")


func _ready() -> void:
	randomize()




func _physics_process(_delta: float):
	if Input.is_action_just_pressed("Resurrect"):
		PlayerStats.max_health -= 1
		PlayerStats.health = PlayerStats.max_health
		emit_signal("resurrect")

func Player_resurrection():
	var player = Player.instance()
	$YSort.add_child(player)
	player.global_position = Vector2(120,40)

func _on_World_resurrect() -> void:
	Player_resurrection()


func _on_MrEyes_Talking() -> void:
	print("working")
