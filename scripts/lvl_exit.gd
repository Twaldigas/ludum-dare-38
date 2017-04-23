extends Node2D

func _ready():
	get_node("Area2D").connect("body_enter", self, "_exit_lvl")

func _exit_lvl(body):
	get_owner().get_node("Camera2D").make_current()
	var timer = get_owner().get_node("Timer")
	timer.start()