extends Control

var player
var enemy
var option1
var option2

func hide():
	$Option1.hide()
	$Option2.hide()
	$EnemyText.hide()
	$PlayerText.hide()

func show():
	$EnemyText.show()
	$Option1.show()
	$Option2.show()
	$PlayerText.show()
