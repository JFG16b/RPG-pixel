extends Control


onready var o1 = $Option1
onready var o2 = $Option2
onready var enemyText = $PlayerText
onready var enemyName = $PlayerText/Name

func _ready() -> void:
	hide()

func hide():
	o1.hide()
	o2.hide()


func show():
	o1.show()
	o2.show()







func _on_PlayerText_ch1() -> void:
	show()
	enemyText.hide()
	enemyName.hide()
	o2.text = "Please show me"
	o1.text = "Eeww, where is the rest of your body?"




func _on_MrEyes_angry() -> void:
	hide()
