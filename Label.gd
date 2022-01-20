extends Label

onready var fps_label = get_node('fps_label')

func _process(delta: float) -> void:
fps_label.set_text(str(Engine.get_frames_per_second()))
