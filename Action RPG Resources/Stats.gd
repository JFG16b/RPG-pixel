extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal max_health_changed(value)
signal health_changed(value)
signal four_plus_health
signal three_health
signal two_health
signal one_health
signal no_health

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	
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

func _ready() -> void:
	self.health = max_health
