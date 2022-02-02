extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var talkArea = $TalkArea/CollisionShape2D

signal talking
signal angry


var state = IDLE

enum{
	IDLE,
	ANGRY,
	TALK,
	PASS
}

func _physics_process(_delta: float) -> void:
	match state:
		IDLE:
			if talkArea.disabled == true:
				state = ANGRY
			animationPlayer.play("Idle")
	
		ANGRY:
			angry_state()
	
		TALK:
			talk()
	
		PASS:
			animationPlayer.stop()

func _on_TalkArea_body_entered(_body: Node) -> void:
	animationPlayer.play("Talk")
	state = TALK

func _on_TalkArea_body_exited(_body: Node) -> void:
	state = IDLE

func talk():
	if Input.is_action_just_pressed("Interact"):
		emit_signal("talking")

func angry_state():
	talkArea.disabled = true
	animationPlayer.play("Angry")
	emit_signal("angry")

func angry_animation_finished():
	state = PASS

func _on_Option1_pressed() -> void:
	state = ANGRY


func _on_AnimationPlayer_animation_finished(Angry: String) -> void:
	state = PASS
