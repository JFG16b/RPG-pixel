extends Control

onready var p = $PlayerText

onready var o1 = $Option1
onready var o2 = $Option2

func _ready() -> void:
	hide()

func hide():
	o1.hide()
	o2.hide()

	p.hide()

func show():

	o1.show()
	o2.show()
	p.show()


func _on_MrEyes_talking() -> void:
	show()
	p.text = "Hello adventurer, I am Mr. Eyes and I can show you how to succed in this lands if you wish me to do that"
	
