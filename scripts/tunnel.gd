extends Node2D

func _ready():
	get_node("Area2D").connect("body_enter", self, "_teleport")
	
func _teleport(body):
	var position = Vector2(-1488, -512)
	get_owner().get_node("Player").set_global_pos(position)