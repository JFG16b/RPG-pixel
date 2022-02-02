extends RichTextLabel

onready var enemyName = $Name

var dialog = ["Hello there traveler.", "I am Mr. eyes and if you wish I will show you how to move around these lands.", "."]
var page = 0
var talk 

signal ch1

func _ready() -> void:
	talk = 0

func _input(event) -> void:
	if talk == 1:
		if event.is_action_pressed("ui_accept"):
			if get_visible_characters() > get_total_character_count():
				if page < dialog.size()-1:
					page += 1
					set_bbcode(dialog[page])
					set_visible_characters(0)
					if page == 2:
						emit_signal("ch1")

func _on_Timer_timeout() -> void:
	set_visible_characters(get_visible_characters()+1)



func _on_MrEyes_talking() -> void:
	talk = 1
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	enemyName.text = str("-Mr.Eyes")

