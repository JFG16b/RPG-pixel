extends Node

export(int) var max_health = 1
onready var health = max_health setget set_health

signal four_plus_health
signal two_health
signal one_health
signal no_health
signal three_health

func set_health(value):
	health = value
	if health == 3:
		emit_signal("three_health")
	if health == 2:
		emit_signal("two_health")
	if health >= 4:
		emit_signal("four_plus_health")
	if health == 1:
		emit_signal("one_health")
	if health <= 0:
		emit_signal("no_health")
