extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

signal talking

var state = IDLE

enum{
	IDLE,
	ANGRY,
	TALK
}

func _physics_process(delta: float) -> void:
	match state:
		IDLE:
			animationPlayer.play("Idle")
	
		ANGRY:
			pass
	
		TALK:
			talk()


func _on_TalkArea_body_entered(_body: Node) -> void:
	animationPlayer.play("Talk")
	state = TALK

func _on_TalkArea_body_exited(_body: Node) -> void:
	animationPlayer.play("Idle")
	state = IDLE

func talk():
	if Input.is_action_just_pressed("Interact"):
		emit_signal("talking")
