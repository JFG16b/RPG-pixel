extends Area2D




func _on_CaveEntrance_body_entered(_body: Node2D) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cave.tscn")

