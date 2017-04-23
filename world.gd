extends Node2D

var items_collected = []
var timer_active = false

func _ready():
	get_node("Timer").connect("timeout", self, "_go_to_menu")
	
func _go_to_menu():
	get_tree().change_scene("res://Menu.tscn")