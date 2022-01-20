extends Area2D



func _on_Node2D_body_entered(body: Node) -> void:
	get_tree().change_scene("res://World.tscn")
