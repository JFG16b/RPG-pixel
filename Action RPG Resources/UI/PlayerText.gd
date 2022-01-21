extends RichTextLabel

var dialog = ["test", "Welcome"]
var page = 0

func _ready() -> void:
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page+=1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout() -> void:
	set_visible_characters(get_visible_characters()+1)

